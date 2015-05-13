class User < ActiveRecord::Base

	has_secure_password

	def foursq_user_token(code)
		url = 'https://foursquare.com/oauth2/access_token?client_id=NVB2TLBGE5SWYUNIPL3NWDB1S3ICQW1IIKD0W4CBTKLFCTRE&client_secret=HV4WHKBBXARKI0SXYKJ0GSG5XEYWMKX2CDJZQU53NI10TOLG&grant_type=authorization_code&redirect_uri=http://localhost:3000&code='
		user_token_response = HTTParty.get(url + code)
		user_token = user_token_response['access_token']
		self.access_token = user_token
		self.save
	end

	def get_lists(token)
		user_lists_url = 'https://api.foursquare.com/v2/users/self/lists?v=20150512&oauth_token='
		user_lists_response = HTTParty.get(user_lists_url + token)
		user_todo_list_id = user_lists_response['response']['lists']['groups'][0]['items'][0]['id']
		user_todo_details_url = 'https://api.foursquare.com/v2/lists/' + user_todo_list_id + '?v=20150512&oauth_token='
		user_todo_details_response = HTTParty.get(user_todo_details_url + token)
		@user_todo_items_details = []
		user_todo_items = user_todo_details_response['response']['list']['listItems']['items']
		user_todo_items.map do |item|
			def item_info(name, address, lat, long, place_url)
				@name = name
				@address = address
				@lat = lat
				@long = long
				@place_url = place_url
				item_info_details = {}
				item_info_details['name'] = @name
				item_info_details['address'] = @address
				item_info_details['lat'] = @lat
				item_info_details['long'] = @long
				item_info_details['place_url'] = @place_url
				@user_todo_items_details.push(item_info_details)
			end
			item_info(item['venue']['name'], item['venue']['location']['formattedAddress'].join(', '), item['venue']['location']['lat'],item['venue']['location']['lng'], item['venue']['url'])
		end
		@user_todo_items_details
	end

	def check_list_items(address, list, time)
		@user_distance = (time.to_i / 60.0) * 3.2
		@closest_places = []
		@geocoded_address = Geokit::Geocoders::GoogleGeocoder.geocode URI.unescape(address)
		list.each do |place|
			@geocoded_place = Geokit::Geocoders::GoogleGeocoder.geocode place['address']
			if @geocoded_address.distance_to(@geocoded_place) < @user_distance
				place['distance_from_address'] = @geocoded_address.distance_to(@geocoded_place)
				place['geocoded_address_param'] = @geocoded_address
				@closest_places.push(place)
			end
		end
		@closest_places
	end












end
































