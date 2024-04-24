import gleam/list

// TODO: please define the Pizza custom type
pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_inner(pizza, 0)
}

fn pizza_price_inner(pizza: Pizza, extras: Int) -> Int {
  case pizza {
    Margherita -> extras + 7
    Caprese -> extras + 9
    Formaggio -> extras + 10
    ExtraSauce(p) -> pizza_price_inner(p, extras + 1)
    ExtraToppings(p) -> pizza_price_inner(p, extras + 2)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  case list.length(order) {
    2 -> order_calculate_price(order, 2)
    1 -> order_calculate_price(order, 3)
    _ -> order_calculate_price(order, 0)
  }
}

fn order_calculate_price(order: List(Pizza), total: Int) -> Int {
  case order {
    [pizza, ..rest] -> order_calculate_price(rest, pizza_price(pizza) + total)
    [] -> total
  }
}
