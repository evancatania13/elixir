defmodule Username do
  def sanitize(~c""), do: ~c""
  def sanitize(username) do
    # ä becomes ae
    # ö becomes oe
    # ü becomes ue
    # ß becomes ss

    # Please implement the sanitize/1 function
    #97 - 122 (a-z)
    [letter | rest] = username
    case letter do
      letter when ?a <= letter and letter <= ?z -> 
        [letter | sanitize(rest)]
      letter when ?_ == letter ->
        [letter | sanitize(rest)]
      letter when ?ä == letter ->
        ~c"ae" ++ sanitize(rest)
      letter when ?ö == letter ->
        ~c"oe" ++ sanitize(rest)
      letter when ?ü == letter ->
        ~c"ue" ++ sanitize(rest)
      letter when ?ß == letter ->
        ~c"ss" ++ sanitize(rest)
      _ -> sanitize(rest)
    end
  end
end
