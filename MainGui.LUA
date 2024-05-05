local http = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local maingui = Instance.new("ScreenGui")
maingui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frameSize = UDim2.new(0, 200, 0, 100)
local outerFrameSize = UDim2.new(0, 240, 0, 140)
local scrollingFrameSize = UDim2.new(1, -10, 1, -30) -- slightly smaller than the frame

local frame = Instance.new("Frame")
frame.Size = frameSize
frame.Position = UDim2.new(0.5, -frameSize.X.Offset / 2, 0.5, -frameSize.Y.Offset / 2)
frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
frame.BorderSizePixel = 2
frame.Parent = maingui
local gui = frame
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = gui.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = scrollingFrameSize
scrollingFrame.Position = UDim2.new(0, 5, 0, 30) -- adjust position to fit inside the frame
scrollingFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 10
scrollingFrame.Parent = frame

local label = Instance.new("TextLabel")
label.Text = " Gazer Sheets Library"
label.Size = UDim2.new(0, 100, 0, 20)
label.Position = UDim2.new(0, 30, 0, 5)
label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
label.BorderSizePixel = 0
label.Parent = frame

local xButton = Instance.new("TextButton")
xButton.Text = "x"
xButton.Size = UDim2.new(0, 20, 0, 20)
xButton.Position = UDim2.new(0, 5, 0, 5)
xButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
xButton.BorderSizePixel = 0
xButton.Parent = frame

xButton.MouseButton1Click:Connect(function()
    maingui:Destroy()
end)

local function createButton(name, scriptUrl)
    wait(0.1)
    local Button = Instance.new("TextButton")
    Button.Text = name
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.Position = UDim2.new(0, 5, 0, (#scrollingFrame:GetChildren() * 35) + 5)
    Button.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
    Button.Parent = scrollingFrame
    Button.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet(scriptUrl))()
        maingui:Destroy()
        wait(0.1) 
        frame.Size = UDim2.new(0, newSize, 0, newSize * 0.5)
    end)
    
    return Button
end

createButton("Anime Style", "https://raw.githubusercontent.com/GazerHA/Gazer-Sheets-Library/main/Anime%20Gui")
createButton("Classical", "https://raw.githubusercontent.com/GazerHA/Gazer-Sheets-Library/main/Classic%20Gui")
createButton("Subscribe Gazer_HA", "https://raw.githubusercontent.com/GazerHA/Gazer-Sheets-Library/main/Subscribe")

-- Add a textbox to set the UI size
local sizeTextbox = Instance.new("TextBox")
sizeTextbox.Size = UDim2.new(0, 100, 0, 20)
sizeTextbox.Position = UDim2.new(1, 5, 0, 5) -- Right of the frame
sizeTextbox.Parent = frame
sizeTextbox.PlaceholderText = "Set UI Size (300-500)"
sizeTextbox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSize = tonumber(sizeTextbox.Text)
        if newSize then
            newSize = math.clamp(newSize, 300, 500) -- Clamp size between 300 and 500
            frame.Size = UDim2.new(0, newSize, 0, newSize * 0.5) -- Example: Set both width and height to the same value
        end
    end
end)
