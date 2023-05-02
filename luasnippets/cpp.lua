---@diagnostic disable: unused-local
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

local function as_header_guard(str)
	return str:upper():gsub("[/\\.-]", "_")
end

local function file_as_header_guard()
	return f(function(_args, snip)
		local res, env = {}, snip.env
		return as_header_guard(env.RELATIVE_FILEPATH)
	end)
end

local function year()
  return f(function(_args, snip)
    local res, env = {}, snip.env
    return env.CURRENT_YEAR
  end)
end

return {
	s({ trig = "#guard", dscr = "Google-style header guard", priority = 2000 }, {
		t({ "#ifndef " }), file_as_header_guard(),
		t({ "", "#define " }), file_as_header_guard(),
		t({ "", "" }), i(0),
		t({ "", "#endif  // " }), file_as_header_guard(),
	}),
	s("//bsd", {
		t({ "// Copyright (c) " }), year(), t({ " Chase Colman. All rights reserved.", "" }),
		t({ "// Use of this source code is governed by a BSD-style license that can be found", "" }),
		t({ "// in the LICENSE file.", ""}),
	}),
}
