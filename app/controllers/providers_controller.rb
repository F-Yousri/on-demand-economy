class ProvidersController < ApplicationController
  before_action :is_verified
  
    def create
        provider = Provider.create!(provider_params)   
    end
    
    def show
       providers = Provider.select(:id, :name, :image)
       
       json_response({message:Message.success, providers: providers })
    end

    private

    def provider_params
      params.permit(:name,:url,:rate,:login_url,:secret_key,:image)
    end
end
