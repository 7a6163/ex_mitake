defmodule ExTwilio.Config do

  def username, do: from_env(:ex_mitake, :username)

  def password, do: from_env(:ex_mitake, :username)

  def api_domain, do: from_env(:ex_mitake, :api_domain, "smexpress.mitake.com.tw")

  def api_port, do: from_env(:ex_mitake, :api_port, "7002")

  def base_url, do: "http://#{api_domain()}:#{api_port()}"

  def from_env(otp_app, key, default \\ nil)

  def from_env(otp_app, key, default) do
    otp_app
    |> Application.get_env(key, default)
    |> read_from_system(default)
  end

  defp read_from_system({:system, env}, default), do: System.get_env(env) || default
  defp read_from_system(value, _default), do: value
end
