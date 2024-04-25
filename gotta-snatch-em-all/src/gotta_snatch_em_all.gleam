import gleam/set.{type Set}

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(set.contains(collection, card), set.insert(collection, card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  let possible =
    collection
    |> set.contains(my_card)

  let worth_it =
    !{
      collection
      |> set.contains(their_card)
    }

  let my_collection =
    collection
    |> set.delete(my_card)
    |> set.insert(their_card)

  #(possible && worth_it, my_collection)
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [current, next, ..rest] -> {
      boring_cards([
        current
          |> set.intersection(next),
        ..rest
      ])
    }
    [final] -> set.to_list(final)
    [] -> []
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  todo
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  todo
}
