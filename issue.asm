;include "macros.asm"

include "pokecrystal/constants.asm"

include "macros/news_macros.asm"
include "macros/news_script_commands.asm"
include "macros/mobile_text_script.asm"
include "pokecrystal/ram.asm"

; NOTE: can also be defined by Makefile
;DEF MINIGAME_FILE EQUS "minigame/quiz_blue.asm"

DEF _MINIGAME_H EQU 1
INCLUDE "{MINIGAME_FILE}"
PURGE _MINIGAME_H

SECTION "Download Text", ROM0[$2000]
	lang      J, ""
	lang_line J, __DATE__
	
	lang      E, "Debug Issue"
	lang_line E, __DATE__
	
	lang      D, ""
	lang_line D, __DATE__
	
	lang F, ""
	lang_line F, __DATE__
	
	lang      I, ""
	lang_line I, __DATE__
	
	lang      S, ""
	lang_line S, __DATE__


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, NEWSBORDER_STRIPED, 3
	news_box  0, 12, 20,  6, NEWSBORDER_GLOWY,   4

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, "ポケモンニュース"
	lang E, "#MON NEWS No.0"
	lang D, "NACHRICHTEN Nr. 0"
	lang F, "INFOS PKMN No.0"
	lang I, "NOTIZIE PKMN Nº0"
	lang S, "?"
	db "@"

	news_menu 2, 5, 1, 4, 0, 2, $12, $04, $07, $04, $02, $04

	news_buttonscript .a_button			; [a] script
	news_buttonscript .b_button			; [b] script
	news_buttonscript 					; [sel] script
	news_buttonscript 					; [start] script
	news_buttonscript 					; [<] script
	news_buttonscript 					; [>] script
	news_buttonscript .up_button		; [^] script
	news_buttonscript .down_button		; [v] script

	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_loadrankingstable RANKINGS_TABLE_DO_NOT

	news_menuitem_names   .menuTrainerRankingsName,   .menuitem4_name,   .menuitem5_name
	news_menuitem_scripts .menuTrainerRankingsScript, .menuitem4_script, .menuitem5_script
	news_menuitem_descs   .menuTrainerRankingsDesc,   .menuitem4_desc,   .menuitem5_desc

.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret

.b_button
	nsc_playsound SFX_MENU
	nsc_exit
	nsc_ret

.up_button
	nsc_up
	nsc_ret

.down_button
	nsc_down
	nsc_ret

.menuTrainerRankingsName
	lang J, "ランキング　<WO>みる"
	lang E, "TRAINER RANKINGS"
	lang D, "BESTENLISTE"
	lang F, "QUIZ #MANIA"
	lang I, "QUIZ #FANATICO"
	lang S, "?"
	db "@"
.menuitem4_name
	minigame_name
	db "@"
.menuitem5_name
	lang J, "やめる"
	lang E, "CANCEL"
	lang D, "ZURÜCK"
	lang F, "RETOUR"
	lang I, "ESCI"
	lang S, "?"
	db "@"

.menuTrainerRankingsScript
	nsc_page TrainerRankings
	nsc_ret

	
.menuitem4_script
	minigame_start
	nsc_ret
	
.menuitem5_script
	nsc_exit
	nsc_ret
	
	
	
.menuTrainerRankingsDesc
	lang      J, "３つ<NO>テーマで"
	lang_line J, "ランキング<WO>します！"
	
	lang      E, "Triple-theme"
	lang_line E, "<TRAINER> ranking!"
	
	lang      D, "Dreifache Trainer-"
	lang_line D, "Bestenliste!"
	
	lang      F, "Classement des"
	lang_line F, "dresseurs!"
	
	lang      I, "Classifiche allen-"
	lang_line I, "atore a tema."
	
	lang      S, "?"
	
	db "@"
.menuitem4_desc
	minigame_desc
	db "@"
	
.menuitem5_desc
	lang      J, "ニュース<WO>みるのを"
	lang_line J, "やめます"
	
	lang      E, "Finish reading"
	lang_line E, "the NEWS."
	
	lang      D, "Lesen der NACH-"
	lang_line D, "RICHTEN beenden."
	
	lang      F, "Arrêter de lire"
	lang_line F, "les INFOS."
	
	lang      I, "Stop lettura"
	lang_line I, "NOTIZIE."
	
	lang      S, "?"
	
	db "@"


; NOTE: these are currently defined to the compiler in the Makefile
;DEF RANKING_1 EQUS "BATTLE_TOWER_WINS"
;DEF RANKING_2 EQUS "BUG_CONTEST_SCORE"
;DEF RANKING_3 EQUS "LONGEST_MAGIKARP"


INCLUDE "ranking_table_common.asm"

INCLUDE "{MINIGAME_FILE}"

	news_end
