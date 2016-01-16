defmodule Metex.Coordinator do
  
  def loop(results \\ [], results_expected) do
    receive do
      {:ok, result} ->
        new_results = [result | results]
        if results_expected == new_results |> Enum.count do
          self |> send(:exit)
        end
        loop(new_results, results_expected)
      :exit ->
        results |> Enum.sort |> Enum.join(", ") |> IO.puts
      _ ->
        loop(results, results_expected)
    end
  end

end