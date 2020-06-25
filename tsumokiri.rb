#!/usr/bin/env ruby

module Tsumokiri

  # Required
  # Called whenever a tile is dealt to Pbot
  def makeDealDecision(operations, tile)
    hand = @round[@seat][:hand]
    keys = operations.keys
    discard = tile
    type = 1
    index = nil

    # Tsumo
    if keys.include?(8)
      # Do tsumo things
      type = 8
      discard = nil
      index = nil

    # Riichi
    elsif keys.include?(7)
      # Do riichi things
      type = 7
      index = 0
      discard = operations[type][index]

    # Discard
    else
      discard = chooseDiscard(hand + tile)
    end

    # Sets moqie value, updates Pbot's hand, then sends the action message
    # I would not recommend changing these
    moqie = isMoqie(discard)
    updateHand(tile, discard)
    doInputOperation(type: type, index: index, tile: discard, moqie: moqie)
  end

  # Required
  # Called whenever another player discards a tile
  def makeDiscardDecision(operations, tile)
    hand = @round[@seat][:hand]
    keys = operations.keys
    discard = tile
    type = nil
    index = nil
    cancelOp = 1

    if keys.include?(9)
      type = 9
      index = 0
      cancelOp = nil
      # Do Ron things

    else
      # Or just ignore every call
    end

    # Send response
    # Don't change this
    doInputChiPengGang(type: type, index: index, cancelOp: cancelOp)
  end

  # Optional
  # You choose what tile to discard however you damn please
  def chooseDiscard(hand)
    hand.pop
  end
end
