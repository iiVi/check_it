class User < ActiveRecord::Base
	has_secure_password

	def foursq_user_token(code)
		url = 'https://foursquare.com/oauth2/access_token?client_id=NVB2TLBGE5SWYUNIPL3NWDB1S3ICQW1IIKD0W4CBTKLFCTRE&client_secret=HV4WHKBBXARKI0SXYKJ0GSG5XEYWMKX2CDJZQU53NI10TOLG&grant_type=authorization_code&redirect_uri=http://localhost:3000&code='
		user_token_response = HTTParty.get(url + code)
		user_token = user_token_response['access_token']
		self.access_token = user_token
		binding.pry
	end


end
