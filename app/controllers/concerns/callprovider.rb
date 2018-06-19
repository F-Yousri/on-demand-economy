module Callprovider
    
    def call_provider(order)
        provider=Provider.find(order.provider_id)
        response = Data_provider::Data.new(order,provider)
        data=response.get_response
        json_data=JSON[data]
        if (json_data['message'] == 'success')
            order.status="active"
            order.cost=json_data['cost']
            order.save
            json_response({ message: Message.success , data: JSON[data]}) 
        else
            order.status="cancelled"
            order.save
            json_response({message:Message.carrier_not_ready ,data: JSON[data]})
        end
    end
  end