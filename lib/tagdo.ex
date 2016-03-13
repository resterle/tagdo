defmodule Tagdo do

    def rm_first(string), do: String.slice(string, 1, String.length(string))
    
    def build_tupel(string) do
        case(String.first(string)) do
          "#" -> {:tag, rm_first(string)}
          "@" -> {:at, rm_first(string)}
          _   -> {:data, string}
        end
    end

    def categorize({key, value}, acc) do
      case acc[key] do
        nil -> Map.put(acc, key, [value]) 
        list -> %{acc | key => list ++ [value]}
      end
    end

    def build_map(input) do
        String.split(input, " ")
        |> Enum.reduce(%{}, fn(s, acc) -> build_tupel(s) |> categorize(acc) end)
    end

end
