import gleam/option.{Some}
import gleam/regex

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(re) =
    regex.from_string("^\\[(DEBUG)|(INFO)|(WARNING)|(ERROR)\\]")
  regex.check(re, line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(re) = regex.from_string("<[~*=-]*>")
  regex.split(re, line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(re) = regex.from_string("User\\s+([^\\s$]+)")
  case regex.scan(with: re, content: line) {
    [match] -> {
      let assert [Some(name)] = match.submatches
      "[USER] " <> name <> " " <> line
    }
    _ -> line
  }
}
