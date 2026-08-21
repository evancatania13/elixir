defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    cond do
      hypotenuse(x,y) > 10 -> 0
      hypotenuse(x,y) > 5 -> 1
      hypotenuse(x,y) > 1 -> 5
      true -> 10
    end
  end

  defp hypotenuse(x,y) do
    :math.sqrt(x*x + y*y)
  end
end
