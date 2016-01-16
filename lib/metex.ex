defmodule Metex do

  def temperatures_of(cities) do
    coordinator_pid = spawn(Metex.Coordinator, :loop, [cities |> Enum.count])

    cities |> Enum.each fn city ->
      spawn(Metex.Worker, :loop, []) |> send({coordinator_pid, city})
    end
  end

end
