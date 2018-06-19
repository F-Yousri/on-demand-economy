module Data_provider
    class Data
        attr_accessor :response,:conn,:response_login,:response_driver
        def initialize(provider)
           login(provider)
        end

        def login(provider)
            self.conn = Faraday.new(:url => provider.login_url)
            self.response_login = conn.post '', 
            {
                :domain =>Rails.application.secrets.base_url,
                :secret_key=>provider.secret_key,
            }
        end
        def get_data(order,provider)
            self.conn = Faraday.new(:url => provider.url)
            self.response =self.conn.post do |req|
                req.url  provider.url
                req.headers['Authorization'] = JSON[self.response_login.body]['auth_token']
                 req.body ={
                    :src_latitude =>order.src_latitude,
                    :src_longitude=>order.src_longitude,
                    :dest_latitude=>order.dest_latitude,
                    :dest_longitude=>order.dest_longitude,
                    :provider_id=>order.provider_id,
                    :payment_method=>order.payment_method,
                    :time=>order.time,
                    :title=>order.title,
                    :images=>order.images,
                    :weight=>order.weight ,
                    :description=>order.description,
                    :pickup_location=>order.pickup_location,
                    :dropoff_location=>order.dropoff_location,
                            }
            end
            self.response=response.body
        end

        def get_response
          self.response
        end

        def track_order (provider, provider_order_id)
            self.conn = Faraday.new(:url => provider.driver_url)
            self.response_driver =self.conn.post do |req|
                req.url  provider.driver_url
                req.headers['Authorization'] = JSON[self.response_login.body]['auth_token']
                 req.body ={
                    :order_id =>provider_order_id,
                            }
            end
             self.response=self.response_driver.body
        end
    end
end
