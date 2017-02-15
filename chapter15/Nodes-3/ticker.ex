defmodule Tickr do
  @interval 2000
  @name :tickr

  def start do
    pid = spawn(__MODULE__, :generator, [[], []])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), {:register, client_pid}
  end

  def generator(clients, queue) do
    receive do
      {:register, pid} ->
        IO.puts "registering #{inspect pid}"
	generator(clients ++ [pid], queue ++ [pid])
    after
      @interval ->
      	if length(queue) > 0 do
	  [head|tail] = queue
      	  send head, { :tick }
	  generator(clients, tail)
	else
	  generator(clients, clients)
	end
    end
  end
end

defmodule Client do
  def start do
    pid = spawn(__MODULE__, :receiver, [])
    Tickr.register(pid)
  end

  def receiver do
    receive do
      {:tick} ->
        IO.puts "tock in client"
	receiver
    end
  end
end