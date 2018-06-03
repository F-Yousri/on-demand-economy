module Data_provider
    class Data
        attr_accessor :response,:conn
        def initialize(order,url)
            self.conn = Faraday.new(:url => url)
            self.response = conn.get ''     
        end

        def get_response
          self.response
        end
    end
end
