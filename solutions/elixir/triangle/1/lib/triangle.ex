defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do

    case valid?(a,b,c) do
      {true, _} -> do_type(a,b,c)
      {false, {:error, message}} ->
        {:error, message}
    end
      
  end

  defp valid?(a,b,c) when a <= 0 or b <= 0 or c <= 0, do: {false, {:error, "all side lengths must be positive"}}
  defp valid?(a,b,c) do
    cond do
      (a + b) >= c and (b + c) >= a and (a + c) >= b -> {true, ""}
      true -> {false, {:error, "side lengths violate triangle inequality"}}
    end
  end

  defp do_type(a, a, a), do: {:ok, :equilateral}
  defp do_type(a, b, c) when a != b and b != c and c != a, do: {:ok, :scalene}
  defp do_type(_a, _b, c), do: {:ok, :isosceles }
end