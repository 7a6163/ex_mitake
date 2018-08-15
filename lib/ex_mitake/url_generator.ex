defmodule ExMitake.UrlGenerator do
  alias ExMitake.Config

  def build_url(data) do
    data
    |> append_base_url()
    |> hacked_string()
  end

  defp append_base_url(query_string) do
    Config.base_url <> query_string
  end

  def to_query_string(list) do
    list
    |> Enum.flat_map(fn
      {key, value} when is_list(value) -> Enum.map(value, &{camelize(key), &1})
      {key, value} -> [{camelize(key), value}]
    end)
    |> URI.encode_query()
  end

  defp hacked_string(url) do
    String.replace(url, "+", "%20")
  end
end
