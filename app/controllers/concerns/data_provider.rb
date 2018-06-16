module Data_provider
    class Data
        attr_accessor :response,:conn,:response_login
        def initialize(order,provider)
           login(provider)
               if JSON[self.response_login.body]['message'] == 'success'
                get_data(order,provider)
            #     # render json: self.response_login['auth_token']
            #     # json_response({message: Message.success,auth_token: self.response_login['auth_token'] })
               else
                self.response={message: "error"}
               end
        end

        def login(provider)
            self.conn = Faraday.new(:url => provider.login_url)
            self.response_login = conn.post '', 
            {
                :domain =>"localhost:3000",
                :secret_key=>provider.secret_key,
            }
        end
        def get_data(order,provider)
            self.conn = Faraday.new(:url => provider.url)
            response =self.conn.post do |req|
                req.url provider.url
                # req.headers['Authorization'] = JSON[self.response_login.body]['auth_token']
                req.body = `{"src_latitude": "#{order.src_latitude}","src_longitude": "#{order.src_longitude}","dest_latitude": "#{order.dest_latitude}","dest_longitude": "#{order.dest_longitude}","provider_id": "#{order.provider_id}","payment_method": "#{order.payment_method}","time": "#{order.time}","title": "#{order.title}","images": "#{order.images}","weight": "#{order.weight}","description": "#{order.description}"}`
            #   end
            # self.conn = Faraday.new(:url => provider.url)
            # self.response = conn.post '', 
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
            }
            end
            self.response=response.body
        end

        def get_response
          self.response
        end
    end
end
