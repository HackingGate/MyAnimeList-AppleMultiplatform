import ATV from 'atvjs';
import CRAPI from 'lib/cr-api';

const _ = ATV._;

const sampleStreams = [
	'https://dl.v.vrv.co/evs/e1271ea0543b96c6c7f79045e02b8542/assets/43265179ac409cfc297665c77bc22743_,3612143.mp4,3612144.mp4,3612142.mp4,3612140.mp4,3612141.mp4,.urlset/master.m3u8?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cCo6Ly9kbC52LnZydi5jby9ldnMvZTEyNzFlYTA1NDNiOTZjNmM3Zjc5MDQ1ZTAyYjg1NDIvYXNzZXRzLzQzMjY1MTc5YWM0MDljZmMyOTc2NjVjNzdiYzIyNzQzXywzNjEyMTQzLm1wNCwzNjEyMTQ0Lm1wNCwzNjEyMTQyLm1wNCwzNjEyMTQwLm1wNCwzNjEyMTQxLm1wNCwudXJsc2V0L21hc3Rlci5tM3U4IiwiQ29uZGl0aW9uIjp7IkRhdGVMZXNzVGhhbiI6eyJBV1M6RXBvY2hUaW1lIjoxNTU1MjYxNzk5fX19XX0_&Signature=W6aYzDucpp~TYIsGcFeR5CpU-rm7QGQWzYuVjNAuhh2Bmh8fFEjxFfhD66f0JO6xgFIwYauSPmH-OcEB8BCgDY5qzogBDpzYDaXDFvihFkYNJVQ6mY2cGanMWHl8bnbaA-dIoLvjNMe9psO-bxHaalTPA7WZLzlxeyekIRL2aFVLDTMot241oT8whK8HJeXqHxVg6fx5AJD0Rpi~B9jFe1eM-uizXAN0Rn7VviIzDVyPzOpVP45G~d459ptPD2q2CdqQ6H6F7DOiFdauz0QjUN6jPtj9Zh1AOZOneHhTcHX-2P7INdqALl6Ej58jBlIWQBTyLSddJndL40MU2chNKA__&Key-Pair-Id=DLVR'
];
const sampleStreamsLength = sampleStreams.length;
const upperBoundIndex = sampleStreamsLength - 1;

var PlayPage = ATV.Page.create({
    name: 'play',
		ready(options, resolve, reject) {
			let mediaId = options.media_id;
			let sessionId = options.session_id;
			let reqUrl = CRAPI.info({
				session_id: sessionId,
				fields: 'media.stream_data,media.media_id',
				media_id: mediaId,
				locale: 'enUS',
  				version: '2.1.6'
			});
			ATV.Ajax
				.get(reqUrl)
				.then((xhr) => {

					let streamUrl = xhr.response.data.stream_data.streams[0].url;
					let player = new Player();
					let mediaItem = new MediaItem('video', streamUrl);
					let playlist = new Playlist();

					playlist.push(mediaItem);
					player.playlist = playlist;
					player.play();

					resolve(false);
				}, (xhr) => {
					// error
					reject();
				})
    }
});

export default PlayPage;