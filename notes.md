## Call types
```ruby
{
  0 => "nothing",
  1 => "discard",
  2 => "chi",
  3 => "pon",
  4 => "closed kan",
  5 => "open kan",
  6 => "add kan",
  7 => "riichi",
  8 => "tsumo",
  9 => "ron",
  10 => "kyuushukyuuhai",
  11 => "declared yakuman"
}
```
## Operations hash structure

```ruby
{
  Type => ["Tile|Tile"],
  Type => ["Tile|Tile", "Tile|Tile"],
  Type => ""
}
```

* When a tile is dealt to you, the operations hash will always contain at least `{1=>""}`, unless you are in riichi
  * When in riichi, the game doesn't actually expect you to respond with anything, so makeDealDecision is not called
* If there is no possible call to make during another player's discard, makeDiscardDecision is not called (the data in `@round` is still updated)
* Types 1, 8, and 9 (Discard, Tsumo, and Ron) will have a value of an empty string, but you don't need this for anything.

## Other notes

* The game uses strings to represent tiles, so things like the bot's hand, dora indicators, etc. are all strings of tiles like "2m7p6s2z3m5m4z8p8p".
* The `@round` instance variable (see data.yml) is reinitialized at the start of every new round. It's fully readable and writeable from the Module, so feel free to add stuff to it
* `@round` and `@seat` are instance variables, so the @ symbol needs to be used when calling them. 'operations' and 'tile' are just local variables to the functions they're passed to.
* I used symbols for most of the operations hash keys. Basically, if it starts with a `:` make sure that's included when calling the data (e.g. `@rounds[:meta][:prevailing]`)
* The `@round` instance variable has an array at `@round[:meta][:dead]` that tracks the number of discarded tiles of each type that can be known to a player (discarded tiles, dora indicators). The first element of this array is the number of "1m" tiles not in play; the 34th element is the number of "7z" tiles not in play
* tamixe a shit :put_litter_in_its_place:

## Example of @round instance variable contents mid-game

```ruby
{
  :meta => {
          :dead => [ 0, 0, 3, 0, 0, 1, 1, 2, 1, 2, 2, 1, 0, 1, 1, 2, 1, 1, 3, 0, 0, 0, 1, 0, 1, 1, 1, 3, 1, 2, 3, 3, 2, 4 ],
    :prevailing => 1,
         :round => 0,
        :mywind => 3,
         :honba => 1,
         :doras => "8s",
     :remaining => 28
  },
      0 => {
      :pond => "2z6s4z3z4z5z7z3z9p6p8p",
    :called => [
      "7s9s8s",
      "8m9m7m"
    ]
  },
      1 => {
      :pond => "2m6m7z5z1z7z7z2p7p2m4p",
    :called => [],
    :riichi => true
  },
      2 => {
      :pond => "9p4z9m5z1p1p1z6z5p8m9p",
    :called => [
      "8p8p8p"
    ]
  },
      3 => {
      :pond => "4s9s7s2m7m8s6z7m9m5m",
    :called => [],
      :hand => "4m2p3p5p5p6p8p5m3p7p1p0p6p"
  }
}
```
