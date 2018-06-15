class OrderScheduleJob < ApplicationJob
  include Callprovider
  queue_as :default

  def perform(order)
    # order.title = "minaaaaa"
    call_provider order
  end
end
