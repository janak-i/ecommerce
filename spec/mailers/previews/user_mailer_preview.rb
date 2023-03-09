# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def new_user_email
		user = User.new(name: "Janak lodhi", email: "janaklodhi@gmail.com", address: "1-2-3 Chuo, Tokyo, 333-0000", phone: "090-7777-8888", message: "I want to place an order!")
		UserMailer.with(user: user).new_order_email
	end

end
