class OrderMailer < ApplicationMailer
	include MinesHelper

	default from: "rolle@rolandschmitt.info"

	def send_order(order)
		@order = order
		kml = generate_kml(@order.mines)
		#kml = generate_kml_from_order(@order)
		attachments["download.kml"] = kml
		mail(to: @order.user.email, subject: "Untergrundkataster - Bestellung " + @order.id.to_s + " vom " + @order.created_at.strftime("%d.%m.%Y, %H:%M:%S"))
	end
end
