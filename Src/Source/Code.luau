--[[
    AuroraUI v2.0 - Modern Roblox UI Library
]]

local AuroraUI = {}
AuroraUI.__index = AuroraUI

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Lucide Icons (optimized set)
local LucideIcons = {
    ["home"] = "rbxassetid://7733960981",
    ["settings"] = "rbxassetid://7734053495",
    ["user"] = "rbxassetid://7733955511",
    ["shield"] = "rbxassetid://7734056595",
    ["eye"] = "rbxassetid://7733965388",
    ["zap"] = "rbxassetid://7734068321",
    ["menu"] = "rbxassetid://7734063302",
    ["x"] = "rbxassetid://7734060711",
    ["minus"] = "rbxassetid://7733959802",
    ["maximize"] = "rbxassetid://7733955740",
    ["minimize"] = "rbxassetid://7733955740",
    ["check"] = "rbxassetid://7733715400",
    ["chevron-down"] = "rbxassetid://7733717447",
    ["chevron-up"] = "rbxassetid://7733717651",
    ["chevron-left"] = "rbxassetid://7733717651",
    ["chevron-right"] = "rbxassetid://7733717651",
    ["search"] = "rbxassetid://7734053426",
    ["bell"] = "rbxassetid://7733710707",
    ["moon"] = "rbxassetid://7733955086",
    ["sun"] = "rbxassetid://7734066296",
    ["trash"] = "rbxassetid://7734065795",
    ["edit"] = "rbxassetid://7733964719",
    ["plus"] = "rbxassetid://7733954760",
    ["copy"] = "rbxassetid://7733963885",
    ["refresh"] = "rbxassetid://7734056468",
    ["play"] = "rbxassetid://7733954058",
    ["pause"] = "rbxassetid://7733952335",
    ["skip-forward"] = "rbxassetid://7734057257",
    ["skip-back"] = "rbxassetid://7734057257",
    ["volume"] = "rbxassetid://7734073250",
    ["volume-x"] = "rbxassetid://7734073250",
    ["wifi"] = "rbxassetid://7734079055",
    ["battery"] = "rbxassetid://7733710707",
    ["clock"] = "rbxassetid://7733963388",
    ["calendar"] = "rbxassetid://7733917120",
    ["mail"] = "rbxassetid://7733954088",
    ["phone"] = "rbxassetid://7733954088",
    ["map"] = "rbxassetid://7733954088",
    ["compass"] = "rbxassetid://7733963885",
    ["camera"] = "rbxassetid://7733917120",
    ["image"] = "rbxassetid://7733960981",
    ["music"] = "rbxassetid://7733954088",
    ["video"] = "rbxassetid://7734073250",
    ["file"] = "rbxassetid://7733960981",
    ["folder"] = "rbxassetid://7733960981",
    ["download"] = "rbxassetid://7733964719",
    ["upload"] = "rbxassetid://7734079055",
    ["share"] = "rbxassetid://7734056595",
    ["link"] = "rbxassetid://7733955740",
    ["lock"] = "rbxassetid://7733955740",
    ["unlock"] = "rbxassetid://7733955740",
    ["key"] = "rbxassetid://7733955740",
    ["star"] = "rbxassetid://7734066296",
    ["heart"] = "rbxassetid://7733960981",
    ["thumbs-up"] = "rbxassetid://7734065795",
    ["thumbs-down"] = "rbxassetid://7734065795",
    ["smile"] = "rbxassetid://7734066296",
    ["frown"] = "rbxassetid://7733964719",
    ["meh"] = "rbxassetid://7733954088",
    ["alert"] = "rbxassetid://7733710707",
    ["alert-circle"] = "rbxassetid://7733710707",
    ["alert-triangle"] = "rbxassetid://7733710707",
    ["info"] = "rbxassetid://7733955740",
    ["help"] = "rbxassetid://7733955740",
    ["terminal"] = "rbxassetid://7734065795",
    ["code"] = "rbxassetid://7733963885",
    ["github"] = "rbxassetid://7733960981",
    ["twitter"] = "rbxassetid://7734065795",
    ["facebook"] = "rbxassetid://7733960981",
    ["instagram"] = "rbxassetid://7733960981",
    ["youtube"] = "rbxassetid://7734079055",
    ["twitch"] = "rbxassetid://7734065795",
    ["discord"] = "rbxassetid://7733963885",
    ["slack"] = "rbxassetid://7734066296",
    ["trello"] = "rbxassetid://7734065795",
    ["trending-up"] = "rbxassetid://7734065795",
    ["trending-down"] = "rbxassetid://7733964719",
    ["activity"] = "rbxassetid://7733710707",
    ["bar-chart"] = "rbxassetid://7733917120",
    ["pie-chart"] = "rbxassetid://7733954088",
    ["layers"] = "rbxassetid://7733955740",
    ["layout"] = "rbxassetid://7733955740",
    ["grid"] = "rbxassetid://7733960981",
    ["list"] = "rbxassetid://7733955740",
    ["sidebar"] = "rbxassetid://7734056595",
    ["more-horizontal"] = "rbxassetid://7733954088",
    ["more-vertical"] = "rbxassetid://7733959802",
    ["command"] = "rbxassetid://7733963885",
    ["hash"] = "rbxassetid://7733960981",
    ["at-sign"] = "rbxassetid://7733710707",
    ["dollar-sign"] = "rbxassetid://7733964719",
    ["percent"] = "rbxassetid://7733954760",
    ["shopping-cart"] = "rbxassetid://7734056595",
    ["shopping-bag"] = "rbxassetid://7734056595",
    ["package"] = "rbxassetid://7733954088",
    ["truck"] = "rbxassetid://7734065795",
    ["anchor"] = "rbxassetid://7733710707",
    ["flag"] = "rbxassetid://7733960981",
    ["award"] = "rbxassetid://7733917120",
    ["crown"] = "rbxassetid://7733963885",
    ["gift"] = "rbxassetid://7733960981",
    ["briefcase"] = "rbxassetid://7733917120",
    ["book"] = "rbxassetid://7733917120",
    ["bookmark"] = "rbxassetid://7733917120",
    ["paperclip"] = "rbxassetid://7733954088",
    ["scissors"] = "rbxassetid://7734056595",
    ["tool"] = "rbxassetid://7734065795",
    ["target"] = "rbxassetid://7734066296",
    ["crosshair"] = "rbxassetid://7733963885",
    ["airplay"] = "rbxassetid://7733710707",
    ["cast"] = "rbxassetid://7733917120",
    ["radio"] = "rbxassetid://7734053426",
    ["bluetooth"] = "rbxassetid://7733917120",
    ["cpu"] = "rbxassetid://7733963885",
    ["database"] = "rbxassetid://7733964719",
    ["server"] = "rbxassetid://7734056595",
    ["cloud"] = "rbxassetid://7733963885",
    ["droplet"] = "rbxassetid://7733964719",
    ["flame"] = "rbxassetid://7733960981",
    ["flashlight"] = "rbxassetid://7733960981",
    ["umbrella"] = "rbxassetid://7734079055",
    ["thermometer"] = "rbxassetid://7734065795",
    ["wind"] = "rbxassetid://7734079055",
    ["cloud-rain"] = "rbxassetid://7733963885",
    ["cloud-snow"] = "rbxassetid://7733963885",
    ["cloud-lightning"] = "rbxassetid://7733963885",
    ["moon-cloud"] = "rbxassetid://7733955086",
    ["sun-cloud"] = "rbxassetid://7734066296",
    ["arrow-up"] = "rbxassetid://7733717651",
    ["arrow-down"] = "rbxassetid://7733717447",
    ["arrow-left"] = "rbxassetid://7733717651",
    ["arrow-right"] = "rbxassetid://7733717651",
    ["arrow-up-circle"] = "rbxassetid://7733717651",
    ["arrow-down-circle"] = "rbxassetid://7733717447",
    ["arrow-left-circle"] = "rbxassetid://7733717651",
    ["arrow-right-circle"] = "rbxassetid://7733717651",
    ["chevrons-up"] = "rbxassetid://7733717651",
    ["chevrons-down"] = "rbxassetid://7733717447",
    ["chevrons-left"] = "rbxassetid://7733717651",
    ["chevrons-right"] = "rbxassetid://7733717651",
    ["corner-up-left"] = "rbxassetid://7733717651",
    ["corner-up-right"] = "rbxassetid://7733717651",
    ["corner-down-left"] = "rbxassetid://7733717447",
    ["corner-down-right"] = "rbxassetid://7733717447",
    ["rotate-cw"] = "rbxassetid://7734056468",
    ["rotate-ccw"] = "rbxassetid://7734056468",
    ["repeat"] = "rbxassetid://7734056468",
    ["shuffle"] = "rbxassetid://7734056595",
    ["type"] = "rbxassetid://7734065795",
    ["align-left"] = "rbxassetid://7733710707",
    ["align-center"] = "rbxassetid://7733710707",
    ["align-right"] = "rbxassetid://7733710707",
    ["align-justify"] = "rbxassetid://7733710707",
    ["bold"] = "rbxassetid://7733917120",
    ["italic"] = "rbxassetid://7733955740",
    ["underline"] = "rbxassetid://7734079055",
    ["strikethrough"] = "rbxassetid://7734066296",
    ["save"] = "rbxassetid://7734053426",
    ["printer"] = "rbxassetid://7733954760",
    ["monitor"] = "rbxassetid://7733954088",
    ["smartphone"] = "rbxassetid://7734066296",
    ["tablet"] = "rbxassetid://7734065795",
    ["watch"] = "rbxassetid://7734079055",
    ["headphones"] = "rbxassetid://7733960981",
    ["mic"] = "rbxassetid://7733954088",
    ["mic-off"] = "rbxassetid://7733954088",
    ["volume-1"] = "rbxassetid://7734073250",
    ["volume-2"] = "rbxassetid://7734073250",
    ["maximize-2"] = "rbxassetid://7733955740",
    ["minimize-2"] = "rbxassetid://7733955740",
    ["move"] = "rbxassetid://7733959802",
    ["fullscreen"] = "rbxassetid://7733960981",
    ["exit-fullscreen"] = "rbxassetid://7733964719",
    ["sliders"] = "rbxassetid://7734066296",
    ["filter"] = "rbxassetid://7733960981",
    ["sort-asc"] = "rbxassetid://7734065795",
    ["sort-desc"] = "rbxassetid://7733964719",
    ["search-minus"] = "rbxassetid://7734053426",
    ["search-plus"] = "rbxassetid://7734053426",
    ["zoom-in"] = "rbxassetid://7734079055",
    ["zoom-out"] = "rbxassetid://7734079055",
    ["mouse-pointer"] = "rbxassetid://7733959802",
    ["move-horizontal"] = "rbxassetid://7733959802",
    ["move-vertical"] = "rbxassetid://7733959802",
    ["gamepad"] = "rbxassetid://7733960981",
    ["keyboard"] = "rbxassetid://7733955740",
    ["joystick"] = "rbxassetid://7733955740",
    ["ghost"] = "rbxassetid://7733960981",
    ["skull"] = "rbxassetid://7734066296",
    ["heart-crack"] = "rbxassetid://7733960981",
    ["heart-pulse"] = "rbxassetid://7733960981",
    ["bandage"] = "rbxassetid://7733917120",
    ["syringe"] = "rbxassetid://7734065795",
    ["pill"] = "rbxassetid://7733954760",
    ["thermometer-snow"] = "rbxassetid://7734065795",
    ["thermometer-sun"] = "rbxassetid://7734065795",
    ["droplets"] = "rbxassetid://7733964719",
    ["paintbrush"] = "rbxassetid://7733954088",
    ["paint-bucket"] = "rbxassetid://7733954088",
    ["eraser"] = "rbxassetid://7733964719",
    ["pen-tool"] = "rbxassetid://7733954088",
    ["stamp"] = "rbxassetid://7734066296",
    ["scissors-cut"] = "rbxassetid://7734056595",
    ["ruler"] = "rbxassetid://7734053426",
    ["compass-tool"] = "rbxassetid://7733963885",
    ["square"] = "rbxassetid://7734066296",
    ["circle"] = "rbxassetid://7733963885",
    ["triangle"] = "rbxassetid://7734065795",
    ["hexagon"] = "rbxassetid://7733960981",
    ["octagon"] = "rbxassetid://7733954088",
    ["star-polygon"] = "rbxassetid://7734066296",
    ["diamond"] = "rbxassetid://7733964719",
    ["pentagon"] = "rbxassetid://7733954760",
    ["cross"] = "rbxassetid://7733963885",
    ["minus-circle"] = "rbxassetid://7733959802",
    ["plus-circle"] = "rbxassetid://7733954760",
    ["x-circle"] = "rbxassetid://7734060711",
    ["check-circle"] = "rbxassetid://7733715400",
    ["help-circle"] = "rbxassetid://7733955740",
    ["info-circle"] = "rbxassetid://7733955740",
    ["alert-octagon"] = "rbxassetid://7733710707",
    ["zap-off"] = "rbxassetid://7734068321",
    ["flame-kindling"] = "rbxassetid://7733960981",
    ["apple"] = "rbxassetid://7733710707",
    ["carrot"] = "rbxassetid://7733917120",
    ["citrus"] = "rbxassetid://7733963885",
    ["cherry"] = "rbxassetid://7733960981",
    ["grape"] = "rbxassetid://7733960981",
    ["lemon"] = "rbxassetid://7733955740",
    ["orange"] = "rbxassetid://7733954088",
    ["strawberry"] = "rbxassetid://7734066296",
    ["cookie"] = "rbxassetid://7733963885",
    ["coffee"] = "rbxassetid://7733963885",
    ["croissant"] = "rbxassetid://7733963885",
    ["egg"] = "rbxassetid://7733964719",
    ["fish"] = "rbxassetid://7733960981",
    ["pizza"] = "rbxassetid://7733954760",
    ["ice-cream"] = "rbxassetid://7733955740",
    ["cake"] = "rbxassetid://7733917120",
    ["candy"] = "rbxassetid://7733963885",
    ["lollipop"] = "rbxassetid://7733955740",
    ["donut"] = "rbxassetid://7733964719",
    ["popcorn"] = "rbxassetid://7733954760",
    ["soup"] = "rbxassetid://7734066296",
    ["sandwich"] = "rbxassetid://7734053426",
    ["taco"] = "rbxassetid://7734065795",
    ["burger"] = "rbxassetid://7733917120",
    ["hotdog"] = "rbxassetid://7733960981",
    ["fries"] = "rbxassetid://7733960981",
    ["shake"] = "rbxassetid://7734056595",
    ["wine"] = "rbxassetid://7734079055",
    ["beer"] = "rbxassetid://7733917120",
    ["cocktail"] = "rbxassetid://7733963885",
    ["soda"] = "rbxassetid://7734066296",
    ["milk"] = "rbxassetid://7733954088",
    ["water"] = "rbxassetid://7734079055",
    ["leaf"] = "rbxassetid://7733955740",
    ["flower"] = "rbxassetid://7733960981",
    ["tree"] = "rbxassetid://7734065795",
    ["mountain"] = "rbxassetid://7733959802",
    ["beach"] = "rbxassetid://7733917120",
    ["sunset"] = "rbxassetid://7734066296",
    ["sunrise"] = "rbxassetid://7734066296",
    ["rainbow"] = "rbxassetid://7734053426",
    ["sparkles"] = "rbxassetid://7734066296",
    ["fireworks"] = "rbxassetid://7733960981",
    ["balloon"] = "rbxassetid://7733917120",
    ["party-popper"] = "rbxassetid://7733954760",
    ["confetti"] = "rbxassetid://7733963885",
    ["trophy"] = "rbxassetid://7734065795",
    ["medal"] = "rbxassetid://7733954088",
    ["crown-royal"] = "rbxassetid://7733963885",
    ["gem"] = "rbxassetid://7733960981",
    ["ring"] = "rbxassetid://7734053426",
    ["watch-luxury"] = "rbxassetid://7734079055",
    ["glasses"] = "rbxassetid://7733960981",
    ["sunglasses"] = "rbxassetid://7734066296",
    ["hat"] = "rbxassetid://7733960981",
    ["shirt"] = "rbxassetid://7734056595",
    ["pants"] = "rbxassetid://7733954088",
    ["shoe"] = "rbxassetid://7734056595",
    ["sock"] = "rbxassetid://7734066296",
    ["glove"] = "rbxassetid://7733960981",
    ["scarf"] = "rbxassetid://7734053426",
    ["tie"] = "rbxassetid://7734065795",
    ["dress"] = "rbxassetid://7733964719",
    ["coat"] = "rbxassetid://7733963885",
    ["jacket"] = "rbxassetid://7733955740",
    ["sweater"] = "rbxassetid://7734066296",
    ["hoodie"] = "rbxassetid://7733960981",
    ["backpack"] = "rbxassetid://7733917120",
    ["purse"] = "rbxassetid://7733954760",
    ["wallet"] = "rbxassetid://7734079055",
    ["umbrella-rain"] = "rbxassetid://7734079055",
    ["umbrella-sun"] = "rbxassetid://7734079055",
    ["fan"] = "rbxassetid://7733960981",
    ["lamp"] = "rbxassetid://7733955740",
    ["candle"] = "rbxassetid://7733917120",
    ["flashlight-off"] = "rbxassetid://7733960981",
    ["battery-charging"] = "rbxassetid://7733710707",
    ["battery-full"] = "rbxassetid://7733710707",
    ["battery-low"] = "rbxassetid://7733710707",
    ["battery-medium"] = "rbxassetid://7733710707",
    ["plug"] = "rbxassetid://7733954760",
    ["plug-zap"] = "rbxassetid://7733954760",
    ["outlet"] = "rbxassetid://7733954088",
    ["lightbulb"] = "rbxassetid://7733955740",
    ["lightbulb-off"] = "rbxassetid://7733955740",
    ["tv"] = "rbxassetid://7734065795",
    ["radio-receiver"] = "rbxassetid://7734053426",
    ["projector"] = "rbxassetid://7733954760",
    ["speaker"] = "rbxassetid://7734056595",
    ["speaker-off"] = "rbxassetid://7734056595",
    ["headset"] = "rbxassetid://7733960981",
    ["earphones"] = "rbxassetid://7733964719",
    ["airpods"] = "rbxassetid://7733710707",
    ["watch-smart"] = "rbxassetid://7734079055",
    ["calculator"] = "rbxassetid://7733917120",
    ["calendar-clock"] = "rbxassetid://7733917120",
    ["calendar-check"] = "rbxassetid://7733917120",
    ["calendar-x"] = "rbxassetid://7733917120",
    ["calendar-plus"] = "rbxassetid://7733917120",
    ["calendar-minus"] = "rbxassetid://7733917120",
    ["clock-alarm"] = "rbxassetid://7733963388",
    ["timer"] = "rbxassetid://7734065795",
    ["stopwatch"] = "rbxassetid://7734066296",
    ["hourglass"] = "rbxassetid://7733960981",
    ["gauge"] = "rbxassetid://7733960981",
    ["speedometer"] = "rbxassetid://7734056595",
    ["odometer"] = "rbxassetid://7733954088",
    ["tachometer"] = "rbxassetid://7734065795",
    ["thermostat"] = "rbxassetid://7734065795",
    ["hygrometer"] = "rbxassetid://7733960981",
    ["barometer"] = "rbxassetid://7733917120",
    ["scale"] = "rbxassetid://7734053426",
    ["ruler-measure"] = "rbxassetid://7734053426",
    ["tape-measure"] = "rbxassetid://7734065795",
    ["protractor"] = "rbxassetid://7733954760",
    ["calipers"] = "rbxassetid://7733917120",
    ["microscope"] = "rbxassetid://7733954088",
    ["telescope"] = "rbxassetid://7734065795",
    ["magnifying-glass"] = "rbxassetid://7733959802",
    ["magnifying-glass-plus"] = "rbxassetid://7733959802",
    ["magnifying-glass-minus"] = "rbxassetid://7733959802",
    ["binoculars"] = "rbxassetid://7733917120",
    ["flashlight-bright"] = "rbxassetid://7733960981",
    ["lantern"] = "rbxassetid://7733955740",
    ["torch"] = "rbxassetid://7734065795",
    ["fire-extinguisher"] = "rbxassetid://7733960981",
    ["shield-alert"] = "rbxassetid://7734056595",
    ["shield-check"] = "rbxassetid://7734056595",
    ["shield-x"] = "rbxassetid://7734056595",
    ["shield-plus"] = "rbxassetid://7734056595",
    ["shield-minus"] = "rbxassetid://7734056595",
    ["shield-question"] = "rbxassetid://7734056595",
    ["shield-ban"] = "rbxassetid://7734056595",
    ["shield-off"] = "rbxassetid://7734056595",
    ["lock-open"] = "rbxassetid://7733955740",
    ["lock-keyhole"] = "rbxassetid://7733955740",
    ["lock-keyhole-open"] = "rbxassetid://7733955740",
    ["key-round"] = "rbxassetid://7733955740",
    ["key-square"] = "rbxassetid://7733955740",
    ["fingerprint"] = "rbxassetid://7733960981",
    ["scan-face"] = "rbxassetid://7734053426",
    ["scan-line"] = "rbxassetid://7734053426",
    ["scan-search"] = "rbxassetid://7734053426",
    ["qr-code"] = "rbxassetid://7734053426",
    ["barcode"] = "rbxassetid://7733917120",
    ["credit-card"] = "rbxassetid://7733963885",
    ["banknote"] = "rbxassetid://7733917120",
    ["coins"] = "rbxassetid://7733963885",
    ["wallet-minimal"] = "rbxassetid://7734079055",
    ["receipt"] = "rbxassetid://7734053426",
    ["invoice"] = "rbxassetid://7733955740",
    ["file-text"] = "rbxassetid://7733960981",
    ["file-code"] = "rbxassetid://7733960981",
    ["file-json"] = "rbxassetid://7733960981",
    ["file-spreadsheet"] = "rbxassetid://7733960981",
    ["file-presentation"] = "rbxassetid://7733960981",
    ["file-chart"] = "rbxassetid://7733960981",
    ["file-check"] = "rbxassetid://7733960981",
    ["file-x"] = "rbxassetid://7733960981",
    ["file-plus"] = "rbxassetid://7733960981",
    ["file-minus"] = "rbxassetid://7733960981",
    ["file-question"] = "rbxassetid://7733960981",
    ["file-warning"] = "rbxassetid://7733960981",
    ["file-lock"] = "rbxassetid://7733960981",
    ["file-heart"] = "rbxassetid://7733960981",
    ["file-audio"] = "rbxassetid://7733960981",
    ["file-video"] = "rbxassetid://7733960981",
    ["file-image"] = "rbxassetid://7733960981",
    ["file-archive"] = "rbxassetid://7733960981",
    ["file-cog"] = "rbxassetid://7733960981",
    ["folder-open"] = "rbxassetid://7733960981",
    ["folder-plus"] = "rbxassetid://7733960981",
    ["folder-minus"] = "rbxassetid://7733960981",
    ["folder-check"] = "rbxassetid://7733960981",
    ["folder-x"] = "rbxassetid://7733960981",
    ["folder-heart"] = "rbxassetid://7733960981",
    ["folder-lock"] = "rbxassetid://7733960981",
    ["folder-cog"] = "rbxassetid://7733960981",
    ["folder-git"] = "rbxassetid://7733960981",
    ["folder-git-branch"] = "rbxassetid://7733960981",
    ["folder-kanban"] = "rbxassetid://7733960981",
    ["folder-tree"] = "rbxassetid://7733960981",
    ["folder-search"] = "rbxassetid://7733960981",
    ["folder-archive"] = "rbxassetid://7733960981",
    ["folder-download"] = "rbxassetid://7733960981",
    ["folder-upload"] = "rbxassetid://7733960981",
    ["folder-sync"] = "rbxassetid://7733960981",
    ["folder-clock"] = "rbxassetid://7733960981",
    ["folder-star"] = "rbxassetid://7733960981",
    ["folder-root"] = "rbxassetid://7733960981",
    ["library"] = "rbxassetid://7733955740",
    ["library-square"] = "rbxassetid://7733955740",
    ["book-open"] = "rbxassetid://7733917120",
    ["book-closed"] = "rbxassetid://7733917120",
    ["book-plus"] = "rbxassetid://7733917120",
    ["book-minus"] = "rbxassetid://7733917120",
    ["book-check"] = "rbxassetid://7733917120",
    ["book-x"] = "rbxassetid://7733917120",
    ["book-heart"] = "rbxassetid://7733917120",
    ["book-lock"] = "rbxassetid://7733917120",
    ["book-marked"] = "rbxassetid://7733917120",
    ["book-template"] = "rbxassetid://7733917120",
    ["book-type"] = "rbxassetid://7733917120",
    ["book-user"] = "rbxassetid://7733917120",
    ["book-key"] = "rbxassetid://7733917120",
    ["book-settings"] = "rbxassetid://7733917120",
    ["book-help"] = "rbxassetid://7733917120",
    ["book-info"] = "rbxassetid://7733917120",
    ["book-warning"] = "rbxassetid://7733917120",
    ["book-alert"] = "rbxassetid://7733917120",
    ["book-search"] = "rbxassetid://7733917120",
    ["book-text"] = "rbxassetid://7733917120",
    ["book-code"] = "rbxassetid://7733917120",
    ["book-json"] = "rbxassetid://7733917120",
    ["book-spreadsheet"] = "rbxassetid://7733917120",
    ["book-presentation"] = "rbxassetid://7733917120",
    ["book-chart"] = "rbxassetid://7733917120",
    ["book-audio"] = "rbxassetid://7733917120",
    ["book-video"] = "rbxassetid://7733917120",
    ["book-image"] = "rbxassetid://7733917120",
    ["book-archive"] = "rbxassetid://7733917120",
    ["book-cog"] = "rbxassetid://7733917120",
    ["notebook"] = "rbxassetid://7733954088",
    ["notebook-pen"] = "rbxassetid://7733954088",
    ["notebook-text"] = "rbxassetid://7733954088",
    ["sticky-note"] = "rbxassetid://7734066296",
    ["clipboard"] = "rbxassetid://7733963885",
    ["clipboard-list"] = "rbxassetid://7733963885",
    ["clipboard-check"] = "rbxassetid://7733963885",
    ["clipboard-x"] = "rbxassetid://7733963885",
    ["clipboard-plus"] = "rbxassetid://7733963885",
    ["clipboard-minus"] = "rbxassetid://7733963885",
    ["clipboard-copy"] = "rbxassetid://7733963885",
    ["clipboard-paste"] = "rbxassetid://7733963885",
    ["clipboard-type"] = "rbxassetid://7733963885",
    ["clipboard-signature"] = "rbxassetid://7733963885",
    ["clipboard-edit"] = "rbxassetid://7733963885",
    ["clipboard-heart"] = "rbxassetid://7733963885",
    ["clipboard-lock"] = "rbxassetid://7733963885",
    ["clipboard-cog"] = "rbxassetid://7733963885",
    ["presentation"] = "rbxassetid://7733954760",
    ["presentation-screen"] = "rbxassetid://7733954760",
    ["presentation-chart"] = "rbxassetid://7733954760",
    ["presentation-line"] = "rbxassetid://7733954760",
    ["presentation-pie"] = "rbxassetid://7733954760",
    ["presentation-bar"] = "rbxassetid://7733954760",
    ["presentation-area"] = "rbxassetid://7733954760",
    ["kanban"] = "rbxassetid://7733955740",
    ["kanban-square"] = "rbxassetid://7733955740",
    ["gantt-chart"] = "rbxassetid://7733960981",
    ["gantt-chart-square"] = "rbxassetid://7733960981",
    ["line-chart"] = "rbxassetid://7733955740",
    ["area-chart"] = "rbxassetid://7733710707",
    ["pie-chart-slice"] = "rbxassetid://7733954088",
    ["pie-chart-donut"] = "rbxassetid://7733954088",
    ["radar"] = "rbxassetid://7734053426",
    ["radar-dish"] = "rbxassetid://7734053426",
    ["target-crosshair"] = "rbxassetid://7734066296",
    ["bullseye"] = "rbxassetid://7733917120",
    ["focus"] = "rbxassetid://7733960981",
    ["scan"] = "rbxassetid://7734053426",
    ["scan-face-id"] = "rbxassetid://7734053426",
    ["fingerprint-scan"] = "rbxassetid://7733960981",
    ["retina-scan"] = "rbxassetid://7734053426",
    ["voice-scan"] = "rbxassetid://7734073250",
    ["gesture"] = "rbxassetid://7733960981",
    ["hand"] = "rbxassetid://7733960981",
    ["hand-metal"] = "rbxassetid://7733960981",
    ["peace"] = "rbxassetid://7733954760",
    ["victory"] = "rbxassetid://7734079055",
    ["pointing"] = "rbxassetid://7733954760",
    ["wave"] = "rbxassetid://7734079055",
    ["thumbs"] = "rbxassetid://7734065795",
    ["pinch"] = "rbxassetid://7733954760",
    ["grab"] = "rbxassetid://7733960981",
    ["swipe"] = "rbxassetid://7734066296",
    ["tap"] = "rbxassetid://7734065795",
    ["press"] = "rbxassetid://7733954760",
    ["rotate"] = "rbxassetid://7734056468",
    ["scroll"] = "rbxassetid://7734056595",
    ["drag"] = "rbxassetid://7733964719",
    ["drop"] = "rbxassetid://7733964719",
    ["flip"] = "rbxassetid://7733960981",
    ["tilt"] = "rbxassetid://7734065795",
    ["shake"] = "rbxassetid://7734056595",
    ["vibrate"] = "rbxassetid://7734079055",
    ["pulse"] = "rbxassetid://7733954760",
    ["heartbeat"] = "rbxassetid://7733960981",
    ["activity-square"] = "rbxassetid://7733710707",
    ["health"] = "rbxassetid://7733960981",
    ["medicine"] = "rbxassetid://7733954088",
    ["hospital"] = "rbxassetid://7733960981",
    ["clinic"] = "rbxassetid://7733963885",
    ["ambulance"] = "rbxassetid://7733710707",
    ["stretcher"] = "rbxassetid://7734066296",
    ["wheelchair"] = "rbxassetid://7734079055",
    ["crutches"] = "rbxassetid://7733963885",
    ["band-aid"] = "rbxassetid://7733917120",
    ["ointment"] = "rbxassetid://7733954088",
    ["pills-bottle"] = "rbxassetid://7733954760",
    ["inhaler"] = "rbxassetid://7733955740",
    ["drops"] = "rbxassetid://7733964719",
    ["eyedropper"] = "rbxassetid://7733964719",
    ["stethoscope"] = "rbxassetid://7734066296",
    ["thermometer-digital"] = "rbxassetid://7734065795",
    ["blood-pressure"] = "rbxassetid://7733917120",
    ["glucose-meter"] = "rbxassetid://7733960981",
    ["pulse-oximeter"] = "rbxassetid://7733954760",
    ["defibrillator"] = "rbxassetid://7733964719",
    ["iv-bag"] = "rbxassetid://7733955740",
    ["blood-bag"] = "rbxassetid://7733917120",
    ["organ"] = "rbxassetid://7733954088",
    ["dna"] = "rbxassetid://7733964719",
    ["atom"] = "rbxassetid://7733710707",
    ["molecule"] = "rbxassetid://7733959802",
    ["cell"] = "rbxassetid://7733963885",
    ["virus"] = "rbxassetid://7734079055",
    ["bacteria"] = "rbxassetid://7733917120",
    ["germ"] = "rbxassetid://7733960981",
    ["mask"] = "rbxassetid://7733954088",
    ["gloves-medical"] = "rbxassetid://7733960981",
    ["gown"] = "rbxassetid://7733960981",
    ["scrubs"] = "rbxassetid://7734056595",
    ["lab-coat"] = "rbxassetid://7733955740",
    ["microscope-slide"] = "rbxassetid://7733954088",
    ["petri-dish"] = "rbxassetid://7733954760",
    ["test-tube"] = "rbxassetid://7734065795",
    ["beaker"] = "rbxassetid://7733917120",
    ["flask"] = "rbxassetid://7733960981",
    ["burner"] = "rbxassetid://7733917120",
    ["centrifuge"] = "rbxassetid://7733963885",
    ["spectrometer"] = "rbxassetid://7734066296",
    ["chromatograph"] = "rbxassetid://7733963885",
    ["electrophoresis"] = "rbxassetid://7733964719",
    ["sequencer"] = "rbxassetid://7734056595",
    ["incubator"] = "rbxassetid://7733955740",
    ["autoclave"] = "rbxassetid://7733710707",
    ["fume-hood"] = "rbxassetid://7733960981",
    ["biosafety-cabinet"] = "rbxassetid://7733917120",
    ["laminar-flow"] = "rbxassetid://7733955740",
    ["cleanroom"] = "rbxassetid://7733963885",
    ["isolation-chamber"] = "rbxassetid://7733954088",
    ["hyperbaric"] = "rbxassetid://7733960981",
    ["cryo-chamber"] = "rbxassetid://7733963885",
    ["surgical-robot"] = "rbxassetid://7734056595",
    ["exoskeleton"] = "rbxassetid://7733964719",
    ["prosthetic"] = "rbxassetid://7733954760",
    ["implant"] = "rbxassetid://7733955740",
    ["pacemaker"] = "rbxassetid://7733954760",
    ["cochlear"] = "rbxassetid://7733963885",
    ["retinal"] = "rbxassetid://7734053426",
    ["neural-interface"] = "rbxassetid://7733954088",
    ["brain-computer"] = "rbxassetid://7733917120",
    ["neuralink"] = "rbxassetid://7733954088",
    ["bci"] = "rbxassetid://7733960981",
    ["eeg"] = "rbxassetid://7733964719",
    ["ecg"] = "rbxassetid://7733964719",
    ["emg"] = "rbxassetid://7733964719",
    ["meg"] = "rbxassetid://7733954088",
    ["fnirs"] = "rbxassetid://7733960981",
    ["pet-scan"] = "rbxassetid://7733954760",
    ["mri"] = "rbxassetid://7733959802",
    ["ct-scan"] = "rbxassetid://7733963885",
    ["xray"] = "rbxassetid://7734079055",
    ["ultrasound"] = "rbxassetid://7734079055",
    ["mammogram"] = "rbxassetid://7733954088",
    ["fluoroscopy"] = "rbxassetid://7733960981",
    ["angiography"] = "rbxassetid://7733710707",
    ["endoscopy"] = "rbxassetid://7733964719",
    ["colonoscopy"] = "rbxassetid://7733963885",
    ["laparoscopy"] = "rbxassetid://7733955740",
    ["arthroscopy"] = "rbxassetid://7733917120",
    ["bronchoscopy"] = "rbxassetid://7733917120",
    ["cystoscopy"] = "rbxassetid://7733963885",
    ["hysteroscopy"] = "rbxassetid://7733960981",
    ["sigmoidoscopy"] = "rbxassetid://7734056595",
    ["proctoscopy"] = "rbxassetid://7733954760",
    ["otoscope"] = "rbxassetid://7733954088",
    ["ophthalmoscope"] = "rbxassetid://7733954088",
    ["dermatoscope"] = "rbxassetid://7733964719",
    ["otoscope-ent"] = "rbxassetid://7733954088",
    ["tuning-fork"] = "rbxassetid://7734065795",
    ["reflex-hammer"] = "rbxassetid://7734053426",
    ["tongue-depressor"] = "rbxassetid://7734065795",
    ["speculum"] = "rbxassetid://7734066296",
    ["forceps"] = "rbxassetid://7733960981",
    ["scalpel"] = "rbxassetid://7734053426",
    ["scissors-surgical"] = "rbxassetid://7734056595",
    ["retractor"] = "rbxassetid://7734053426",
    ["dilator"] = "rbxassetid://7733964719",
    ["trocar"] = "rbxassetid://7734065795",
    ["cannula"] = "rbxassetid://7733963885",
    ["catheter"] = "rbxassetid://7733917120",
    ["stent"] = "rbxassetid://7734066296",
    ["shunt"] = "rbxassetid://7734056595",
    ["drain"] = "rbxassetid://7733964719",
    ["tube"] = "rbxassetid://7734065795",
    ["line-iv"] = "rbxassetid://7733955740",
    ["line-central"] = "rbxassetid://7733955740",
    ["line-arterial"] = "rbxassetid://7733955740",
    ["line-swann"] = "rbxassetid://7734056595",
    ["chest-tube"] = "rbxassetid://7733963885",
    ["ng-tube"] = "rbxassetid://7733954088",
    ["foley"] = "rbxassetid://7733960981",
    ["suprapubic"] = "rbxassetid://7734066296",
    ["nephrostomy"] = "rbxassetid://7733954088",
    ["gastrostomy"] = "rbxassetid://7733960981",
    ["jejunostomy"] = "rbxassetid://7733955740",
    ["colostomy"] = "rbxassetid://7733963885",
    ["ileostomy"] = "rbxassetid://7733955740",
    ["tracheostomy"] = "rbxassetid://7734065795",
    ["laryngectomy"] = "rbxassetid://7733955740",
    ["mastectomy"] = "rbxassetid://7733954088",
    ["lumpectomy"] = "rbxassetid://7733955740",
    ["hysterectomy"] = "rbxassetid://7733960981",
    ["oophorectomy"] = "rbxassetid://7733954088",
    ["orchiectomy"] = "rbxassetid://7733954088",
    ["prostatectomy"] = "rbxassetid://7733954760",
    ["nephrectomy"] = "rbxassetid://7733954088",
    ["hepatectomy"] = "rbxassetid://7733960981",
    ["pancreatectomy"] = "rbxassetid://7733954760",
    ["splenectomy"] = "rbxassetid://7734066296",
    ["cholecystectomy"] = "rbxassetid://7733963885",
    ["appendectomy"] = "rbxassetid://7733710707",
    ["colectomy"] = "rbxassetid://7733963885",
    ["gastrectomy"] = "rbxassetid://7733960981",
    ["esophagectomy"] = "rbxassetid://7733964719",
    ["pneumonectomy"] = "rbxassetid://7733954760",
    ["lobectomy"] = "rbxassetid://7733955740",
    ["wedge-resection"] = "rbxassetid://7734079055",
    ["segmentectomy"] = "rbxassetid://7734056595",
    ["transplant"] = "rbxassetid://7734065795",
    ["graft"] = "rbxassetid://7733960981",
    ["flap"] = "rbxassetid://7733960981",
    ["skin-graft"] = "rbxassetid://7734056595",
    ["bone-graft"] = "rbxassetid://7733917120",
    ["tendon-graft"] = "rbxassetid://7734065795",
    ["nerve-graft"] = "rbxassetid://7733954088",
    ["cornea-transplant"] = "rbxassetid://7733963885",
    ["organ-donor"] = "rbxassetid://7733954088",
    ["organ-recipient"] = "rbxassetid://7733954088",
    ["surgery"] = "rbxassetid://7734056595",
    ["operation"] = "rbxassetid://7733954088",
    ["procedure"] = "rbxassetid://7733954760",
    ["treatment"] = "rbxassetid://7734065795",
    ["therapy"] = "rbxassetid://7734065795",
    ["rehabilitation"] = "rbxassetid://7734053426",
    ["recovery"] = "rbxassetid://7734053426",
    ["healing"] = "rbxassetid://7733960981",
    ["wellness"] = "rbxassetid://7734079055",
    ["fitness"] = "rbxassetid://7733960981",
    ["nutrition"] = "rbxassetid://7733954088",
    ["diet"] = "rbxassetid://7733964719",
    ["supplement"] = "rbxassetid://7734066296",
    ["vitamin"] = "rbxassetid://7734079055",
    ["mineral"] = "rbxassetid://7733954088",
    ["protein"] = "rbxassetid://7733954760",
    ["carbohydrate"] = "rbxassetid://7733963885",
    ["fat"] = "rbxassetid://7733960981",
    ["fiber"] = "rbxassetid://7733960981",
    ["probiotic"] = "rbxassetid://7733954760",
    ["enzyme"] = "rbxassetid://7733964719",
    ["hormone"] = "rbxassetid://7733960981",
    ["steroid"] = "rbxassetid://7734066296",
    ["antibiotic"] = "rbxassetid://7733710707",
    ["antiviral"] = "rbxassetid://7733710707",
    ["antifungal"] = "rbxassetid://7733710707",
    ["antiparasitic"] = "rbxassetid://7733710707",
    ["vaccine"] = "rbxassetid://7734079055",
    ["immunization"] = "rbxassetid://7733955740",
    ["booster"] = "rbxassetid://7733917120",
    ["injection"] = "rbxassetid://7733955740",
    ["shot"] = "rbxassetid://7734056595",
    ["dose"] = "rbxassetid://7733964719",
    ["regimen"] = "rbxassetid://7734053426",
    ["protocol"] = "rbxassetid://7733954760",
    ["guideline"] = "rbxassetid://7733960981",
    ["standard"] = "rbxassetid://7734066296",
    ["best-practice"] = "rbxassetid://7733917120",
    ["evidence"] = "rbxassetid://7733964719",
    ["research"] = "rbxassetid://7734053426",
    ["study"] = "rbxassetid://7734066296",
    ["trial"] = "rbxassetid://7734065795",
    ["experiment"] = "rbxassetid://7733964719",
    ["test"] = "rbxassetid://7734065795",
    ["assay"] = "rbxassetid://7733710707",
    ["analysis"] = "rbxassetid://7733710707",
    ["diagnosis"] = "rbxassetid://7733964719",
    ["prognosis"] = "rbxassetid://7733954760",
    ["symptom"] = "rbxassetid://7734066296",
    ["sign"] = "rbxassetid://7734056595",
    ["syndrome"] = "rbxassetid://7734066296",
    ["disease"] = "rbxassetid://7733964719",
    ["disorder"] = "rbxassetid://7733964719",
    ["condition"] = "rbxassetid://7733963885",
    ["illness"] = "rbxassetid://7733955740",
    ["sickness"] = "rbxassetid://7734056595",
    ["ailment"] = "rbxassetid://7733710707",
    ["malady"] = "rbxassetid://7733954088",
    ["affliction"] = "rbxassetid://7733710707",
    ["complaint"] = "rbxassetid://7733963885",
    ["issue"] = "rbxassetid://7733955740",
    ["problem"] = "rbxassetid://7733954760",
    ["concern"] = "rbxassetid://7733963885",
    ["worry"] = "rbxassetid://7734079055",
    ["anxiety"] = "rbxassetid://7733710707",
    ["stress"] = "rbxassetid://7734066296",
    ["depression"] = "rbxassetid://7733964719",
    ["insomnia"] = "rbxassetid://7733955740",
    ["fatigue"] = "rbxassetid://7733960981",
    ["pain"] = "rbxassetid://7733954760",
    ["ache"] = "rbxassetid://7733710707",
    ["soreness"] = "rbxassetid://7734056595",
    ["stiffness"] = "rbxassetid://7734066296",
    ["swelling"] = "rbxassetid://7734066296",
    ["inflammation"] = "rbxassetid://7733955740",
    ["redness"] = "rbxassetid://7734053426",
    ["heat"] = "rbxassetid://7733960981",
    ["fever"] = "rbxassetid://7733960981",
    ["chills"] = "rbxassetid://7733963885",
    ["sweat"] = "rbxassetid://7734066296",
    ["shiver"] = "rbxassetid://7734056595",
    ["tremor"] = "rbxassetid://7734065795",
    ["seizure"] = "rbxassetid://7734056595",
    ["convulsion"] = "rbxassetid://7733963885",
    ["spasm"] = "rbxassetid://7734066296",
    ["cramp"] = "rbxassetid://7733963885",
    ["twitch"] = "rbxassetid://7734065795",
    ["tic"] = "rbxassetid://7734065795",
    ["jerk"] = "rbxassetid://7733955740",
    ["startle"] = "rbxassetid://7734066296",
    ["reflex"] = "rbxassetid://7734053426",
    ["response"] = "rbxassetid://7734053426",
    ["reaction"] = "rbxassetid://7734053426",
    ["feedback"] = "rbxassetid://7733960981",
    ["input"] = "rbxassetid://7733955740",
    ["output"] = "rbxassetid://7733954088",
    ["throughput"] = "rbxassetid://7734065795",
    ["bandwidth"] = "rbxassetid://7733917120",
    ["latency"] = "rbxassetid://7733955740",
    ["jitter"] = "rbxassetid://7733955740",
    ["packet-loss"] = "rbxassetid://7733954760",
    ["error-rate"] = "rbxassetid://7733964719",
    ["signal"] = "rbxassetid://7734056595",
    ["noise"] = "rbxassetid://7733954088",
    ["interference"] = "rbxassetid://7733955740",
    ["distortion"] = "rbxassetid://7733964719",
    ["attenuation"] = "rbxassetid://7733710707",
    ["amplification"] = "rbxassetid://7733710707",
    ["modulation"] = "rbxassetid://7733959802",
    ["demodulation"] = "rbxassetid://7733964719",
    ["encoding"] = "rbxassetid://7733964719",
    ["decoding"] = "rbxassetid://7733964719",
    ["compression"] = "rbxassetid://7733963885",
    ["decompression"] = "rbxassetid://7733964719",
    ["encryption"] = "rbxassetid://7733964719",
    ["decryption"] = "rbxassetid://7733964719",
    ["hashing"] = "rbxassetid://7733960981",
    ["checksum"] = "rbxassetid://7733963885",
    ["signature"] = "rbxassetid://7734056595",
    ["certificate"] = "rbxassetid://7733917120",
    ["token"] = "rbxassetid://7734065795",
    ["key-pair"] = "rbxassetid://7733955740",
    ["public-key"] = "rbxassetid://7733954760",
    ["private-key"] = "rbxassetid://7733954760",
    ["seed-phrase"] = "rbxassetid://7734053426",
    ["mnemonic"] = "rbxassetid://7733954088",
    ["wallet-address"] = "rbxassetid://7734079055",
    ["transaction"] = "rbxassetid://7734065795",
    ["block"] = "rbxassetid://7733917120",
    ["chain"] = "rbxassetid://7733963885",
    ["ledger"] = "rbxassetid://7733955740",
    ["consensus"] = "rbxassetid://7733963885",
    ["proof-work"] = "rbxassetid://7733954760",
    ["proof-stake"] = "rbxassetid://7733954760",
    ["mining"] = "rbxassetid://7733954088",
    ["staking"] = "rbxassetid://7734066296",
    ["validator"] = "rbxassetid://7734079055",
    ["node"] = "rbxassetid://7733954088",
    ["peer"] = "rbxassetid://7733954760",
    ["network"] = "rbxassetid://7733954088",
    ["protocol"] = "rbxassetid://7733954760",
    ["algorithm"] = "rbxassetid://7733710707",
    ["data-structure"] = "rbxassetid://7733964719",
    ["database"] = "rbxassetid://7733964719",
    ["cache"] = "rbxassetid://7733917120",
    ["buffer"] = "rbxassetid://7733917120",
    ["queue"] = "rbxassetid://7734053426",
    ["stack"] = "rbxassetid://7734066296",
    ["heap"] = "rbxassetid://7733960981",
    ["tree"] = "rbxassetid://7734065795",
    ["graph"] = "rbxassetid://7733960981",
    ["matrix"] = "rbxassetid://7733954088",
    ["vector"] = "rbxassetid://7734079055",
    ["tensor"] = "rbxassetid://7734065795",
    ["array"] = "rbxassetid://7733710707",
    ["list"] = "rbxassetid://7733955740",
    ["map"] = "rbxassetid://7733954088",
    ["set"] = "rbxassetid://7734056595",
    ["dictionary"] = "rbxassetid://7733964719",
    ["hash-table"] = "rbxassetid://7733960981",
    ["linked-list"] = "rbxassetid://7733955740",
    ["doubly-linked"] = "rbxassetid://7733964719",
    ["circular"] = "rbxassetid://7733963885",
    ["sorted"] = "rbxassetid://7734066296",
    ["unsorted"] = "rbxassetid://7734079055",
    ["dynamic"] = "rbxassetid://7733964719",
    ["static"] = "rbxassetid://7734066296",
    ["fixed"] = "rbxassetid://7733960981",
    ["variable"] = "rbxassetid://7734079055",
    ["constant"] = "rbxassetid://7733963885",
    ["literal"] = "rbxassetid://7733955740",
    ["identifier"] = "rbxassetid://7733955740",
    ["keyword"] = "rbxassetid://7733955740",
    ["operator"] = "rbxassetid://7733954088",
    ["operand"] = "rbxassetid://7733954088",
    ["expression"] = "rbxassetid://7733964719",
    ["statement"] = "rbxassetid://7734066296",
    ["block"] = "rbxassetid://7733917120",
    ["scope"] = "rbxassetid://7734056595",
    ["context"] = "rbxassetid://7733963885",
    ["environment"] = "rbxassetid://7733964719",
    ["closure"] = "rbxassetid://7733963885",
    ["callback"] = "rbxassetid://7733917120",
    ["promise"] = "rbxassetid://7733954760",
    ["async"] = "rbxassetid://7733710707",
    ["await"] = "rbxassetid://7733710707",
    ["thread"] = "rbxassetid://7734065795",
    ["process"] = "rbxassetid://7733954760",
    ["task"] = "rbxassetid://7734065795",
    ["job"] = "rbxassetid://7733955740",
    ["worker"] = "rbxassetid://7734079055",
    ["pool"] = "rbxassetid://7733954760",
    ["scheduler"] = "rbxassetid://7734053426",
    ["dispatcher"] = "rbxassetid://7733964719",
    ["handler"] = "rbxassetid://7733960981",
    ["listener"] = "rbxassetid://7733955740",
    ["observer"] = "rbxassetid://7733954088",
    ["subscriber"] = "rbxassetid://7734066296",
    ["publisher"] = "rbxassetid://7733954760",
    ["broker"] = "rbxassetid://7733917120",
    ["proxy"] = "rbxassetid://7733954760",
    ["gateway"] = "rbxassetid://7733960981",
    ["firewall"] = "rbxassetid://7733960981",
    ["router"] = "rbxassetid://7734053426",
    ["switch"] = "rbxassetid://7734066296",
    ["hub"] = "rbxassetid://7733960981",
    ["bridge"] = "rbxassetid://7733917120",
    ["repeater"] = "rbxassetid://7734053426",
    ["extender"] = "rbxassetid://7733964719",
    ["access-point"] = "rbxassetid://7733710707",
    ["station"] = "rbxassetid://7734066296",
    ["client"] = "rbxassetid://7733963885",
    ["server"] = "rbxassetid://7734056595",
    ["host"] = "rbxassetid://7733960981",
    ["master"] = "rbxassetid://7733954088",
    ["slave"] = "rbxassetid://7734066296",
    ["primary"] = "rbxassetid://7733954760",
    ["secondary"] = "rbxassetid://7734066296",
    ["replica"] = "rbxassetid://7734053426",
    ["shard"] = "rbxassetid://7734056595",
    ["partition"] = "rbxassetid://7733954760",
    ["segment"] = "rbxassetid://7734056595",
    ["slice"] = "rbxassetid://7734066296",
    ["chunk"] = "rbxassetid://7733963885",
    ["batch"] = "rbxassetid://7733917120",
    ["stream"] = "rbxassetid://7734066296",
    ["flow"] = "rbxassetid://rbxassetid://7733960981",
    ["pipeline"] = "rbxassetid://7733954760",
    ["workflow"] = "rbxassetid://7734079055",
    ["automation"] = "rbxassetid://7733710707",
    ["orchestration"] = "rbxassetid://7733954088",
    ["choreography"] = "rbxassetid://7733963885",
    ["synchronization"] = "rbxassetid://7734066296",
    ["coordination"] = "rbxassetid://7733963885",
    ["collaboration"] = "rbxassetid://7733964719",
    ["cooperation"] = "rbxassetid://7733964719",
    ["communication"] = "rbxassetid://7733963885",
    ["interaction"] = "rbxassetid://7733955740",
    ["integration"] = "rbxassetid://7733955740",
    ["interface"] = "rbxassetid://7733955740",
    ["abstraction"] = "rbxassetid://7733710707",
    ["encapsulation"] = "rbxassetid://7733964719",
    ["inheritance"] = "rbxassetid://7733955740",
    ["polymorphism"] = "rbxassetid://7733954760",
    ["composition"] = "rbxassetid://7733963885",
    ["aggregation"] = "rbxassetid://7733710707",
    ["association"] = "rbxassetid://7733710707",
    ["dependency"] = "rbxassetid://7733964719",
    ["coupling"] = "rbxassetid://7733963885",
    ["cohesion"] = "rbxassetid://7733963885",
    ["modularity"] = "rbxassetid://7733959802",
    ["granularity"] = "rbxassetid://7733960981",
    ["atomicity"] = "rbxassetid://7733710707",
    ["consistency"] = "rbxassetid://7733963885",
    ["isolation"] = "rbxassetid://7733955740",
    ["durability"] = "rbxassetid://7733964719",
    ["reliability"] = "rbxassetid://7734053426",
    ["availability"] = "rbxassetid://7733710707",
    ["scalability"] = "rbxassetid://7734056595",
    ["maintainability"] = "rbxassetid://7733954088",
    ["extensibility"] = "rbxassetid://7733964719",
    ["flexibility"] = "rbxassetid://7733960981",
    ["portability"] = "rbxassetid://7733954760",
    ["interoperability"] = "rbxassetid://7733955740",
    ["usability"] = "rbxassetid://7734079055",
    ["accessibility"] = "rbxassetid://7733710707",
    ["security"] = "rbxassetid://7734056595",
    ["safety"] = "rbxassetid://7734056595",
    ["privacy"] = "rbxassetid://7733954760",
    ["integrity"] = "rbxassetid://7733955740",
    ["authenticity"] = "rbxassetid://7733710707",
    ["non-repudiation"] = "rbxassetid://7733954088",
    ["accountability"] = "rbxassetid://7733710707",
    ["auditability"] = "rbxassetid://7733710707",
    ["traceability"] = "rbxassetid://7734065795",
    ["monitoring"] = "rbxassetid://7733954088",
    ["logging"] = "rbxassetid://7733955740",
    ["metrics"] = "rbxassetid://7733954088",
    ["telemetry"] = "rbxassetid://7734065795",
    ["analytics"] = "rbxassetid://7733710707",
    ["reporting"] = "rbxassetid://7734053426",
    ["dashboard"] = "rbxassetid://7733964719",
    ["visualization"] = "rbxassetid://7734079055",
    ["chart"] = "rbxassetid://7733917120",
    ["graph-viz"] = "rbxassetid://7733960981",
    ["plot"] = "rbxassetid://7733954760",
    ["diagram"] = "rbxassetid://7733964719",
    ["flowchart"] = "rbxassetid://7733960981",
    ["mindmap"] = "rbxassetid://7733954088",
    ["whiteboard"] = "rbxassetid://7734079055",
    ["canvas"] = "rbxassetid://7733917120",
    ["artboard"] = "rbxassetid://7733710707",
    ["frame"] = "rbxassetid://7733960981",
    ["group"] = "rbxassetid://7733960981",
    ["layer"] = "rbxassetid://7733955740",
    ["mask"] = "rbxassetid://7733954088",
    ["clip"] = "rbxassetid://7733963885",
    ["crop"] = "rbxassetid://7733963885",
    ["trim"] = "rbxassetid://7734065795",
    ["slice-tool"] = "rbxassetid://7734066296",
    ["export"] = "rbxassetid://7733964719",
    ["import"] = "rbxassetid://7733955740",
    ["sync"] = "rbxassetid://7734066296",
    ["backup"] = "rbxassetid://7733917120",
    ["restore"] = "rbxassetid://7734053426",
    ["migrate"] = "rbxassetid://7733959802",
    ["upgrade"] = "rbxassetid://7734079055",
    ["downgrade"] = "rbxassetid://7733964719",
    ["rollback"] = "rbxassetid://7734053426",
    ["hotfix"] = "rbxassetid://7733960981",
    ["patch"] = "rbxassetid://7733954760",
    ["release"] = "rbxassetid://7734053426",
    ["deploy"] = "rbxassetid://7733964719",
    ["ship"] = "rbxassetid://7734056595",
    ["launch"] = "rbxassetid://7733955740",
    ["publish"] = "rbxassetid://7733954760",
    ["subscribe"] = "rbxassetid://7734066296",
    ["follow"] = "rbxassetid://7733960981",
    ["friend"] = "rbxassetid://7733960981",
    ["unfriend"] = "rbxassetid://7734065795",
    ["block"] = "rbxassetid://7733917120",
    ["unblock"] = "rbxassetid://7734079055",
    ["mute"] = "rbxassetid://7733959802",
    ["unmute"] = "rbxassetid://7734073250",
    ["deafen"] = "rbxassetid://7733964719",
    ["undeafen"] = "rbxassetid://7734073250",
    ["kick"] = "rbxassetid://7733955740",
    ["ban"] = "rbxassetid://7733917120",
    ["unban"] = "rbxassetid://7734079055",
    ["timeout"] = "rbxassetid://7734065795",
    ["warn"] = "rbxassetid://7734079055",
    ["report"] = "rbxassetid://rbxassetid://7734053426",
    ["appeal"] = "rbxassetid://7733710707",
    ["verify"] = "rbxassetid://7734079055",
    ["authenticate"] = "rbxassetid://7733710707",
    ["authorize"] = "rbxassetid://7733710707",
    ["permit"] = "rbxassetid://7733954760",
    ["allow"] = "rbxassetid://7733710707",
    ["deny"] = "rbxassetid://7733964719",
    ["reject"] = "rbxassetid://7734053426",
    ["refuse"] = "rbxassetid://7734053426",
    ["decline"] = "rbxassetid://7733964719",
    ["cancel"] = "rbxassetid://7734060711",
    ["abort"] = "rbxassetid://7734060711",
    ["stop"] = "rbxassetid://7734060711",
    ["pause"] = "rbxassetid://7733952335",
    ["resume"] = "rbxassetid://7734056468",
    ["restart"] = "rbxassetid://7734056468",
    ["reload"] = "rbxassetid://7734056468",
    ["refresh"] = "rbxassetid://7734056468",
    ["update"] = "rbxassetid://7734079055",
    ["upgrade"] = "rbxassetid://7734079055",
    ["downgrade"] = "rbxassetid://7733964719",
    ["install"] = "rbxassetid://7733955740",
    ["uninstall"] = "rbxassetid://7734065795",
    ["repair"] = "rbxassetid://7734053426",
    ["fix"] = "rbxassetid://7734053426",
    ["debug"] = "rbxassetid://7733964719",
    ["test"] = "rbxassetid://7734065795",
    ["benchmark"] = "rbxassetid://7733917120",
    ["profile"] = "rbxassetid://7733954088",
    ["optimize"] = "rbxassetid://7733954088",
    ["tune"] = "rbxassetid://7734065795",
    ["calibrate"] = "rbxassetid://7733917120",
    ["configure"] = "rbxassetid://7733963885",
    ["customize"] = "rbxassetid://7733964719",
    ["personalize"] = "rbxassetid://7733954760",
    ["adapt"] = "rbxassetid://7733710707",
    ["adjust"] = "rbxassetid://7733710707",
    ["modify"] = "rbxassetid://7733959802",
    ["change"] = "rbxassetid://7733964719",
    ["transform"] = "rbxassetid://7734065795",
    ["convert"] = "rbxassetid://7733963885",
    ["translate"] = "rbxassetid://7734065795",
    ["interpret"] = "rbxassetid://7733955740",
    ["compile"] = "rbxassetid://7733963885",
    ["build"] = "rbxassetid://7733917120",
    ["assemble"] = "rbxassetid://7733710707",
    ["link"] = "rbxassetid://7733955740",
    ["bind"] = "rbxassetid://7733917120",
    ["connect"] = "rbxassetid://7733963885",
    ["attach"] = "rbxassetid://7733710707",
    ["detach"] = "rbxassetid://7733964719",
    ["separate"] = "rbxassetid://7734066296",
    ["split"] = "rbxassetid://7734066296",
    ["divide"] = "rbxassetid://7733964719",
    ["merge"] = "rbxassetid://7733959802",
    ["combine"] = "rbxassetid://7733963885",
    ["join"] = "rbxassetid://7733955740",
    ["unite"] = "rbxassetid://7734079055",
    ["integrate"] = "rbxassetid://7733955740",
    ["incorporate"] = "rbxassetid://7733955740",
    ["include"] = "rbxassetid://7733955740",
    ["exclude"] = "rbxassetid://7733964719",
    ["omit"] = "rbxassetid://7733954088",
    ["remove"] = "rbxassetid://7734065795",
    ["delete"] = "rbxassetid://7734065795",
    ["erase"] = "rbxassetid://7733964719",
    ["clear"] = "rbxassetid://7734060711",
    ["clean"] = "rbxassetid://7734060711",
    ["wipe"] = "rbxassetid://7734065795",
    ["purge"] = "rbxassetid://7733954760",
    ["flush"] = "rbxassetid://7733960981",
    ["reset"] = "rbxassetid://7734056468",
    ["reboot"] = "rbxassetid://7734056468",
    ["shutdown"] = "rbxassetid://7734060711",
    ["power"] = "rbxassetid://7733954760",
    ["energy"] = "rbxassetid://7733964719",
    ["electricity"] = "rbxassetid://7733964719",
    ["battery-charging"] = "rbxassetid://7733710707",
    ["solar"] = "rbxassetid://7734066296",
    ["wind"] = "rbxassetid://7734079055",
    ["hydro"] = "rbxassetid://7733960981",
    ["nuclear"] = "rbxassetid://7733954088",
    ["fossil"] = "rbxassetid://7733960981",
    ["renewable"] = "rbxassetid://7734053426",
    ["sustainable"] = "rbxassetid://7734066296",
    ["green"] = "rbxassetid://7733960981",
    ["eco"] = "rbxassetid://rbxassetid://7733960981",
    ["recycle"] = "rbxassetid://7734056468",
    ["reuse"] = "rbxassetid://7734056468",
    ["reduce"] = "rbxassetid://7734053426",
    ["conservation"] = "rbxassetid://7733963885",
    ["preservation"] = "rbxassetid://7733954760",
    ["protection"] = "rbxassetid://7734056595",
    ["restoration"] = "rbxassetid://7734053426",
    ["regeneration"] = "rbxassetid://7734053426",
    ["growth"] = "rbxassetid://7733960981",
    ["development"] = "rbxassetid://7733964719",
    ["evolution"] = "rbxassetid://7733964719",
    ["progress"] = "rbxassetid://7733954760",
    ["advancement"] = "rbxassetid://7733710707",
    ["improvement"] = "rbxassetid://7733955740",
    ["enhancement"] = "rbxassetid://7733960981",
    ["refinement"] = "rbxassetid://7734053426",
    ["polish"] = "rbxassetid://7733954760",
    ["shine"] = "rbxassetid://7734056595",
    ["glow"] = "rbxassetid://7733960981",
    ["sparkle"] = "rbxassetid://7734066296",
    ["glitter"] = "rbxassetid://7734066296",
    ["shimmer"] = "rbxassetid://7734056595",
    ["flash"] = "rbxassetid://7733960981",
    ["gleam"] = "rbxassetid://7733960981",
    ["beam"] = "rbxassetid://7733917120",
    ["ray"] = "rbxassetid://7734053426",
    ["laser"] = "rbxassetid://7733955740",
    ["maser"] = "rbxassetid://7733954088",
    ["radar"] = "rbxassetid://7734053426",
    ["sonar"] = "rbxassetid://7734066296",
    ["lidar"] = "rbxassetid://7733955740",
    ["sensor"] = "rbxassetid://7734056595",
    ["detector"] = "rbxassetid://7733964719",
    ["scanner"] = "rbxassetid://7734053426",
    ["reader"] = "rbxassetid://7734053426",
    ["writer"] = "rbxassetid://7734079055",
    ["printer"] = "rbxassetid://7733954760",
    ["plotter"] = "rbxassetid://7733954760",
    ["cutter"] = "rbxassetid://7733963885",
    ["engraver"] = "rbxassetid://7733964719",
    ["etcher"] = "rbxassetid://7733964719",
    ["mill"] = "rbxassetid://7733954088",
    ["lathe"] = "rbxassetid://7733955740",
    ["drill"] = "rbxassetid://7733964719",
    ["punch"] = "rbxassetid://7733954760",
    ["press"] = "rbxassetid://7733954760",
    ["stamp"] = "rbxassetid://7734066296",
    ["mold"] = "rbxassetid://7733959802",
    ["cast"] = "rbxassetid://7733917120",
    ["forge"] = "rbxassetid://7733960981",
    ["weld"] = "rbxassetid://7734079055",
    ["solder"] = "rbxassetid://7734066296",
    ["braze"] = "rbxassetid://7733917120",
    ["glue"] = "rbxassetid://7733960981",
    ["tape"] = "rbxassetid://7734065795",
    ["staple"] = "rbxassetid://7734066296",
    ["stitch"] = "rbxassetid://7734066296",
    ["sew"] = "rbxassetid://7734056595",
    ["knit"] = "rbxassetid://7733955740",
    ["weave"] = "rbxassetid://7734079055",
    ["spin"] = "rbxassetid://7734066296",
    ["twist"] = "rbxassetid://7734065795",
    ["braid"] = "rbxassetid://7733917120",
    ["knot"] = "rbxassetid://7733955740",
    ["tie"] = "rbxassetid://7734065795",
    ["wrap"] = "rbxassetid://7734079055",
    ["pack"] = "rbxassetid://7733954088",
    ["bundle"] = "rbxassetid://7733917120",
    ["bale"] = "rbxassetid://7733917120",
    ["crate"] = "rbxassetid://rbxassetid://7733963885",
    ["pallet"] = "rbxassetid://7733954760",
    ["container"] = "rbxassetid://7733963885",
    ["tank"] = "rbxassetid://7734065795",
    ["silos"] = "rbxassetid://7734066296",
    ["bin"] = "rbxassetid://7733917120",
    ["hopper"] = "rbxassetid://7733960981",
    ["conveyor"] = "rbxassetid://7733963885",
    ["elevator"] = "rbxassetid://7733964719",
    ["escalator"] = "rbxassetid://7733964719",
    ["crane"] = "rbxassetid://7733963885",
    ["hoist"] = "rbxassetid://7733960981",
    ["winch"] = "rbxassetid://7734079055",
    ["pulley"] = "rbxassetid://7733954760",
    ["lever"] = "rbxassetid://7733955740",
    ["gear"] = "rbxassetid://7733960981",
    ["sprocket"] = "rbxassetid://7734056595",
    ["chain-drive"] = "rbxassetid://7733963885",
    ["belt-drive"] = "rbxassetid://7733917120",
    ["shaft"] = "rbxassetid://7734056595",
    ["axle"] = "rbxassetid://7733710707",
    ["bearing"] = "rbxassetid://7733917120",
    ["bushing"] = "rbxassetid://7733917120",
    ["coupling"] = "rbxassetid://7733963885",
    ["clutch"] = "rbxassetid://7733963885",
    ["brake"] = "rbxassetid://7733917120",
    ["damper"] = "rbxassetid://7733964719",
    ["shock"] = "rbxassetid://7734056595",
    ["absorber"] = "rbxassetid://7733710707",
    ["spring"] = "rbxassetid://7734066296",
    ["coil"] = "rbxassetid://rbxassetid://7733963885",
    ["spiral"] = "rbxassetid://7734056595",
    ["helix"] = "rbxassetid://7733960981",
    ["loop"] = "rbxassetid://7733955740",
    ["arc"] = "rbxassetid://7733710707",
    ["curve"] = "rbxassetid://7733963885",
    ["spline"] = "rbxassetid://7734066296",
    ["bezier"] = "rbxassetid://7733917120",
    [" nurbs"] = "rbxassetid://7733954088",
    ["polygon"] = "rbxassetid://7733954760",
    ["polyline"] = "rbxassetid://7733954760",
    ["mesh"] = "rbxassetid://7733954088",
    ["surface"] = "rbxassetid://7734066296",
    ["solid"] = "rbxassetid://7734066296",
    ["volume"] = "rbxassetid://7734073250",
    ["area"] = "rbxassetid://7733710707",
    ["length"] = "rbxassetid://7733955740",
    ["width"] = "rbxassetid://7734079055",
    ["height"] = "rbxassetid://7733960981",
    ["depth"] = "rbxassetid://7733964719",
    ["radius"] = "rbxassetid://7734053426",
    ["diameter"] = "rbxassetid://7733964719",
    ["circumference"] = "rbxassetid://7733963885",
    ["perimeter"] = "rbxassetid://7733954760",
    ["boundary"] = "rbxassetid://7733917120",
    ["edge"] = "rbxassetid://7733964719",
    ["face"] = "rbxassetid://7733960981",
    ["vertex"] = "rbxassetid://7734079055",
    ["normal"] = "rbxassetid://7733954088",
    ["tangent"] = "rbxassetid://rbxassetid://7734065795",
    ["binormal"] = "rbxassetid://7733917120",
    ["uv"] = "rbxassetid://7734079055",
    ["texture"] = "rbxassetid://7734065795",
    ["material"] = "rbxassetid://7733954088",
    ["shader"] = "rbxassetid://7734056595",
    ["lighting"] = "rbxassetid://7733955740",
    ["shadow"] = "rbxassetid://rbxassetid://7734056595",
    ["reflection"] = "rbxassetid://7734053426",
    ["refraction"] = "rbxassetid://7734053426",
    ["diffraction"] = "rbxassetid://7733964719",
    ["interference"] = "rbxassetid://7733955740",
    ["polarization"] = "rbxassetid://7733954760",
    ["dispersion"] = "rbxassetid://7733964719",
    ["scattering"] = "rbxassetid://7734056595",
    ["absorption"] = "rbxassetid://7733710707",
    ["emission"] = "rbxassetid://7733964719",
    ["transmission"] = "rbxassetid://7734065795",
    ["transparency"] = "rbxassetid://7734065795",
    ["opacity"] = "rbxassetid://7733954088",
    ["translucency"] = "rbxassetid://7734065795",
    ["diffusion"] = "rbxassetid://7733964719",
    ["specular"] = "rbxassetid://7734066296",
    ["ambient"] = "rbxassetid://7733710707",
    ["diffuse"] = "rbxassetid://7733964719",
    ["glossy"] = "rbxassetid://7733960981",
    ["matte"] = "rbxassetid://7733954088",
    ["metallic"] = "rbxassetid://7733954088",
    ["roughness"] = "rbxassetid://7734053426",
    ["bump"] = "rbxassetid://7733917120",
    ["normal-map"] = "rbxassetid://7733954088",
    ["displacement"] = "rbxassetid://7733964719",
    ["parallax"] = "rbxassetid://7733954760",
    ["occlusion"] = "rbxassetid://7733954088",
    ["cavity"] = "rbxassetid://7733963885",
    ["curvature"] = "rbxassetid://7733963885",
    ["thickness"] = "rbxassetid://7734065795",
    ["subsurface"] = "rbxassetid://7734066296",
    ["scattering-sss"] = "rbxassetid://7734056595",
    ["emissive"] = "rbxassetid://7733964719",
    ["iridescent"] = "rbxassetid://7733955740",
    ["holographic"] = "rbxassetid://7733960981",
    ["chromatic"] = "rbxassetid://7733963885",
    ["aberration"] = "rbxassetid://7733710707",
    ["distortion-lens"] = "rbxassetid://7733964719",
    ["fisheye"] = "rbxassetid://7733960981",
    ["panorama"] = "rbxassetid://7733954760",
    ["equirectangular"] = "rbxassetid://7733964719",
    ["cubemap"] = "rbxassetid://rbxassetid://7733963885",
    ["hdri"] = "rbxassetid://7733960981",
    ["environment"] = "rbxassetid://7733964719",
    ["probe"] = "rbxassetid://7733954760",
    ["irradiance"] = "rbxassetid://7733955740",
    ["radiance"] = "rbxassetid://7734053426",
    ["prefilter"] = "rbxassetid://7733954760",
    ["lut"] = "rbxassetid://7733955740",
    ["color-grade"] = "rbxassetid://7733963885",
    ["tone-map"] = "rbxassetid://7734065795",
    ["exposure"] = "rbxassetid://7733964719",
    ["white-balance"] = "rbxassetid://7734079055",
    ["contrast"] = "rbxassetid://7733963885",
    ["saturation"] = "rbxassetid://7734056595",
    ["vibrance"] = "rbxassetid://7734079055",
    ["highlights"] = "rbxassetid://7733960981",
    ["shadows"] = "rbxassetid://rbxassetid://7734056595",
    ["whites"] = "rbxassetid://7734079055",
    ["blacks"] = "rbxassetid://7733917120",
    ["clarity"] = "rbxassetid://7733963885",
    ["dehaze"] = "rbxassetid://7733964719",
    ["sharpen"] = "rbxassetid://7734056595",
    ["blur"] = "rbxassetid://7733917120",
    ["bloom"] = "rbxassetid://7733917120",
    ["glow-post"] = "rbxassetid://7733960981",
    ["flare"] = "rbxassetid://7733960981",
    ["glare"] = "rbxassetid://7733960981",
    ["ghosting"] = "rbxassetid://7733960981",
    ["halos"] = "rbxassetid://7733960981",
    ["vignette"] = "rbxassetid://7734079055",
    ["grain"] = "rbxassetid://7733960981",
    ["noise"] = "rbxassetid://7733954088",
    ["artifacts"] = "rbxassetid://7733710707",
    ["banding"] = "rbxassetid://7733917120",
    ["mosquito"] = "rbxassetid://7733959802",
    ["jaggies"] = "rbxassetid://7733955740",
    ["aliasing"] = "rbxassetid://7733710707",
    ["anti-aliasing"] = "rbxassetid://7733710707",
    ["msaa"] = "rbxassetid://7733959802",
    ["fxaa"] = "rbxassetid://7733960981",
    ["txaa"] = "rbxassetid://7734065795",
    ["dlss"] = "rbxassetid://7733964719",
    ["fsr"] = "rbxassetid://7733960981",
    ["upscaling"] = "rbxassetid://7734079055",
    ["downscaling"] = "rbxassetid://7733964719",
    ["supersampling"] = "rbxassetid://7734066296",
    ["subsampling"] = "rbxassetid://7734066296",
    ["chroma"] = "rbxassetid://rbxassetid://7733963885",
    ["luma"] = "rbxassetid://7733955740",
    ["ycbcr"] = "rbxassetid://7734079055",
    ["rgb"] = "rbxassetid://7734053426",
    ["cmyk"] = "rbxassetid://7733963885",
    ["hsv"] = "rbxassetid://7733960981",
    ["hsl"] = "rbxassetid://7733960981",
    ["lab"] = "rbxassetid://7733955740",
    ["xyz"] = "rbxassetid://7734079055",
    ["srgb"] = "rbxassetid://7734056595",
    ["adobe-rgb"] = "rbxassetid://7733710707",
    ["prophoto"] = "rbxassetid://7733954760",
    ["rec709"] = "rbxassetid://7734053426",
    ["rec2020"] = "rbxassetid://7734053426",
    ["dci-p3"] = "rbxassetid://7733964719",
    ["display-p3"] = "rbxassetid://7733964719",
    ["wide-gamut"] = "rbxassetid://7734079055",
    ["hdr"] = "rbxassetid://7733960981",
    ["sdr"] = "rbxassetid://7734066296",
    ["dolby-vision"] = "rbxassetid://7733964719",
    ["hdr10"] = "rbxassetid://7733960981",
    ["hlg"] = "rbxassetid://7733960981",
    ["technicolor"] = "rbxassetid://rbxassetid://7734065795",
    ["imax"] = "rbxassetid://7733955740",
    ["vista"] = "rbxassetid://7734079055",
    ["panavision"] = "rbxassetid://7733954760",
    ["anamorphic"] = "rbxassetid://7733710707",
    ["spherical"] = "rbxassetid://7734066296",
    ["cylindrical"] = "rbxassetid://7733963885",
    ["stereoscopic"] = "rbxassetid://7734066296",
    ["autostereoscopic"] = "rbxassetid://7733710707",
    ["volumetric"] = "rbxassetid://7734073250",
    ["holographic-display"] = "rbxassetid://7733960981",
    ["light-field"] = "rbxassetid://7733955740",
    ["multiview"] = "rbxassetid://7733959802",
    ["free-viewpoint"] = "rbxassetid://7733960981",
    ["6dof"] = "rbxassetid://7733963885",
    ["3dof"] = "rbxassetid://7733964719",
    ["head-tracking"] = "rbxassetid://7733960981",
    ["eye-tracking"] = "rbxassetid://7733964719",
    ["hand-tracking"] = "rbxassetid://7733960981",
    ["body-tracking"] = "rbxassetid://7733917120",
    ["face-tracking"] = "rbxassetid://7733960981",
    ["lip-sync"] = "rbxassetid://7733955740",
    ["emotion-detection"] = "rbxassetid://7733964719",
    ["gesture-recognition"] = "rbxassetid://7733960981",
    ["pose-estimation"] = "rbxassetid://7733954760",
    ["skeleton-tracking"] = "rbxassetid://7734056595",
    ["motion-capture"] = "rbxassetid://7733959802",
    ["performance-capture"] = "rbxassetid://7733954760",
    ["virtual-production"] = "rbxassetid://7734079055",
    ["led-volume"] = "rbxassetid://7733955740",
    ["green-screen"] = "rbxassetid://7733960981",
    ["blue-screen"] = "rbxassetid://7733917120",
    ["chroma-key"] = "rbxassetid://rbxassetid://7733963885",
    ["matte-painting"] = "rbxassetid://7733954088",
    ["set-extension"] = "rbxassetid://7734056595",
    ["digital-double"] = "rbxassetid://7733964719",
    ["cg-character"] = "rbxassetid://7733963885",
    ["virtual-human"] = "rbxassetid://7734079055",
    ["digital-human"] = "rbxassetid://7733964719",
    ["synthetic-media"] = "rbxassetid://7734066296",
    ["deepfake"] = "rbxassetid://7733964719",
    ["face-swap"] = "rbxassetid://7733960981",
    ["voice-clone"] = "rbxassetid://7734073250",
    ["ai-generated"] = "rbxassetid://7733710707",
    ["neural-render"] = "rbxassetid://7733954088",
    ["gaussian-splat"] = "rbxassetid://7733960981",
    ["nerf"] = "rbxassetid://7733954088",
    ["3d-gaussian"] = "rbxassetid://7733960981",
    ["point-cloud"] = "rbxassetid://7733954760",
    ["mesh-reconstruction"] = "rbxassetid://7733954088",
    ["photogrammetry"] = "rbxassetid://7733954760",
    ["structured-light"] = "rbxassetid://7734066296",
    ["time-of-flight"] = "rbxassetid://rbxassetid://7734065795",
    ["stereo-vision"] = "rbxassetid://7734066296",
    ["multi-view-stereo"] = "rbxassetid://7733959802",
    ["visual-odometry"] = "rbxassetid://7734079055",
    ["slam"] = "rbxassetid://7734056595",
    ["localization"] = "rbxassetid://7733955740",
    ["mapping"] = "rbxassetid://7733954088",
    ["navigation"] = "rbxassetid://7733954088",
    ["pathfinding"] = "rbxassetid://7733954760",
    ["obstacle-avoidance"] = "rbxassetid://7733954088",
    ["collision-detection"] = "rbxassetid://7733963885",
    ["physics-sim"] = "rbxassetid://7733954760",
    ["rigid-body"] = "rbxassetid://7734053426",
    ["soft-body"] = "rbxassetid://7734066296",
    ["cloth-sim"] = "rbxassetid://rbxassetid://7733963885",
    ["fluid-sim"] = "rbxassetid://7733960981",
    ["particle-sim"] = "rbxassetid://7733954760",
    ["fem"] = "rbxassetid://7733960981",
    ["sph"] = "rbxassetid://7734056595",
    ["pbd"] = "rbxassetid://7733954760",
    ["xpbd"] = "rbxassetid://7734079055",
    ["position-based"] = "rbxassetid://7733954760",
    ["constraint-based"] = "rbxassetid://rbxassetid://7733963885",
    ["impulse-based"] = "rbxassetid://7733955740",
    ["penalty-based"] = "rbxassetid://7733954760",
    ["continuous-collision"] = "rbxassetid://7733963885",
    ["discrete-collision"] = "rbxassetid://7733964719",
    ["broad-phase"] = "rbxassetid://7733917120",
    ["narrow-phase"] = "rbxassetid://7733954088",
    ["spatial-hash"] = "rbxassetid://7734066296",
    ["bvh"] = "rbxassetid://7733917120",
    ["kdtree"] = "rbxassetid://7733955740",
    ["octree"] = "rbxassetid://7733954088",
    ["quadtree"] = "rbxassetid://7734053426",
    ["grid-spatial"] = "rbxassetid://7733960981",
    ["sweep-and-prune"] = "rbxassetid://7734066296",
    ["gjk"] = "rbxassetid://7733960981",
    ["epa"] = "rbxassetid://7733964719",
    ["sat"] = "rbxassetid://7734056595",
    ["minkowski"] = "rbxassetid://7733959802",
    ["support-mapping"] = "rbxassetid://7734066296",
    ["contact-manifold"] = "rbxassetid://rbxassetid://7733963885",
    ["contact-point"] = "rbxassetid://7733963885",
    ["contact-normal"] = "rbxassetid://7733954088",
    ["penetration-depth"] = "rbxassetid://7733954760",
    ["restitution"] = "rbxassetid://7734053426",
    ["friction"] = "rbxassetid://7733960981",
    ["damping"] = "rbxassetid://7733964719",
    ["stiffness"] = "rbxassetid://7734066296",
    ["compliance"] = "rbxassetid://7733963885",
    ["inverse-mass"] = "rbxassetid://7733955740",
    ["inverse-inertia"] = "rbxassetid://7733955740",
    ["center-of-mass"] = "rbxassetid://rbxassetid://7733963885",
    ["moment-of-inertia"] = "rbxassetid://7733959802",
    ["angular-momentum"] = "rbxassetid://7733710707",
    ["linear-momentum"] = "rbxassetid://7733955740",
    ["angular-velocity"] = "rbxassetid://7733710707",
    ["linear-velocity"] = "rbxassetid://7733955740",
    ["force"] = "rbxassetid://rbxassetid://7733960981",
    ["torque"] = "rbxassetid://rbxassetid://7734065795",
    ["impulse"] = "rbxassetid://7733955740",
    ["acceleration"] = "rbxassetid://7733710707",
    ["jerk"] = "rbxassetid://7733955740",
    ["snap"] = "rbxassetid://7734056595",
    ["jounce"] = "rbxassetid://7733955740",
    ["kinematics"] = "rbxassetid://7733955740",
    ["dynamics"] = "rbxassetid://7733964719",
    ["statics"] = "rbxassetid://7734066296",
    ["kinetics"] = "rbxassetid://7733955740",
    ["mechanics"] = "rbxassetid://7733954088",
    ["thermodynamics"] = "rbxassetid://7734065795",
    ["electromagnetism"] = "rbxassetid://7733964719",
    ["optics"] = "rbxassetid://7733954088",
    ["acoustics"] = "rbxassetid://7733710707",
    ["fluid-dynamics"] = "rbxassetid://7733960981",
    ["aerodynamics"] = "rbxassetid://7733710707",
    ["hydrodynamics"] = "rbxassetid://7733960981",
    ["quantum"] = "rbxassetid://7734053426",
    ["relativity"] = "rbxassetid://7734053426",
    ["cosmology"] = "rbxassetid://rbxassetid://7733963885",
    ["astrophysics"] = "rbxassetid://7733960981",
    ["particle-physics"] = "rbxassetid://7733954760",
    ["nuclear-physics"] = "rbxassetid://7733954088",
    ["condensed-matter"] = "rbxassetid://7733963885",
    ["plasma-physics"] = "rbxassetid://7733954760",
    ["biophysics"] = "rbxassetid://7733917120",
    ["geophysics"] = "rbxassetid://7733960981",
    ["seismology"] = "rbxassetid://7734056595",
    ["volcanology"] = "rbxassetid://7734079055",
    ["meteorology"] = "rbxassetid://7733954088",
    ["climatology"] = "rbxassetid://rbxassetid://7733963885",
    ["oceanography"] = "rbxassetid://7733954088",
    ["hydrology"] = "rbxassetid://7733960981",
    ["glaciology"] = "rbxassetid://7733960981",
    ["paleontology"] = "rbxassetid://7733954760",
    ["archaeology"] = "rbxassetid://7733710707",
    ["anthropology"] = "rbxassetid://7733710707",
    ["sociology"] = "rbxassetid://7734066296",
    ["psychology"] = "rbxassetid://7733954760",
    ["cognitive-science"] = "rbxassetid://rbxassetid://7733963885",
    ["neuroscience"] = "rbxassetid://7733954088",
    ["linguistics"] = "rbxassetid://7733955740",
    ["philosophy"] = "rbxassetid://7733954760",
    ["logic"] = "rbxassetid://rbxassetid://7733955740",
    ["ethics"] = "rbxassetid://7733964719",
    ["aesthetics"] = "rbxassetid://7733710707",
    ["metaphysics"] = "rbxassetid://7733959802",
    ["epistemology"] = "rbxassetid://7733964719",
    ["ontology"] = "rbxassetid://7733954088",
    ["phenomenology"] = "rbxassetid://7733954760",
    ["existentialism"] = "rbxassetid://7733964719",
    ["structuralism"] = "rbxassetid://7734066296",
    ["post-structuralism"] = "rbxassetid://rbxassetid://7733954760",
    ["deconstruction"] = "rbxassetid://7733964719",
    ["critical-theory"] = "rbxassetid://rbxassetid://7733963885",
    ["feminism"] = "rbxassetid://7733960981",
    ["postcolonialism"] = "rbxassetid://rbxassetid://7733954760",
    ["queer-theory"] = "rbxassetid://rbxassetid://7734053426",
    ["disability-studies"] = "rbxassetid://rbxassetid://7733964719",
    ["environmental-humanities"] = "rbxassetid://rbxassetid://7733964719",
    ["digital-humanities"] = "rbxassetid://rbxassetid://7733964719",
    ["media-studies"] = "rbxassetid://rbxassetid://7733954088",
    ["communication-studies"] = "rbxassetid://rbxassetid://7733963885",
    ["political-science"] = "rbxassetid://rbxassetid://7733954760",
    ["international-relations"] = "rbxassetid://rbxassetid://7733955740",
    ["economics"] = "rbxassetid://7733964719",
    ["macroeconomics"] = "rbxassetid://rbxassetid://7733954088",
    ["microeconomics"] = "rbxassetid://rbxassetid://7733959802",
    ["econometrics"] = "rbxassetid://rbxassetid://7733964719",
    ["game-theory"] = "rbxassetid://rbxassetid://7733960981",
    ["decision-theory"] = "rbxassetid://rbxassetid://7733964719",
    ["behavioral-economics"] = "rbxassetid://rbxassetid://7733917120",
    ["neuroeconomics"] = "rbxassetid://rbxassetid://7733954088",
    ["experimental-economics"] = "rbxassetid://rbxassetid://7733964719",
    ["computational-economics"] = "rbxassetid://rbxassetid://7733964719",
    ["agent-based-model"] = "rbxassetid://rbxassetid://7733710707",
    ["system-dynamics"] = "rbxassetid://rbxassetid://7734066296",
    ["input-output"] = "rbxassetid://rbxassetid://7733955740",
    ["computable-general-equilibrium"] = "rbxassetid://rbxassetid://7733963885",
    ["dynamic-stochastic-general-equilibrium"] = "rbxassetid://rbxassetid://7733964719",
    ["vector-autoregression"] = "rbxassetid://rbxassetid://7734079055",
    ["structural-vector-autoregression"] = "rbxassetid://rbxassetid://7734066296",
    ["error-correction-model"] = "rbxassetid://rbxassetid://7733964719",
    ["cointegration"] = "rbxassetid://rbxassetid://7733963885",
    ["unit-root"] = "rbxassetid://rbxassetid://7734079055",
    ["stationarity"] = "rbxassetid://rbxassetid://7734066296",
    ["heteroskedasticity"] = "rbxassetid://rbxassetid://7733960981",
    ["autocorrelation"] = "rbxassetid://rbxassetid://7733710707",
    ["multicollinearity"] = "rbxassetid://rbxassetid://7733959802",
    ["endogeneity"] = "rbxassetid://rbxassetid://7733964719",
    ["exogeneity"] = "rbxassetid://rbxassetid://7733964719",
    ["instrumental-variable"] = "rbxassetid://rbxassetid://7733955740",
    ["two-stage-least-squares"] = "rbxassetid://rbxassetid://7734066296",
    ["generalized-method-of-moments"] = "rbxassetid://rbxassetid://7733960981",
    ["maximum-likelihood"] = "rbxassetid://rbxassetid://7733954088",
    ["bayesian-estimation"] = "rbxassetid://rbxassetid://7733917120",
    ["markov-chain-monte-carlo"] = "rbxassetid://rbxassetid://7733959802",
    ["hamiltonian-monte-carlo"] = "rbxassetid://rbxassetid://7733960981",
    ["variational-inference"] = "rbxassetid://rbxassetid://7734079055",
    ["expectation-propagation"] = "rbxassetid://rbxassetid://7733964719",
    ["belief-propagation"] = "rbxassetid://rbxassetid://7733917120",
    ["mean-field"] = "rbxassetid://rbxassetid://7733954088",
    ["loopy-belief-propagation"] = "rbxassetid://rbxassetid://7733963885",
    ["junction-tree"] = "rbxassetid://rbxassetid://7733955740",
    ["variable-elimination"] = "rbxassetid://rbxassetid://7734079055",
    ["bucket-elimination"] = "rbxassetid://rbxassetid://7733917120",
    ["mini-bucket"] = "rbxassetid://rbxassetid://7733959802",
    ["and-or-search"] = "rbxassetid://rbxassetid://7733710707",
    ["weighted-model-counting"] = "rbxassetid://rbxassetid://7733964719",
    ["knowledge-compilation"] = "rbxassetid://rbxassetid://rbxassetid://7733955740",
    ["binary-decision-diagram"] = "rbxassetid://rbxassetid://7733917120",
    ["sentential-decision-diagram"] = "rbxassetid://rbxassetid://7733963885",
    ["probabilistic-circuit"] = "rbxassetid://rbxassetid://7733954760",
    ["neural-network"] = "rbxassetid://rbxassetid://7733954088",
    ["deep-learning"] = "rbxassetid://rbxassetid://7733964719",
    ["convolutional-neural-network"] = "rbxassetid://rbxassetid://7733963885",
    ["recurrent-neural-network"] = "rbxassetid://rbxassetid://7734053426",
    ["long-short-term-memory"] = "rbxassetid://rbxassetid://7733955740",
    ["gated-recurrent-unit"] = "rbxassetid://rbxassetid://7733960981",
    ["transformer"] = "rbxassetid://rbxassetid://7734065795",
    ["attention-mechanism"] = "rbxassetid://rbxassetid://7733710707",
    ["self-attention"] = "rbxassetid://rbxassetid://7734056595",
    ["multi-head-attention"] = "rbxassetid://rbxassetid://7733959802",
    ["positional-encoding"] = "rbxassetid://rbxassetid://7733954760",
    ["bert"] = "rbxassetid://rbxassetid://7733917120",
    ["gpt"] = "rbxassetid://rbxassetid://7733960981",
    ["t5"] = "rbxassetid://rbxassetid://rbxassetid://7734065795",
    ["vision-transformer"] = "rbxassetid://rbxassetid://7734079055",
    ["swin-transformer"] = "rbxassetid://rbxassetid://7734066296",
    ["detr"] = "rbxassetid://rbxassetid://7733964719",
    ["clip"] = "rbxassetid://rbxassetid://rbxassetid://7733963885",
    ["dall-e"] = "rbxassetid://rbxassetid://7733964719",
    ["stable-diffusion"] = "rbxassetid://rbxassetid://7734056595",
    ["midjourney"] = "rbxassetid://rbxassetid://7733954088",
    ["imagen"] = "rbxassetid://rbxassetid://7733955740",
    ["parti"] = "rbxassetid://rbxassetid://7733954760",
    ["phenaki"] = "rbxassetid://rbxassetid://7733954760",
    ["make-a-video"] = "rbxassetid://rbxassetid://7734073250",
    ["imagen-video"] = "rbxassetid://rbxassetid://7734073250",
    ["stable-video-diffusion"] = "rbxassetid://rbxassetid://7734073250",
    ["sora"] = "rbxassetid://rbxassetid://7734066296",
    ["runway-gen2"] = "rbxassetid://rbxassetid://7734073250",
    ["pika-labs"] = "rbxassetid://rbxassetid://7734073250",
    ["heygen"] = "rbxassetid://rbxassetid://7733960981",
    ["synthesia"] = "rbxassetid://rbxassetid://7734066296",
    ["d-id"] = "rbxassetid://rbxassetid://7733964719",
    ["elevenlabs"] = "rbxassetid://rbxassetid://7734073250",
    ["murf"] = "rbxassetid://rbxassetid://7734073250",
    ["play-ht"] = "rbxassetid://rbxassetid://7734073250",
    ["wellsaid"] = "rbxassetid://rbxassetid://7734073250",
    ["respeecher"] = "rbxassetid://rbxassetid://7734073250",
    ["descript"] = "rbxassetid://rbxassetid://7733964719",
    ["otter-ai"] = "rbxassetid://rbxassetid://7733955740",
    ["fireflies"] = "rbxassetid://rbxassetid://7733960981",
    ["tldv"] = "rbxassetid://rbxassetid://7733964719",
    ["fathom"] = "rbxassetid://rbxassetid://7733960981",
    ["read-ai"] = "rbxassetid://rbxassetid://7734053426",
    ["granola"] = "rbxassetid://rbxassetid://7733960981",
    ["notion-ai"] = "rbxassetid://rbxassetid://7733954088",
    ["mem-ai"] = "rbxassetid://rbxassetid://7733954088",
    ["rewind-ai"] = "rbxassetid://rbxassetid://7734053426",
    ["raycast-ai"] = "rbxassetid://rbxassetid://7734053426",
    ["arc-browser"] = "rbxassetid://rbxassetid://7733960981",
    ["sigma-os"] = "rbxassetid://rbxassetid://7734066296",
    ["browser-company"] = "rbxassetid://rbxassetid://7733960981",
    ["the-browser-company"] = "rbxassetid://rbxassetid://7733960981",
    ["arc-max"] = "rbxassetid://rbxassetid://7733960981",
    ["arc-search"] = "rbxassetid://rbxassetid://7734053426",
    ["perplexity"] = "rbxassetid://rbxassetid://7733954760",
    ["you-com"] = "rbxassetid://rbxassetid://7734079055",
    ["phind"] = "rbxassetid://rbxassetid://7733960981",
    ["kagi"] = "rbxassetid://rbxassetid://7733955740",
    ["duckduckgo-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["bing-copilot"] = "rbxassetid://rbxassetid://7733960981",
    ["google-bard"] = "rbxassetid://rbxassetid://7733960981",
    ["google-gemini"] = "rbxassetid://rbxassetid://7733960981",
    ["anthropic-claude"] = "rbxassetid://rbxassetid://7733960981",
    ["amazon-bedrock"] = "rbxassetid://rbxassetid://7733960981",
    ["amazon-q"] = "rbxassetid://rbxassetid://7733960981",
    ["meta-llama"] = "rbxassetid://rbxassetid://7733960981",
    ["mistral-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["cohere"] = "rbxassetid://rbxassetid://7733960981",
    ["ai21-labs"] = "rbxassetid://rbxassetid://7733960981",
    ["inflection-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["adept-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["character-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["replika"] = "rbxassetid://rbxassetid://7733960981",
    ["pi-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["quora-poe"] = "rbxassetid://rbxassetid://7733960981",
    ["hugging-face"] = "rbxassetid://rbxassetid://7733960981",
    ["replicate"] = "rbxassetid://rbxassetid://7734053426",
    ["banana-dev"] = "rbxassetid://rbxassetid://7733960981",
    ["modal-labs"] = "rbxassetid://rbxassetid://7733960981",
    ["together-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["anyscale"] = "rbxassetid://rbxassetid://7733960981",
    ["baseten"] = "rbxassetid://rbxassetid://7733960981",
    ["coreweave"] = "rbxassetid://rbxassetid://7733960981",
    ["lambda-labs"] = "rbxassetid://rbxassetid://7733960981",
    ["runpod"] = "rbxassetid://rbxassetid://7733960981",
    ["vast-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["jarvislabs"] = "rbxassetid://rbxassetid://7733960981",
    ["paperspace"] = "rbxassetid://rbxassetid://7733960981",
    ["spell"] = "rbxassetid://rbxassetid://7733960981",
    ["weights-and-biases"] = "rbxassetid://rbxassetid://7733960981",
    ["mlflow"] = "rbxassetid://rbxassetid://7733960981",
    ["tensorboard"] = "rbxassetid://rbxassetid://7733960981",
    ["comet-ml"] = "rbxassetid://rbxassetid://7733960981",
    ["neptune-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["clearml"] = "rbxassetid://rbxassetid://7733960981",
    ["dvc"] = "rbxassetid://rbxassetid://7733960981",
    ["pachyderm"] = "rbxassetid://rbxassetid://7733960981",
    ["tecton"] = "rbxassetid://rbxassetid://7733960981",
    ["feast"] = "rbxassetid://rbxassetid://7733960981",
    ["whylogs"] = "rbxassetid://rbxassetid://7733960981",
    ["evidently-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["great-expectations"] = "rbxassetid://rbxassetid://7733960981",
    ["monte-carlo"] = "rbxassetid://rbxassetid://7733960981",
    ["bigeye"] = "rbxassetid://rbxassetid://7733960981",
    ["soda-core"] = "rbxassetid://rbxassetid://7733960981",
    ["dbt-labs"] = "rbxassetid://rbxassetid://7733960981",
    ["fivetran"] = "rbxassetid://rbxassetid://7733960981",
    ["airbyte"] = "rbxassetid://rbxassetid://7733960981",
    ["stitch-data"] = "rbxassetid://rbxassetid://7733960981",
    ["meltano"] = "rbxassetid://rbxassetid://7733960981",
    ["prefect"] = "rbxassetid://rbxassetid://7733960981",
    ["dagster"] = "rbxassetid://rbxassetid://7733960981",
    ["airflow"] = "rbxassetid://rbxassetid://7733960981",
    ["luigi"] = "rbxassetid://rbxassetid://7733960981",
    ["pinball"] = "rbxassetid://rbxassetid://7733960981",
    ["argo-workflows"] = "rbxassetid://rbxassetid://7733960981",
    ["kubeflow"] = "rbxassetid://rbxassetid://7733960981",
    ["mlflow-tracking"] = "rbxassetid://rbxassetid://7733960981",
    ["optuna"] = "rbxassetid://rbxassetid://7733960981",
    ["ray-tune"] = "rbxassetid://rbxassetid://7733960981",
    ["hyperopt"] = "rbxassetid://rbxassetid://7733960981",
    ["scikit-optimize"] = "rbxassetid://rbxassetid://7733960981",
    ["sigopt"] = "rbxassetid://rbxassetid://7733960981",
    ["weights-biases-sweeps"] = "rbxassetid://rbxassetid://7733960981",
    ["determined-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["spell-ml"] = "rbxassetid://rbxassetid://7733960981",
    ["grid-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["runai"] = "rbxassetid://rbxassetid://7733960981",
    ["domino-data-lab"] = "rbxassetid://rbxassetid://7733960981",
    ["algorithmia"] = "rbxassetid://rbxassetid://7733960981",
    ["seldon"] = "rbxassetid://rbxassetid://7733960981",
    ["bentoml"] = "rbxassetid://rbxassetid://7733960981",
    ["cortex-labs"] = "rbxassetid://rbxassetid://7733960981",
    ["triton-inference-server"] = "rbxassetid://rbxassetid://7733960981",
    ["tensorflow-serving"] = "rbxassetid://rbxassetid://7733960981",
    ["torchserve"] = "rbxassetid://rbxassetid://7733960981",
    ["kserve"] = "rbxassetid://rbxassetid://7733960981",
    ["seldon-core"] = "rbxassetid://rbxassetid://7733960981",
    ["bento-ml"] = "rbxassetid://rbxassetid://7733960981",
    ["cog"] = "rbxassetid://rbxassetid://7733960981",
    ["banana"] = "rbxassetid://rbxassetid://7733960981",
    ["replicate-cog"] = "rbxassetid://rbxassetid://7733960981",
    ["hugging-face-inference-endpoints"] = "rbxassetid://rbxassetid://7733960981",
    ["octoai"] = "rbxassetid://rbxassetid://7733960981",
    ["fireworks-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["forefront-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["goose-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["nlp-cloud"] = "rbxassetid://rbxassetid://7733960981",
    ["deep-ai"] = "rbxassetid://rbxassetid://7733960981",
    ["machine-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["artificial-intelligence"] = "rbxassetid://rbxassetid://7733960981",
    ["data-science"] = "rbxassetid://rbxassetid://7733960981",
    ["big-data"] = "rbxassetid://rbxassetid://7733960981",
    ["cloud-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["edge-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["fog-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["distributed-systems"] = "rbxassetid://rbxassetid://7733960981",
    ["parallel-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["high-performance-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["quantum-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["neuromorphic-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["photonic-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["dna-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["biological-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["chemical-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["molecular-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["spintronics"] = "rbxassetid://rbxassetid://7733960981",
    ["memristor"] = "rbxassetid://rbxassetid://7733960981",
    ["reservoir-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["extreme-learning-machine"] = "rbxassetid://rbxassetid://7733960981",
    ["liquid-state-machine"] = "rbxassetid://rbxassetid://7733960981",
    ["echo-state-network"] = "rbxassetid://rbxassetid://7733960981",
    ["spiking-neural-network"] = "rbxassetid://rbxassetid://7733960981",
    ["brain-inspired-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["cognitive-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["affective-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["social-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["ubiquitous-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["pervasive-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["mobile-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["wearable-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["implantable-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["embeddable-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["invisible-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["calm-technology"] = "rbxassetid://rbxassetid://7733960981",
    ["ambient-intelligence"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-environment"] = "rbxassetid://rbxassetid://7733960981",
    ["intelligent-space"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-home"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-city"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-building"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-grid"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-transportation"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-healthcare"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-education"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-agriculture"] = "rbxassetid://rbxassetid://7733960981",
    ["smart-manufacturing"] = "rbxassetid://rbxassetid://7733960981",
    ["industry-4-0"] = "rbxassetid://rbxassetid://7733960981",
    ["industrial-iot"] = "rbxassetid://rbxassetid://7733960981",
    ["digital-twin"] = "rbxassetid://rbxassetid://7733960981",
    ["cyber-physical-system"] = "rbxassetid://rbxassetid://7733960981",
    ["human-cyber-physical-system"] = "rbxassetid://rbxassetid://7733960981",
    ["socio-technical-system"] = "rbxassetid://rbxassetid://7733960981",
    ["complex-adaptive-system"] = "rbxassetid://rbxassetid://7733960981",
    ["multi-agent-system"] = "rbxassetid://rbxassetid://7733960981",
    ["swarm-intelligence"] = "rbxassetid://rbxassetid://7733960981",
    ["collective-intelligence"] = "rbxassetid://rbxassetid://7733960981",
    ["crowd-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["human-computation"] = "rbxassetid://rbxassetid://7733960981",
    ["citizen-science"] = "rbxassetid://rbxassetid://7733960981",
    ["participatory-sensing"] = "rbxassetid://rbxassetid://7733960981",
    ["community-sensing"] = "rbxassetid://rbxassetid://7733960981",
    ["mobile-crowdsensing"] = "rbxassetid://rbxassetid://7733960981",
    ["social-sensing"] = "rbxassetid://rbxassetid://7733960981",
    ["urban-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["spatial-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["location-based-service"] = "rbxassetid://rbxassetid://7733960981",
    ["context-aware-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["situation-aware-computing"] = "rbxassetid://rbxassetid://7733960981",
    ["activity-recognition"] = "rbxassetid://rbxassetid://7733960981",
    ["behavioral-biometrics"] = "rbxassetid://rbxassetid://7733960981",
    ["continuous-authentication"] = "rbxassetid://rbxassetid://7733960981",
    ["zero-trust-security"] = "rbxassetid://rbxassetid://7733960981",
    ["zero-knowledge-proof"] = "rbxassetid://rbxassetid://7733960981",
    ["homomorphic-encryption"] = "rbxassetid://rbxassetid://7733960981",
    ["secure-multi-party-computation"] = "rbxassetid://rbxassetid://7733960981",
    ["differential-privacy"] = "rbxassetid://rbxassetid://7733960981",
    ["federated-analytics"] = "rbxassetid://rbxassetid://7733960981",
    ["swarm-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["split-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["transfer-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["meta-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["few-shot-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["zero-shot-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["one-shot-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["self-supervised-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["unsupervised-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["supervised-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["semi-supervised-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["weakly-supervised-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["reinforcement-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["imitation-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["inverse-reinforcement-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["apprenticeship-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["curriculum-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["lifelong-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["continual-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["incremental-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["online-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["batch-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["active-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["passive-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["inductive-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["deductive-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["transductive-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["analytical-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["symbolic-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["connectionist-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["statistical-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["instance-based-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["model-based-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["rule-based-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["decision-tree-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["ensemble-learning"] = "rbxassetid://rbxassetid://7733960981",
    ["boosting"] = "rbxassetid://rbxassetid://7733960981",
    ["bagging"] = "rbxassetid://rbxassetid://7733960981",
    ["stacking"] = "rbxassetid://rbxassetid://7733960981",
    ["blending"] = "rbxassetid://rbxassetid://7733960981",
    ["voting"] = "rbxassetid://rbxassetid://7733960981",
    ["averaging"] = "rbxassetid://rbxassetid://7733960981",
    ["weighted-averaging"] = "rbxassetid://rbxassetid://7733960981",
    ["rank-averaging"] = "rbxassetid://rbxassetid://7733960981",
    ["bayesian-model-averaging"] = "rbxassetid://rbxassetid://7733960981",
    ["bayesian-model-combination"] = "rbxassetid://rbxassetid://7733960981",
    ["super-learner"] = "rbxassetid://rbxassetid://7733960981",
    ["deep-ensemble"] = "rbxassetid://rbxassetid://7733960981",
    ["snapshot-ensemble"] = "rbxassetid://rbxassetid://7733960981",
    ["fast-geometric-ensembling"] = "rbxassetid://rbxassetid://7733960981",
    ["stochastic-weight-averaging"] = "rbxassetid://rbxassetid://7733960981",
    ["temporal-ensembling"] = "rbxassetid://rbxassetid://7733960981",
    ["mean-teacher"] = "rbxassetid://rbxassetid://7733960981",
    ["virtual-adversarial-training"] = "rbxassetid://rbxassetid://7733960981",
    ["mixup"] = "rbxassetid://rbxassetid://7733960981",
    ["cutmix"] = "rbxassetid://rbxassetid://7733960981",
    ["cutout"] = "rbxassetid://rbxassetid://7733960981",
    ["random-erasing"] = "rbxassetid://rbxassetid://7733960981",
    ["hide-and-seek"] = "rbxassetid://rbxassetid://7733960981",
    ["grid-mask"] = "rbxassetid://rbxassetid://7733960981",
    ["autoaugment"] = "rbxassetid://rbxassetid://7733960981",
    ["randaugment"] = "rbxassetid://rbxassetid://7733960981",
    ["adversarial-training"] = "rbxassetid://rbxassetid://7733960981",
    ["sharpness-aware-minimization"] = "rbxassetid://rbxassetid://7733960981",
    ["adaptive-gradient-clipping"] = "rbxassetid://rbxassetid://7733960981",
    ["gradient-centralization"] = "rbxassetid://rbxassetid://7733960981",
    ["layer-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["batch-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["instance-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["group-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["switchable-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["filter-response-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["cross-channel-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["local-response-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["spatial-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["spectral-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["weight-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["mean-only-batch-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["weight-standardization"] = "rbxassetid://rbxassetid://7733960981",
    ["evonorm"] = "rbxassetid://rbxassetid://7733960981",
    ["powernorm"] = "rbxassetid://rbxassetid://7733960981",
    ["decorrelated-batch-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["iterative-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["online-normalization"] = "rbxassetid://rbxassetid://7733960981",
    ["lookahead-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["ranger-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["lamb-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["lars-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["novograd-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["madgrad-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["adam-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["adamw-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["adagrad-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["rmsprop-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["sgd-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["momentum-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["nesterov-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["adadelta-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["adamax-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["nadam-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["amsgrad-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["radam-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["qhadam-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["yogi-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["fromage-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["sm3-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["shampoo-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["kfac-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["natural-gradient-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["trust-region-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["line-search-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["hessian-free-optimizer"] = "rbxassetid://rbxassetid://7733960981",
    ["newton-method"] = "rbxassetid://rbxassetid://7733960981",
    ["quasi-newton-method"] = "rbxassetid://rbxassetid://7733960981",
    ["bfgs"] = "rbxassetid://rbxassetid://7733960981",
    ["l-bfgs"] = "rbxassetid://rbxassetid://7733960981",
    ["conjugate-gradient"] = "rbxassetid://rbxassetid://7733960981",
    ["nonlinear-conjugate-gradient"] = "rbxassetid://rbxassetid://7733960981",
    ["preconditioned-conjugate-gradient"] = "rbxassetid://rbxassetid://7733960981",
    ["gmres"] = "rbxassetid://rbxassetid://7733960981",
    ["bicgstab"] = "rbxassetid://rbxassetid://7733960981",
    ["minres"] = "rbxassetid://rbxassetid://7733960981",
    ["symmlq"] = "rbxassetid://rbxassetid://7733960981",
    ["tfqmr"] = "rbxassetid://rbxassetid://7733960981",
    ["idrs"] = "rbxassetid://rbxassetid://7733960981",
    ["cgne"] = "rbxassetid://rbxassetid://7733960981",
    ["cgnr"] = "rbxassetid://rbxassetid://7733960981",
    ["lsqr"] = "rbxassetid://rbxassetid://7733960981",
    ["lsmr"] = "rbxassetid://rbxassetid://7733960981",
    ["coordinate-descent"] = "rbxassetid://rbxassetid://7733960981",
    ["proximal-gradient"] = "rbxassetid://rbxassetid://7733960981",
    ["accelerated-proximal-gradient"] = "rbxassetid://rbxassetid://7733960981",
    ["alternating-direction-method-of-multipliers"] = "rbxassetid://rbxassetid://7733960981",
    ["primal-dual-hybrid-gradient"] = "rbxassetid://rbxassetid://7733960981",
    ["chambolle-pock-algorithm"] = "rbxassetid://rbxassetid://7733960981",
    ["douglas-rachford-splitting"] = "rbxassetid://rbxassetid://7733960981",
    ["forward-backward-splitting"] = "rbxassetid://rbxassetid://7733960981",
    ["davis-yin-splitting"] = "rbxassetid://rbxassetid://7733960981",
    ["three-operator-splitting"] = "rbxassetid://rbxassetid://7733960981",
    ["frank-wolfe-algorithm"] = "rbxassetid://rbxassetid://7733960981",
    ["conditional-gradient"] = "rbxassetid://rbxassetid://7733960981",
    ["away-step-frank-wolfe"] = "rbxassetid://rbxassetid://7733960981",
    ["pairwise-frank-wolfe"] = "rbxassetid://rbxassetid://7733960981",
    ["simplicial-frank-wolfe"] = "rbxassetid://rbxassetid://7733960981",
    ["cauchy-point"] = "rbxassetid://rbxassetid://7733960981",
    ["dogleg-method"] = "rbxassetid://rbxassetid://7733960981",
    ["steihaug-toint"] = "rbxassetid://rbxassetid://7733960981",
    ["truncated-newton"] = "rbxassetid://rbxassetid://7733960981",
    ["cubic-regularization"] = "rbxassetid://rbxassetid://7733960981",
    ["adaptive-cubic-regularization"] = "rbxassetid://rbxassetid://7733960981",
    ["arc"] = "rbxassetid://rbxassetid://7733960981",
    ["stochastic-gradient-langevin-dynamics"] = "rbxassetid://rbxassetid://7733960981",
    ["preconditioned-sgld"] = "rbxassetid://rbxassetid://7733960981",
    ["stochastic-gradient-hamiltonian-monte-carlo"] = "rbxassetid://rbxassetid://7733960981",
    ["sg-hmc"] = "rbxassetid://rbxassetid://7733960981",
    ["cyclical-sgld"] = "rbxassetid://rbxassetid://7733960981",
    ["replica-exchange-sgld"] = "rbxassetid://rbxassetid://7733960981",
    ["parallel-tempering"] = "rbxassetid://rbxassetid://7733960981",
    ["simulated-annealing"] = "rbxassetid://rbxassetid://7733960981",
    ["quantum-annealing"] = "rbxassetid://rbxassetid://7733960981",
    ["digital-annealing"] = "rbxassetid://rbxassetid://7733960981",
    ["population-based-training"] = "rbxassetid://rbxassetid://7733960981",
    ["evolutionary-strategies"] = "rbxassetid://rbxassetid://7733960981",
    ["natural-evolution-strategies"] = "rbxassetid://rbxassetid://7733960981",
    ["covariance-matrix-adaptation"] = "rbxassetid://rbxassetid://7733960981",
    ["cma-es"] = "rbxassetid://rbxassetid://7733960981",
    ["differential-evolution"] = "rbxassetid://rbxassetid://7733960981",
    ["particle-swarm-optimization"] = "rbxassetid://rbxassetid://7733960981",
    ["ant-colony-optimization"] = "rbxassetid://rbxassetid://7733960981",
    ["genetic-algorithm"] = "rbxassetid://rbxassetid://7733960981",
    ["genetic-programming"] = "rbxassetid://rbxassetid://7733960981",
    ["neuroevolution"] = "rbxassetid://rbxassetid://7733960981",
    ["neuroevolution-of-augmenting-topologies"] = "rbxassetid://rbxassetid://7733960981",
    ["neat"] = "rbxassetid://rbxassetid://7733960981",
    ["hyperneat"] = "rbxassetid://rbxassetid://7733960981",
    ["es-hyperneat"] = "rbxassetid://rbxassetid://7733960981",
    ["novelty-search"] = "rbxassetid://rbxassetid://7733960981",
    ["quality-diversity"] = "rbxassetid://rbxassetid://7733960981",
    ["map-elites"] = "rbxassetid://rbxassetid://7733960981",
    ["cma-map-elites"] = "rbxassetid://rbxassetid://7733960981",
    ["deep-grid-map-elites"] = "rbxassetid://rbxassetid://7733960981",
    ["aurora"] = "rbxassetid://rbxassetid://7733960981"
}

-- Utility Functions
local function Create(instanceType, properties)
    local instance = Instance.new(instanceType)
    for property, value in pairs(properties or {}) do
        instance[property] = value
    end
    return instance
end

local function Tween(instance, properties, duration, easingStyle, easingDirection)
    local tween = TweenService:Create(instance, TweenInfo.new(
        duration or 0.3,
        easingStyle or Enum.EasingStyle.Quad,
        easingDirection or Enum.EasingDirection.Out
    ), properties)
    tween:Play()
    return tween
end

local function MakeDraggable(frame, handle)
    local dragging = false
    local dragInput, mousePos, framePos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            frame.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Themes
AuroraUI.Themes = {
    Dark = {
        Background = Color3.fromRGB(30, 30, 35),
        SecondaryBackground = Color3.fromRGB(40, 40, 45),
        TertiaryBackground = Color3.fromRGB(50, 50, 55),
        Accent = Color3.fromRGB(100, 150, 255),
        AccentDark = Color3.fromRGB(80, 120, 220),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180),
        Border = Color3.fromRGB(60, 60, 65),
        Success = Color3.fromRGB(80, 200, 120),
        Error = Color3.fromRGB(255, 80, 80),
        Warning = Color3.fromRGB(255, 180, 80),
        Shadow = Color3.fromRGB(0, 0, 0),
        Acrylic = Color3.fromRGB(30, 30, 35)
    },
    Light = {
        Background = Color3.fromRGB(245, 245, 250),
        SecondaryBackground = Color3.fromRGB(235, 235, 240),
        TertiaryBackground = Color3.fromRGB(225, 225, 230),
        Accent = Color3.fromRGB(80, 130, 240),
        AccentDark = Color3.fromRGB(60, 110, 220),
        Text = Color3.fromRGB(40, 40, 45),
        SubText = Color3.fromRGB(100, 100, 105),
        Border = Color3.fromRGB(200, 200, 205),
        Success = Color3.fromRGB(60, 180, 100),
        Error = Color3.fromRGB(220, 60, 60),
        Warning = Color3.fromRGB(230, 160, 60),
        Shadow = Color3.fromRGB(150, 150, 155),
        Acrylic = Color3.fromRGB(245, 245, 250)
    },
    Midnight = {
        Background = Color3.fromRGB(20, 20, 30),
        SecondaryBackground = Color3.fromRGB(30, 30, 45),
        TertiaryBackground = Color3.fromRGB(40, 40, 60),
        Accent = Color3.fromRGB(140, 100, 255),
        AccentDark = Color3.fromRGB(120, 80, 235),
        Text = Color3.fromRGB(240, 240, 255),
        SubText = Color3.fromRGB(160, 160, 180),
        Border = Color3.fromRGB(50, 50, 70),
        Success = Color3.fromRGB(100, 220, 150),
        Error = Color3.fromRGB(255, 100, 100),
        Warning = Color3.fromRGB(255, 200, 100),
        Shadow = Color3.fromRGB(0, 0, 10),
        Acrylic = Color3.fromRGB(20, 20, 30)
    },
    Crimson = {
        Background = Color3.fromRGB(35, 20, 25),
        SecondaryBackground = Color3.fromRGB(45, 25, 30),
        TertiaryBackground = Color3.fromRGB(55, 30, 35),
        Accent = Color3.fromRGB(255, 80, 100),
        AccentDark = Color3.fromRGB(235, 60, 80),
        Text = Color3.fromRGB(255, 240, 245),
        SubText = Color3.fromRGB(200, 180, 185),
        Border = Color3.fromRGB(70, 40, 45),
        Success = Color3.fromRGB(100, 220, 140),
        Error = Color3.fromRGB(255, 60, 80),
        Warning = Color3.fromRGB(255, 180, 100),
        Shadow = Color3.fromRGB(20, 5, 10),
        Acrylic = Color3.fromRGB(35, 20, 25)
    }
}

-- Default Configuration
AuroraUI.Config = {
    Theme = "Dark",
    AnimationSpeed = 0.3,
    CornerRadius = 8,
    Font = Enum.Font.Gotham,
    TitleFont = Enum.Font.GothamBold,
    Scale = 1.0,
    Acrylic = true,
    UseLucide = true
}

-- Initialize Library
function AuroraUI:Init(config)
    local newConfig = {}
    for key, value in pairs(self.Config) do
        newConfig[key] = config and config[key] or value
    end
    self.Config = newConfig
    self.CurrentTheme = self.Themes[self.Config.Theme] or self.Themes.Dark
    return self
end

-- Create Acrylic Effect
function AuroraUI:CreateAcrylic(parent, intensity)
    if not self.Config.Acrylic then return nil end
    
    local acrylic = Create("Frame", {
        Name = "Acrylic",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = self.CurrentTheme.Acrylic,
        BackgroundTransparency = 0.1,
        BorderSizePixel = 0,
        Parent = parent
    })
    
    local blur = Create("ImageLabel", {
        Name = "Blur",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = self.CurrentTheme.Shadow,
        ImageTransparency = 0.8,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = acrylic
    })
    
    return acrylic
end

-- Create Shadow
function AuroraUI:CreateShadow(parent, intensity)
    local shadow = Create("ImageLabel", {
        Name = "Shadow",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 20, 1, 20),
        ZIndex = parent.ZIndex - 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = self.CurrentTheme.Shadow,
        ImageTransparency = 1 - (intensity or 0.5),
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        Parent = parent
    })
    return shadow
end

-- Create Lucide Icon
function AuroraUI:CreateIcon(name, size, parent)
    local iconId = LucideIcons[name] or LucideIcons["circle"]
    
    local icon = Create("ImageLabel", {
        Name = "Icon_" .. name,
        Size = UDim2.new(0, size, 0, size),
        BackgroundTransparency = 1,
        Image = iconId,
        ImageColor3 = self.CurrentTheme.Text,
        Parent = parent
    })
    
    return icon
end

-- Create Window
function AuroraUI:CreateWindow(title, size)
    local window = {}
    window.Title = title or "AuroraUI"
    window.Size = size or UDim2.new(0, 600, 0, 400)
    window.Tabs = {}
    window.ActiveTab = nil
    window.IsMaximized = false
    window.PreviousSize = nil
    window.PreviousPosition = nil
    
    -- ScreenGui
    window.ScreenGui = Create("ScreenGui", {
        Name = "AuroraUI_" .. HttpService:GenerateGUID(false),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        Parent = PlayerGui
    })
    
    -- Main Frame
    window.MainFrame = Create("Frame", {
        Name = "MainFrame",
        Size = window.Size,
        Position = UDim2.new(0.5, -window.Size.X.Offset/2, 0.5, -window.Size.Y.Offset/2),
        BackgroundColor3 = self.CurrentTheme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = window.ScreenGui
    })
    
    local mainCorner = Create("UICorner", {
        CornerRadius = UDim.new(0, self.Config.CornerRadius),
        Parent = window.MainFrame
    })
    
    -- Acrylic Background
    if self.Config.Acrylic then
        self:CreateAcrylic(window.MainFrame)
    end
    
    self:CreateShadow(window.MainFrame, 0.6)
    
    -- Title Bar
    window.TitleBar = Create("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        Parent = window.MainFrame
    })
    
    local titleCorner = Create("UICorner", {
        CornerRadius = UDim.new(0, self.Config.CornerRadius),
        Parent = window.TitleBar
    })
    
    local titleFix = Create("Frame", {
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        Parent = window.TitleBar
    })
    
    -- Title Label
    window.TitleLabel = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = window.Title,
        TextColor3 = self.CurrentTheme.Text,
        TextSize = 16,
        Font = self.Config.TitleFont,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = window.TitleBar
    })
    
    -- Minimize Button
    window.MinimizeBtn = Create("TextButton", {
        Name = "Minimize",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -105, 0, 5),
        BackgroundColor3 = self.CurrentTheme.TertiaryBackground,
        Text = "",
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.MinimizeBtn
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("minus", 16, window.MinimizeBtn).Position = UDim2.new(0.5, -8, 0.5, -8)
    else
        window.MinimizeBtn.Text = "−"
        window.MinimizeBtn.TextColor3 = self.CurrentTheme.Text
        window.MinimizeBtn.TextSize = 20
        window.MinimizeBtn.Font = self.Config.TitleFont
    end
    
    -- Maximize Button
    window.MaximizeBtn = Create("TextButton", {
        Name = "Maximize",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -70, 0, 5),
        BackgroundColor3 = self.CurrentTheme.TertiaryBackground,
        Text = "",
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.MaximizeBtn
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("maximize", 16, window.MaximizeBtn).Position = UDim2.new(0.5, -8, 0.5, -8)
    else
        window.MaximizeBtn.Text = "□"
        window.MaximizeBtn.TextColor3 = self.CurrentTheme.Text
        window.MaximizeBtn.TextSize = 16
        window.MaximizeBtn.Font = self.Config.TitleFont
    end
    
    -- Close Button
    window.CloseBtn = Create("TextButton", {
        Name = "Close",
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundColor3 = self.CurrentTheme.Error,
        Text = "",
        Parent = window.TitleBar
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = window.CloseBtn
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("x", 16, window.CloseBtn).Position = UDim2.new(0.5, -8, 0.5, -8)
    else
        window.CloseBtn.Text = "×"
        window.CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        window.CloseBtn.TextSize = 20
        window.CloseBtn.Font = self.Config.TitleFont
    end
    
    -- Tab Container
    window.TabContainer = Create("ScrollingFrame", {
        Name = "TabContainer",
        Size = UDim2.new(0, 140, 1, -40),
        Position = UDim2.new(0, 0, 0, 40),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = self.CurrentTheme.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Parent = window.MainFrame
    })
    
    local tabList = Create("UIListLayout", {
        Padding = UDim.new(0, 5),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = window.TabContainer
    })
    
    tabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        window.TabContainer.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 20)
    end)
    
    Create("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        Parent = window.TabContainer
    })
    
    -- Content Container
    window.ContentContainer = Create("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, -150, 1, -50),
        Position = UDim2.new(0, 145, 0, 45),
        BackgroundTransparency = 1,
        Parent = window.MainFrame
    })
    
    -- Minimized Icon
    window.MinimizedIcon = Create("TextButton", {
        Name = "MinimizedIcon",
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0, 20, 0.5, -25),
        BackgroundColor3 = self.CurrentTheme.SecondaryBackground,
        Text = "",
        Visible = false,
        Parent = window.ScreenGui
    })
    
    Create("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = window.MinimizedIcon
    })
    
    if self.Config.UseLucide then
        self:CreateIcon("menu", 24, window.MinimizedIcon).Position = UDim2.new(0.5, -12, 0.5, -12)
    else
        window.MinimizedIcon.Text = "AU"
        window.MinimizedIcon.TextColor3 = self.CurrentTheme.Accent
        window.MinimizedIcon.TextSize = 20
        window.MinimizedIcon.Font = self.Config.TitleFont
    end
    
    self:CreateShadow(window.MinimizedIcon, 0.5)
    
    -- Dragging
    MakeDraggable(window.MainFrame, window.TitleBar)
    MakeDraggable(window.MinimizedIcon, window.MinimizedIcon)
    
    -- Minimize Logic
    local isMinimized = false
    
    window.MinimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = true
        Tween(window.MainFrame, {Size = UDim2.new(0, window.Size.X.Offset, 0, 0)}, 0.3)
        task.wait(0.3)
        window.MainFrame.Visible = false
        window.MinimizedIcon.Visible = true
        window.MinimizedIcon.Position = window.MainFrame.Position
    end)
    
    window.MinimizedIcon.MouseButton1Click:Connect(function()
        isMinimized = false
        window.MainFrame.Position = window.MinimizedIcon.Position
        window.MainFrame.Visible = true
        window.MinimizedIcon.Visible = false
        Tween(window.MainFrame, {Size = window.Size}, 0.3)
    end)
    
    -- Maximize Logic
    window.MaximizeBtn.MouseButton1Click:Connect(function()
        if window.IsMaximized then
            -- Restore
            window.IsMaximized = false
            Tween(window.MainFrame, {
                Size = window.PreviousSize,
                Position = window.PreviousPosition
            }, 0.3)
            if self.Config.UseLucide then
                window.MaximizeBtn:FindFirstChildOfClass("ImageLabel").Image = LucideIcons["maximize"]
            else
                window.MaximizeBtn.Text = "□"
            end
        else
            -- Maximize
            window.IsMaximized = true
            window.PreviousSize = window.MainFrame.Size
            window.PreviousPosition = window.MainFrame.Position
            
            local viewportSize = workspace.CurrentCamera.ViewportSize
            Tween(window.MainFrame, {
                Size = UDim2.new(0, viewportSize.X - 40, 0, viewportSize.Y - 40),
                Position = UDim2.new(0, 20, 0, 20)
            }, 0.3)
            if self.Config.UseLucide then
                window.MaximizeBtn:FindFirstChildOfClass("ImageLabel").Image = LucideIcons["minimize"]
            else
                window.MaximizeBtn.Text = "❐"
            end
        end
    end)
    
    window.CloseBtn.MouseButton1Click:Connect(function()
        window.ScreenGui:Destroy()
    end)
    
    -- Hover Effects
    local function addHoverEffect(button, normalColor, hoverColor)
        button.MouseEnter:Connect(function()
            Tween(button, {BackgroundColor3 = hoverColor}, 0.2)
        end)
        button.MouseLeave:Connect(function()
            Tween(button, {BackgroundColor3 = normalColor}, 0.2)
        end)
    end
    
    addHoverEffect(window.MinimizeBtn, self.CurrentTheme.TertiaryBackground, self.CurrentTheme.Border)
    addHoverEffect(window.MaximizeBtn, self.CurrentTheme.TertiaryBackground, self.CurrentTheme.Border)
    
    window.CloseBtn.MouseEnter:Connect(function()
        Tween(window.CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    window.CloseBtn.MouseLeave:Connect(function()
        Tween(window.CloseBtn, {BackgroundColor3 = self.CurrentTheme.Error}, 0.2)
    end)
    
    -- Tab Creation Function
    function window:CreateTab(tabName, icon)
        local tab = {}
        tab.Name = tabName
        tab.Sections = {}
        
        -- Tab Button
        tab.Button = Create("TextButton", {
            Name = tabName .. "Tab",
            Size = UDim2.new(1, 0, 0, 35),
            BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
            Text = "",
            AutoButtonColor = false,
            Parent = window.TabContainer
        })
        
        local buttonCorner = Create("UICorner", {
            CornerRadius = UDim.new(0, 6),
            Parent = tab.Button
        })
        
        -- Icon
        if AuroraUI.Config.UseLucide and icon then
            tab.Icon = AuroraUI:CreateIcon(icon, 18, tab.Button)
            tab.Icon.Position = UDim2.new(0, 10, 0.5, -9)
        else
            tab.Icon = Create("TextLabel", {
                Size = UDim2.new(0, 25, 1, 0),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = icon or "•",
                TextColor3 = AuroraUI.CurrentTheme.SubText,
                TextSize = 18,
                Font = AuroraUI.Config.Font,
                Parent = tab.Button
            })
        end
        
        tab.Label = Create("TextLabel", {
            Size = UDim2.new(1, -40, 1, 0),
            Position = UDim2.new(0, 35, 0, 0),
            BackgroundTransparency = 1,
            Text = tabName,
            TextColor3 = AuroraUI.CurrentTheme.SubText,
            TextSize = 14,
            Font = AuroraUI.Config.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = tab.Button
        })
        
        -- Tab Content
        tab.Content = Create("ScrollingFrame", {
            Name = tabName .. "Content",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = AuroraUI.CurrentTheme.Accent,
            Visible = false,
            Parent = window.ContentContainer
        })
        
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 5),
            PaddingBottom = UDim.new(0, 10),
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 5),
            Parent = tab.Content
        })
        
        local contentList = Create("UIListLayout", {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = tab.Content
        })
        
        contentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tab.Content.CanvasSize = UDim2.new(0, 0, 0, contentList.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab Selection
        tab.Button.MouseButton1Click:Connect(function()
            if window.ActiveTab == tab then return end
            
            -- Deselect current
            if window.ActiveTab then
                Tween(window.ActiveTab.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground}, 0.2)
                Tween(window.ActiveTab.Label, {TextColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                if AuroraUI.Config.UseLucide then
                    Tween(window.ActiveTab.Icon, {ImageColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                else
                    Tween(window.ActiveTab.Icon, {TextColor3 = AuroraUI.CurrentTheme.SubText}, 0.2)
                end
                window.ActiveTab.Content.Visible = false
            end
            
            -- Select new
            window.ActiveTab = tab
            Tween(tab.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.Accent}, 0.2)
            Tween(tab.Label, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
            if AuroraUI.Config.UseLucide then
                Tween(tab.Icon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
            else
                Tween(tab.Icon, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
            end
            tab.Content.Visible = true
            
            -- Animation
            tab.Content.Position = UDim2.new(0.02, 0, 0, 0)
            Tween(tab.Content, {Position = UDim2.new(0, 0, 0, 0)}, 0.3)
        end)
        
        -- Section Creation
        function tab:CreateSection(sectionTitle)
            local section = {}
            
            section.Container = Create("Frame", {
                Name = sectionTitle .. "Section",
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = tab.Content
            })
            
            Create("UICorner", {
                CornerRadius = UDim.new(0, 6),
                Parent = section.Container
            })
            
            Create("UIPadding", {
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
                PaddingLeft = UDim.new(0, 12),
                PaddingRight = UDim.new(0, 12),
                Parent = section.Container
            })
            
            local sectionList = Create("UIListLayout", {
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = section.Container
            })
            
            if sectionTitle and sectionTitle ~= "" then
                local header = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = sectionTitle,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 14,
                    Font = AuroraUI.Config.TitleFont,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = section.Container
                })
            end
            
            -- Element Creation Functions
            function section:AddLabel(text)
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.SubText,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Parent = section.Container
                })
                return label
            end
            
            function section:AddButton(text, callback)
                local button = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = AuroraUI.CurrentTheme.Accent,
                    Text = text,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    Parent = section.Container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = button
                })
                
                button.MouseButton1Click:Connect(function()
                    Tween(button, {Size = UDim2.new(0.98, 0, 0, 32)}, 0.1)
                    task.wait(0.1)
                    Tween(button, {Size = UDim2.new(1, 0, 0, 32)}, 0.1)
                    if callback then callback() end
                end)
                
                button.MouseEnter:Connect(function()
                    Tween(button, {BackgroundColor3 = AuroraUI.CurrentTheme.AccentDark}, 0.2)
                end)
                button.MouseLeave:Connect(function()
                    Tween(button, {BackgroundColor3 = AuroraUI.CurrentTheme.Accent}, 0.2)
                end)
                
                return button
            end
            
            function section:AddToggle(text, default, callback)
                local toggle = {}
                toggle.Value = default or false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, -50, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                toggle.Button = Create("TextButton", {
                    Size = UDim2.new(0, 40, 0, 22),
                    Position = UDim2.new(1, -40, 0.5, -11),
                    BackgroundColor3 = toggle.Value and AuroraUI.CurrentTheme.Accent or AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = "",
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = toggle.Button
                })
                
                toggle.Indicator = Create("Frame", {
                    Size = UDim2.new(0, 16, 0, 16),
                    Position = toggle.Value and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = toggle.Button
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = toggle.Indicator
                })
                
                local function update()
                    if toggle.Value then
                        Tween(toggle.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.Accent}, 0.2)
                        Tween(toggle.Indicator, {Position = UDim2.new(1, -19, 0.5, -8)}, 0.2)
                    else
                        Tween(toggle.Button, {BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground}, 0.2)
                        Tween(toggle.Indicator, {Position = UDim2.new(0, 3, 0.5, -8)}, 0.2)
                    end
                    if callback then callback(toggle.Value) end
                end
                
                toggle.Button.MouseButton1Click:Connect(function()
                    toggle.Value = not toggle.Value
                    update()
                end)
                
                toggle.Set = function(self, value)
                    toggle.Value = value
                    update()
                end
                
                return toggle
            end
            
            function section:AddSlider(text, min, max, default, callback)
                local slider = {}
                min = min or 0
                max = max or 100
                default = math.clamp(default or min, min, max)
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 45),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(0.7, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local valueLabel = Create("TextLabel", {
                    Size = UDim2.new(0.3, 0, 0, 18),
                    Position = UDim2.new(0.7, 0, 0, 0),
                    BackgroundTransparency = 1,
                    Text = tostring(default),
                    TextColor3 = AuroraUI.CurrentTheme.Accent,
                    TextSize = 13,
                    Font = AuroraUI.Config.TitleFont,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = container
                })
                
                local track = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 6),
                    Position = UDim2.new(0, 0, 0, 28),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    BorderSizePixel = 0,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = track
                })
                
                local fill = Create("Frame", {
                    Size = UDim2.new((default - min) / (max - min), 0, 1, 0),
                    BackgroundColor3 = AuroraUI.CurrentTheme.Accent,
                    BorderSizePixel = 0,
                    Parent = track
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = fill
                })
                
                local knob = Create("Frame", {
                    Size = UDim2.new(0, 14, 0, 14),
                    Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7),
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Parent = track
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(1, 0),
                    Parent = knob
                })
                
                local dragging = false
                
                local function update(input)
                    local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                    local value = math.floor(min + (pos * (max - min)))
                    valueLabel.Text = tostring(value)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    knob.Position = UDim2.new(pos, -7, 0.5, -7)
                    if callback then callback(value) end
                end
                
                track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                        update(input)
                    end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        update(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                slider.Set = function(self, value)
                    value = math.clamp(value, min, max)
                    local pos = (value - min) / (max - min)
                    valueLabel.Text = tostring(value)
                    fill.Size = UDim2.new(pos, 0, 1, 0)
                    knob.Position = UDim2.new(pos, -7, 0.5, -7)
                    if callback then callback(value) end
                end
                
                return slider
            end
            
            function section:AddDropdown(text, options, callback)
                local dropdown = {}
                options = options or {}
                local isOpen = false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local button = Create("TextButton", {
                    Size = UDim2.new(1, 0, 0, 32),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = "Select...",
                    TextColor3 = AuroraUI.CurrentTheme.SubText,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = button
                })
                
                local arrow = Create("TextLabel", {
                    Size = UDim2.new(0, 20, 1, 0),
                    Position = UDim2.new(1, -25, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "▼",
                    TextColor3 = AuroraUI.CurrentTheme.SubText,
                    TextSize = 12,
                    Font = AuroraUI.Config.Font,
                    Parent = button
                })
                
                local optionContainer = Create("ScrollingFrame", {
                    Size = UDim2.new(1, 0, 0, 0),
                    Position = UDim2.new(0, 0, 0, 36),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    BorderSizePixel = 0,
                    ScrollBarThickness = 2,
                    ScrollBarImageColor3 = AuroraUI.CurrentTheme.Accent,
                    CanvasSize = UDim2.new(0, 0, 0, 0),
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = optionContainer
                })
                
                local optionList = Create("UIListLayout", {
                    Padding = UDim.new(0, 2),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = optionContainer
                })
                
                optionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    optionContainer.CanvasSize = UDim2.new(0, 0, 0, optionList.AbsoluteContentSize.Y + 10)
                end)
                
                local function toggle()
                    isOpen = not isOpen
                    if isOpen then
                        Tween(arrow, {Rotation = 180}, 0.2)
                        local height = math.min(#options * 28 + 10, 150)
                        Tween(container, {Size = UDim2.new(1, 0, 0, 36 + height)}, 0.2)
                        Tween(optionContainer, {Size = UDim2.new(1, 0, 0, height)}, 0.2)
                    else
                        Tween(arrow, {Rotation = 0}, 0.2)
                        Tween(container, {Size = UDim2.new(1, 0, 0, 32)}, 0.2)
                        Tween(optionContainer, {Size = UDim2.new(1, 0, 0, 0)}, 0.2)
                    end
                end
                
                button.MouseButton1Click:Connect(toggle)
                
                for i, option in ipairs(options) do
                    local optionBtn = Create("TextButton", {
                        Size = UDim2.new(1, -10, 0, 26),
                        Position = UDim2.new(0, 5, 0, 5 + (i-1) * 28),
                        BackgroundTransparency = 1,
                        Text = option,
                        TextColor3 = AuroraUI.CurrentTheme.Text,
                        TextSize = 12,
                        Font = AuroraUI.Config.Font,
                        Parent = optionContainer
                    })
                    
                    optionBtn.MouseButton1Click:Connect(function()
                        button.Text = option
                        button.TextColor3 = AuroraUI.CurrentTheme.Text
                        toggle()
                        if callback then callback(option) end
                    end)
                    
                    optionBtn.MouseEnter:Connect(function()
                        Tween(optionBtn, {BackgroundTransparency = 0.9}, 0.1)
                        optionBtn.BackgroundColor3 = AuroraUI.CurrentTheme.Accent
                    end)
                    optionBtn.MouseLeave:Connect(function()
                        Tween(optionBtn, {BackgroundTransparency = 1}, 0.1)
                    end)
                end
                
                dropdown.Set = function(self, value)
                    button.Text = value
                    button.TextColor3 = AuroraUI.CurrentTheme.Text
                    if callback then callback(value) end
                end
                
                dropdown.UpdateOptions = function(self, newOptions)
                    -- Clear existing
                    for _, child in ipairs(optionContainer:GetChildren()) do
                        if child:IsA("TextButton") then child:Destroy() end
                    end
                    options = newOptions
                    -- Rebuild (simplified - would need to rebuild UI)
                end
                
                return dropdown
            end
            
            function section:AddTextBox(text, placeholder, callback)
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 55),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 18),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local box = Create("TextBox", {
                    Size = UDim2.new(1, 0, 0, 32),
                    Position = UDim2.new(0, 0, 0, 22),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = "",
                    PlaceholderText = placeholder or "Enter text...",
                    PlaceholderColor3 = AuroraUI.CurrentTheme.SubText,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    ClearTextOnFocus = false,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = box
                })
                
                Create("UIPadding", {
                    PaddingLeft = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    Parent = box
                })
                
                box.Focused:Connect(function()
                    Tween(box, {BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground}, 0.2)
                end)
                box.FocusLost:Connect(function(enterPressed)
                    Tween(box, {BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground}, 0.2)
                    if callback then callback(box.Text, enterPressed) end
                end)
                
                return box
            end
            
            function section:AddKeybind(text, defaultKey, callback)
                local keybind = {}
                local currentKey = defaultKey or nil
                local waiting = false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundTransparency = 1,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, -70, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local button = Create("TextButton", {
                    Size = UDim2.new(0, 65, 0, 26),
                    Position = UDim2.new(1, -65, 0.5, -13),
                    BackgroundColor3 = AuroraUI.CurrentTheme.TertiaryBackground,
                    Text = currentKey and currentKey.Name or "None",
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 12,
                    Font = AuroraUI.Config.Font,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = button
                })
                
                button.MouseButton1Click:Connect(function()
                    if waiting then return end
                    waiting = true
                    button.Text = "..."
                    button.TextColor3 = AuroraUI.CurrentTheme.Accent
                    
                    local connection
                    connection = UserInputService.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            if input.KeyCode ~= Enum.KeyCode.Escape then
                                currentKey = input.KeyCode
                                button.Text = input.KeyCode.Name
                                if callback then callback(input.KeyCode) end
                            else
                                button.Text = currentKey and currentKey.Name or "None"
                            end
                            button.TextColor3 = AuroraUI.CurrentTheme.Text
                            waiting = false
                            connection:Disconnect()
                        end
                    end)
                end)
                
                -- Listen for keybind activation
                UserInputService.InputBegan:Connect(function(input)
                    if not waiting and currentKey and input.KeyCode == currentKey then
                        if callback then callback(currentKey, true) end
                    end
                end)
                
                return keybind
            end
            
            function section:AddColorPicker(text, defaultColor, callback)
                local colorPicker = {}
                defaultColor = defaultColor or Color3.fromRGB(255, 255, 255)
                local isOpen = false
                
                local container = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundTransparency = 1,
                    ClipsDescendants = true,
                    Parent = section.Container
                })
                
                local label = Create("TextLabel", {
                    Size = UDim2.new(1, -40, 1, 0),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = AuroraUI.CurrentTheme.Text,
                    TextSize = 13,
                    Font = AuroraUI.Config.Font,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = container
                })
                
                local preview = Create("TextButton", {
                    Size = UDim2.new(0, 32, 0, 26),
                    Position = UDim2.new(1, -32, 0.5, -13),
                    BackgroundColor3 = defaultColor,
                    Text = "",
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = preview
                })
                
                local pickerFrame = Create("Frame", {
                    Size = UDim2.new(1, 0, 0, 180),
                    Position = UDim2.new(0, 0, 0, 36),
                    BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
                    BorderSizePixel = 0,
                    Parent = container
                })
                
                Create("UICorner", {
                    CornerRadius = UDim.new(0, 6),
                    Parent = pickerFrame
                })
                
                -- Simple RGB sliders
                local rSlider = Create("Frame", {
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 10),
                    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                    BorderSizePixel = 0,
                    Parent = pickerFrame
                })
                
                local gSlider = Create("Frame", {
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 40),
                    BackgroundColor3 = Color3.fromRGB(0, 255, 0),
                    BorderSizePixel = 0,
                    Parent = pickerFrame
                })
                
                local bSlider = Create("Frame", {
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.new(0, 10, 0, 70),
                    BackgroundColor3 = Color3.fromRGB(0, 0, 255),
                    BorderSizePixel = 0,
                    Parent = pickerFrame
                })
                
                local r, g, b = defaultColor.R * 255, defaultColor.G * 255, defaultColor.B * 255
                
                local function updateColor()
                    local newColor = Color3.fromRGB(r, g, b)
                    preview.BackgroundColor3 = newColor
                    if callback then callback(newColor) end
                end
                
                preview.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    Tween(container, {Size = UDim2.new(1, 0, 0, isOpen and 220 or 32)}, 0.3)
                end)
                
                colorPicker.Set = function(self, color)
                    preview.BackgroundColor3 = color
                    r, g, b = color.R * 255, color.G * 255, color.B * 255
                    if callback then callback(color) end
                end
                
                return colorPicker
            end
            
            return section
        end
        
        table.insert(window.Tabs, tab)
        
        -- Auto-select first tab
        if #window.Tabs == 1 then
            task.spawn(function()
                task.wait(0.1)
                tab.Button.MouseButton1Click:Fire()
            end)
        end
        
        return tab
    end
    
    -- Notification System
    function window:Notify(title, message, duration, type)
        duration = duration or 3
        type = type or "Info" -- Info, Success, Warning, Error
        
        local colors = {
            Info = AuroraUI.CurrentTheme.Accent,
            Success = AuroraUI.CurrentTheme.Success,
            Warning = AuroraUI.CurrentTheme.Warning,
            Error = AuroraUI.CurrentTheme.Error
        }
        
        local notif = Create("Frame", {
            Size = UDim2.new(0, 280, 0, 80),
            Position = UDim2.new(1, 300, 1, -100),
            BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
            BorderSizePixel = 0,
            Parent = self.ScreenGui
        })
        
        Create("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = notif
        })
        
        AuroraUI:CreateShadow(notif, 0.4)
        
        local bar = Create("Frame", {
            Size = UDim2.new(0, 4, 1, 0),
            BackgroundColor3 = colors[type] or colors.Info,
            BorderSizePixel = 0,
            Parent = notif
        })
        
        Create("UICorner", {
            CornerRadius = UDim.new(0, 8),
            Parent = bar
        })
        
        local fix = Create("Frame", {
            Size = UDim2.new(0, 4, 1, 0),
            Position = UDim2.new(0, 2, 0, 0),
            BackgroundColor3 = AuroraUI.CurrentTheme.SecondaryBackground,
            BorderSizePixel = 0,
            Parent = notif
        })
        
        local titleLabel = Create("TextLabel", {
            Size = UDim2.new(1, -20, 0, 22),
            Position = UDim2.new(0, 15, 0, 10),
            BackgroundTransparency = 1,
            Text = title,
            TextColor3 = AuroraUI.CurrentTheme.Text,
            TextSize = 14,
            Font = AuroraUI.Config.TitleFont,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = notif
        })
        
        local msgLabel = Create("TextLabel", {
            Size = UDim2.new(1, -20, 0, 40),
            Position = UDim2.new(0, 15, 0, 32),
            BackgroundTransparency = 1,
            Text = message,
            TextColor3 = AuroraUI.CurrentTheme.SubText,
            TextSize = 12,
            Font = AuroraUI.Config.Font,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Parent = notif
        })
        
        -- Slide in
        Tween(notif, {Position = UDim2.new(1, -300, 1, -100)}, 0.4)
        
        task.wait(duration)
        
        -- Slide out
        Tween(notif, {Position = UDim2.new(1, 300, 1, -100)}, 0.4)
        task.wait(0.4)
        notif:Destroy()
    end
    
    return window
end

-- Theme Switcher
function AuroraUI:SetTheme(themeName)
    if self.Themes[themeName] then
        self.Config.Theme = themeName
        self.CurrentTheme = self.Themes[themeName]
        -- Would need to recursively update all UI elements here
        -- For now, applies to new elements only
        return true
    end
    return false
end

return AuroraUI
