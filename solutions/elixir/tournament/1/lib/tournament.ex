defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @default_stats %{mp: 0, w: 0, d: 0, l: 0, p: 0}
  @outcomes ["win", "loss", "draw"]

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    sanitize_input(input)
    |> generate_score_card()
    |> Enum.sort_by(fn {name, stats} -> {-stats.p, name} end)
    |> print_score_card()
  end

  defp sanitize_input(input) do
    Enum.reject(input, fn item -> 
      case String.split(item, ";") do
        [_,_, outcome] when outcome in @outcomes -> false
        _ -> true
      end
    end)
  end

  defp print_score_card(results) do
    header = "Team                           | MP |  W |  D |  L |  P"

    rows = 
      Enum.map_join(results, "\n", fn {name, stats} -> 
        "#{String.pad_trailing(name, 31)}|#{format_stats(stats)}" 
      end)

    if rows == "", do: header, else: header <> "\n" <> rows
  end 
  
  defp format_stats(stats) do
    " #{String.pad_leading(to_string(stats.mp), 2)} |" <>
    " #{String.pad_leading(to_string(stats.w), 2)} |" <>
    " #{String.pad_leading(to_string(stats.d), 2)} |" <>
    " #{String.pad_leading(to_string(stats.l), 2)} |" <>
    " #{String.pad_leading(to_string(stats.p), 2)}"
  end
  
  defp generate_score_card([]), do: %{};
  defp generate_score_card(input) do
    Enum.reduce(input, %{}, fn item, results_map -> 
      [team_a, team_b, outcome] = String.split(item, ";")
      updated_map = 
        results_map
        |> Map.put_new(team_a, @default_stats)
        |> Map.put_new(team_b, @default_stats)
        
      case (outcome) do
        "draw" -> 
          Map.update!(updated_map, team_a, fn stats -> 
            %{stats | mp: stats.mp + 1, w: stats.w, l: stats.l, d: stats.d + 1, p: stats.p + 1 }
          end)
          |> Map.update!(team_b, fn stats -> 
            %{stats | mp: stats.mp + 1, w: stats.w, l: stats.l, d: stats.d + 1, p: stats.p + 1 }
          end)
        "win" -> 
          Map.update!(updated_map, team_a, fn stats -> 
            %{stats | mp: stats.mp + 1, w: stats.w + 1, l: stats.l, d: stats.d, p: stats.p + 3 }
          end)
          |> Map.update!(team_b, fn stats -> 
            %{stats | mp: stats.mp + 1, w: stats.w, l: stats.l + 1, d: stats.d, p: stats.p }
          end)
        "loss" ->
          Map.update!(updated_map, team_a, fn stats -> 
            %{stats | mp: stats.mp + 1, w: stats.w, l: stats.l + 1, d: stats.d, p: stats.p }
          end)
          |> Map.update!(team_b, fn stats -> 
            %{stats | mp: stats.mp + 1, w: stats.w + 1, l: stats.l, d: stats.d, p: stats.p + 3 }
          end)
        _ -> nil
      end
    end) 
  end

end


