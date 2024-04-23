import gleam/result

pub type Player {
  Black
  White
}

pub type Game {
  Game(
    white_captured_stones: Int,
    black_captured_stones: Int,
    player: Player,
    error: String,
  )
}

pub fn apply_rules(
  game: Game,
  rule1: fn(Game) -> Result(Game, String),
  rule2: fn(Game) -> Game,
  rule3: fn(Game) -> Result(Game, String),
  rule4: fn(Game) -> Result(Game, String),
) -> Game {
  let res =
    game
    |> rule1
    |> result.map(rule2)
    |> result.try(rule3)
    |> result.try(rule4)

  case res {
    Ok(g) -> toggle_player(g)
    Error(err) ->
      Game(
        game.white_captured_stones,
        game.black_captured_stones,
        game.player,
        err,
      )
  }
}

fn toggle_player(game: Game) -> Game {
  case game {
    Game(w, b, Black, error) -> Game(w, b, White, error)
    Game(w, b, White, error) -> Game(w, b, Black, error)
  }
}
