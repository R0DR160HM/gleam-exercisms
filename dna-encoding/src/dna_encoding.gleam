import gleam/list

pub type Nucleotide {
  Adenine
  Cytosine
  Guanine
  Thymine
}

pub fn encode_nucleotide(nucleotide: Nucleotide) -> Int {
  case nucleotide {
    Adenine -> 0b00
    Cytosine -> 0b01
    Guanine -> 0b10
    Thymine -> 0b11
  }
}

pub fn decode_nucleotide(nucleotide: Int) -> Result(Nucleotide, Nil) {
  case nucleotide {
    0b00 -> Ok(Adenine)
    0b01 -> Ok(Cytosine)
    0b10 -> Ok(Guanine)
    0b11 -> Ok(Thymine)
    _ -> Error(Nil)
  }
}

pub fn encode(dna: List(Nucleotide)) -> BitArray {
  encode_inner(dna, <<>>)
}

fn encode_inner(dna: List(Nucleotide), value: BitArray) -> BitArray {
  case dna {
    [current, ..rest] -> {
      let value = <<value:bits, encode_nucleotide(current):2>>
      encode_inner(rest, value)
    }
    [] -> value
  }
}

pub fn decode(dna: BitArray) -> Result(List(Nucleotide), Nil) {
  decode_inner(dna, [])
}

fn decode_inner(
  dna: BitArray,
  decoded: List(Nucleotide),
) -> Result(List(Nucleotide), Nil) {
  case dna {
    <<current:2, rest:bits>> -> {
      case decode_nucleotide(current) {
        Ok(nuc) -> {
          decode_inner(rest, list.append(decoded, [nuc]))
        }
        Error(_) -> Error(Nil)
      }
    }
    <<>> -> Ok(decoded)
    _ -> Error(Nil)
  }
}
