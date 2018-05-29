class ProvidersController < ApplicationController
    def create
        order = Provider.create!(provider_params)   
    end

    private

    def provider_params
      params.permit(
        :name,
        :url
      )
    end
end
