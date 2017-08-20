defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = start_supervised(KV.Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 5)
    assert KV.Bucket.get(bucket, "milk") == 5
  end

  test "deletes values by key", %{bucket: bucket} do
    KV.Bucket.put(bucket, "eggs", 2)
    assert KV.Bucket.get(bucket, "eggs") == 2

    assert KV.Bucket.delete(bucket, "eggs") == 2
    assert KV.Bucket.get(bucket, "eggs") == nil
  end
end
