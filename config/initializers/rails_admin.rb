RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end

  config.current_user_method(&:current_admin)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.excluded_models << Admin
  
    config.model 'Provider' do
      edit do
        field :url, :string
        field :name, :string
        field :rate, :integer
        field :image, :carrierwave,multiple: true
        field :login_url, :string
        field :secret_key, :string
      end
      
    end
    config.model 'Order' do
      edit do
        field :src_latitude, :float
        field :src_longitude, :float
        field :provider_id, :integer
        field :weight, :float
        field :dest_latitude, :float
        field :dest_longitude, :float
        field :pickup_location, :float
        field :dropoff_location, :float
        field :description,:string
        field :created_by ,:integer
        field :provider_order_id ,:integer
        field :status
        field :time 
        field :title
        field :payment_method 
        field :cost
        field :images do
          partial "my_awesome_partial"
        end
      end
    end
      config.model 'Order' do
      show do
          field :src_latitude, :float
          field :src_longitude, :float
          field :provider_id, :integer
          field :weight, :float
          field :dest_latitude, :float
          field :dest_longitude, :float
          field :pickup_location, :float
          field :dropoff_location, :float
          field :description,:string
          field :created_by ,:integer
          field :provider_order_id ,:integer
          field :status
          field :time 
          field :title
          field :payment_method 
          field :cost
          # field :images do
          #   pretty_value do
          #     bindings[:view].render :partial => "multi_images", :locals => {:field => self, :form => bindings[:form]}
          #   end  
          # end
        
      end
    end

end
