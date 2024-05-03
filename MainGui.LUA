local http = game:GetService("HttpService")


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


local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Size = scrollingFrameSize
scrollingFrame.Position = UDim2.new(0, 5, 0, 30) -- adjust position to fit inside the frame
scrollingFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
scrollingFrame.BorderSizePixel = 0
scrollingFrame.ScrollBarThickness = 10
scrollingFrame.Parent = frame


local label = Instance.new("TextLabel")
label.Text = "Gazer Sheets Library"
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
    end)
    
    return Button
end

createButton("Anime Style", "later")
