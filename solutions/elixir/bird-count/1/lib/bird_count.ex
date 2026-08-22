defmodule BirdCount do
  def today(list) do
    List.first(list)
  end

  def increment_day_count([]), do: [1]
  def increment_day_count(list) do
    [today | not_today] = list
    [today + 1 | not_today]
  end

  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([today | not_today]) do
    cond do
      today == 0 -> true
      true -> has_day_without_birds?(not_today)
    end
  end

  def total([]), do: 0
  def total([head | tail]) do
    head + total(tail)
  end

  def busy_days([]), do: 0
  def busy_days([h | t]) do
    cond do
      h >=5 -> 1 + busy_days(t)
      true -> busy_days(t)
    end
  end
end
