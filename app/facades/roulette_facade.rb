# frozen_string_literal: true

# Facade for the roulette restaurant show
class RouletteFacade
  def initialize(location)
    @location = location
  end

  def static_map
    response = service.get_static_map
  end

  def java_map
    response = service.get_java_map
  end

  def service
    GoogleMapService.new(@location)
  end
end
