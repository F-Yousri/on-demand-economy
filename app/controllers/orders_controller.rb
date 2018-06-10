# require 'json'

class OrdersController < ApplicationController
    # before_action :set_order, only: [:show, :update, :destroy]
    before_action :authorize_request ,:is_verified
    def create
        order = Order.create!(order_params)
        order.created_by=current_user.id
        order.save
        call_provider order
    end
    def show
        
        pending_orders=Order.where(created_by: current_user.id,status: "pending").order(time: :desc)
        active_orders=Order.where(created_by: current_user.id,status: "active").order(time: :desc)
        upcomig_orders=Order.where(created_by: current_user.id,status: "upcoming").order(time: :desc)
        response={:pending=> pending_orders,:active=> active_orders ,:upcoming=> upcomig_orders}
        json_response({ message: Message.success , data: response}) 
        # render json: pending_orders
    end

    def set_order
        @order = Order.find(params[:id])
    end
    
    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:provider_id,:payment_method,:time,:title,:images)
    end
    private
    def call_provider(order)
        @provider=Provider.find(order.provider_id)
        provider_url=@provider.url
        response = Data_provider::Data.new(order,provider_url)
        data=response.get_response.body

        # json_response({ message: Message.success , data: JSON[data]}) 
        render json: data
    end
end
