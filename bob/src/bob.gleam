import gleam/regex
import gleam/string

pub fn hey(remark: String) -> String {
  case is_question(remark), is_yell(remark), is_silence(remark) {
    True, False, False -> "Sure."
    False, True, False -> "Whoa, chill out!"
    True, True, False -> "Calm down, I know what I'm doing!"
    False, False, True -> "Fine. Be that way!"
    _, _, _ -> "Whatever."
  }
}

fn is_question(r: String) {
  r
  |> string.trim
  |> string.ends_with("?")
  // let assert Ok(reg) = regex.from_string("\\?\\s*$")
  // regex.check(reg, r)
}

fn is_yell(r: String) {
  let assert Ok(reg) = regex.from_string("[A-Z]")
  regex.check(reg, r) && string.uppercase(r) == r
  // let assert Ok(reg1) = regex.from_string("[a-z]")
  // !regex.check(reg1, r) && regex.check(reg2, r)
}

fn is_silence(r: String) {
  string.trim(r) == ""
  // let assert Ok(reg) = regex.from_string("^\\s*$")
  // regex.check(reg, r)
}
