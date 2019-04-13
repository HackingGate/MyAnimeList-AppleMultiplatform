const baseUrl = 'https://api.crunchyroll.com/';
const session_id = '5828f42150639d94c09e2fa32446bf27';
const baseWebUrl = 'https://www.crunchyroll.com/';

const toQueryString = (obj) => {
    return (
        _.map(obj, (v, k) => {
            if (_.isArray(v)) {
                return (_.map(v, (av) => `${k}[]=${av}`)).join('&');
            } else {
                return `${encodeURIComponent(k)}=${encodeURIComponent(v)}`;
            }
        })
    ).join('&');
};
const toUrl = (url = '', params = {}) => {
    let q = toQueryString(params);
    let urlBuffer = [url];
    if (q) {
        urlBuffer.push(/\?.+$/.test(url) ? `&${q}` : `?${q}`);
    }
    return urlBuffer.join('');
};
const buildUrl = (url, params) => toUrl(`${baseUrl}${url}?session_id=${session_id}`, params);
const buildWebUrl = (name_token) => toUrl(`${baseWebUrl}${name_token}?skip_wall=1`);

const apiUrls = {
    get topAiring() { return buildUrl('top/anime/1/airing'); },
    malDetails(id) { return buildUrl(`anime/${id}`); },
    webPage(name_token) { return buildWebUrl(`${name_token}`); },
    listCollections(params) { return buildUrl(`list_collections.0.json`, params); },
    listMedia(params) { return buildUrl(`list_media.0.json`, params); },
    info(params) { return buildUrl(`info.0.json`, params); }
}

export default apiUrls;