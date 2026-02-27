Label = {}
Label.__index = Label

function Label:new(x, y, text, font, horizontalAlign, verticalAlign, width, height, color)
	local o = {}
	o.x = x or 0
	o.y = y or 0
	o.text = text or ""
	o.font = font or DefaultFont
	o.hAlign = horizontalAlign or "left"
	o.vAlign = verticalAlign or "up"
	o.width = width
	o.height = height
	o.color = color or {1, 1, 1, 1}
	o.autosize = width == nil or height == nil or horizontalAlign == nil or verticalAlign == nil
	return setmetatable(o, self)
end

function Label:draw()
	local oldFont = love.graphics.getFont()
	local oldR, oldG, oldB, oldA = love.graphics.getColor()
	love.graphics.setColor(self.color)
	love.graphics.setFont(self.font)
	if not self.autosize then
		local x = self.x
		local y = 0
		local wrapWidth, wrapText = self.font:getWrap(self.text, self.width)
		local lineHeight = self.font:getHeight()
		if self.vAlign == "up" then
			y = self.y
		elseif self.vAlign == "down" then
			y = (self.y + self.height) - (lineHeight * #wrapText)
		elseif self.vAlign == "center" then
			y = (self.y + (self.height / 2)) - (lineHeight * #wrapText)/2
		end 
		love.graphics.printf(_l(self.text), math.floor(x), math.floor(y), self.width, self.hAlign)
	else
		love.graphics.print(_l(self.text), self.x, self.y)
	end
	love.graphics.setFont(oldFont)
	love.graphics.setColor(oldR, oldG, oldB, oldA)
end