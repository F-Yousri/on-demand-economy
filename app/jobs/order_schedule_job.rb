class OrderScheduleJob < ApplicationJob
  include Callprovider
  queue_as :default

  def perform(order)
    if (order.status != "cancelled")
    call_provider(true, order)
    end
  end
end
