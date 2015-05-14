class SessionsController < ApplicationController

	def new
	end

	def create
		username = params[:username]
		password = params[:password]
		user = User.find_by(username: username)
		redirect_link = 'http://thawing-headland-7058.herokuapp.com/users/' + user.id.to_s

		if user && user.authenticate(password)
			session[:current_user] = user.id
			redirect_to redirect_link
		else
			render :new
		end
	end

	def destroy
		session[:current_user] = nil
		redirect_to 'http://thawing-headland-7058.herokuapp.com'
	end


end