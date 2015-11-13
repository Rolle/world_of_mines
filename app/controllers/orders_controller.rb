class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end
  
  def show
    @order = set_order
    
  end

  def new
    @order = Order.create(user: current_user, state: 0)

    current_user.work_list_ids.each do |id|
      mine = Mine.find(id)
      OrderDetail.create(order: @order, mine: mine)
    end
    redirect_to :controller => 'mines', :action => 'work_list'
  end

  def first_approval
    @order = set_order
    @order.update_attributes(first_approval: current_user)
    redirect_to :action => 'index'
  end

  def second_approval
    @order = set_order
    @order.update_attributes(second_approval: current_user, state: 1)
    OrderMailer.delay.send_order(@order).devliver_now
    redirect_to :action => 'index'
  end  

  def destroy
    @order = set_order
    @order.destroy
    redirect_to :action => 'index'
  end

private
  def set_order
    return Order.find(params[:id])
  end

    def order_params
      params.require(:order).permit(:user)
    end
end


