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
						resolve({
							response: xhr.response,
							debug: seriesId
						});
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