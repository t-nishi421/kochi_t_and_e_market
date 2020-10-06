class Shipping_cost < ActiveHash::Base
  self.data = [
    {id: 1, content: '送料込み（出品者負担）'},
    {id: 2, content: '着払い（購入者負担）'}
  ]
end