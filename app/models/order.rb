class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :first_approval, class_name: "User", foreign_key: "first_approval"
	belongs_to :second_approval, class_name: "User", foreign_key: "second_approval"
	has_many :order_details, dependent: :delete_all

	def mines
		mines = []
		order_details.each do |detail|
			mines << detail.mine
		end
		return mines
	end
end
