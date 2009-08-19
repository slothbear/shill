" Vim syntax file
" Language:	Linden scripting language
" Maintainer:	Gabriel Spinnaker (gs@geekmafia.net)
" Last Change:	2004 Sep 11
" %SHILL_UPDATE_NOTICE%

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Basic syntax
syn case match
syn keyword	lStatement	jump return default state
syn match	lLabel		"@.\+;"
syn keyword	lConditional	if else 
syn keyword	lRepeat		while for do
syn keyword	lTodo		contained TODO FIXME XXX
syn keyword	lType		integer float list vector rotation quaternion string key
syn match	lOperator	"[-=+%^&|*!~]"
syn match	lOperator	"[-+]="
syn match	lOperator	"&&"
syn match	lOperator	"||"
syn match	lOperator	"[!=<>]="
syn match	lOperator	"[<>]"
syn match	lOperator	"[<>][<>]"
syn cluster	lCommentGroup	contains=lTodo
syn match	lComment	"//.*$" contains=@lCommentGroup

syn region 	lString		start=+"+  skip=+\\\\\|\\"+  end=+"+
syn match	lNumber		"-\=\<\d\+\>"
syn match	lHexNumber	"0x\<\d\+\>"
syn match	lFloat		"-\=\<\d\+\.\d\+\>"
syn region	lBlock		matchgroup=lSpecial start=/{/ end=/}/ contains=ALL
syn cluster	lListGroup	contains=lNumber,lFloat,lString,lOperator
syn region	lList		matchgroup=lSpecial start=/\[/ end=/\]/ contains=@lListGroup
syn region	lParen		matchgroup=lSpecial start=/(/ end=/)/ contains=ALL
syn match	lVecQuatXYZS	".\[xyzs\]"

START:constants
syn keyword	lConstant %name%
END:constants

" Events
START:events
syn keyword	lEvent %name%
END:events

" Built-in functions
START:functions
syn keyword lFunction %name%
END:functions

" Deprecated functions
syn keyword lDeprecated llSound llSoundPreload llRemoteLoadScript llMakeExplosion llMakeFire llMakeFountain llMakeSmoke llXorBase64Strings llPointAt llStopPointAt
" Deprecated constants (as of 1.5.x)
syn keyword lDeprecated PSYS_SRC_INNERANGLE PSYS_SRC_OUTERANGLE

if version >= 508 || !exists("did_b_syntax_inits")
   if version < 508
      let did_b_syntax_inits = 1
      command -nargs=+ HiLink hi link <args>
   else
      command -nargs=+ HiLink hi def link <args>
   endif
  HiLink lLabel			Label
  HiLink lConditional		Conditional
  HiLink lRepeat		Repeat
"  HiLink cCharacter		Character
  HiLink lNumber		Number
"  HiLink cOctalZero		PreProc	 " link this to Error if you want
  HiLink lFloat			Float
  HiLink lOperator		Operator
  HiLink lVecQuatXYZS		Operator
  HiLink lFunction		Function
  HiLink lEvent			Statement
"  HiLink cStorageClass		StorageClass
"  HiLink cInclude		Include
"  HiLink cPreProc		PreProc
"  HiLink cDefine		Macro
"  HiLink cError		Error
  HiLink lStatement		Statement
"  HiLink cPreCondit		PreCondit
  HiLink lSpecial		SpecialChar
  HiLink lType			Type
  HiLink lConstant		Constant
  HiLink lString		String
  HiLink lComment		Comment
  HiLink lDeprecated		Error
  HiLink lTodo			Todo

  delcommand HiLink
endif

let b:current_syntax = "lsl"

" vim: ts=8
