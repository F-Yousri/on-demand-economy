class PaymentsController < ApplicationController
    before_action :is_verified

    # def create
    #     Payment_method = Payment.create!(Payment_methods_params)   
    # end
    
    def show
       payment_methods = Payment.select(:id, :name, :image)
       
       json_response({message:Message.success, Payment_methods: payment_methods })
    end

    private

    def Payment_methods_params
      params.permit(
        :name,
        :status
      )
    end
end
