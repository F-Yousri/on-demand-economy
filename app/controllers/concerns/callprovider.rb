module Callprovider
    
    def call_provider(order)
        @provider=Provider.find(order.provider_id)
        provider_url=@provider.url
        response = Data_provider::Data.new(order,provider_url)
        data=response.get_response.body

        # json_response({ message: Message.success , data: JSON[data]}) 
        render json: data
        end
    
  end