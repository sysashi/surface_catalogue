defmodule Surface.Catalogue.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children =
      [
        {Phoenix.PubSub, name: Surface.Catalogue.PubSub}
      ] ++ endpoint()

    opts = [strategy: :one_for_one, name: Surface.Catalogue.Supervisor]

    Supervisor.start_link(children, opts)
  end

  if Mix.env() == :test && Mix.Project.get() == Surface.Catalogue.MixProject do
    defp endpoint(), do: [Surface.Catalogue.Server.Endpoint]
  else
    defp endpoint(), do: []
  end
end
