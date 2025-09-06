--!strict
--@author guywithalemon

--[[

	> an extremely simple key sequencer module, for the barest of basics.
	
	> allows you to create "sequences," which act like keyboard shorcuts, and get returned a signal
	  that's fired whenever that sequence is matched.  e.g. X + C | A + W + S + D, etc.
	
	credits ->
	> AlexanderLindholt, the writer of the signal library used

]]

local UserInputService = game:GetService("UserInputService")
local Signal = require(script.Signal)
local Sequences = require(script.Sequences)

local CurrentKeySequence:{number} = {}

local PRIME_MULT = 31
local MODULUS = 2^32 - 1

--Creates and returns an indentifier hash from a table of Keycode integral values.
local function CreateSequenceHash(keycodes:{number}) : number

	local currentHash = 0

	for _, keycode in keycodes do
		currentHash = (currentHash * PRIME_MULT + keycode) % MODULUS
	end
	
	return currentHash

end

UserInputService.InputBegan:Connect(function(inputObject:InputObject, gameProcessedEvent:boolean)
	
	if gameProcessedEvent or inputObject.KeyCode == Enum.KeyCode.Unknown then return end
	
	table.insert(CurrentKeySequence, inputObject.KeyCode.Value)
	local newHash = CreateSequenceHash(CurrentKeySequence)
	
	local foundSequence = Sequences[newHash]
	if foundSequence then foundSequence:Fire() end
	
end)

UserInputService.InputEnded:Connect(function(inputObject:InputObject, gameProcessedEvent:boolean)
		
	if inputObject.KeyCode == Enum.KeyCode.Unknown then return end
	
	local foundKeycode = table.find(CurrentKeySequence, inputObject.KeyCode.Value)
	if not foundKeycode then return end
	
	table.remove(CurrentKeySequence, foundKeycode)
		
end)

--Create a new key sequence, returning its Signal.
return function(...:Enum.KeyCode) : Signal.Signal<>
	
	local indicedKeycodes = {}
	
	for index, keycode in {...} do
		indicedKeycodes[index] = keycode.Value
	end
	
	local identifier = CreateSequenceHash(indicedKeycodes)
	local sequenceSignal = Signal(identifier)
	
	Sequences[identifier] = sequenceSignal

	return sequenceSignal

end