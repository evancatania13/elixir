defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts :: opts) :: {:ok, opts} | {:error, opts}

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
  
  @callback handle_frame(dot :: dot, frame_number :: frame_number, opts :: opts) :: dot
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  
  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    if rem(frame_number, 4) == 0 do
      %{dot | opacity: dot.opacity/2}
    else
      dot
    end
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation
  
  @impl DancingDots.Animation
  def init(opts) do
    velocity = Keyword.get(opts, :velocity, nil)
    
    if is_number(velocity) do
      {:ok, [{:velocity, velocity}]}
    else
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end        
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    {_status, velocity} = Keyword.fetch(opts, :velocity)
    radius_modifier = (frame_number - 1) * velocity
    %{dot | radius: dot.radius + radius_modifier}
  end
end
