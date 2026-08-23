defmodule TopSecret do
  def to_ast(string) do
    {:ok, ast} = Code.string_to_quoted(string)
    ast
  end

  def decode_secret_message_part({opp, _meta, func} = ast, acc) when opp in [:def, :defp] do
    secret = handle_func(func)
    {ast, [secret | acc]}
  end

  defp handle_func([{name, _line , args} | rest] = _func) do
    case name do
      name when name != :when  -> 
        arity = if is_list(args), do: length(args), else: 0
        String.slice(to_string(name), 0, arity)
      _ -> handle_func(args)
    end
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], fn ast, acc -> decode_secret_message_part(ast, acc) end)
    acc
    |> Enum.reverse()
    |> Enum.join()
  end
end
