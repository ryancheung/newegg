module Newegg
  module Orders
    # Fetch order list
    # @param options [Hash]
    # @option options [String] :status Required. 0:待审核 1:待出库 4:已出库 -1:作废 -5:BackOrder
    # @option options [Time,String] :IndateFrom Optional. 下单时间开始
    # @option options [Time,String] :IndateTo Optional. 下单时间结束
    # @option options [Time,String] :endTime Required.
    # @option options [Integer] :pageIndex Optional, defaults to 1. Current page
    # @option options [Integer] :pageSize Optional, Order count per page
    def fetch_orders(options)
      if Time === options[:IndateFrom]
        options[:IndateFrom] = options[:IndateFrom].strftime('%Y-%m-%d %T')
      end

      if Time === options[:IndateTo]
        options[:IndateTo] = options[:IndateTo].strftime('%Y-%m-%d %T')
      end

      get('/v1/order', options)
    end
  end
end
