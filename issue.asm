include "pokecrystal/constants.asm"

include "macros/news_macros.asm"
include "macros/news_script_commands.asm"
include "macros/mobile_text_script.asm"
include "pokecrystal/ram.asm"


DEF NEWS_TEXT_BORDER EQUS "NEWSBORDER_GLOWY, 4"
	; used in "first issue" seen in EN ROM data
;DEF NEWS_MAIN_BORDER EQUS "NEWSBORDER_STRIPED, 3"
	; used in "first issue" seen in magazine scan
DEF NEWS_MAIN_BORDER EQUS "NEWSBORDER_BLOCKY, 4"


; NOTE: these are currently defined to the compiler in the Makefile
;DEF RANKING_1 EQUS "BATTLE_TOWER_WINS"
;DEF RANKING_2 EQUS "BUG_CONTEST_SCORE"
;DEF RANKING_3 EQUS "LONGEST_MAGIKARP"

; NOTE: this is also currently defined by the Makefile
;DEF MINIGAME_FILE EQUS "minigame/quiz_blue.asm"

DEF _MINIGAME_H EQU 1
INCLUDE "{MINIGAME_FILE}"
PURGE _MINIGAME_H


SECTION "Download Text", ROM0[$2000]

	db PERSISTENT_MINIGAME_DATA_SIZE
	
	lang      J, "ディバグ　はっこう！"
	lang_line J, "{d:__UTC_YEAR__}とし　{d:__UTC_MONTH__}がつ　{d:__UTC_DAY__}にち"
	
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
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, "ポケモンニュース　そうかんごう";"ポケモンニュース"
	lang E, "#MON NEWS No.1";"#MON NEWS No.0"
	lang D, "NACHRICHTEN Nr. 1";"NACHRICHTEN Nr. 0"
	lang F, "INFOS PKMN No.1";"INFOS PKMN No.0"
	lang I, "NOTIZIE PKMN Nº1";"NOTIZIE PKMN Nº0"
	lang S, "?"
	db "@"

	;news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, $02, $04
	news_menu 2, 5, 1, 4, 0, 2, 16, 4, 7, 4, SHOW_ARROWS | SHOW_DESCRIPTIONS, $04

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

	news_menuitem_names   .menuNewsGuideName,   .menuTrainerRankingsName
	news_menuitem_names   .menuMinigameName
IF DEF(NUM_MINIGAMES)
DEF loopindex = 2
REPT NUM_MINIGAMES-1
	news_menuitem_names   .menuMinigame{d:loopindex}Name
ENDR
ENDC
	news_menuitem_names   .menuAboutFeesName, .menuQuitName
	
	news_menuitem_scripts .menuNewsGuideScript, .menuTrainerRankingsScript
	news_menuitem_scripts .menuMinigameScript
IF DEF(NUM_MINIGAMES)
DEF loopindex = 2
REPT NUM_MINIGAMES-1
	news_menuitem_scripts   .menuMinigame{d:loopindex}Script
ENDR
ENDC
	news_menuitem_scripts .menuAboutFeesScript, .menuQuitScript
	
	news_menuitem_descs   .menuDesc,.menuDesc;.menuNewsGuideDesc,   .menuTrainerRankingsDesc
	news_menuitem_descs   .menuDesc;.menuMinigameDesc
IF DEF(NUM_MINIGAMES)
DEF loopindex = 2
REPT NUM_MINIGAMES-1
	news_menuitem_descs   .menuDesc;.menuMinigame{d:loopindex}Desc
ENDR
ENDC
	news_menuitem_descs   .menuDesc,.menuDesc;.menuQuitDesc
DEF MINIGAME_MENU_POS EQU 2
.a_button
	nsc_playsound SFX_READ_TEXT
	
	; the news is very finicky about when it chooses to update palettes....
IF DEF(minigame_abuttonhook)
	nsc_compare wNewsMenuOption, .nohook, .hook, .nohook, 1, MINIGAME_MENU_POS
.hook
	minigame_abuttonhook
.nohook
ENDC
	
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

.menuNewsGuideName
	lang J, "ニュースガイド"
	lang E, "NEWS GUIDE"
	lang D, "NACHRICHTEN-INFO"
	lang F, "GUIDE des INFOS"
	lang I, "GUIDA NOTIZIE"
	lang S, "?"
	db "@"
	
.menuTrainerRankingsName
	lang J, "トレーナーランキング"
	lang E, "TRAINER RANKINGS"
	lang D, "BESTENLISTE"
	lang F, "QUIZ #MANIA"
	lang I, "QUIZ #FANATICO"
	lang S, "?"
	db "@"
.menuMinigameName
	minigame_name
	db "@"
IF DEF(NUM_MINIGAMES)
DEF loopindex = 2
REPT NUM_MINIGAMES-1
.menuMinigame{d:loopindex}Name
	minigame_name_{d:loopindex}
	db "@"
ENDR
ENDC

.menuAboutFeesName
	lang J, "りょうきんについて"
	lang E, "ABOUT FEES"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

.menuQuitName
	lang J, "やめる"
	lang E, "CANCEL"
	lang D, "ZURÜCK"
	lang F, "RETOUR"
	lang I, "ESCI"
	lang S, "?"
	db "@"

.menuNewsGuideScript
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .newsGuideText
	nsc_waitbutton
	nsc_ret
	
.menuTrainerRankingsScript
	nsc_page TrainerRankings
	nsc_ret

	
.menuMinigameScript
	minigame_start
	nsc_ret
		
IF DEF(NUM_MINIGAMES)
DEF loopindex = 2
REPT NUM_MINIGAMES-1
.menuMinigame{d:loopindex}Script
	minigame_start_{d:loopindex}
	nsc_ret
ENDR
ENDC

.menuAboutFeesScript
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .aboutFeesText
	nsc_waitbutton
	nsc_ret
	
.menuQuitScript
	nsc_exit
	nsc_ret
	
.newsGuideText
	lang_text J, "#ニュース　そうかんごうでは"
	lang_line J, "<TRAINER>ランキングと"
	lang_cont J, "#カルトクイズで"
	lang_cont J, "おたのしみ　ください！"
	lang_para J, "あなた<NO>ランキング<NO>せいせきは"
	lang_line J, "ランキング<NO>こうしん<WO>すれば"
	lang_cont J, "なんどでも　かきかえられるので"
	lang_cont J, "がんばれば　トップ<NI>なれるかも！"

	lang_text E, "We hope you enjoy"
	lang_line E, "the <TRAINER> RANK-"
	lang_cont E, "INGS and #MANIA"
	lang_cont E, "QUIZ in issue No.1"
	lang_para E, "You can update"
	lang_line E, "your ranking at"
	lang_cont E, "any time."
	lang_para E, "If you work hard"
	lang_line E, "you can reach the"
	lang_cont E, "top!"
	
	lang_text D, "Wir hoffen, dir"
	lang_line D, "gefallen die"
	lang_para D, "<TRAINER>-BESTEN-"
	lang_line D, "LISTE und das"
	lang_para D, "#MANIAC-QUIZ"
	lang_line D, "in Ausgabe Nr. 1!"
	lang_para D, "Du kannst deinen"
	lang_line D, "Rang jederzeit"
	lang_cont D, "aktualisieren."
	lang_para D, "Gib dein Bestes,"
	lang_line D, "um einen hohen"
	lang_cont D, "Rang zu erreichen!"
	
	lang_text F, "Nous espérons que"
	lang_line F, "vous apprécierez"
	lang_para F, "Le CLASSEMENT"
	lang_line F, "et le QUIZ #-"
	lang_cont F, "MANIA dans la"
	lang_cont F, "parution No.1"
	lang_para F, "Vous pouvez mettre"
	lang_line F, "à jour votre"
	lang_cont F, "classement"
	lang_cont F, "n'importe quand."
	lang_para F, "Si vous"
	lang_line F, "travaillez dur"
	lang_cont F, "vous atteindrez"
	lang_cont F, "le sommet!"
	
	lang_text I, "Ci auguriamo che"
	lang_line I, "la CLASSIFICA"
	lang_para I, "ALLENATORI e il"
	lang_line I, "QUIZ #MANIA"
	lang_para I, "nella prima"
	lang_line I, "edizione ti"
	lang_cont I, "piacciano."
	lang_para I, "Puoi aggiornare"
	lang_line I, "la classifica"
	lang_cont I, "quando vuoi."
	lang_para I, "Se lavori sodo,"
	lang_line I, "raggiungerai la"
	lang_cont I, "vetta!"
	
	lang      S, "?"
	
	done
	
.aboutFeesText
	lang_text J, "？"
	
	lang_text E, "?"
	
	lang_text D, "?"
	
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang_text S, "?"
	
	done

	; TODO: translation not yet approved
.menuDesc
	lang      J, "メニュー<WO>えらんでください"
	
	lang      E, "Please choose"
	lang_line E, "a menu."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"
	
; NOTE: these unique descriptions are present in the EN ROM "first issue" data.
;       however, magazine scans don't line up with this, and i can't find 
;       record of descriptions of minigames, etc. from published issues

;.menuNewsGuideDesc
;	lang      J, "よみこんだ　ニュースを"
;	lang_line J, "かんたん<NI>せつめいします"
;
;	lang      E, "Read an explan-"
;	lang_line E, "ation of the NEWS."
;	
;	lang      D, "Eine Erklärung zu"
;	lang_line D, "den NACHRICHTEN."
;	
;	lang      F, "Lire les explica-"
;	lang_line F, "tions des INFOS."
;	
;	lang      I, "Leggi la spiegazi-"
;	lang_line I, "one delle NOTIZIE."
;	
;	lang      S, "?"
;	
;	db "@"
	
;.menuTrainerRankingsDesc
;	lang      J, "３つ<NO>テーマで"
;	lang_line J, "ランキング<WO>します！"
;	
;	lang      E, "Triple-theme"
;	lang_line E, "<TRAINER> ranking!"
;	
;	lang      D, "Dreifache Trainer-"
;	lang_line D, "Bestenliste!"
;	
;	lang      F, "Classement des"
;	lang_line F, "dresseurs!"
;	
;	lang      I, "Classifiche allen-"
;	lang_line I, "atore a tema."
;	
;	lang      S, "?"
;	
;	db "@"
;.menuMinigameDesc
;	minigame_desc
;	db "@"
;
;IF DEF(NUM_MINIGAMES)
;DEF loopindex = 2
;REPT NUM_MINIGAMES-1
;.menuMinigame{d:loopindex}Desc
;	minigame_desc_{d:loopindex}
;	db "@"
;ENDR
;ENDC
;	
;.menuQuitDesc
;	lang      J, "ニュース<WO>みるのを"
;	lang_line J, "やめます"
;	
;	lang      E, "Finish reading"
;	lang_line E, "the NEWS."
;	
;	lang      D, "Lesen der NACH-"
;	lang_line D, "RICHTEN beenden."
;	
;	lang      F, "Arrêter de lire"
;	lang_line F, "les INFOS."
;	
;	lang      I, "Stop lettura"
;	lang_line I, "NOTIZIE."
;	
;	lang      S, "?"
;	
;	db "@"


INCLUDE "{MINIGAME_FILE}"

INCLUDE "ranking_table_common.asm"

	; this is... just for matching.
	; it makes no sense.
	; it doesnt need to be here.
	db 4

	news_end


; extra byte at the end of news data for persistent storage
; used by minigames to check whether you've already received the game's prize
; overwritten when the next issue comes in
sMinigameFlag:: db 0
