class TradingStatus < ActiveHash::Base
  self.data = [
    {id: 1, name: '下書き'},
    {id: 2, name: '販売中'},
    {id: 3, name: '取引中'},
    {id: 4, name: '完売'}
  ]
end