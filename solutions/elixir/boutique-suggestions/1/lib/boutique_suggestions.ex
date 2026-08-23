defmodule BoutiqueSuggestions do
  def get_combinations(tops, bottoms, options \\ []) do
    maximum_price = Keyword.get(options, :maximum_price, 100)
    
    for %{base_color: top_color, price: top_price} = top <- tops,
        %{base_color: bottom_color, price: bottom_price} = bottom <- bottoms, 
        top_color != bottom_color,
        (top_price + bottom_price) <= maximum_price
        do
      {top, bottom}
    end
  end
end
