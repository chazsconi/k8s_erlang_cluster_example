defmodule K8SExampleTest do
  use ExUnit.Case
  doctest K8SExample

  test "greets the world" do
    assert K8SExample.hello() == :world
  end
end
