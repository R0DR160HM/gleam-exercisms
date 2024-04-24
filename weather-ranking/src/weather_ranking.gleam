import gleam/list
import gleam/order.{type Order}

pub type City {
  City(name: String, temperature: Temperature)
}

pub type Temperature {
  Celsius(Float)
  Fahrenheit(Float)
}

pub fn fahrenheit_to_celsius(f: Float) -> Float {
  { f -. 32.0 } /. 1.8
}

pub fn compare_temperature(left: Temperature, right: Temperature) -> Order {
  let left_temp = case left {
    Celsius(temp) -> temp
    Fahrenheit(temp) -> fahrenheit_to_celsius(temp)
  }

  let right_temp = case right {
    Celsius(temp) -> temp
    Fahrenheit(temp) -> fahrenheit_to_celsius(temp)
  }

  case left_temp, right_temp {
    l, t if l <. t -> order.Lt
    l, t if l >. t -> order.Gt
    _, _ -> order.Eq
  }
  // case left_temp, right_temp {
  //   l, t if l < t -> Lt
  // }
}

pub fn sort_cities_by_temperature(cities: List(City)) -> List(City) {
  cities
  |> list.sort(fn(a, b) { compare_temperature(a.temperature, b.temperature) })
}
