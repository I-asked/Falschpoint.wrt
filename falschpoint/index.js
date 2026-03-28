'use strict';

function updateFavs() {
	$('#favorites').empty();
	if (favs.length > 0) {
		updateItems($('#favorites'), favs);
	} else {
		$('<li><em>Nothing here yet&hellip;</em></li>').appendTo($('#favorites'));
		$('#favorites').listview().listview('refresh');
	}
}

window.favs = [];

$(document).on('deviceready', function() {
	if (window.widget !== undefined) {
		$('.link-act').on('click', function(e) {
			e.preventDefault();
			window.widget.openURL($(e.target).attr('href'));
		});

		window.favs = JSON.parse(window.widget.preferenceForKey('favorites') || '[]');
	}
	updateFavs();
});

function searchUrlFor(query) {
	return 'https://db-api.unstable.life/search?smartSearch=' + encodeURIComponent(query) + '&filter=true&fields=id,title,originalDescription&platform=Flash&zipped=true';
}

function infoUrlFor(id) {
	return 'https://db-api.unstable.life/search?id=' + id + '&limit=1';
}

function logoUrlFor(id) {
	if (!id) { return '/assets/placeholder_logo.png'; }
	return 'https://infinity.unstable.life/images/Logos/' + id.slice(0, 2) + '/' + id.slice(2, 4) + '/' + id + '.png?type=png';
}

function shotUrlFor(id) {
	if (!id) { return '/assets/placeholder_shot.png'; }
	return 'https://infinity.unstable.life/images/Screenshots/' + id.slice(0, 2) + '/' + id.slice(2, 4) + '/' + id + '.png?type=jpg';
}

function gameUrlFor(id) {
	return 'https://ooooooooo.ooo/?id=' + id;
}

function updateItems(list, items, iCb) {
	items.forEach(function(ent, i) {
		if (iCb !== undefined && !iCb(i)) { return; }

		var li = $('<li></li>');
		var a = $('<a>', {
			href: '#',
			click: function(e) {
				e.preventDefault();
				if (window.isLoading) { return; }
				window.isLoading = true;
				$.mobile.loading('show', { theme: 'b', text: 'Please wait\u2026', textVisible: true });
				fetch(infoUrlFor(ent.id))
					.then(function (res) { return res.json(); })
					.then(function (data) {
						var ent = data[0];
						$('.game-devl').text(ent.developer);
						$('.game-publ').text(ent.publisher);
						$('.game-reld').text(ent.releaseDate);
						$('#game-tags').empty();
						ent.tags.forEach(function(tag) {
							var li = $('<li></li>');
							li.text(tag);
							$('#game-tags').append(li);
						});
						$('.game-name').text(ent.title);
						$('.game-desc').text(ent.originalDescription);
						$('.game-shot').attr('src', shotUrlFor(ent.id));
						$('#game-cset').collapsibleset().collapsibleset('refresh');
						$('.collapsible-dyn').collapsible('destroy').collapsible();
						window.currentGame = ent;
						return fetch(gameUrlFor(ent.id));
					})
					.then(function (res) { return res.text(); })
					.then(function (data) {
						var ok = false;
						var dom = $.parseHTML(data);
						if (dom) {
							var node = $(dom).find('.player-container');
							if (node) {
								var url = node.data('game-zip');
								if (url) {
									$('#game-play').attr('href', url);
									ok = true;
								}
							}
						}

						window.isLoading = false;
						$.mobile.loading('hide');
						if (ok) {
							$.mobile.pageContainer.pagecontainer('change', '#game-page', {
								transition: 'slide',
								changeHash: true,
								reload: false
							});
						} else {
							$('#error-text').text('Error: ' + data);
							$('#error-popup').popup().popup('open');
						}
					})
					.catch(function (err) {
						window.isLoading = false;
						$.mobile.loading('hide');

						$('#error-text').text('Request failed: ' + err.toString());
						$('#error-popup').popup().popup('open');
					});
			}
		});
		var img = $('<img>', { src: logoUrlFor(ent.id) });
		var h2 = $('<h2></h2>').text(ent.title);
		var p = $('<p></p>').text(ent.originalDescription);
		a.append(img);
		a.append(h2);
		a.append(p);
		li.append(a);
		if (list.data('split-theme')) {
			li.append($('<a>', {
				click: function(e) {
					var newFavs = [];
					favs.forEach(function(fa) {
						if (fa.id !== ent.id) { newFavs.push(fa); }
					});
					window.favs = newFavs;
					updateFavs();
					if (window.widget !== undefined) {
						window.widget.setPreferenceForKey(JSON.stringify(favs), 'favorites');
					}
				}
			}));
		}
		list.append(li);
	});
	list.listview('refresh');
}

function updateList(page) {
	var pageSize = 10;

	if (page === 0) { $('#results').empty(); }
	else if (page > Math.floor(window.results.length / pageSize)) { return; }

	updateItems(
		$('#results'),
		window.results,
		function(i) { return !((i < (page * pageSize)) || (i >= ((page + 1) * pageSize))); });
}

window.pageNum = 0;
window.results = [];
window.isLoading = false;

$(document).ready(function() {
	$('#search-form').on('submit', function(e) {
		e.preventDefault();
		if (window.isLoading) { return; }
		var query = $('#search-field').val();
		if (query === '') { return; }
		window.isLoading = true;
		$.mobile.loading('show', { theme: 'b', text: 'Please wait\u2026', textVisible: true });
		fetch(searchUrlFor(query), { headers: { 'Accept': 'application/json' } })
			.then(function(res) { return res.json(); })
			.then(function(data) {
				window.results = data;
				window.pageNum = 0;
				updateList(0);
				$('html,body').scrollTop(0);
				window.isLoading = false;
				$.mobile.loading('hide');
			})
			.catch(function(err) {
				window.isLoading = false;
				$.mobile.loading('hide');

				$('#error-text').text('Fetch error: ' + err.toString());
				$('#error-popup').popup().popup('open');
			});
	});

	var isScrolling = false;
	$(document).on('scrollstop', function() {
		if (
			$.mobile.activePage.attr('id') === 'search-page' &&
			!window.isLoading &&
			!isScrolling &&
			window.results.length &&
			($(window).scrollTop() >= $.mobile.activePage.height() - $(window).height() - 100)
		) {
			isScrolling = true;
			updateList(++window.pageNum);
			isScrolling = false;
		}
	});

	$('#game-fav').on('submit', function(e) {
		e.preventDefault();
		if (!window.currentGame) { return; }
		var hasFav = false;
		favs.forEach(function(fa) {
			if (fa.id === window.currentGame.id) { hasFav = true; }
		});
		if (!hasFav) {
			favs.push(window.currentGame);
			updateFavs();
			if (window.widget !== undefined) {
				window.widget.setPreferenceForKey(JSON.stringify(favs), 'favorites');
			}
		}
	});
});
