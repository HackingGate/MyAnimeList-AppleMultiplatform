import ATV from 'atvjs';
import template from './template.hbs';
import API from 'lib/api';

var HomePage = ATV.Page.create({
	name: 'home',
	template: template,
	ready(options, resolve, reject) {
		let getPopularMovies = ATV.Ajax.get(API.popularMovies);
		let getPopularTvShows = ATV.Ajax.get(API.popularTvShows);
		let getTopAiring = ATV.Ajax.get(API.topAiring);

		Promise
			.all([getPopularMovies, getPopularTvShows, getTopAiring])
			.then((xhrs) => {
				let movies = xhrs[0].response;
				let tvShows = xhrs[1].response;
				let topAiring = xhrs[2].response;

				resolve({
					movies: movies.results,
					tvShows: tvShows.results,
					topAiring: topAiring.top
				});
			}, (xhr) => {
				// error
				reject();
			})
	}
});

export default HomePage;