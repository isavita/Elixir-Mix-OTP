defmodule KV.RegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, registry} = start_supervised KV.Registry
    %{registry: registry}
  end

  test "spwans buckets", %{registry: registry} do
    assert KV.Registry.lookup(registry, "shopping") == :error

    assert KV.Registry.create(registry, "shopping") == :ok
    assert {:ok, bucket} = KV.Registry.lookup(registry, "shopping")

    KV.Bucket.put(bucket, "eggs", 12)
    assert KV.Bucket.get(bucket, "eggs") == 12
  end

  test "removes buckets on exit", %{registry: registry} do
    KV.Registry.create(registry, "shopping")
    {:ok, bucket} = KV.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)
    assert KV.Registry.lookup(registry, "shopping") == :error
  end
end
