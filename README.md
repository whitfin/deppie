# Deppie

Deppie is a minimal deprecation logger for Elixir. The intent is to provide a very fast way to emit a deprecation message the first time a function is called. It's not meant to be fancy, it's just meant to work.

## Why Deppie?

Ever written a library and had to deprecate a function? That's why.

It's a pain in a stateless language to keep track of when you have/haven't logged a warning, so Deppie removes that pain in an easy way, without impacting the application flow. The typical overhead of a `Deppie.once/1` call is under a microsecond.

Originally this module was going to be named `Deprecation`, but that's pretty long to type ;)

## Installation

Deppie is available on Hex:

  1. Add deppie to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:deppie, "~> 1.0.0"}]
    end
    ```

  2. Ensure deppie is started before your application:

    ```elixir
    def application do
      [applications: [:deppie]]
    end
    ```

## Usage

It's super-duper easy to work with Deppie, as there are currently only two exposed functions; `warn/1` and `once/1`.

```elixir
# `Deppie.warn/1` just emits a basic deprecation notice
iex(1)> Deppie.warn("MyModule.my_function/1 is deprecated!")
12:48:14.037 [warn]  Deprecation Notice: MyModule.my_function/1 is deprecated!
:ok
# `Deppie.once/1` will only emit a message once during the life of an application
iex(2)> Deppie.once("MyModule.my_function/1 is deprecated!")
12:48:22.965 [warn]  Deprecation Notice: MyModule.my_function/1 is deprecated!
:ok
# Second time it's called, nothing happens!
iex(3)> Deppie.once("MyModule.my_function/1 is deprecated!")
:ok
```

If this library becomes popular, I might add bonus features like binary formatting - but for now the two functions above should be sufficient.
