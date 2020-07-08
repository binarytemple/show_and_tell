defmodule MorphixExample do
  def main() do
    m = %{"top" => %{"inner" => %{innerist: [nil, 1]}, nil_val: nil}}

    IO.inspect(Morphix.atomorphiform!(m))
    IO.inspect(Morphix.compactiform!(m))
    IO.inspect(Morphix.equaliform?(%{cat: [0, 3, 4]}, %{cat: [3, 4, 0]}))
    IO.inspect(Morphix.equaliform?(%{cat: [0, 3, 4]}, %{cat: [3, 4, 0]}))

    nil
  end
end
