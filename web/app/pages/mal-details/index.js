import ATV from 'atvjs';
import template from './template.hbs';
import API from 'lib/api';
import CRAPI from 'lib/cr-api';

String.prototype.replaceAll = function(search, replacement) {
    var target = this;
    return target.replace(new RegExp(search, 'g'), replacement);
};

var MalDetailsPage = ATV.Page.create({
	name: 'mal-details',
	template: template,
	ready(options, resolve, reject) {
		let malId = options.mal_id;

		ATV.Ajax
			.get(API.malDetails(malId))
			.then((xhr) => {
				let name_token = xhr.response.title_english.toLowerCase().replaceAll(' ', '-');

				// download webpage from crunchyroll
				ATV.Ajax.get(CRAPI.webPage(name_token), {responseType: 'text'})
					.then((crxhr) => {

						// get seriesId from html
						let page = crxhr.response
						let idDivRegex = /<div class="show-actions" group_id="(.*)"><\/div>/; // search for a div with an id
						var seriesId = page.match(idDivRegex)[1];
						if (!seriesId) {
							seriesId = 0;
						}

						let reqUrl = CRAPI.listCollections({
        					series_id: seriesId,
       						limit: 1000,
        					offset: 0
						});
						ATV.Ajax
							.get(reqUrl)
							.then((crcollexhr) => {

								let firstCollectionId = crcollexhr.response.data[0].collection_id;
								
								let reqUrl = CRAPI.listMedia({
									collection_id: firstCollectionId,
									include_clips: 0,
									limit: 1000,
									offset: 0
								});
								ATV.Ajax
									.get(reqUrl)
									.then((crmediaxhr) => {

										let episodeArray = crmediaxhr.response.data;
										resolve({
											response: xhr.response,
											debug: episodeArray[0].name,
											episodes: episodeArray
										});
									}, (crmediaxhr) => {
										// error
										reject();
									})						

							}, (crcollexhr) => {
								// error
								reject();
							})
					}, (crxhr) => {
						// error
						reject();
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

export default MalDetailsPage;