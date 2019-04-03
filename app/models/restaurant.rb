class Restaurant
  attr_reader :name, :address, :price_range, :cuisine, :rating, :distance

  def initialize(data)
    @name = data[:name]
    @address = "#{data[:location][:address1]} #{data[:location][:address2]} #{data[:location][:city]}, #{data[:location][:state]} #{data[:location][:zip_code]}"
    @price_range = data[:price]
    @cuisine = data[:categories].first[:title]
    @rating = data[:rating]
    @distance = (data[:distance] / 1609.344).round(2)
  end
end
