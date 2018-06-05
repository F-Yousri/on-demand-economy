module Data_provider
    class Data
        attr_accessor :response,:conn
        def initialize(order,url)
            self.conn = Faraday.new(:url => url)
            self.response = conn.post '', { :from => order.from }

        end

        def get_response
          self.response
        end
    end
end
