class MessengerController < ApplicationController
	include 'messenger.rb'

	def mail
		if(params.include?'subject' && params.incluse?'message')
			user = current_human
			email = user.email;
		end
	end
	def sms

	end
end
