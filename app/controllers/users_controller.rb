require 'openssl'
require 'geokit'
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
			redirect_to "https://foursquare.com/oauth2/authenticate?client_id=NVB2TLBGE5SWYUNIPL3NWDB1S3ICQW1IIKD0W4CBTKLFCTRE&response_type=code&redirect_uri=http://thawing-headland-7058.herokuapp.com/authfoursq"
		else
			render :new
		end
	end





	def show
		@user = User.find(params[:id])
		@user_places = current_user.get_lists(current_user.access_token)
	end


	def address_check
		@user_list = current_user.get_lists(current_user.access_token)
		@results = current_user.check_list_items(params[:address], @user_list, params[:time])
		respond_to do |format|
			format.json {render :json => @results}
		end
	end



	def authenticate_foursq
		@user_auth_token = request.original_url.split('=')[1]
		User.last.foursq_user_token(@user_auth_token)
  	end




	private
	
	def user_params
		params.require(:user).permit(:username, :password, :password_confirmation)
	end



end