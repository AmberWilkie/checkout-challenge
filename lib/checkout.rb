require 'pry'

class Checkout

  attr_reader :total, :cart, :promotion, :pre_price, :products, :product

  def initialize(promo = {})
    @promotion = promo[:promo]
    @cart = []
    @products = set_products
    validate_promo(@promotion)
  end

  def scan(item)
    @cart << find_item(item)
    total
  end

  def remove_from_cart(item)
    @cart.slice!(find_item(item)[:code])
  end

  def total
    pre_price = 0.0
    cart.each { |x|
      pre_price += x[:price] }
    give_promotion(pre_price)
    @total.round(2)
  end

  private
  def find_item(item)
    @product = @products.detect { |x| x[:name] == item}
  end

  def give_promotion(pre_price)
    case promotion
    when '60bucks'
      sixty_bucks_promo(pre_price)
    when 'hotdogs'
      @total = pre_price - hot_dog_promo('hotdog')
    when 'both'
      @total = sixty_bucks_promo(pre_price) - hot_dog_promo('hotdog')*0.9
    else
      @total = pre_price
    end
  end

  def validate_promo(promo)
    unless promo == '60bucks' || promo == 'hotdogs' || promo == 'both' || promo.nil?
      raise 'Invalid promo'
    end
  end

  def sixty_bucks_promo(pre_price)
    pre_price > 60.0 ?
     @total = pre_price*0.9 : @total = pre_price
  end

  def hot_dog_promo(item)
    count = Hash.new(0)
    cart.each do |x|
      count[x] += 1
    end
    count[find_item(item)] >= 2 ? (count[find_item(item)]*0.75) : 0
  end

  def set_products
    [
      {
        code: 1,
        name: 'blanket',
        desc: 'A soft and fluffy blanket',
        price: 19.95
      },
      {
        code: 2,
        name: 'lounger',
        desc: 'A sturdy and attractive beach chair',
        price: 45.0
      },
      {
        code: 3,
        name: 'hotdog',
        desc: 'An overpriced meat product',
        price: 9.25
      }
    ]
  end
end
