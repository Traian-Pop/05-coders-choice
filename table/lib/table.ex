defmodule Table do
  
  #  defdelegate spinner(),               to: Table.Impl
  #defdelegate spin(spinner),           to: Table.Impl
  defdelegate spin(),           to: Table.Impl
end
