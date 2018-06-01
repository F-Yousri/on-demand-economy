require 'json'

class OrdersController < ApplicationController
    # before_action :set_order, only: [:show, :update, :destroy]

    def create
        @json= JSON.parse(request.raw_post)
        # payment_method=Payment_method::Payment.new(params[:payment_method])
        # order = Order.create!(order_params)
        # provider=Provider.find(params[:provider_id])
        # render json: payment_method.payment_method
        render plain: @json["data"]["name"]
        # json_response(order)
    end

    def set_order
        @order = Todo.find(params[:id])
    end

    def order_params
        params.permit(:from,:to,:provider_id,:payment_method,:data, :name,images: [])
      end
end
