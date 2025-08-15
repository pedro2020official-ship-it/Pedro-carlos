--[[

Script Final Completo:

Sistema de Key: "PCFscripts"
Interface Rainbow / Neon (bordas rainbow, textos brancos)
4 posições para marcar
Teleguiado suave entre posições com noclip
Botão de Teleporte 3 metros à frente
Anti-reset, anti-patch, anti-volta e proteção suprema

--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local KEY_CORRETA = "PCFscripts"
local pos1,pos2,pos3,pos4 = nil,nil,nil,nil
local ultimaPosicao = nil
local tweenEmExecucao = false
local teleguiadoVelocidade = 57
local corFundo = Color3.fromRGB(0,0,0)
local corTexto = Color3.fromRGB(255,255,255)

-- Função Rainbow
local function criarRainbow(frame)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 2
    stroke.Transparency = 0
    spawn(function()
        while frame.Parent do
            stroke.Color = Color3.fromHSV((tick()*0.8)%1,0.9,1)
            task.wait(0.03)
        end
    end)
end

-- GUI Key
local keyGui = Instance.new("ScreenGui", PlayerGui)
keyGui.Name = "KeyGui"
keyGui.ResetOnSpawn = false

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0,300,0,200)
keyFrame.Position = UDim2.new(0.5,-150,0.5,-100)
keyFrame.BackgroundColor3 = corFundo
keyFrame.Active = true
keyFrame.Draggable = true
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0,12)
criarRainbow(keyFrame)

local byText = Instance.new("TextLabel", keyFrame)
byText.Size = UDim2.new(1,0,0,25)
byText.Position = UDim2.new(0,0,0,10)
byText.BackgroundTransparency = 1
byText.Text = "BY: Pedro and Carlos"
byText.TextColor3 = corTexto
byText.Font = Enum.Font.GothamBlack
byText.TextSize = 20
byText.TextXAlignment = Enum.TextXAlignment.Center

local title = Instance.new("TextLabel", keyFrame)
title.Size = UDim2.new(1,0,0,25)
title.Position = UDim2.new(0,0,0,40)
title.BackgroundTransparency = 1
title.Text = "🔑 Digite a Key:"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Center
title.TextColor3 = corTexto

local textBox = Instance.new("TextBox", keyFrame)
textBox.Size = UDim2.new(0.85,0,0,45)
textBox.Position = UDim2.new(0.075,0,0,70)
textBox.PlaceholderText = "Digite a key aqui..."
textBox.TextColor3 = corTexto
textBox.BackgroundColor3 = Color3.fromRGB(30,0,0)
Instance.new("UICorner", textBox).CornerRadius = UDim.new(0,8)

local confirmar = Instance.new("TextButton", keyFrame)
confirmar.Size = UDim2.new(0.85,0,0,45)
confirmar.Position = UDim2.new(0.075,0,0,125)
confirmar.Text = "Confirmar"
confirmar.TextColor3 = corTexto
confirmar.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner", confirmar).CornerRadius = UDim.new(0,8)

-- Função criar GUI principal
local mainGui, iconGui, mainFrame
local function criarMainGui()
    mainGui = Instance.new("ScreenGui", PlayerGui)
    mainGui.Name = "PCF_Hub"
    mainGui.ResetOnSpawn = false
    mainGui.Enabled = true

    mainFrame = Instance.new("Frame", mainGui)
    mainFrame.Size = UDim2.new(0,320,0,460)
    mainFrame.Position = UDim2.new(0.5,-160,0.5,-230)
    mainFrame.BackgroundColor3 = corFundo
    mainFrame.Active = true
    mainFrame.Draggable = true
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,14)
    criarRainbow(mainFrame)

    local titulo = Instance.new("TextLabel", mainFrame)
    titulo.Size = UDim2.new(1,-20,0,40)
    titulo.Position = UDim2.new(0,10,0,8)
    titulo.BackgroundTransparency = 1
    titulo.Text = "PCF Hub"
    titulo.Font = Enum.Font.GothamBlack
    titulo.TextSize = 26
    titulo.TextXAlignment = Enum.TextXAlignment.Center
    titulo.TextColor3 = corTexto
    criarRainbow(titulo)

    local subtitulo = Instance.new("TextLabel", mainFrame)
    subtitulo.Size = UDim2.new(1,-20,0,22)
    subtitulo.Position = UDim2.new(0,10,0,48)
    subtitulo.BackgroundTransparency = 1
    subtitulo.Text = "discord:https://discord.gg/x63GJy9Q"
    subtitulo.Font = Enum.Font.Gotham
    subtitulo.TextSize = 16
    subtitulo.TextXAlignment = Enum.TextXAlignment.Center
    subtitulo.TextColor3 = corTexto
    criarRainbow(subtitulo)

    local function criarBotao(texto,ordem)
        local b = Instance.new("TextButton", mainFrame)
        b.Size = UDim2.new(0,280,0,40)
        b.Position = UDim2.new(0.5,-140,0,90+(ordem-1)*48)
        b.Text = texto
        b.Font = Enum.Font.GothamBlack
        b.TextSize = 20
        b.TextColor3 = corTexto
        b.AutoButtonColor = false
        b.BackgroundColor3 = Color3.fromRGB(20,20,20)
        Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
        criarRainbow(b)
        b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(50,50,50) end)
        b.MouseLeave:Connect(function() b.BackgroundColor3 = Color3.fromRGB(20,20,20) end)
        return b
    end

    -- Botões
    local botao1 = criarBotao("📍 Marcar posição 1",1)
    local botao2 = criarBotao("📍 Marcar posição 2",2)
    local botao3 = criarBotao("📍 Marcar posição 3",3)
    local botao4 = criarBotao("📍 Marcar posição 4",4)
    local botaoGo = criarBotao("🚀 Teleguiado",5)
    local botaoResetPos = criarBotao("♻️ Resetar posições",6)
    local botaoBase = criarBotao("⚡ Teleporte 3m à frente",7)

    local function mostrarMensagemBotao(botao,texto)
        local oldText = botao.Text
        botao.Text = texto
        spawn(function()
            local tempo = 0
            while tempo < 2 do
                botao.TextColor3 = Color3.fromHSV((tick()*0.8)%1,0.9,1)
                task.wait(0.03)
                tempo = tempo + 0.03
            end
            botao.TextColor3 = corTexto
            botao.Text = oldText
        end)
    end

    local function mostrarConquista(texto)
        local gui = Instance.new("ScreenGui", PlayerGui)
        gui.ResetOnSpawn = false
        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0,200,0,50)
        frame.Position = UDim2.new(1,-210,1,-60)
        frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
        frame.BackgroundTransparency = 0.2
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0,8)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1,0,1,0)
        label.BackgroundTransparency = 1
        label.Text = texto
        label.Font = Enum.Font.GothamBold
        label.TextSize = 18
        label.TextXAlignment = Enum.TextXAlignment.Center
        label.TextYAlignment = Enum.TextYAlignment.Center

        spawn(function()
            local tempo = 0
            while tempo < 2 do
                label.TextColor3 = Color3.fromHSV((tick()*0.8)%1,0.9,1)
                task.wait(0.03)
                tempo = tempo + 0.03
            end
            gui:Destroy()
        end)
    end

    local function noclipAtivar(char)
        local partes = {}
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
                table.insert(partes, part)
            end
        end
        return partes
    end
    local function noclipDesativar(partes)
        for _, part in pairs(partes) do
            if part and part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end

    local function teleguiado(paraPos)
        if not paraPos or tweenEmExecucao then return end
        tweenEmExecucao = true
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        mostrarConquista("Noclip ON")
        local partesNoclip = noclipAtivar(char)

        local duracao = (paraPos - hrp.Position).Magnitude / teleguiadoVelocidade
        local tween = TweenService:Create(hrp, TweenInfo.new(duracao, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(paraPos)})
        tween:Play()
        tween.Completed:Wait()

        noclipDesativar(partesNoclip)
        mostrarConquista("Chegou!")
        tweenEmExecucao = false
    end

    -- Marcar posições
    botao1.MouseButton1Click:Connect(function()
        pos1 = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").Position
        ultimaPosicao = pos1
        mostrarMensagemBotao(botao1,"Posição 1 marcada!")
    end)
    botao2.MouseButton1Click:Connect(function()
        pos2 = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").Position
        ultimaPosicao = pos2
        mostrarMensagemBotao(botao2,"Posição 2 marcada!")
    end)
    botao3.MouseButton1Click:Connect(function()
        pos3 = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").Position
        ultimaPosicao = pos3
        mostrarMensagemBotao(botao3,"Posição 3 marcada!")
    end)
    botao4.MouseButton1Click:Connect(function()
        pos4 = (player.Character or player.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart").Position
        ultimaPosicao = pos4
        mostrarMensagemBotao(botao4,"Posição 4 marcada!")
    end)

    botaoGo.MouseButton1Click:Connect(function()
        if ultimaPosicao then
            teleguiado(ultimaPosicao)
        else
            mostrarConquista("❌ Nenhuma posição marcada!")
        end
    end)

    botaoResetPos.MouseButton1Click:Connect(function()
        pos1,pos2,pos3,pos4,ultimaPosicao = nil,nil,nil,nil,nil
        mostrarConquista("✅ Posições resetadas!")
    end)

    botaoBase.MouseButton1Click:Connect(function()
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        hrp.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 3
        mostrarConquista("Teleporte 3m concluído!")
    end)

    -- Ícone abrir/fechar
    iconGui = Instance.new("ScreenGui", PlayerGui)
    iconGui.Name = "IconeScript"
    iconGui.ResetOnSpawn = false
    iconGui.Enabled = true

    local icon = Instance.new("TextButton", iconGui)
    icon.Size = UDim2.new(0,60,0,60)
    icon.Position = UDim2.new(0,12,0,12)
    icon.Text = "C"
    icon.TextSize = 28
    icon.Font = Enum.Font.GothamBlack
    icon.TextColor3 = corTexto
    icon.BackgroundColor3 = corFundo
    Instance.new("UICorner", icon).CornerRadius = UDim.new(1,0)
    criarRainbow(icon)
    icon.MouseButton1Click:Connect(function()
        mainGui.Enabled = not mainGui.Enabled
    end)
end

-- Validação da Key
confirmar.MouseButton1Click:Connect(function()
    local input = textBox.Text:match("%S+")
    if input and input:lower() == KEY_CORRETA:lower() then
        keyGui:Destroy()
        criarMainGui()
    else
        textBox.Text = "❌ Key incorreta"
    end
end)
