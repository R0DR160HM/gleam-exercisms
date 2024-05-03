pub fn square_of_sum(n: Int) -> Int {
  do_sum(n, 1, 0)
}

fn do_sum(cap: Int, current: Int, acc: Int) -> Int {
  case current <= cap {
    True -> do_sum(cap, current + 1, acc + current)
    False -> acc * acc
  }
}

pub fn sum_of_squares(n: Int) -> Int {
  do_square_and_sum(n, 1, 0)
}

fn do_square_and_sum(cap: Int, current: Int, acc: Int) -> Int {
  case current <= cap {
    True -> {
      do_square_and_sum(cap, current + 1, acc + { current * current })
    }
    False -> acc
  }
}

pub fn difference(n: Int) -> Int {
  square_of_sum(n) - sum_of_squares(n)
}
