local AreoVolt = {}
AreoVolt.Buttons = {}
AreoVolt.Labels = {}

function AreoVolt.DestroyExisting()
    local player = game:GetService("Players").LocalPlayer
    if player and player:FindFirstChild("PlayerGui") then
        local existingGUI = player.PlayerGui:FindFirstChild("AreoVoltHUB")
        if existingGUI then
            existingGUI:Destroy()
        end
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
    local container = Instance.new("ScrollingFrame") -- SCROLLING FRAME ADDED
    local layout = Instance.new("UIListLayout")

    -- Set Parent Correctly
    local player = game:GetService("Players").LocalPlayer
    if not player then return end
    AreoVoltHUB.Name = "AreoVoltHUB"
    AreoVoltHUB.Parent = player:WaitForChild("PlayerGui")

    -- GUI Settings
    AreoVoltHUB.ResetOnSpawn = false
    AreoVoltHUB.IgnoreGuiInset = true

    -- Main Window
    MainWindow.Parent = AreoVoltHUB
    MainWindow.BackgroundColor3 = Color3.new(0, 0, 0)
    MainWindow.BorderSizePixel = 0
    MainWindow.Position = UDim2.new(0.314, 0, 0.172, 0)
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

    -- SCROLLING FRAME for UI Elements
    container.Parent = MainWindow
    container.Size = UDim2.new(1, 0, 1, -25) -- Adjusted to fit everything below the topbar
    container.Position = UDim2.new(0, 0, 0, 25) -- Moves down below the topbar
    container.BackgroundTransparency = 1
    container.ClipsDescendants = true
    container.ScrollBarThickness = 5
    container.CanvasSize = UDim2.new(0, 0, 0, 0) -- Starts at 0, will auto-grow

    layout.Parent = container
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)

    -- Auto-adjust scrolling size when elements are added
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        container.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
    end)

    AreoVolt.Container = container -- Store container reference
    return MainWindow
end

-- Auto-Parent to Container (No Need to Specify Parent Anymore!)
function AreoVolt.CreateButton(settings)
    local button = Instance.new("TextButton")
    button.Name = settings.Name or "Button"
    button.Parent = AreoVolt.Container -- Automatically goes inside the container
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, 0)
    button.Text = settings.Text or "Button"
    button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    button.BackgroundTransparency = 0.3
    button.Font = Enum.Font.SciFi
    button.TextScaled = true
    button.TextColor3 = Color3.new(0, 0.6, 1)

    if settings.Callback then
        button.MouseButton1Click:Connect(settings.Callback)
    end

    AreoVolt.Buttons[button.Name] = button
    return button
end

function AreoVolt.CreateLabel(settings)
    local label = Instance.new("TextLabel")
    label.Name = settings.Name or "Label"
    label.Parent = AreoVolt.Container -- Automatically goes inside the container
    label.Size = UDim2.new(0.9, 0, 0, 30)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.Text = settings.Text or "Label"
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.SciFi
    label.TextScaled = true
    label.TextColor3 = Color3.new(0, 0.6, 1)

    AreoVolt.Labels[label.Name] = label
    return label
end
