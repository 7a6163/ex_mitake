defmodule ExMitake.Api do
  use HTTPoison.Base
  alias ExMitake.UrlGenerator, as: Url
  alias __MODULE__

  def send_message(data) do
    data |> format_data |> Url.build_url() |> Api.get!()
  end

  defp format_data(data) when is_map(data) do
    data
    |> Map.to_list()
    |> Url.to_query_string()
  end

  defp format_data(data) when is_list(data) do
    Url.to_query_string(data)
  end

  defp format_data(data), do: data
end
