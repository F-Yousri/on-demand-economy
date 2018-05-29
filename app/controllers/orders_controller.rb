class OrdersController < ApplicationController
    # before_action :set_order, only: [:show, :update, :destroy]

    def create
        order = Order.create!(order_params)
        @provider=Provider.find(params[:provider_id])

    end

    def set_order
        @order = Todo.find(params[:id])
    end

    def order_params
        params.permit(:from,:to,:provider_id,images: [])
      end
end
