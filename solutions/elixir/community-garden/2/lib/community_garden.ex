# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\Keyword.new()) do
    {:ok, _agent_pid} = Agent.start(fn -> {0,[]} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_, list} -> list end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn 
      [] ->
        new_id = 1
        plot = %Plot{plot_id: new_id, registered_to: register_to}
        {plot, {new_id, [plot]}}
      {count, plots} ->
        new_id = count + 1
        plot = %Plot{plot_id: new_id, registered_to: register_to}
        { plot, {new_id,[plot | plots]}}
    end)
  end

  def release(pid, plot_id) do
    Agent.get_and_update(pid, fn
      {count, plots} ->
        {:ok, {count, Enum.reject(plots, fn plot -> plot.plot_id == plot_id end)}}
      end)
  end

  def get_registration(pid, plot_id) do
    list = 
      list_registrations(pid)
      |> Enum.filter(fn plot -> plot.plot_id == plot_id end)
    
    case list do
        [] -> {:not_found, "plot is unregistered"}
        _ -> List.first(list)
    end
  end
end