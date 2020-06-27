#!/usr/bin/env ruby

module Tsumokiri
  # Required
  # Called whenever a tile is dealt to Pbot
  def makeDealDecision(operations, tile)
    hand = @round[@seat][:hand]
    keys = operations.keys
    discard = tile
    type, index = 1, nil

    # Tsumo
    if keys.include?(8)
      # Do tsumo things

    # Riichi
    elsif keys.include?(7)
      # Do riichi things

    # Discard
    else
      discard = chooseDiscard(hand + tile)
    end

    {type: type, index: index, tile: discard}
  end

  # Required
  # Called whenever another player discards a tile
  def makeDiscardDecision(operations, tile)
    keys = operations.keys
    type, index = 0, nil

    if keys.include?(9)
      # Do Ron things

    end
    # Or just ignore every call

    {type: type, index: index}
  end

  # Optional
  # You choose what tile to discard however you damn please
  def chooseDiscard(hand)
    hand[-2..-1]
  end
end
