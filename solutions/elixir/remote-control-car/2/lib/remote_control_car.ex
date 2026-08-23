defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100, 
    distance_driven_in_meters: 0
  ]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname \\ "none") do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{} = remote_car) do
    {_, value} = Map.fetch(remote_car, :distance_driven_in_meters)
    "#{value} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0} = _remote_car) do
     "Battery empty"
  end 
  def display_battery(%RemoteControlCar{} = remote_car) do
    {_, value} = Map.fetch(remote_car, :battery_percentage)
    "Battery at #{value}%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = remote_car), do: remote_car
  def drive(%RemoteControlCar{} = remote_car) do
    %{remote_car | 
      battery_percentage: remote_car.battery_percentage  - 1,
      distance_driven_in_meters: remote_car.distance_driven_in_meters + 20
    }
  end
end
