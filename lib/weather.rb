class Weather

  attr_reader :current_weather

  def initialize
    @current_weather = weather_randomizer
  end

  # def stormy?
  #   if @current_weather == "stormy"
  #     true
  #   else
  #     false
  #   end
  # end

  def weather_randomizer
    condition = rand(1..2)
    if condition == 1
      @current_weather = "stormy"
    else
      @current_weather = "not stormy"
    end
  end


end
