[![Build Status](https://travis-ci.org/jlgeering/magixir.svg?branch=master)](https://travis-ci.org/jlgeering/magixir)

# Magixir

**WIP do not use**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `magixir` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:magixir, "~> 0.1.0"}]
    end
    ```

  2. Ensure `magixir` is started before your application:

    ```elixir
    def application do
      [applications: [:magixir]]
    end
    ```

## Contributor Information

### Test it

```sh
mix test       # Run tests once
mix test.watch # Run tests on file changes
mix credo      # Code linter
```

## See Also

* Version 1, in Ruby: [maruto](https://github.com/jlgeering/maruto)
* Version 2, in Clojure: [clojento](https://github.com/jlgeering/clojento)
