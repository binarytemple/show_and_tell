defmodule PackmaticExampleSource do
  @behaviour Packmatic.Source

  defstruct ram_file: nil

  def validate(_arg) do
    :ok
  end

  def init(bytes) when is_binary(bytes) do
    {:ok, file} = File.open("foo.txt", [:ram, :write, :binary, :read])
    :file.write(file, bytes)
    :file.position(file, 0)
    {:ok, %PackmaticExampleSource{ram_file: file}}
  end

  def read(%PackmaticExampleSource{ram_file: ram_file}) do
    case ram_file |> IO.binstream(1024 * 1024) |> Enum.take(1) do
      [data] -> [data]
      [] -> :eof
    end
  end
end

defmodule PackmaticExample do
  def main() do
    entries = [
      [
        source: {:url, "https://codeload.github.com/elixir-lang/elixir/tar.gz/master"},
        path: "elixir-master.tar.gz"
      ],
      [
        source: {PackmaticExampleSource, "this package contains the downloaded elixir sources"},
        path: "readme.txt"
      ]
    ]

    stream = Packmatic.build_stream(entries)

    stream |> Stream.into(File.stream!("/tmp/foo.zip", [:write])) |> Stream.run()
  end
end
