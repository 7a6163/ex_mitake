defmodule ExMitake.Api do
  use HTTPoison.Base
  alias ExMitake.Config
  alias ExMitake.UrlGenerator, as: Url
  alias __MODULE__

  def send_message(data) do
    url = "http://#{Config.api_domain()}:7003/SpSendUtf?"
    data |> append_auth() |> format_data() |> build_url(url) |> Api.get!()
  end

  defp build_url(query_string, base_url) do
    base_url <> query_string
  end

  defp format_data(data) when is_map(data) do
    data
    |> Map.to_list()
    |> Url.to_query_string()
  end

  defp format_data(data) when is_list(data) do
    Url.to_query_string(data)
  end

  defp format_data(data) do
    data
  end

  defp append_auth(data) do
    [username: Config.username(),
     password: Config.password(),
     CharsetURL: "utf-8"] ++ data
  end
end
