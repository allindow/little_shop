class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :items, through: :order_items
  enum status: %w(ordered paid cancelled completed)

  def date
    created_at.strftime("%m/%d/%Y")
  end

  def sub_total(item)
    item_quantity(item) * item.price
  end

  def total
    items.reduce(0) { |initial, item| initial += sub_total(item) }
  end

  def time_updated
    updated_at.strftime("%m-%e-%y %H:%M %p")
  end

  def item_quantity(item)
    OrderItem.find_by(order: self, item: item).quantity
  end

  def total_items
    items.reduce(0) { |initial, item| initial += item_quantity(item) }
  end

end
