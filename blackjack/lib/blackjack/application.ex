defmodule Blackjack.Application do

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false    
    
    children = [
      worker(Blackjack, [], restart: :permanent)
    ]

    opts = [
      strategy: :one_for_one, 
      name: Blackjack.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
