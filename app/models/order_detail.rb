class OrderDetail < ActiveRecord::Base
	belongs_to :order
	belongs_to :mine
end
