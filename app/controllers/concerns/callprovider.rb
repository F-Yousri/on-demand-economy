module Callprovider
    
    def call_provider(new=false, order)
        provider=Provider.find(order.provider_id)
       
     
        connection = Data_provider::Data.new(provider)
        if JSON[connection.response_login.body]['message'] == 'success'
            if new
            connection.get_data(order,provider)
        else
            connection.track_order(provider, order.provider_order_id)
        end
           else
            connection.response={message: "error"}
           end

        data=connection.get_response
        json_data=JSON[data]
        if (new && json_data['message'] == 'success')
            order.status="active"
            order.cost=json_data['cost']
            order.provider_order_id=json_data['provider_order_id']
            order.save
            render json: { message: Message.success , data: JSON[data]}
        elsif (json_data['message'] == 'success')
            render json: { message: Message.success , data: JSON[data]}
        else
            order.status="cancelled"
            order.save
            render json: JSON[data]
        end

    end
  end