class ApplicationController < ActionController::Base
	protect_from_forgery unless: -> { request.format.json? }
	SECRET = "yoursecretword"


	def authentication
		decode_data = decode_user_data(request.headers["token"])
		user_data = decode_data[0]["user_data"] unless !decode_data
		user = user_data
		if user
			return true
		else
			render json: { message: "invalid credentials" }
		end
	end

	def encode_user_data(payload)
		token = JWT.encode payload, SECRET, "HS256"
		return token
	end

	def decode_user_data(token)
		begin
			@data = JWT.decode token, SECRET, true, { algorithm: "HS256" }
			return @data
		rescue => e
			puts e
		end
	end

	def is_admin
		byebug
		if product.user_role == "admin"
		end
	end


	def current_cart
		@current_cart=Product.find(params[:id])
	end
	

	def current_user
		byebug
		@current_user ||= User.find_by(id: params["id"])
	end
end


