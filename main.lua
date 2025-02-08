local AreoVolt = {}

-- Function to check and remove an existing AreoVolt GUI
function AreoVolt.DestroyExisting()
    local existing = game.CoreGui:FindFirstChild("AreoVoltHUB") 
        or (game:GetService("Players").LocalPlayer 
        and game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") 
        and game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("AreoVoltHUB"))

    if existing then
        existing:Destroy()
    end
end

function AreoVolt.CreateWindow(settings)
    AreoVolt.DestroyExisting()

    local title = settings.Title or "Window"

    local AreoVoltHUB = Instance.new("ScreenGui")
    local MainWindow = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local topbar = Instance.new("Frame")
    local close = Instance.new("TextButton")
    local titleLabel = Instance.new("TextLabel")
    local container = Instance.new("Frame") 
    local layout = Instance.new("UIListLayout") 

    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    AreoVoltHUB.Name = "AreoVoltHUB"
    AreoVoltHUB.Parent = player:WaitForChild("PlayerGui")

    -- Main Window (Preserves Your Position & Design)
    MainWindow.Parent = AreoVoltHUB
    MainWindow.BackgroundColor3 = Color3.new(0, 0, 0)
    MainWindow.BorderSizePixel = 0
    MainWindow.Position = UDim2.new(0.314843744, 0, 0.172297299, 0)
    MainWindow.Size = UDim2.new(0, 369, 0, 388)

    UICorner.Parent = MainWindow

    -- Top Bar
    topbar.Parent = MainWindow
    topbar.BackgroundTransparency = 1
    topbar.BorderSizePixel = 0
    topbar.Size = UDim2.new(0, 369, 0, 25)

    -- Close Button
    close.Parent = topbar
    close.BackgroundTransparency = 1
    close.BorderSizePixel = 0
    close.Position = UDim2.new(0.932, 0, 0, 0)
    close.Size = UDim2.new(0, 25, 0, 25)
    close.Font = Enum.Font.SciFi
    close.Text = "X"
    close.TextColor3 = Color3.new(0, 0.6, 1)
    close.TextScaled = true

    -- Title Label
    titleLabel.Parent = topbar
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0.016, 0, 0, 0)
    titleLabel.Size = UDim2.new(0, 338, 0, 25)
    titleLabel.Font = Enum.Font.SciFi
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(0, 0.6, 1)
    titleLabel.TextScaled = true
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Close Button Functionality
    close.MouseButton1Click:Connect(function()
        AreoVoltHUB:Destroy()
    end)

    -- Container for UI elements (Prevents Overlapping)
    container.Parent = MainWindow
    container.Size = UDim2.new(1, 0, 1, -30)
    container.Position = UDim2.new(0, 0, 0, 30)
    container.BackgroundTransparency = 1

    layout.Parent = container
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)

    return MainWindow, container
end

-- Function to Create Buttons (Preserves Your Design)
function AreoVolt.CreateButton(parent, settings)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.Text = settings.Text or "Button"
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.Font = Enum.Font.SciFi
    button.TextScaled = true
    button.TextColor3 = Color3.new(1, 1, 1)

    if settings.Callback then
        button.MouseButton1Click:Connect(settings.Callback)
    end

    return button
end

-- Function to Create Labels (Preserves Your Design)
function AreoVolt.CreateLabel(parent, settings)
    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Size = UDim2.new(0.9, 0, 0, 30)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.Text = settings.Text or "Label"
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SciFi
    label.TextScaled = true
    label.TextColor3 = Color3.new(1, 1, 1)

    return label
end

return AreoVolt
