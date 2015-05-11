class UsersController < ApplicationController

	def index
		render json: User.all 
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to "https://foursquare.com/oauth2/authenticate?client_id=NVB2TLBGE5SWYUNIPL3NWDB1S3ICQW1IIKD0W4CBTKLFCTRE&response_type=code&redirect_uri=http://localhost:3000/authfoursq"
		else
			render :new
		end
	end

	def show
	end

	def authenticate_foursq
		@user_auth_token = request.original_url.split('=')[1]
		def current_user
  			User.find_by(id: session[:current_user])
  		end
  		token = 'poop'
  		binding.pry
  	end


	private
	
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end



end