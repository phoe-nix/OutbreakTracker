local IconLinks = require "icondata"
local IconLinks2 = require "icondata2"
local UIAtlasInfo = require "uidata"
RoomNames = require "roomnames"

function LoadAssets()
	ItemCountFont = love.graphics.newImageFont("assets/ItemCountFont.png", "0123456789")
	TimeFont = love.graphics.newImageFont("assets/TimeFont.png", "0123456789:./")
	VirusFont = love.graphics.newImageFont("assets/VirusFont.png", "0123456789.%")
	VirusFont:setFilter("nearest", "linear")
	UIAtlas = LoadTextureAtlas("assets/ui.png", UIAtlasInfo)
	ItemIcons = LoadTextureAtlas("assets/icons.png", IconLinks)
	ItemIcons2 = LoadTextureAtlas("assets/StartingItem.png", IconLinks2)
	DefaultFont = love.graphics.newFont("assets/arialbd.ttf",18)
	SmallFont = love.graphics.newFont("assets/arialbd.ttf",15)
	VerySmallFont = love.graphics.newFont("assets/arialbd.ttf",13)
	MiniFont = love.graphics.newFont("assets/arialnb.ttf",11)
	--MiniFont = love.graphics.newFont(9)
end

function LoadTextureAtlas(texture, links) -- Really dirty stuff here
	local o = {}
	o.tex = love.graphics.newImage(texture)
	o.quads = {}
	o.draw = function (self, name, x, y, r, sx, sy, ox, oy, kx, ky)
		if (self.quads[name] == nil) then
			love.graphics.setFont()
			love.graphics.print(name, x, y)
		else
			love.graphics.draw(self.tex, self.quads[name], x, y, r, sx, sy, ox, oy, kx, ky)
		end
	end
	o.addSB = function (self, sb, name, x, y, r, sx, sy, ox, oy, kx, ky)
		sb:add( self.quads[name], x, y, r or 0, sx, sy, ox, oy, kx, ky)
	end
	for k, v in pairs(links.frameIndex) do
		o.quads[k] = love.graphics.newQuad(links.sheet.frames[v].x, links.sheet.frames[v].y, 
											links.sheet.frames[v].width, links.sheet.frames[v].height, 
											links.sheet.sheetContentWidth, links.sheet.sheetContentHeight)
	end
	return o
end