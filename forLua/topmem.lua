
-- topmem.lua: get the top %MEM or if given parameter C, the top %CPU
-- You can also run the following from bash, respectively:
-- top -bn1 |tail -n+8 |sort -nk10 |tail -1
-- top -bn1 |tail -n+8 |sort -nk9  |tail -1

-- Ternary operator: If parameter is 'C', then target %CPU instead of %MEM
local POS = (#arg >0 and string.upper(arg[1]) == "C") and 9 or 10

-- source: https://stackoverflow.com/questions/72386387/lua-split-string-to-table
function string:split(sep)
	local sep = sep or ","
	local result = {}
	local i = 1
	for c in self:gmatch(string.format("([^%s]+)", sep)) do
		result[i] = c
		i = i + 1
	end
	return result
end

-- source: https://forums.solar2d.com/t/seeking-more-optimal-solution-replace-single-character-at-position-in-string/348184/4
function replaceAt(str, at, with)
	return ((at < 1) or (at > string.len(str)))
		and str
		or string.sub(str, 1, at-1) .. with .. string.sub(str, at+1)
end

local maxline = ""
local maxval = -1
local nowdata = 0

for line in io.popen([[LANG=C /usr/bin/top -bn1]]):lines() do
	if nowdata == 1 then
		local ARR = line:split(" ")
		if #ARR > 10 then
			if tonumber(ARR[POS]) > maxval then
				maxline = line
				maxval = tonumber(ARR[POS])
			end
		end
	elseif line:find("%CPU.+%MEM") ~= nil then
		local s = line:find("%CPU.+%MEM")
		print(replaceAt(line, s-2+((POS-9)*6), ">"))
		nowdata = 1
	end
end

print(maxline)
