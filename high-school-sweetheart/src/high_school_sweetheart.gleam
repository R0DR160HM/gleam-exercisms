import gleam/list
import gleam/string

pub fn first_letter(name: String) -> String {
  name
  |> string.trim()
  |> string.slice(0, 1)
}

pub fn initial(name: String) {
  name
  |> first_letter
  |> string.uppercase()
  |> string.append(".")
}

pub fn initials(full_name: String) -> String {
  let initials =
    full_name
    |> string.split(" ")
    |> list.map(initial(_))

  case initials {
    [first, second, ..] -> {
      first
      |> string.append(" ")
      |> string.append(second)
    }
    [first] -> first
    [] -> ""
  }
}

pub fn pair(full_name1: String, full_name2: String) {
  "
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     1. 1.  +  2. 2.     **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *
"
  |> string.replace("1. 1.", initials(full_name1))
  |> string.replace("2. 2.", initials(full_name2))
}
