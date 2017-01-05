defmodule Deppie do
  require Logger

  @moduledoc """
  Deppie is a very small library to make logging deprecation warnings easy.

  Typically you want to notify the user on first use of a deprecated function,
  rather than every time they use the function. Deppie makes this easy in an
  efficient and convenient way - the typical overhead of a `Deppie.once/1` call
  is under a single microsecond.
  """

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
    Agent.cast(:deppie, fn(dep) ->
      hash = :erlang.md5(msg)
      if !MapSet.member?(dep, hash) and should_log?() do
        warn(msg)
        MapSet.put(dep, hash)
      else
        dep
      end
    end)
  end

  @doc """
  Resets Deppie to the initial state.

  This is typically of no use to anybody outside this library.

  ## Examples

      iex> Deppie.reset()
      :ok

  """
  @spec reset() :: :ok
  def reset do
    Agent.cast(:deppie, fn(_) -> MapSet.new() end)
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
  def warn(msg) when is_bitstring(msg) do
    Logger.warn("Deprecation Notice: #{msg}")
  end

  # Determines whether we need to log or not, due to the log level. This is used
  # to make sure that we don't disable a deprecation warning
  defp should_log? do
    Logger.compare_levels(Logger.level, :warn) != :gt
  end

end
