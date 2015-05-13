class SessionsController < ApplicationController

	def new
	end

	def create
		username = params[:username]
		password = params[:password]
		user = User.find_by(username: username)
		redirect_link = 'http://localhost:3000/users/' + user.id.to_s

		if user && user.authenticate(password)
			session[:current_user] = user.id
			binding.pry
			redirect_to redirect_link
		else
			render :new
		end
	end

	def destroy
		session[:current_user] = nil
		redirect_to sessions_new_path
	end


end