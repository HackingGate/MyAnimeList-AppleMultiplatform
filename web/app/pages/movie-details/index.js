import ATV from 'atvjs';
import template from './template.hbs';
import API from 'lib/api';

var MovieDetailsPage = ATV.Page.create({
	name: 'movie-details',
	template: template,
	ready(options, resolve, reject) {
		let movieId = options.id;

		ATV.Ajax
			.get(API.movieDetails(movieId))
			.then((xhr) => {
				resolve(xhr.response);
			}, (xhr) => {
				// error
				reject();
			})
	}
});

export default MovieDetailsPage;