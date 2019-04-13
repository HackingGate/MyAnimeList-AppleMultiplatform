import ATV from 'atvjs';
import template from './template.hbs';
import API from 'lib/api';

var TvShowsPage = ATV.Page.create({
    name: 'movies',
    url: API.discoverTvShows,
    template: template
});

export default TvShowsPage;