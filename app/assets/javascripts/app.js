console.log('app.js is loaded, bro');

$(document).ready(function() {
	$('#address-check-button').on('click', function(address) {
		console.log('button clicked bro')
		$.ajax({
			url: 'http://localhost:3000/listcheck',
			method: 'post',
			data: {address: encodeURI($('#address-input').val())},
			dataType: 'json'
		}).done(function(places){
			$('#results-container').empty();
			for (var i = 0; i < places.length; i++) {
				var user_list_item = $('<div>').attr('class', 'user_list_item');
				var place_name = places[i].name;
				var place_distance = places[i].distance_from_address;
				user_list_item.html('<br>' + place_name + ' is about ' + place_distance + ' miles away from your destination' + '<br>' + '<br>');
				user_list_item.appendTo($('#results-container'));
			};
		})
	})
});

