import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

pub fn to_tree(data: List(Int)) -> Tree {
  append_multiple(Nil, data)
}

pub fn append_multiple(to root: Tree, values data: List(Int)) {
  case data {
    [value, ..rest] ->
      append(value, to: root)
      |> append_multiple(rest)
    [] -> root
  }
}

pub fn append(to root: Tree, value value: Int) {
  case root {
    Nil -> Node(value, Nil, Nil)
    Node(current, left, right) -> {
      case value <= current {
        True -> Node(current, append(left, value), right)
        False -> Node(current, left, append(right, value))
      }
    }
  }
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data
  |> to_tree
  |> to_list
}

pub fn to_list(tree: Tree) -> List(Int) {
  case tree {
    Nil -> []
    Node(current, left, right) ->
      list.concat([to_list(left), [current], to_list(right)])
  }
}
