
# in lib/order.rb
class Order

  DELIVERY_TIME = 3600

  def initialize(menu, basket)
    @basket = basket
    @menu = menu
    @complete = false
  end

  def select_dish(index)
    dish = @menu.get_dish(index)
    @basket.add_item(dish)
  end

  def complete!
    @complete = true
    time = Time.now + DELIVERY_TIME
    summary(time)
  end

  def show
    @basket.show_basket
  end

  private

  def summary(time)
    {
      items: @basket.items,
      total: @basket.formatted_total,
      time: time
    }
  end
end
