local commented_line = require("commented.init").commented_line
local function foo()
	return commented_line()
end

return {
	empty_comment = foo
}
