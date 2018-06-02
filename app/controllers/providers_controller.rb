class ProvidersController < ApplicationController
    def create
        provider = Provider.create!(provider_params)   
    end

    private

    def provider_params
      params.permit(
        :name,
        :url
      )
    end
end
