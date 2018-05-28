class OrdersController < ApplicationController
    # before_action :set_order, only: [:show, :update, :destroy]

    def index
        @orders = Order.all
        @user=current_user
        json_response(@user)
    end

    def set_order
        @order = Todo.find(params[:id])
    end
end
