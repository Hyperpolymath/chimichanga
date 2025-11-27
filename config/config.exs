import Config

# Munition configuration
config :munition,
  # Default runtime implementation
  runtime: Munition.Runtime.Wasmex,
  # Default fuel allocation
  default_fuel: 100_000,
  # Default timeout in milliseconds
  default_timeout: 5_000

# Import environment specific config
import_config "#{config_env()}.exs"
