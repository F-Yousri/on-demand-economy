# require 'active_merchant'

module Payment_method
    class Payment
        ActiveMerchant::Billing::Base.mode = :test

        attr_accessor :payment_method,:credit_card,:gateway,:amount
        def initialize(payment_method)
            case payment_method
            when "master"
                self.master
                # break
            when "visa"
                self.visa
                # break
            else
                self.cash
                # break
            end
        end


        def master
            self.payment_method = "master" 
            self.init
            self.check 
        end 
        def visa
            self.payment_method = "visa"
        end 
        def cash
            self.payment_method = "cash" 
        end 

        def init 
            self.gateway = ActiveMerchant::Billing::MastercardGateway.new(
                :login => 'TestMerchant',
                :password => 'password')

                self.amount = 1000

                self.credit_card = ActiveMerchant::Billing::CreditCard.new(
                    :first_name         => 'Bob',
                    :last_name          => 'Bobsen',
                    :number             => '4242424242424242',
                    :month              => '8',
                    :year               => Time.now.year+1,
                    :verification_value => '000')
        end

        def check
            if self.credit_card.validate.empty?
                # Capture $10 from the credit card
                response = gateway.purchase(amount, credit_card)
              
                if response.success?
                  puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
                else
                  raise StandardError, response.message
                end
            end
        end
    end
  end