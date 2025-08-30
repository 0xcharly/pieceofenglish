import Config

defmodule PoeConfig do
  def create_http_config() do
    with {:ok, addr} <- System.get_env("HTTP_BINDING_ADDRESS"),
         {:ok, ip} <- :inet.parse_address(addr) do
      [ip: ip, port: port]
    else
      _ ->
        raise """
        environment variable HTTP_BINDING_ADDRESS is missing or invalid.
        For example: 127.0.0.1
        """
    end
  end
end

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.

# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/poe start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if System.get_env("PHX_SERVER") do
  config :poe, PoeWeb.Endpoint, server: true
end

if config_env() == :prod do
  database_path =
    System.get_env("DATABASE_PATH") ||
      raise """
      environment variable DATABASE_PATH is missing.
      For example: /etc/poe/poe.db
      """

  config :poe, Poe.Repo,
    database: database_path,
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "5")

  # The secret key base is used to sign/encrypt cookies and other secrets.
  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  config :poe, :dns_cluster_query, System.get_env("DNS_CLUSTER_QUERY")

  config :poe, PoeWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: PoeConfig.create_http_config(),
    secret_key_base: secret_key_base
end
