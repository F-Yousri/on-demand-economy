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
        orders=Order.where(created_by: current_user.id).order(time: :desc)
        render json: orders
    end

    def set_order
        @order = Order.find(params[:id])
    end
    
    def order_params
        params.permit(:from,:to,:provider_id,:payment_method,:time,:title,:images)
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
