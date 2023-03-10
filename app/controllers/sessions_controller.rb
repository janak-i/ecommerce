class SessionsController < ApplicationController
	before_action :authentication, :only => [:login]
	default from: 'notifications@example.com'
	before_action :welcome_email, :only=>[:create]


	def signup
		byebug
		user = User.new(email: params[:email], password_digest: params[:password_digest], user_role: params[:user_role])
		if user.save
			UserMailer.with(user: @user).welcome_email.deliver_later
			token = encode_user_data({ user_data: user.id })
			render json: { token: token }
		else
			render json: { message: "invalid credentials" }
		end
	end

	def change_password
		user = User.find(params['data'][:id])
		if params['data'][:old_password] == (params['data'][:new_password])
			render json: { message: 'cant update password with the same password'}
		elsif params['data'][:new_password]== (params['data'][:confirm_password])
			user.update(password_digest: params['data'][:new_password])
			render json: { message: 'Password Updated Successfully' }, status: :ok
		else
			render json: { message: 'Password can not change change.' }, status: :unprocessable_entity
		end
	end


	def login
		user = User.find_by(email: params[:email])
		if user && user.password_digest == params[:password_digest]
			token = encode_user_data({ user_data: user.id })
			render json: { token: token }
		else
			render json: { message: "invalid credentials" }
		end
	end

	def welcome_email
		byebug
		@user = params[:user]
		@url  = 'http://example.com/login'
		mail(to: @user.email, subject: 'you have Successfully register in my application welcome')
	end
end







	