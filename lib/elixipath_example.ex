defmodule ElixirpathExample do
  def build_structure() do
    player1 = [:inner_player1, :inner_player2]
    player2 = [:inner_player3, :inner_player4]
    details1 = %{player: player1}
    details2 = %{player: player2}
    plays1 = %{details: details1}
    plays2 = %{details: details2}
    drivers = [%{plays: plays1}, %{plays: plays2}]
    %{scoring_drives: drivers}
  end

  def build_incomplete_structure() do
    player2 = [:inner_player3, :inner_player4]
    details2 = %{player: player2}
    plays1 = %{details: nil}
    plays2 = %{details: details2}
    drivers = [%{plays: plays1}, %{plays: plays2}]
    %{scoring_drives: drivers}
  end

  @doc """
  elixipath doesn't support filter expressions - such as the following
  ```
  kubectl get service  --output="jsonpath={.items[?(@.spec.type=='LoadBalancer')].status.loadBalancer.ingress[0].ip}"
  ```
  """
  def main() do
    structure = build_structure()
    IO.puts("structure #{inspect(structure, pretty: true)}")

    IO.puts("players_with #{inspect(players_with(structure), pretty: true)}")
    IO.puts("players_elixpath #{inspect(players_elixpath(structure), pretty: true)}")

    incomplete_structure = build_incomplete_structure()
    IO.puts("players_with #{inspect(players_with(incomplete_structure), pretty: true)}")
    IO.puts("players_elixpath #{inspect(players_elixpath(incomplete_structure), pretty: true)}")
  end

  # Extracting players using elixpath
  def players_elixpath(sd = %{scoring_drives: _}) do
    {:ok, res} = Elixpath.query(sd, ":scoring_drives.*.*.:details.:player")
    res
  end

  # Extracting players using For Comprehension
  def players_with(%{scoring_drives: drivers}) do
    for %{plays: %{details: %{player: player}}} <- drivers do
      player
    end
  end
end
