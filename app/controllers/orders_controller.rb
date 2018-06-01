require 'json'

class OrdersController < ApplicationController
    # before_action :set_order, only: [:show, :update, :destroy]
    before_action :authorize_request
    def create
        order = Order.create!(order_params)
        order.created_by=current_user.id
        order.save
        call_provider order
    end

    def set_order
        @order = Order.find(params[:id])
    end
    
    def order_params
        params.permit(:from,:to,:provider_id,:payment_method,:images)
    end
    private
    def call_provider(order)
        @provider=Provider.find(order.provider_id)
        provider_url=@provider.url
    end
end
