import ATV from 'atvjs';
import Handlebars from 'handlebars';

const imageBaseUrl = 'https://image.tmdb.org/t/p/';

function assetUrl(name) {
    return `${ATV.launchOptions.BASEURL}assets/${name}`;
}

function imageUrl(name) {
    return ((_.startsWith(name, 'http://') || _.startsWith(name, 'https://')) ? name : `${ATV.launchOptions.BASEURL}assets/img/${name}`);
}

function backgroundImage(img = '', className = '') {
    return `<background><img class="${className}" src="${imageUrl(img)}" /></background>`;
}

const helpers = {
	toJSON(obj = {}) {
		let str;
		try {
			str = JSON.stringify(obj);
		} catch (ex) {
			str = "{}"
		}
		return str;
	},
	asset_url(asset) {
		return new Handlebars.SafeString(assetUrl(asset));
	},
	img_url(img) {
		return new Handlebars.SafeString(imageUrl(img));
	},
	background_image(img) {
		return new Handlebars.SafeString(backgroundImage(img));
	},
	poster_url(posterPath) {
		return new Handlebars.SafeString(`${imageBaseUrl}w342${posterPath}`);
	},
	toFixed(popularity) {
		return Number.prototype.toFixed.call(popularity, 2);
	},
	// duration(duration) {
	// 	return new Handlebars.SafeString(formatDuration(duration));
	// },
	genres(genres) {
		let str = [];
		_.each(genres, (g) => str.push(g.name));
		return new Handlebars.SafeString(str.join(', '));
	}
};

// register all helpers
_.each(helpers, (fn, name) => Handlebars.registerHelper(name, fn));

export default helpers;