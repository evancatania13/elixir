defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    pid = Kernel.spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} ->
        Map.put(results, input, :ok)
      {:EXIT, ^pid, reason} ->
        Map.put(results, input, :error)
    after
      100 ->
        Map.put(results, input, :timeout)
    end 
  end

  def reliability_check(calculator, inputs) do
    trap_exit = Process.flag(:trap_exit, true)
    
    starts = Enum.reduce(inputs, [], fn input, acc -> 
        map = start_reliability_check(calculator,input)
        [map | acc]
    end)

    awaits = Enum.reduce(starts, %{}, fn start, acc -> 
        map = await_reliability_check_result(start,acc)
        Map.merge(acc, map)
    end)
    Process.flag(:trap_exit, trap_exit)
    awaits
  end

  def correctness_check(calculator, inputs) do
    trap_exit = Process.flag(:trap_exit, true)
    
    tasks = Enum.reduce(inputs, [], fn input, acc -> 
        task = Task.async(fn -> calculator.(input) end)
        [task | acc]
    end)

    results = Enum.reduce(tasks, [], fn task, acc -> 
        result = Task.await(task, 100)
        [result | acc ]
    end)
    Process.flag(:trap_exit, trap_exit)
    results
  end
end
