local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local manager = {Prefix = "!"}

if Players:FindFirstChild("USERNAME_4ACC") then
    owner = Players["USERNAME_4ACC"]
end

function GetPlayerFromName(txt)
    for i,v in next, Players:GetChildren() do
        if v ~= LocalPlayer and string.lower(v.Name):match(string.lower(txt)) then
            return v
        end
    end
end

function Teleport(cframe)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored == false then
        local hrp = LocalPlayer.Character:WaitForChild("HumanoidRootPart") 
        hrp.CFrame = cframe
     end
end

manager.commands = {
    [manager.Prefix.."tpall"] = function(Sender, args)
        if LocalPlayer.Character and Sender.Character and Sender.Character:FindFirstChild("HumanoidRootPart") and Sender.Character:FindFirstChild("HumanoidRootPart").Anchored == false then
            Teleport(Sender.Character.HumanoidRootPart.CFrame)
        end
    end,
    [manager.Prefix.."me"] = function(Sender, args)
        if args[1] and LocalPlayer.Character and Sender.Character and Sender.Character:FindFirstChild("HumanoidRootPart") and Sender.Character:FindFirstChild("HumanoidRootPart").Anchored == false then
            local hrp = Sender.Character:FindFirstChild("HumanoidRootPart") 

            if GetPlayerFromName(args[1]) == LocalPlayer then
                Teleport(hrp.CFrame)
            end   

         end
    end
}

local function PassCommand(Sender, Message)
    local message = string.lower(Message)
    local arguments = string.split(message, " ")
    local command = arguments[1]

    if manager.commands[string.lower(command)] then
        table.remove(arguments, 1)
        manager.commands[string.lower(command)](Sender, arguments) 
    end   
end

owner.Chatted:Connect(function(message)
    PassCommand(owner, message)
end)
