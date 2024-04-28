import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn read_emails(path: String) -> Result(List(String), Nil) {
  case simplifile.read(path) {
    Ok(file) -> {
      file
      |> string.split("\n")
      |> list.filter(fn(email) { email != "" })
      |> Ok
    }
    Error(_) -> Error(Nil)
  }
}

pub fn create_log_file(path: String) -> Result(Nil, Nil) {
  simplifile.create_file(path)
  |> result.nil_error
}

pub fn log_sent_email(path: String, email: String) -> Result(Nil, Nil) {
  simplifile.append(email <> "\n", to: path)
  |> result.nil_error
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  log_path
  |> create_log_file
  |> result.try(fn(_) { read_emails(emails_path) })
  |> result.try(fn(emails) { try_sending_email(emails, send_email, log_path) })
}

fn try_sending_email(
  emails: List(String),
  send_email: fn(String) -> Result(Nil, Nil),
  log_path: String,
) -> Result(Nil, Nil) {
  case emails {
    [current, ..rest] -> {
      let res = case send_email(current) {
        Ok(_) -> log_sent_email(log_path, current)
        Error(_) -> Ok(Nil)
      }
      res
      |> result.try(fn(_) { try_sending_email(rest, send_email, log_path) })
    }
    [] -> Ok(Nil)
  }
}
