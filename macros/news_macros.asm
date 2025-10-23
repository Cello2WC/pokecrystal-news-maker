MACRO trans_string
WARN "the 'trans' macro family is deprecated. use 'lang' instead."
ENDM

MACRO trans_text
WARN "the 'trans' macro family is deprecated. use 'lang' instead."
ENDM

MACRO trans_line
WARN "the 'trans' macro family is deprecated. use 'lang' instead."
ENDM

MACRO trans_next
WARN "the 'trans' macro family is deprecated. use 'lang' instead."
ENDM

MACRO trans_para
WARN "the 'trans' macro family is deprecated. use 'lang' instead."
ENDM

MACRO trans_cont
WARN "the 'trans' macro family is deprecated. use 'lang' instead."
ENDM

MACRO lang
IF DEF(_LANG_\1)
SHIFT
	\#
ENDC
ENDM

MACRO notlang
IF !DEF(_LANG_\1)
SHIFT
	\#
ENDC
ENDM



MACRO news_coord
; x, y
rept _NARG / 2
	dw (\2) * SCREEN_WIDTH + (\1)
	shift 2
endr
ENDM

MACRO news_begin
	news_header
News_Issue_Begin:
DEF NextScreenIsOpening = 1
ENDM

MACRO news_end
News_Issue_End:
	;db $FF ; this is just to make chopping the trailing 00's off the resulting file easier
ENDM

MACRO news_length
	dw News_Issue_End - News_Issue_Begin
ENDM

MACRO news_header
	dw $A000
	dw $0000	; to be replaced with checksum later
	news_length
ENDM

MACRO news_screen
\1::
DEF currentScreen = \1
if NextScreenIsOpening != 0
DEF openingScreen = \1
DEF NextScreenIsOpening = 0
endc
	news_def_bgm \2
ENDM

MACRO news_def_bgm
	db \1
ENDM

MACRO news_def_pals
REDEF _NUM_CUSTOM_PALS EQUS "_NUM_CUSTOM_PALS_\@"
	db {_NUM_CUSTOM_PALS}
DEF {_NUM_CUSTOM_PALS} = 0
ENDM

MACRO news_pal
	dw \1, \2, \3, \4
DEF {_NUM_CUSTOM_PALS} += 1
ENDM

MACRO news_def_boxes
REDEF _NUM_BOXES EQUS "_NUM_BOXES_\@"
	db {_NUM_BOXES}
DEF {_NUM_BOXES} = 0
ENDM

; x, y, w, h, border, pal
MACRO news_box
	db \1, \2, \3, \4, \5, \6
DEF {_NUM_BOXES} += 1
ENDM

MACRO news_def_strings
REDEF _NUM_STRINGS EQUS "_NUM_STRINGS_\@"
	db {_NUM_STRINGS}
DEF {_NUM_STRINGS} = 0
ENDM

; x, y, string
MACRO news_string
	news_coord \1, \2
	db \3
DEF {_NUM_STRINGS} += 1
ENDM

DEF SHOW_ARROWS       EQU %0001
DEF SHOW_DESCRIPTIONS EQU %0010
; x, y, colums, rows, colums width, row height, width+x, ?, ?, max before scrolling, ?, ?
	;  \1: menu X
	;  \2: menu Y
	;  \3: menu columns
	;  \4: menu rows
	;  \5: colums width
	;  \6: row height
	;  \7: width to clear when scrolling? 
	;      (could probably default to (\3*\5) + \1)
	;      (but seems to   default to -1      + \1 in non-scrolling menus)
	;  \8: height for up arrow when FLAG_SHOW_ARROWS
	;  \9: vertical offset from \8 for down arrow when FLAG_SHOW_ARROWS
	; \10: cursor Y at which scrolling starts (default to \4 ?)
	; \11: flags
	;      bit 0 - FLAG_SHOW_ARROWS
	;      bit 1 - FLAG_SHOW_DESCRIPTIONS
	; \12: related to horizontal menu scrolling
	
	
MACRO news_menu
	db \1, \2, \3, \4, \5, \6, \7+\1, \8, \9, 
SHIFT 9
	db \1, \2, \3
ENDM
	
MACRO relativepointer
REPT _NARG
	dw \1 - currentScreen
SHIFT
ENDR
ENDM
	
DEF BUTTONSCRIPT_NONE EQU $FFFF
MACRO news_buttonscript
	if _NARG == 0
	dw BUTTONSCRIPT_NONE
	else
	relativepointer \1
	endc
ENDM
	
MACRO news_def_menuitems
REDEF _NUM_MENU_ITEMS EQUS "_NUM_MENU_ITEMS_\@"
	db {_NUM_MENU_ITEMS}
DEF {_NUM_MENU_ITEMS} = 0
ENDM

MACRO news_menuitem_names
DEF {_NUM_MENU_ITEMS} += _NARG
rept _NARG
	relativepointer \1
	shift 1
endr
ENDM

MACRO news_menuitem_scripts
rept _NARG
	relativepointer \1
	shift 1
endr
ENDM

MACRO news_menuitem_descs
rept _NARG
	relativepointer \1
	shift 1
endr
ENDM

; x, y, w, h
MACRO news_menudescription
	news_coord \1, \2
	db \3, \4
ENDM

DEF RANKINGS_TABLE_LOAD		EQU 1
DEF RANKINGS_TABLE_DO_NOT	EQU 0
MACRO news_loadrankingstable
if _NARG == 0
	db RANKINGS_TABLE_LOAD
else
	db \1
endc
ENDM

MACRO news_norankingstable
	db RANKINGS_TABLE_DO_NOT
ENDM
