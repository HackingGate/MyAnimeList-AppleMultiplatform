import ATV from 'atvjs';
import template from './template.hbs';
import API from 'lib/api';
import CRAPI from 'lib/cr-api';

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

function getNameToken(name) {
	let name_lower = name.toLowerCase();
	let name_split = name_lower.split(':')[0];
	let name_token = name_split.replaceAll('`', '').replaceAll(' ', '-');
	return name_token;
}

var MalDetailsPage = ATV.Page.create({
	name: 'mal-details',
	template: template,
	ready(options, resolve, reject) {
		let malId = options.mal_id;

		ATV.Ajax
			.get(API.malDetails(malId))
			.then((xhr) => {
				var best_title = xhr.response.title;
				if (xhr.response.title_english) {
					// prefer title_english
					best_title = xhr.response.title_english;
				}
				let name_token = getNameToken(best_title);
				// download webpage from crunchyroll
				ATV.Ajax.get(CRAPI.webPage(name_token), {responseType: 'text'})
					.then((crxhr) => {
						getSeriesId(xhr, crxhr, resolve);
					}, (crxhr) => {
						// error
						if (crxhr.status == 404) {
							if (xhr.response.related.Adaptation[0].name) {
								let adaptationName = xhr.response.related.Adaptation[0].name;
								let name_token = getNameToken(adaptationName);
								ATV.Ajax.get(CRAPI.webPage(name_token), {responseType: 'text'})
									.then((crxhr) => {
										getSeriesId(xhr, crxhr, resolve);
									}, (crxhr) => {
										resolve({
											response: xhr.response,
											debug: name_token
										});
									})
							} else {
								resolve({
									response: xhr.response,
									debug: 'no adaption name'
								});
							}
						} else {
							resolve({
								response: xhr.response,
								debug: crxhr.status
							});
						}
					})

				// resolve({
				// 	response: xhr.response,
				// 	name: CRAPI.webPage(name_token)
				// });

				// resolve(xhr.response);
			}, (xhr) => {
				// error
				reject();
			})
	}
});

function getSeriesId(xhr, crxhr, resolve) {
	// get seriesId from html
	let page = crxhr.response
	let idDivRegex = /<div class="show-actions" group_id="(.*)"><\/div>/; // search for a div with an id
	var seriesId = page.match(idDivRegex)[1];
	if (!seriesId) {
		seriesId = 0;
	}

	startSession(function(sessionId, err){
		if (err) {
			resolve({
				response: xhr.response,
				debug: err
			});
			return;
		}
		let reqUrl = CRAPI.listCollections({
			session_id: sessionId,
			series_id: seriesId,
			limit: 1000,
			offset: 0,
			locale: 'enUS',
  			version: '2.1.6'
		});
		ATV.Ajax
			.get(reqUrl)
			.then((crcollexhr) => {
				var collections = crcollexhr.response.data
				let filteredCollections = collections
				// attempt to ignore dubs
				const languages = ['RU']
				filteredCollections = collections.filter((collection) => !(
					// check if there is (x Dub) or (Dub) there
					/\((.*)?Dub(bed)?\)/.test(collection.name) ||
					// check if it contains a two letter language string, like the ones above
					languages.find((language) => collection.name.includes(`(${language})`)) !== undefined
				))

				let firstCollectionId = filteredCollections[0].collection_id;
				
				let reqUrl = CRAPI.listMedia({
					session_id: sessionId,
					collection_id: firstCollectionId,
					include_clips: 0,
					limit: 1000,
					offset: 0,
					locale: 'enUS',
  					version: '2.1.6'
				});
				ATV.Ajax
					.get(reqUrl)
					.then((crmediaxhr) => {
	
						// let episodeArray = crmediaxhr.response.data;
						var episodeArray = crmediaxhr.response.data.map(function(el) {
							var o = Object.assign({}, el);
							o.session_id = sessionId;
							return o;
						});
						resolve({
							response: xhr.response,
							episodes: episodeArray,
							debug: reqUrl
						});
					}, (crmediaxhr) => {
						// error
						resolve({
							response: xhr.response,
							debug: 'crmediaxhr failed'
						});
					})						
	
			}, (crcollexhr) => {
				// error
				resolve({
					response: xhr.response,
					debug: 'crcollexhr failed'
				});
			})
	});
}

function startSession(callback) {
	ATV.Ajax
		.get('https://api2.cr-unblocker.com/start_session')
		.then((xhr) => {
			if (xhr.response.data.session_id) {
				callback(xhr.response.data.session_id, null);
			} else {
				callback(null, 'no session_id');
			}
		}, (xhr) => {
			// error
			callback(null, 'error');
		})
}

export default MalDetailsPage;