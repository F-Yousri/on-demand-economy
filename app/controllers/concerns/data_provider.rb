module Data_provider
    class Data
        attr_accessor :response,:conn
        def initialize(order,url)
            self.conn = Faraday.new(:url => url)
            self.response = conn.post '', 
            {
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

        def get_response
          self.response
        end
    end
end
