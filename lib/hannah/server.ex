defmodule Hannah.Server do
  use GenServer

  #Client API ################
  def start_link(personality) do
    IO.puts Hannah.Bot.greeting(personality)

    GenServer.start_link(__MODULE__, personality, name: __MODULE__)
  end

  def converse(input), do: GenServer.call(__MODULE__, {:converse, input})
  def farewell, do: GenServer.cast(__MODULE__, :farewell)

  #Server Callbacks ################

  def handle_call({:converse, input}, _from, personality) do
    response = Hannah.Bot.response_to(input, personality)
    { :reply, response, personality}
  end

  def handle_cast(:farewell, personality) do
    IO.puts Hannah.Bot.farewell(personality)
    GenServer.stop(__MODULE__)
  end
end
