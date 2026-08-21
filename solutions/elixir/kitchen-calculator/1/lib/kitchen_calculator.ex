defmodule KitchenCalculator do
  def get_volume(volume_pair) do
    Kernel.elem(volume_pair,1)
  end

  def to_milliliter({:cup, value}) do
    {:milliliter, value * 240}
  end 

  def to_milliliter({:fluid_ounce, value}) do
    {:milliliter,value * 30}
  end 

  def to_milliliter({:teaspoon, value}) do
    {:milliliter,value * 5}
  end 

  def to_milliliter({:tablespoon, value}) do
    {:milliliter,value * 15}
  end 

  def to_milliliter({:milliliter, value}) do
    {:milliliter,value}
  end 
  
  # Please implement the from_milliliter/2 functions
  def from_milliliter({:milliliter, value}, :cup)  do
    {:cup, value / 240}
  end

  def from_milliliter({:milliliter, value}, :fluid_ounce)  do
    {:fluid_ounce, value / 30}
  end

  def from_milliliter({:milliliter, value}, :teaspoon)  do
    {:teaspoon, value / 5}
  end

  def from_milliliter({:milliliter, value}, :tablespoon)  do
    {:tablespoon, value / 15}
  end

  def from_milliliter({:milliliter, value}, :milliliter)  do
    {:milliliter, value }
  end

  def convert(volume_pair, unit) do
    # Please implement the convert/2 function
    from_milliliter(to_milliliter(volume_pair), unit)
  end
end
