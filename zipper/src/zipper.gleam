pub type Tree(a) {
  Leaf
  Node(value: a, left: Tree(a), right: Tree(a))
}

pub opaque type Zipper(a) {
  Zipper(focus: Tree(a), path: List(Direction(a)))
}

type Direction(a) {
  Left(a, node: Tree(a))
  Right(a, node: Tree(a))
}

pub fn to_zipper(tree: Tree(a)) -> Zipper(a) {
  Zipper(tree, [])
}

pub fn to_tree(zipper: Zipper(a)) -> Tree(a) {
  case up(zipper) {
    Ok(zipper) -> to_tree(zipper)
    Error(Nil) -> zipper.focus
  }
}

pub fn value(zipper: Zipper(a)) -> Result(a, Nil) {
  case zipper {
    Zipper(Leaf, ..) -> Error(Nil)
    Zipper(Node(value, ..), ..) -> Ok(value)
  }
}

pub fn up(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(path: [], ..) -> Error(Nil)
    Zipper(focus: left, path: [Left(value, right), ..path]) ->
      Ok(Zipper(focus: Node(value, left, right), path: path))
    Zipper(focus: right, path: [Right(value, left), ..path]) ->
      Ok(Zipper(focus: Node(value, left, right), path: path))
  }
}

pub fn left(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, left, right), path: path) ->
      Ok(Zipper(focus: left, path: [Left(value, right), ..path]))
  }
}

pub fn right(zipper: Zipper(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, left, right), path: path) ->
      Ok(Zipper(focus: right, path: [Right(value, left), ..path]))
  }
}

pub fn set_value(zipper: Zipper(a), value: a) -> Zipper(a) {
  case zipper {
    Zipper(focus: Leaf, ..) -> Zipper(..zipper, focus: Node(value, Leaf, Leaf))
    Zipper(focus: Node(_, left, right), ..) ->
      Zipper(..zipper, focus: Node(value, left, right))
  }
}

pub fn set_left(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, _, right), ..) ->
      Ok(Zipper(..zipper, focus: Node(value, tree, right)))
  }
}

pub fn set_right(zipper: Zipper(a), tree: Tree(a)) -> Result(Zipper(a), Nil) {
  case zipper {
    Zipper(focus: Leaf, ..) -> Error(Nil)
    Zipper(focus: Node(value, left, _), ..) ->
      Ok(Zipper(..zipper, focus: Node(value, left, tree)))
  }
}
