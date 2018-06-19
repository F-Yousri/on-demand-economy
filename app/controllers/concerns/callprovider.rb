module Callprovider
    
    def call_provider(order)
        provider=Provider.find(order.provider_id)
        response = Data_provider::Data.new(order,provider)
        data=response.get_response
        json_data=JSON[data]
        if (json_data['message'] == 'success')
            order.status="active"
            order.cost=json_data['cost']
            order.provider_order_id=json_data['provider_order_id']
            order.save
            render json: { message: Message.success , data: JSON[data]} 
        else
            order.status="cancelled"
            order.save
            render json: response
        end
    end
  end