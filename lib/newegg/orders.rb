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

    # Get order details
    # @param order_number [String] Required.
    #
    # @return [Hash]
    def order_details(order_number)
      get("/v1/order/#{order_number}")
    end

    # Ship order
    # @param order_number [String] Required.
    # @param options [Hash]
    # @option options [String] :ShippingService SEF --- 商家自送 SF --- 顺风 YTO --- 圆通 STO --- 申通 YUNDA --- 韵达 ZTO --- 中通 TTK --- 天天 HT --- 汇通 EMS --- EMS ZJS --- 宅急送 OTHER --- 其它
    # @option options [String] :PackageNumber Tracking number
    def ship_order(order_number, options)
      params = {
        OperationType: 'UpdateOrder',
        Shipment: {
          ShippingService: options.fetch(:ShippingService),
          PackageNumber: options.fetch(:PackageNumber)
        }
      }

      post("/v1/order/#{order_number}", params)
    end

    # Cancel order
    # @param order_number [String] Required.
    # @param options [Hash]
    # @option options [String] :Reason Optional.
    def cancel_order(order_number, options)
      params = {
        OperationType: 'UpdateOrder',
        OrderNumber: order_number,
        Action: 4,
        Reason: options.fetch(:Reason)
      }

      post("/v1/order/#{order_number}", params)
    end
  end
end
