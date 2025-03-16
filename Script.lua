-- Criando a interface gráfica do ScriptHub
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 150)  -- Ajuste o tamanho do hub
Frame.Position = UDim2.new(0.5, -125, 0.5, -75)  -- Centraliza o hub na tela
Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true  -- Permite que o Frame seja movido

-- Função para criar botões
local function createButton(parent, text, position, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0, 200, 0, 40)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Text = text
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 18
    Button.Parent = parent
    Button.MouseButton1Click:Connect(callback)
    return Button
end

-- Criando os botões na interface
createButton(Frame, "COIN", UDim2.new(0, 25, 0, 30), function()
    game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Coins", 480, 99999999)
end)

createButton(Frame, "LVL", UDim2.new(0, 25, 0, 80), function()
    game:GetService("ReplicatedStorage").Remotes.generateBoost:FireServer("Levels", 480, 10)
end)

-- Criando o botão de fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = Frame
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- Fecha o GUI quando o botão for clicado
end)

-- Criando o botão de minimizar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -80, 0, 10)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
MinimizeButton.Text = "-"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = Frame
MinimizeButton.MouseButton1Click:Connect(function()
    -- Animação de minimizar
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local goal = {Size = UDim2.new(0, 250, 0, 30), Position = UDim2.new(0.5, -125, 0.5, -75)}
    local tween = tweenService:Create(Frame, tweenInfo, goal)
    tween:Play()
    tween.Completed:Connect(function()
        MinimizeButton.Visible = false
        RestoreButton.Visible = true
    end)
end)

-- Criando um botão para restaurar
local RestoreButton = Instance.new("TextButton")
RestoreButton.Size = UDim2.new(0, 30, 0, 30)
RestoreButton.Position = UDim2.new(1, -80, 0, 10)
RestoreButton.BackgroundColor3 = Color3.fromRGB(50, 50, 255)
RestoreButton.Text = "+"
RestoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RestoreButton.Font = Enum.Font.GothamBold
RestoreButton.TextSize = 20
RestoreButton.Parent = Frame
RestoreButton.Visible = false
RestoreButton.MouseButton1Click:Connect(function()
    -- Animação de restaurar
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local goal = {Size = UDim2.new(0, 250, 0, 150), Position = UDim2.new(0.5, -125, 0.5, -75)}
    local tween = tweenService:Create(Frame, tweenInfo, goal)
    tween:Play()
    tween.Completed:Connect(function()
        MinimizeButton.Visible = true
        RestoreButton.Visible = false
    end)
end)

-- Atalho para abrir/fechar o GUI (Ctrl Direito)
local UserInputService = game:GetService("UserInputService")
local isOpen = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.RightControl then
        if isOpen then
            ScreenGui:Destroy() -- Fecha o GUI
        else
            ScreenGui.Enabled = true
            -- Animação de abrir
            local tweenService = game:GetService("TweenService")
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            local goal = {Size = UDim2.new(0, 250, 0, 150), Position = UDim2.new(0.5, -125, 0.5, -75)}
            local tween = tweenService:Create(Frame, tweenInfo, goal)
            tween:Play()
        end
        isOpen = not isOpen
    end
end)
