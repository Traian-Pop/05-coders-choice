defmodule Player.Mixfile do
  use Mix.Project

  def project do
    [
      app: :player,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
      #,mod: {Player.Application, []}
    ]
  end

  defp deps do
    [
      { :casino, path: "../casino" },
    ]
  end
end
