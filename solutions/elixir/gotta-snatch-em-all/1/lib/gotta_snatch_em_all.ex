defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    {MapSet.member?(collection, card), MapSet.put(collection, card)}
  end

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    updated_collection = 
      MapSet.put(collection, their_card)
      |> MapSet.delete(your_card)
    
    cond do 
      not MapSet.member?(collection, your_card) -> {false, updated_collection}
      MapSet.member?(collection, their_card) -> {false, updated_collection}
      true -> {true, updated_collection}
    end
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    MapSet.new(cards) |> MapSet.to_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection)
    |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []
  def boring_cards(collections) do
    Enum.reduce(collections, fn boring, acc -> 
      MapSet.intersection(boring, acc)
    end)
    |> MapSet.to_list()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0 
  def total_cards(collections) do
    Enum.reduce(collections, fn collection, acc -> 
      MapSet.union(collection, acc)
    end)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    shiny = fn n -> String.contains?(n, "Shiny") end
    {
      MapSet.filter(collection, shiny) |> MapSet.to_list(), 
      MapSet.reject(collection, shiny) |> MapSet.to_list()
    }
    
  end
end
