defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) do
    case get_factors(number) do
      {:error, message} -> {:error, message}
      factors -> do_classify(factors, number) 
    end 
  end

  defp get_factors(number) when number <= 0, do: {:error, "Classification is only possible for natural numbers." }
  defp get_factors(number) do
    top = number/2 |> Float.ceil() |> Kernel.trunc()
    
    1..top
    |> Enum.reject(fn x -> ( rem(number, x) != 0 or x == number) end)
  end

  defp do_classify(factors, number) do
    sum = Enum.reduce(factors, 0, fn x, acc -> x + acc end)
    case sum do
      sum when sum == number -> {:ok, :perfect}
      sum when sum > number -> {:ok, :abundant}
      sum when sum < number -> {:ok, :deficient}
    end
  end 
end
