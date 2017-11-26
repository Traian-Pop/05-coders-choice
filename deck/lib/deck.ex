defmodule Deck do

  alias Deck.Impl

  defdelegate deck(),                   to: Deck.Impl
  #defdelegate deck(suits, nums),        to: Deck.Impl
  defdelegate shuffle(deck \\ deck()),  to: Deck.Impl
  defdelegate deal(deck, num),          to: Deck.Impl

end
