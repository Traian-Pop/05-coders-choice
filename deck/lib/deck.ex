defmodule Deck do

  alias Deck.Impl

  defdelegate deck(),                   to: Impl
  defdelegate deck(suits, nums),        to: Impl
  defdelegate shuffle(deck \\ deck()),  to: Impl
  defdelegate deal(deck, num),          to: Impl

end
