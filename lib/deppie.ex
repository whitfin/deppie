defmodule Deppie do
  @moduledoc """
  Deppie is a very small library to make logging deprecation warnings easy.

  Typically you want to notify the user on first use of a deprecated function,
  rather than every time they use the function. Deppie makes this easy in an
  efficient and convenient way - the typical overhead of a `Deppie.once/1` call
  is under a single microsecond.
  """
  require Logger

  # inline for better perforfmance
  @compile {:inline, once: 1, warn: 1}

  @doc """
  Emits a deprecation message the first time this function is called.

  This makes it easy to log deprecation on first usage, rather than having to
  check manually.

  ## Examples

      iex> Deppie.once("MyModule.my_function/1 is deprecated!")
      :ok

  """
  @spec once(msg :: bitstring) :: :ok
  def once(msg) when is_bitstring(msg) do
    if should_log?() do
      :global_flags.once("deppie:once:#{:erlang.phash2(msg)}", fn ->
        warn(msg)
      end)
    end
    :ok
  end

  @doc """
  Emits a deprecation message every time this function is called.

  This is a less frequent use case, but it's used internally by `Deppie.once/1`
  to avoid duplication of any log formatting.

  ## Examples

      iex> Deppie.warn("MyModule.my_function/1 is deprecated!")
      :ok

  """
  @spec warn(msg :: bitstring) :: :ok
  def warn(msg) when is_bitstring(msg),
    do: Logger.warn("Deprecation Notice: #{msg}")

  # Determines whether we need to log or not, due to the log level. This is used
  # to make sure that we don't disable a deprecation warning
  defp should_log?,
    do: Logger.compare_levels(Logger.level, :warn) != :gt
end
