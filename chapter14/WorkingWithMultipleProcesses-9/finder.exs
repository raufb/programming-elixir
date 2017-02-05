defmodule Finder do

  def run(dir_path) do
    dir_full_path = Path.expand(dir_path)
    file_list = File.ls!(dir_full_path) |> Enum.map(&(Path.join([ dir_full_path, &1 ])))
    Enum.each 1..10, fn num_processes ->
      {time, result} = :timer.tc(Scheduler, :run, [num_processes, Finder, :find, file_list])
      if num_processes == 1 do
        IO.puts inspect result
        IO.puts "\n #   time(s)"
    end
    :io.format "~2B   ~.2f~n", [num_processes, time/1000000.0]
  end
  
  end

  def find(scheduler) do
    send scheduler, { :ready, self}
    receive do
      { :exec, file_path, client } ->
        send client, { :answer, file_path, find_occurrences(file_path, "cat"), self }
	find(scheduler)
      { :shutdown } ->
        exit(:normal)
    end
  end

  def find_occurrences(file_path, pattern) do
    text = File.read!(file_path)
    text_length = String.length(text)
    length_without_pattern = String.length(String.replace(text, pattern, "", global: true))
    div( (text_length - length_without_pattern), String.length(pattern) )
  end

end

defmodule Scheduler do

  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map( fn(_) -> spawn(module, func, [self] ) end)
    |> schedule_processes(to_calculate, [])

  end

  def schedule_processes(processes, queue, results) do
    receive do
      { :ready, pid } when length(queue) > 0 ->
        [next | tail] = queue
	send pid, {:exec, next, self}
	schedule_processes(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
	if length(processes) > 1 do
	  schedule_processes(List.delete(processes, pid), queue, results)
	else
	  Enum.sort( results, fn {n1,_}, {n2,_} -> n1 <= n2 end )
	end
      {:answer, input, result, _pid} ->
        schedule_processes(processes, queue, [ {input, result} | results])
    end
  end
end