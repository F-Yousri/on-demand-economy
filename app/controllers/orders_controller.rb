class OrdersController < ApplicationController
    require 'json'

    # before_action :set_order, only: [:show, :update, :destroy]
    before_action :authorize_request ,:is_verified
    include Callprovider
   
    def create
        order = Order.new(order_params)
        order.created_by=current_user.id
        order.save!
        time_in_minute =(order.time.to_i - order.created_at.to_i).to_i/60
           if (time_in_minute <= 0)
            json_response({message: Message.order_time_error})
            elsif (time_in_minute >= 60)
                OrderScheduleJob.set(wait: (time_in_minute-60).minute).perform_later(order)
                order.status="upcoming"
                order.save
                json_response({message: Message.success})
            else
                call_provider(true, order)
            end
      
     
    end

    def show_history
        active_orders=Order.where(created_by: current_user.id,status: "active").order(time: :desc)
        history_orders=Order.where(created_by: current_user.id,status: "history").order(time: :desc).page(params[:page_number])
        total_history_pages=history_orders.total_pages
        data={active: active_orders,history: history_orders}
        response={message: Message.success ,total_pages: total_history_pages ,data: data}
        json_response(response)
    end

    def track
        order=Order.find(params[:order_id])
        call_provider(order)
    end

    def show_upcoming
        upcoming_orders=Order.where(created_by: current_user.id,status: "upcoming").order(time: :desc).page(params[:page_number])
        total_upcoming_pages=upcoming_orders.total_pages
        data={upcoming: upcoming_orders}
        response={message: Message.success,total_pages: total_upcoming_pages ,data: data}
        json_response(response)

    end

    def set_order
        @order = Order.find(params[:id])
    end
    
    def cancel 
        
        order=Order.find(params[:order_id]) 
        if order.created_by == current_user.id && order.status == "upcoming"
        order.status = "cancelled"
        order.save!
        json_response({message: Message.success})
        else
        json_response({message: Message.not_delete})
        end
    end
    private
    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:provider_id,:payment_method,:time,:title,:weight,:description,:pickup_location,:dropoff_location,:images,:or)
    end
end
