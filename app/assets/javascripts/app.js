console.log('app.js is loaded, bro');

$(document).ready(function() {
	$('#address-check-button').on('click', function(address) {
		console.log('button clicked bro')
		$.ajax({
			url: '/listcheck',
			method: 'post',
			data: {address: encodeURI($('#address-input').val()), time: encodeURI($('#minutes-input').val())},
			dataType: 'json'
		}).done(function(places){
			console.log('test done function');
			$('#results-container').empty();
			for (var i = 0; i < places.length; i++) {
				var user_list_item = $('<div>').attr('class', 'user_list_item');
				var place_url = places[i].place_url;
				var place_name = places[i].name;
				var place_distance = places[i].distance_from_address;
				var geocoded_address_param = places[i].geocoded_address_param.full_address
				user_list_item.html('<br>' + '<a href=' + place_url + '>' + place_name + '</a>' + ' is about ' + place_distance + ' miles away from ' + geocoded_address_param + '<br>' + '<br>');
				user_list_item.appendTo($('#results-container'));
			};
		})
	})
});

