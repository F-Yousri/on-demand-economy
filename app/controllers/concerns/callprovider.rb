module Callprovider
    
    def call_provider(order)
        provider=Provider.find(order.provider_id)
        response = Data_provider::Data.new(order,provider)
        data=response.get_response
        if (JSON[data]['message'] == 'success')
            json_response({ message: Message.success , data: JSON[data]}) 
        else
            json_response({message:Message.carrier_not_ready })
        end
    end
  end