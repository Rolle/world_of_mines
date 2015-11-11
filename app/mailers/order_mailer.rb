class OrderMailer < ApplicationMailer
	default from: "rolle@rolandschmitt.info"

	def send_order(order)
		@order = order
		mail(to: @order.user.email, subject: "Untergrundkataster - Bestellung " + @order.id.to_s + " vom " + @order.created_at.strftime("%d.%m.%Y, %H:%M:%S"))
	end
end
