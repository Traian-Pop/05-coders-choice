defmodule Deck do

  defdelegate deck(),                   to: Deck.Impl
  defdelegate shuffle(deck \\ deck()),  to: Deck.Impl
  defdelegate deal(deck, num),          to: Deck.Impl

end
