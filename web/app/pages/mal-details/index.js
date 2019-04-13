import ATV from 'atvjs';
import template from './template.hbs';
import API from 'lib/api';

var MalDetailsPage = ATV.Page.create({
	name: 'mal-details',
	template: template,
	ready(options, resolve, reject) {
		let malId = options.mal_id;

		ATV.Ajax
			.get(API.malDetails(malId))
			.then((xhr) => {
				resolve(xhr.response);
			}, (xhr) => {
				// error
				reject();
			})
	}
});

export default MalDetailsPage;