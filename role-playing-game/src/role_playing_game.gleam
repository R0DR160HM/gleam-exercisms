import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  option.unwrap(player.name, "Mighty Magician")
}

pub fn revive(player: Player) -> Option(Player) {
  let mana = case player.level >= 10 {
    True -> Some(100)
    False -> player.mana
  }
  case player {
    Player(name, level, 0, _) -> {
      Some(Player(name, level, 100, mana))
    }
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player {
    Player(n, l, h, Some(mana)) if mana > cost -> {
      let updated_player = Player(n, l, h, Some(mana - cost))
      #(updated_player, cost * 2)
    }
    Player(n, l, h, Some(mana)) if mana == cost -> {
      let updated_player = Player(n, l, h, None)
      #(updated_player, cost * 2)
    }
    Player(n, l, h, None) if h > cost -> {
      let updated_player = Player(n, l, h - cost, None)
      #(updated_player, 0)
    }
    Player(n, l, h, None) if h <= cost -> {
      let updated_player = Player(n, l, 0, None)
      #(updated_player, 0)
    }
    _ -> #(player, 0)
  }
}
