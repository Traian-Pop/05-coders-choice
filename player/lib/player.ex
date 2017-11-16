defmodule Player do
  
  defdelegate play(), to: Player.Impl

end
