pub fn today(days: List(Int)) -> Int {
  case days {
    [today, ..] -> today
    _ -> 0
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [today, ..rest] -> [today + 1, ..rest]
    _ -> [1]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [today, ..] if today == 0 -> True
    [today, ..rest] if today > 0 -> has_day_without_birds(rest)
    _ -> False
  }
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [today, tomorrow, ..rest] -> total([today + tomorrow, ..rest])
    [count] -> count
    _ -> 0
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  busy_days_inner(days, 0)
}

fn busy_days_inner(days: List(Int), busy: Int) -> Int {
  case days {
    [current, ..rest] if current >= 5 -> busy_days_inner(rest, busy + 1)
    [_, ..rest] -> busy_days_inner(rest, busy)
    [] -> busy
  }
}
