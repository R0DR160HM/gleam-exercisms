import gleam/string

pub fn message(log_line: String) -> String {
  case log_line {
    "[ERROR]:" <> m -> string.trim(m)
    "[WARNING]:" <> m -> string.trim(m)
    "[INFO]:" <> m -> string.trim(m)
    _ -> "Invalid level, please use [INFO], [WARNING] or [ERROR]"
  }
}

pub fn log_level(log_line: String) -> String {
  case log_line {
    "[ERROR]:" <> _ -> "error"
    "[WARNING]:" <> _ -> "warning"
    "[INFO]:" <> _ -> "info"
    _ -> "Invalid level, please use [INFO], [WARNING] or [ERROR]"
  }
}

pub fn reformat(log_line: String) -> String {
  message(log_line) <> " (" <> log_level(log_line) <> ")"
}
