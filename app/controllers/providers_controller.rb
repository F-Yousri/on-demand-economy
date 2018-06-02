class ProvidersController < ApplicationController
  
    def create
        provider = Provider.create!(provider_params)   
    end
    
    def show
       providers = Provider.select(:id, :name, :image)
       json_response({providers: providers })
    end

    private

    def provider_params
      params.permit(
        :name,
        :url
      )
    end
end
