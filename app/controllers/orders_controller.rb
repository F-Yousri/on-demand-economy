class OrdersController < ApplicationController
    # before_action :set_order, only: [:show, :update, :destroy]
    before_action :authorize_request ,:is_verified
    
    def create
        order = Order.create!(order_params)
        order.created_by=current_user.id
        order.save
        call_provider order
    end

    def image_path (orderImage)
         orderImage.each do |order|
             self.order['images']['url']='https://driveo.herokuapp.com/'+order['images']['url']
        end
    end

    def show
        pending_orders=Order.where(created_by: current_user.id,status: "pending").order(time: :desc).each do |order|
            order.images.each do |image|
                image.url
            end
        end
        active_orders=Order.where(created_by: current_user.id,status: "active").order(time: :desc)
        upcomig_orders=Order.where(created_by: current_user.id,status: "upcoming").order(time: :desc).page(params[:page_number])
        history_orders=Order.where(created_by: current_user.id,status: "history").order(time: :desc).page(params[:page_number])
        history_pages=history_orders.total_pages
        response={message: Message.success ,history_pages: history_pages, history: history_orders,active: active_orders ,upcoming: upcomig_orders}
        
            # history_orders.each do |order| 
            #     @response= order['images']
            # end
        json_response(@response)

    end

    def set_order
        @order = Order.find(params[:id])
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

    def order_params
        params.permit(:src_latitude,:src_longitude,:dest_latitude,:dest_longitude,:provider_id,:payment_method,:time,:title,:images,:weight)
    end
end
