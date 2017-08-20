defmodule KV.Bucket do
  use Agent

  @doc "Initializes the bucket."
  def start_link(_options) do
    Agent.start_link(fn -> %{} end)
  end

  @doc "Adds a new element to the bucket."
  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  @doc "Gets existing element from the bucket using the `key` or returns nil if there is no element with such a key."
  def get(bucket, key), do: Agent.get(bucket, &Map.get(&1, key))

  @doc "Deletes the `key-value` pair from the bucket."
  def delete(bucket, key) do
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
