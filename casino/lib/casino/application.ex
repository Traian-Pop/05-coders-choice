defmodule Casino.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false
    
    children = [
      worker(Casino, [], restart: :permanent)
    ]
    
    opts = [
      strategy: :one_for_one, 
      name: Casino.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
