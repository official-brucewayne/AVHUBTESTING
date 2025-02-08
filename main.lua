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
	-- Remove any existing GUI before making a new one
	AreoVolt.DestroyExisting()

	local title = settings.Title or "Window"

	local AreoVoltHUB = Instance.new("ScreenGui")
	local MainWindow = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local topbar = Instance.new("Frame")
	local close = Instance.new("TextButton")
	local titleLabel = Instance.new("TextLabel")
	local container = Instance.new("Frame") -- Holds UI elements
	local layout = Instance.new("UIListLayout") -- Prevents overlapping

	local player = game:GetService("Players").LocalPlayer
	if not player then return end
	AreoVoltHUB.Name = "AreoVoltHUB"
	AreoVoltHUB.Parent = player:WaitForChild("PlayerGui")

	-- Window styling
	MainWindow.Parent = AreoVoltHUB
	MainWindow.Size = UDim2.new(0, 369, 0, 388)
	MainWindow.BackgroundColor3 = Color3.new(0, 0, 0)

	UICorner.Parent = MainWindow

	-- Topbar
	topbar.Parent = MainWindow
	topbar.Size = UDim2.new(1, 0, 0, 25)
	topbar.BackgroundTransparency = 1

	close.Parent = topbar
	close.Size = UDim2.new(0, 25, 0, 25)
	close.Text = "X"

	titleLabel.Parent = topbar
	titleLabel.Size = UDim2.new(1, -30, 0, 25)
	titleLabel.Text = title
	titleLabel.TextXAlignment = Enum.TextXAlignment.Left

	-- Close Button Functionality
	close.MouseButton1Click:Connect(function()
		AreoVoltHUB:Destroy()
	end)

	-- Container for elements
	container.Parent = MainWindow
	container.Size = UDim2.new(1, 0, 1, -30)
	container.Position = UDim2.new(0, 0, 0, 30)
	container.BackgroundTransparency = 1

	layout.Parent = container
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 5)

	return MainWindow, container
end

function AreoVolt.CreateButton(parent, settings)
	local button = Instance.new("TextButton")
	button.Parent = parent
	button.Size = UDim2.new(0.9, 0, 0, 40)
	button.Position = UDim2.new(0.05, 0, 0, 0)
	button.Text = settings.Text or "Button"
	button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)

	if settings.Callback then
		button.MouseButton1Click:Connect(settings.Callback)
	end

	return button
end

function AreoVolt.CreateLabel(parent, settings)
	local label = Instance.new("TextLabel")
	label.Parent = parent
	label.Size = UDim2.new(0.9, 0, 0, 30)
	label.Position = UDim2.new(0.05, 0, 0, 0)
	label.Text = settings.Text or "Label"
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)

	return label
end

return AreoVolt
