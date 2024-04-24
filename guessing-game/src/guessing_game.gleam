pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    41 | 43 -> "So close"
    g if g < 41 -> "Too low"
    g if g > 43 -> "Too high"
    _ -> "idk"
  }
}
