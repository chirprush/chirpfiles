hi clear
if exists("syntax")
	syntax reset
endif

let g:colors_name = "one-dark"

let s:red            = {"gui": "#E06C75", "cterm": "204"}
let s:dark_red       = {"gui": "#BE5046", "cterm": "196"}
let s:green          = {"gui": "#98C379", "cterm": "114"}
let s:yellow         = {"gui": "#E5C07B", "cterm": "186"}
let s:dark_yellow    = {"gui": "#D19A66", "cterm": "173"}
let s:blue           = {"gui": "#61AFEF", "cterm": "39" }
let s:purple         = {"gui": "#C678DD", "cterm": "170"}
let s:cyan           = {"gui": "#56B6C2", "cterm": "37" }
let s:white          = {"gui": "#ABB2BF", "cterm": "145"}
let s:black          = {"gui": "#282C34", "cterm": "235"}
let s:light_grey     = {"gui": "#7f8693", "cterm": "243"}
let s:comment_grey   = {"gui": "#5c6370", "cterm": "59" }
let s:gutter_fg_grey = {"gui": "#4B5263", "cterm": "240"}
let s:cursor_grey    = {"gui": "#2C323C", "cterm": "236"}
let s:visual_grey    = {"gui": "#3E4452", "cterm": "237"}
let s:menu_grey      = {"gui": "#353b45", "cterm": "238"}
let s:special_grey   = {"gui": "#3B4048", "cterm": "237"}
let s:vertsplit      = {"gui": "#181A1F", "cterm": "59" }

let s:blank          = {"gui": "NONE", "cterm": "NONE"}

let s:gui = &termguicolors || has("gui_running")

let g:colors = {
			\ "red" : "#E06C75",
			\ "dark_red" : "#BE5046",
			\ "green" : "#98C379",
			\ "yellow" : "#E5C07B",
			\ "dark_yellow" : "#D19A66",
			\ "blue" : "#61AFEF",
			\ "purple" : "#C678DD",
			\ "cyan" : "#56B6C2",
			\ "white" : "#ABB2BF",
			\ "black" : "#282C34",
			\ "light_grey" : "#7f8693",
			\ "comment_grey" : "#5c6370",
			\ "gutter_fg_grey" : "#4B5263",
			\ "cursor_grey" : "#2C323C",
			\ "visual_grey" : "#3E4452",
			\ "menu_grey" : "#353b45",
			\ "special_grey" : "#3B4048",
			\ "vertsplit" : "#181A1F",
			\ }

function! s:h(name, ...)
	let l:cmd = "hi " . a:name . " "
	if a:0 == 0
		echom "No highlighting for group " . a:name
	else
		let l:attrs = ["fg", "bg", ""]
		for i in range(a:0)
			if len(a:000[i]) > 0
				" the last argument (cterm/gui) is always a string
				if i == 2
					let l:cmd .= "cterm=" . a:000[i] . " gui=" . a:000[i] . " "
				else
					let l:cmd .= "cterm" . l:attrs[i] . "=" . get(a:000[i], "cterm", "") . " "
					let l:cmd .= "gui" . l:attrs[i] . "=" . get(a:000[i], "gui", "") . " "
				endif
			endif
		endfor
		execute l:cmd
	endif
endfunction!

call s:h("Normal", s:white, s:black)
call s:h("EndOfBuffer", s:black, s:black)
call s:h("NonText", s:black, s:black)
call s:h("Error", s:red, s:black, "bold")
call s:h("ErrorMsg", s:red, s:black, "bold")
call s:h("WarningMsg", s:red, s:black, "bold")
call s:h("Question", s:purple, s:black, "bold")
call s:h("Cursor", s:blank, s:blank, "reverse")
call s:h("LineNr", s:gutter_fg_grey, s:black)
call s:h("CursorLineNr", s:white, s:black, "NONE")
call s:h("Search", s:black, s:yellow)
call s:h("IncSearch", s:yellow, s:comment_grey)

call s:h("Visual", "", s:visual_grey)
call s:h("MatchParen", "", s:menu_grey, "bold")
call s:h("CursorLine", "", s:cursor_grey, "NONE")
" Intended for vert:│ (see :help 'fillchars')
call s:h("VertSplit", s:black, s:gutter_fg_grey)
call s:h("StatusLine", s:menu_grey, s:white)
call s:h("StatusLineNC", s:gutter_fg_grey, s:black, "underline")
call s:h("StatusLineTerm", s:white, s:gutter_fg_grey)
call s:h("StatusLineTermNC", s:white, s:special_grey)

call s:h("TabLineFill", s:cursor_grey, s:cursor_grey)
call s:h("TabLine", s:white, s:menu_grey, "bold")
call s:h("TabLineSel", s:white, s:black, "bold")

call s:h("Pmenu", s:white, s:menu_grey)
call s:h("PmenuSel", s:menu_grey, s:green)
if s:gui
	call s:h("PmenuThumb", "", s:gutter_fg_grey)
	call s:h("PmenuSbar", "", s:special_grey)
else
	call s:h("PmenuThumb", "", s:special_grey)
	call s:h("PmenuSbar", "", s:gutter_fg_grey)
endif

call s:h("Comment", s:comment_grey, "", "")
call s:h("Folded", s:comment_grey, s:black, "NONE")
call s:h("Conceal", s:blue, s:black)
call s:h("Directory", s:purple)
call s:h("Title", s:blue, "", "bold")
call s:h("Todo", s:blue, s:black, "bold")
call s:h("Identifier", s:red, "", "NONE")
call s:h("String", s:green)
call s:h("PreProc", s:purple)
call s:h("Type", s:purple, "", "NONE")
call s:h("Statement", s:purple, "", "NONE")
call s:h("Number", s:dark_yellow)
call s:h("Special", s:cyan)
call s:h("SpecialKey", s:purple)
call s:h("Function", s:blue)
call s:h("Constant", s:blue)

call s:h("cIncluded", s:green)
call s:h("cFormat", s:dark_yellow)
call s:h("cSpecial", s:cyan)
call s:h("cTypeDecl", s:yellow)
call s:h("cPredictType", s:white)
call s:h("cCapitalCast", s:yellow)
call s:h("cVariable", s:red)
call s:h("cVariableDecl", s:red)
call s:h("cSymbolOp", s:purple)
call s:h("cSpecialCharacter", s:cyan)
call s:h("cCharacter", s:green)
call s:h("cMacro", s:blue)
call s:h("cSecondMacro", s:cyan)
call s:h("cSwitchMacro", s:cyan)

call s:h("rustIdentifier", s:yellow)

call s:h("pythonSelf", s:purple)
call s:h("pythonNone", s:purple)
call s:h("pythonBoolean", s:purple)
call s:h("pythonMagicMethods", s:cyan)
call s:h("pythonClass", s:yellow)
call s:h("pythonFuncVar", s:dark_yellow)
call s:h("pythonDefineFunction", s:cyan)
call s:h("pythonFunctionCall", s:blue)
call s:h("pythonBuiltinType", s:cyan)
call s:h("pythonTypingType", s:cyan)
call s:h("pythonBuiltinFunction", s:cyan)
call s:h("pythonConstant", s:dark_yellow)
call s:h("pythonSymbolOperator", s:purple)
call s:h("pythonNonOperator", s:light_grey)

call s:h("luaTable", s:white)
call s:h("luaFunc", s:blue)
call s:h("luaFunction", s:purple)

call s:h("javaScriptFunction", s:purple)
call s:h("javaScriptMemberFunction", s:cyan)
call s:h("javaScriptOperator", s:purple)
call s:h("javaScriptTernaryOperator", s:purple)
call s:h("javaScriptType", s:yellow)
call s:h("javaScriptIdentifier", s:purple)
call s:h("javaScriptVar", s:white)
call s:h("javaScriptKeyword", s:yellow)
call s:h("javaScriptBraces", s:white)

call s:h("htmlTitle", s:blue, "", "bold")
call s:h("htmlTag", s:blue)
call s:h("htmlEndTag", s:blue)
call s:h("htmlEvent", s:red)
call s:h("htmlArg", s:red)

call s:h("vimCommentTitle", s:blue, "", "bold")
call s:h("vimBracket", s:blue)
call s:h("vimMapMod", s:cyan)
call s:h("vimNotation", s:blue)
call s:h("vimFunction", s:blue)
call s:h("vimUserFunc", s:purple)

call s:h("orgDone", s:green, s:visual_grey, "bold")
call s:h("orgTodo", s:red, s:visual_grey, "bold")
call s:h("orgDate", s:cyan)
call s:h("orgCounter", s:green)
call s:h("orgCheckmark", s:dark_yellow, "", "bold")
call s:h("orgCheckbox", s:dark_yellow, "", "bold")
call s:h("orgClosed", s:yellow, "", "bold")
call s:h("orgClosedColon", s:yellow, "", "bold")
call s:h("orgLink", s:comment_grey)
call s:h("orgLinkSource", s:blue, "", "underline")
call s:h("orgLinkDescription", s:purple, "", "bold")

call s:h("orgBold", "", "", "bold")
call s:h("orgItalic", "", "", "italic")
call s:h("orgUnderline", "", "", "underline")
call s:h("orgVerbatim", s:purple, "", "italic")
call s:h("orgStrike", s:blue, "", "underline")
call s:h("orgCode", s:green, "", "italic")

call s:h("swkHeader", s:yellow, "", "bold")
call s:h("swkBulletPoint", s:cyan)
call s:h("swkBulletSubject", s:blue, "", "bold")
call s:h("swkBulletSubjectSep", s:blue)
call s:h("swkBulletContent", s:purple)
call s:h("swkString", s:blue)
call s:h("swkMathOperator", s:cyan)
call s:h("swkMathVariable", s:red)

call s:h("cmdlogSuccess", s:green)
call s:h("cmdlogFailure", s:red)

call s:h("qfLineNr", s:blue)
