class Order < ApplicationRecord
  def price
    # price is base price - quantity discount + shipping
    quantity * item_price -
    [0, quantity - 500].max * item_price * 0.05 -
    [quantity * item_price * 0.1, 100].min
  end
end




class Order
  def price
    base_price - quantity_discount - shipping
  end

  def base_price
    quantity * item_price
  end

  def quantity_discount
    [0, quantity - NUMERO_LIMIT].max * item_price * 0.05
  end

  def shipping
    [base_price * 0.1, 100].min
  end
end
