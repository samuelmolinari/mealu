# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mealu,
  ecto_repos: [Mealu.Repo]

# Configures the endpoint
config :mealu, Mealu.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AMVp60sgHXJgeXvLs2C9jYu9Wyuu46Chn5L3jCOkF4yslvfEud3VfrEjtCMJHvrR",
  render_errors: [view: Mealu.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mealu.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
