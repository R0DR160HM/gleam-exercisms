import gleam/option.{type Option, None, Some}

pub fn two_fer(name: Option(String)) -> String {
  let you = case name {
    None -> "you"
    Some(n) -> n
  }
  "One for " <> you <> ", one for me."
}
