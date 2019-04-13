import ATV from 'atvjs';
import template from './template.hbs';
import API from 'lib/api';

var MoviesPage = ATV.Page.create({
    name: 'movies',
    url: API.discoverMovies,
    template: template
});

export default MoviesPage;