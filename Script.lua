local keyCorrect = string.reverse("4321KED-YEK")

-- Função para tornar a GUI arrastável
local function makeDraggable(frame)
    local dragToggle = false
    local dragInput, mousePos, framePos
    
    local function updateInput(input)
        local delta = input.Position - mousePos
        frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
    end
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragToggle = true
            mousePos = input.Position
            framePos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input == dragInput and dragToggle then
            updateInput(input)
        end
    end)
end

-- Criando a GUI da Key moderna
local ScreenGui = Instance.new("ScreenGui")
local KeyFrame = Instance.new("Frame")
local KeyBox = Instance.new("TextBox")
local SubmitButton = Instance.new("TextButton")
local MinimizeKey = Instance.new("TextButton")
local MinimizedFrame = Instance.new("Frame")
local OpenKeyButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

KeyFrame.Size = UDim2.new(0, 350, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
KeyFrame.BackgroundTransparency = 0.2
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = ScreenGui
makeDraggable(KeyFrame)

KeyBox.Size = UDim2.new(0, 250, 0, 50)
KeyBox.Position = UDim2.new(0.5, -125, 0.3, 0)
KeyBox.PlaceholderText = "Digite a key..."
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
KeyBox.Parent = KeyFrame

SubmitButton.Size = UDim2.new(0, 250, 0, 50)
SubmitButton.Position = UDim2.new(0.5, -125, 0.65, 0)
SubmitButton.Text = "Verificar"
SubmitButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Parent = KeyFrame

MinimizeKey.Size = UDim2.new(0, 30, 0, 30)
MinimizeKey.Position = UDim2.new(1, -40, 0, 10)
MinimizeKey.Text = "-"
MinimizeKey.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
MinimizeKey.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeKey.Parent = KeyFrame

-- Criando a caixinha minimizada
MinimizedFrame.Size = UDim2.new(0, 100, 0, 40)
MinimizedFrame.Position = UDim2.new(0, 10, 0.9, -50)
MinimizedFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizedFrame.Visible = false
MinimizedFrame.Parent = ScreenGui
makeDraggable(MinimizedFrame)

OpenKeyButton.Size = UDim2.new(1, 0, 1, 0)
OpenKeyButton.Text = "Abrir Hub"
OpenKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenKeyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
OpenKeyButton.Parent = MinimizedFrame

MinimizeKey.MouseButton1Click:Connect(function()
    KeyFrame.Visible = false
    MinimizedFrame.Visible = true
end)

OpenKeyButton.MouseButton1Click:Connect(function()
    KeyFrame.Visible = true
    MinimizedFrame.Visible = false
end)

SubmitButton.MouseButton1Click:Connect(function()
    if KeyBox.Text == keyCorrect then
        KeyFrame.Visible = false
        MinimizedFrame:Destroy()
        showMainHub()
    else
        KeyBox.Text = "Key incorreta!"
    end
end)

-- Criando a GUI do Script Hub
function showMainHub()
    local MainGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local GiveLevel = Instance.new("TextButton")
    local GiveCoin = Instance.new("TextButton")
    local InfiniteCoin = Instance.new("TextButton")
    local MinimizeMain = Instance.new("TextButton")

    MainGui.Parent = game.CoreGui

    MainFrame.Size = UDim2.new(0, 350, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    MainFrame.Parent = MainGui
    makeDraggable(MainFrame)

    GiveLevel.Size = UDim2.new(0, 300, 0, 50)
    GiveLevel.Position = UDim2.new(0.5, -150, 0.2, 0)
    GiveLevel.Text = "Give Level"
    GiveLevel.Parent = MainFrame
    GiveLevel.MouseButton1Click:Connect(function()
        game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Levels", 480, 10)
    end)

    GiveCoin.Size = UDim2.new(0, 300, 0, 50)
    GiveCoin.Position = UDim2.new(0.5, -150, 0.5, 0)
    GiveCoin.Text = "Give Coin"
    GiveCoin.Parent = MainFrame
    GiveCoin.MouseButton1Click:Connect(function()
        game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 480, 99999999)
    end)

    InfiniteCoin.Size = UDim2.new(0, 300, 0, 50)
    InfiniteCoin.Position = UDim2.new(0.5, -150, 0.8, 0)
    InfiniteCoin.Text = "Infinite Coin"
    InfiniteCoin.Parent = MainFrame
    InfiniteCoin.MouseButton1Click:Connect(function()
        while true do
            game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 480, 99999999)
            wait(1)
        end
    end)
end
