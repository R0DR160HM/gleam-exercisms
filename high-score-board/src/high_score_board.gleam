import gleam/dict.{type Dict}
import gleam/option.{None, Some}

pub type ScoreBoard =
  Dict(String, Int)

pub fn create_score_board() -> ScoreBoard {
  dict.new()
  |> dict.insert("The Best Ever", 1_000_000)
}

pub fn add_player(
  score_board: ScoreBoard,
  player: String,
  score: Int,
) -> ScoreBoard {
  score_board
  |> dict.insert(player, score)
}

pub fn remove_player(score_board: ScoreBoard, player: String) -> ScoreBoard {
  score_board
  |> dict.delete(player)
}

pub fn update_score(
  score_board: ScoreBoard,
  player: String,
  points: Int,
) -> ScoreBoard {
  case dict.has_key(score_board, player) {
    True ->
      score_board
      |> dict.update(player, fn(x) {
        case x {
          Some(i) -> i + points
          None -> points
        }
      })
    False -> score_board
  }
}

pub fn apply_monday_bonus(score_board: ScoreBoard) -> ScoreBoard {
  score_board
  |> dict.map_values(fn(_, val) { val + 100 })
}
