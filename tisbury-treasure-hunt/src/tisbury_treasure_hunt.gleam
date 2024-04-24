import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(place, location) = place_location
  #(location, place)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  let #(_, place_location) = place
  let reversed_place_location =
    place_location_to_treasure_location(place_location)

  treasures
  |> list.filter(fn(treasure) {
    let #(_, treasure_location) = treasure
    reversed_place_location == treasure_location
  })
  |> list.length
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  let #(found_treasure_name, _) = found_treasure
  let #(desired_treasure_name, _) = desired_treasure
  let #(place_name, _) = place

  case found_treasure_name, desired_treasure_name, place_name {
    "Brass Spyglass", _, "Abandoned Lighthouse" -> True
    "Amethyst Octopus", "Crystal Crab", "Stormy Breakwater" -> True
    "Amethyst Octopus", "Glass Starfish", "Stormy Breakwater" -> True
    "Vintage Pirate Hat", "Model Ship in Large Bottle", "Harbor Managers Office" ->
      True
    "Vintage Pirate Hat",
      "Antique Glass Fishnet Float",
      "Harbor Managers Office" -> True
    _, _, _ -> False
  }
}
