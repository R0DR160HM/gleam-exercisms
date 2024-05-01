import gleam/queue.{type Queue}

pub fn insert_top(queue: Queue(Int), card: Int) -> Queue(Int) {
  queue
  |> queue.push_back(card)
}

pub fn remove_top_card(queue: Queue(Int)) -> Queue(Int) {
  case queue.pop_back(queue) {
    Ok(#(_, new_queue)) -> new_queue
    Error(_) -> queue
  }
}

pub fn insert_bottom(queue: Queue(Int), card: Int) -> Queue(Int) {
  queue
  |> queue.push_front(card)
}

pub fn remove_bottom_card(queue: Queue(Int)) -> Queue(Int) {
  case queue.pop_front(queue) {
    Ok(#(_, new_queue)) -> new_queue
    Error(_) -> queue
  }
}

pub fn check_size_of_stack(queue: Queue(Int), target: Int) -> Bool {
  queue.length(queue) == target
}
