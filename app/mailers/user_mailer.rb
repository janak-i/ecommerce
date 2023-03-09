class UserMailer < ApplicationMailer
	def new_user_email(user)
		@user = user
		mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	end
	
end
