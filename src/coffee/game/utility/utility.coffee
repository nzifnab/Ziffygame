Game.Utility = {
  padString: (value, padSize, padChar) ->
    value += ""
    return value if value.length >= padSize
    padChar = if padChar? then padChar else '0'
    pad = new Array(1+padSize).join(padChar)
    (pad + value).slice(-pad.length)

  negativeCheck: (number) ->
    if number < 0
      -1
    else if number > 0
      1
    else
      0
}
