# ltween
tween for lua

## Usage
```
local tween = require "tween"
local obj = tween.new()
obj:make(tween.type.Linear, 10, tween.wrap_mode.Once, 0, 1)
obj:test()
```

## Statement
This work is based on AHEasing: https://github.com/warrenm/AHEasing
