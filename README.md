# keysequencer
a bare to the bone keyboard key "sequencer" Roblox module.

allows you to create "sequences," which act like keyboard shorcuts, and get returned a signal
that's fired whenever that sequence is matched. <br>
*X + C*
*A + W + S + D, etc.*

**note** that this is designed around of a keyboard shortcut-esque, where all keys have to be held synchronously, in order; it's not a "combo" of sorts.

# code examples;

### creating sequences
```luau
local KeySequencer = require(@KeySequencer)

local ShiftZ = KeySequencer(Enum.KeyCode.LeftShift, Enum.KeyCode.Z)
local CtrlVB = KeySequencer(Enum.KeyCode.LeftControl, Enum.KeyCode.V, Enum.KeyCode.B)
local CtrlHMPeriodPagedown = KeySequencer(Enum.KeyCode.LeftControl, Enum.KeyCode.H, Enum.KeyCode.M, Enum.KeyCode.Period, Enum.KeyCode.PageDown)

ShiftZ:Connect(function()
	print("Shift + Z was pressed!")
end)

CtrlVB:Connect(function()
	print("Ctrl + V + B was pressed!")
end)

CtrlHMPeriodPagedown:Connect(function()
	print("Your hands must be in weird positions right now.")
end)
```
	
## **credits** <br>
AlexanderLindholt, the writer of the signal library (SignalPlus) used, https://github.com/AlexanderLindholt
