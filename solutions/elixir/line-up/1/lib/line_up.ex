defmodule LineUp do
  @doc """
  Formats a full ticket sentence for the given name and number, including
  the person's name, the ordinal form of the number, and fixed descriptive text.
  """
  @spec format(name :: String.t(), number :: pos_integer()) :: String.t()
  def format(name, number) do
    "#{name}, you are the #{number}#{suffix(number)} customer we serve today. Thank you!"
  end

  defp suffix(number) when rem(number, 100) in 11..13, do: "th"
  defp suffix(number) do
    cond do
      rem(number, 10) == 1 -> "st"
      rem(number, 10) == 2 -> "nd"
      rem(number, 10) == 3 -> "rd"
      true -> "th"
    end
  end
end
