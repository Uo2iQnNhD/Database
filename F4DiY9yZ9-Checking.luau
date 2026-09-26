local UserInputService = game:GetService("UserInputService")
local isMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled
local isPC = UserInputService.MouseEnabled and not UserInputService.TouchEnabled

if isMobile then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/LgMrbYxN-LoadingMobile.luau"))()
elseif isPC then
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Uo2iQnNhD/Database/refs/heads/main/XpjD4k78-Loading.luau"))()
end
