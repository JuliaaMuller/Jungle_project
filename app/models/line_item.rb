class LineItem < ActiveRecord::Base

  belongs_to :order
  belongs_to :product

  monetize :item__cents, numericality: true
  monetize :total_price_cents, numericality: true

end
