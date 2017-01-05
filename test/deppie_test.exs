defmodule DeppieTest do
  use ExUnit.Case, async: false

  alias ExUnit.CaptureLog

  setup do
    start_level = Logger.level()

    on_exit(fn ->
      Logger.configure([ level: start_level ])
    end)

    Logger.configure([ level: :debug ])

    Deppie.reset()

    :ok
  end

  test "warn/1" do
    msg = CaptureLog.capture_log(fn ->
      Deppie.warn("deprecation message")
    end)

    assert(msg =~ "Deprecation Notice: deprecation message")
  end

  test "once/1" do
    deprecation_msg = gen_msg()

    msg = CaptureLog.capture_log(fn ->
      Deppie.once(deprecation_msg)
      :timer.sleep(5)
    end)

    assert(msg =~ "Deprecation Notice: #{deprecation_msg}")

    msg = CaptureLog.capture_log(fn ->
      Deppie.once(deprecation_msg)
      :timer.sleep(5)
    end)

    assert(msg == "")
  end

  test "once/1 with a higher log level" do
    Logger.configure([ level: :error ])

    deprecation_msg = gen_msg()

    msg = CaptureLog.capture_log(fn ->
      Deppie.once(deprecation_msg)
      :timer.sleep(5)
    end)

    assert(msg == "")

    Logger.configure([ level: :debug ])

    msg = CaptureLog.capture_log(fn ->
      Deppie.once(deprecation_msg)
      :timer.sleep(5)
    end)

    assert(msg =~ "Deprecation Notice: #{deprecation_msg}")
  end

  defp gen_msg do
    :crypto.rand_uniform(1, 10000) |> to_string
  end

end
