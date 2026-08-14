" Vim syntax file for the Masa language.

if exists("b:current_syntax")
  finish
endif

" Keywords: control flow, declarations, package machinery.
syntax keyword masaKeyword package import
syntax keyword masaKeyword fn async await defer return
syntax keyword masaKeyword struct union enum error map
syntax keyword masaConditional if else when then match
syntax keyword masaRepeat for break continue
syntax keyword masaKeyword in

" Word operators (Masa uses these instead of && / ||).
syntax keyword masaOperator and or not

" Symbol operators. Defined before comments/strings so that later, higher-
" priority match items (// comment, "string") win over a bare `/` etc.
syntax match masaOperator "[-+*/%<>=!&|^~?]"
syntax match masaOperator ":="
syntax match masaOperator "->"

" Odin-style compiler directives, e.g. #private.
syntax match masaDirective "#\h\w*"

" Builtin type(s) and constants.
syntax keyword masaType number string bool any
syntax keyword masaBoolean true false
syntax keyword masaConstant nil

" Comments: line and C-style block comments.
syntax match masaComment "//.*$" contains=masaTodo
syntax region masaComment start=+/\*+ end=+\*/+ keepend contains=masaTodo
syntax keyword masaTodo contained TODO FIXME XXX NOTE HACK

" Strings: double-quoted only, with escape sequences.
syntax match  masaEscape contained "\\\%([nrt0\\\"']\|x\x\{2}\|u\x\{4}\|U\x\{8}\)"
syntax region masaString start=+"+ skip=+\\"+ end=+"+ contains=masaEscape

" Numbers: decimal, hex, octal, binary, floats, with underscores.
syntax match masaNumber "\<\d[0-9_]*\%(\.\d[0-9_]*\)\?\%([eE][-+]\?\d\+\)\?\>"
syntax match masaNumber "\<0x[0-9a-fA-F_]\+\>"
syntax match masaNumber "\<0o[0-7_]\+\>"
syntax match masaNumber "\<0b[01_]\+\>"

" Function definitions: highlight the name after `fn`.
syntax match masaFunction "\<\h\w*\ze\s*::\s*\%(async\s\+\)\?fn\>"
" Function call: identifier immediately followed by (
syntax match masaFunctionCall "\<\h\w*\ze\s*("

" Link to standard highlight groups.
highlight default link masaKeyword       Keyword
highlight default link masaConditional   Conditional
highlight default link masaRepeat        Repeat
highlight default link masaOperator      Operator
highlight default link masaDirective     PreProc
highlight default link masaType          Type
highlight default link masaBoolean       Boolean
highlight default link masaConstant      Constant
highlight default link masaComment       Comment
highlight default link masaTodo          Todo
highlight default link masaString        String
highlight default link masaEscape        SpecialChar
highlight default link masaNumber        Number
highlight default link masaFunction      Function
highlight default link masaFunctionCall  Function

let b:current_syntax = "masa"
