Truinclude "pokecrystal/constants.asm"

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
	
	lang J, db   "ディバグ　はっこう！"
	lang J, line "{d:__UTC_YEAR__}とし　{d:__UTC_MONTH__}がつ　{d:__UTC_DAY__}にち"
	
	lang E, db   "Debug Issue"
	lang E, line __DATE__
	
	lang D, db   "Debug-Ausgabe"
	lang D, line __DATE__
	
	lang F, db ""
	lang F, line __DATE__
	
	lang I, db   "Numero Debug"
	lang I, line __DATE__
	
	lang S, db   ""
	lang S, line __DATE__


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, db "ポケモンニュース　そうかんごう";"ポケモンニュース"
	lang E, db "#MON NEWS No.1";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 1";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.1";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº1";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º1"
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
	lang J, db "ニュースガイド"
	lang E, db "NEWS GUIDE"
	lang D, db "NACHRICHTEN-INFO"
	lang F, db "GUIDE des INFOS"
	lang I, db "GUIDA NOTIZIE"
	lang S, db "GUÍA DE NOTICIAS"
	db "@"
	
.menuTrainerRankingsName
	lang J, db "トレーナーランキング"
	lang E, db "TRAINER RANKINGS"
	lang D, db "BESTENLISTE"
	lang F, db "CLASSEMENT"
	lang I, db "CLASSIFICA ALLEN."
	lang S, db "CLASIF. ENTRE."
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
	lang J, db "りょうきんについて"
	lang E, db "ABOUT FEES"
	lang D, db "GEBÜHREN-INFOS"
	lang F, db "INFOS TARIFS"
	lang I, db "INFO COSTI"
	lang S, db "INFO. DE TARIFAS"
	db "@"

.menuQuitName
	lang J, db "やめる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "ESCI"
	lang S, db "SALIR"
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
	lang J, text "#ニュース　そうかんごうでは"
	lang J, line "<TRAINER>ランキングと"
	lang J, cont "#カルトクイズで"
	lang J, cont "おたのしみ　ください！"
	lang J, para "あなた<NO>ランキング<NO>せいせきは"
	lang J, line "ランキング<NO>こうしん<WO>すれば"
	lang J, cont "なんどでも　かきかえられるので"
	lang J, cont "がんばれば　トップ<NI>なれるかも！"

	lang E, text "We hope you enjoy"
	lang E, line "the <TRAINER> RANK-" ; Check out the commented `.menuTrainerRankingsDesc` further below for official translations.
	lang E, cont "INGS and #MON"
	lang E, cont "QUIZ in issue No.1"
	lang E, para "You can update"
	lang E, line "your ranking at"
	lang E, cont "any time."
	lang E, para "If you work hard"
	lang E, line "you can reach the"
	lang E, cont "top!"
	
	lang D, text "Wir hoffen, dir"
	lang D, line "gefallen die"
	lang D, para "<TRAINER>-BESTEN-"
	lang D, line "LISTE und das"
	lang D, para "#MON-QUIZ in"
	lang D, line "Ausgabe Nr. 1!"
	lang D, para "Du kannst deinen"
	lang D, line "Rang jederzeit"
	lang D, cont "aktualisieren."
	lang D, para "Gib dein Bestes,"
	lang D, line "um einen hohen"
	lang D, cont "Rang zu erreichen!"
	
	lang F, text "Nous espérons que"
	lang F, line "vous apprécierez" ; Temps futur utilisé ailleurs dans le jeu.
	lang F, para "le CLASSEMENT des"
	lang F, line "<TRAINER>S et le"
	lang F, cont "QUIZ #MON dans"
	lang F, cont "la parution no. 1!" ; Numéro abrégé ainsi ailleurs ; la majuscule n'est cependant pas uniforme, mais grammaticalement incorrecte ici.
	lang F, para "Vous pouvez mettre"
	lang F, line "à jour votre"
	lang F, cont "classement quand"
	lang F, cont "vous le souhaitez."
	lang F, para "Travaillez dur"
	lang F, line "et vous atteindrez"
	lang F, cont "le sommet!"
	
	lang I, text "Ci auguriamo che"
	lang I, line "la CLASSIFICA"
	lang I, para "ALLENATORI e il"
	lang I, line "QUIZ #MON"
	lang I, para "nella prima"
	lang I, line "edizione ti"
	lang I, cont "piacciano."
	lang I, para "Puoi aggiornare"
	lang I, line "la classifica"
	lang I, cont "quando vuoi."
	lang I, para "Se lavori sodo,"
	lang I, line "raggiungerai la"
	lang I, cont "vetta!"
	
	lang S, db   "?"
	
	done
	
.aboutFeesText
	lang J, text "？"
	
	lang E, text "?"
	
	lang D, text "?"
	
	lang F, text "?"
	
	lang I, text "?"
	
	lang S, text "?"
	
	done

.menuDesc
	; Japanese
	lang J, db   "メニュー<WO>えらんでください"
	; English
	lang E, db   "Please choose"
	lang E, line "a menu."
	
	; German
	lang D, db   "Bitte wähle ein"
	lang D, line "Menü aus."
	
	lang F, db   "Veuillez choisir"
	lang F, line "un menu."
	
	lang I, db   "Selezionare un"
	lang I, line "menù, per favore."
	
	lang S, db   "Por favor, elija"
	lang S, line "un menú."
	
	db "@"
	
; NOTE: these unique descriptions are present in the EN ROM "first issue" data.
;       however, magazine scans don't line up with this, and i can't find 
;       record of descriptions of minigames, etc. from published issues

;.menuNewsGuideDesc
;	lang J, db   "よみこんだ　ニュースを"
;	lang J, line "かんたん<NI>せつめいします"
;
;	lang E, db   "Read an explan-"
;	lang E, line "ation of the NEWS."
;	
;	lang D, db   "Eine Erklärung zu"
;	lang D, line "den NACHRICHTEN."
;	
;	lang F, db   "Lire les explica-"
;	lang F, line "tions des INFOS."
;	
;	lang I, db   "Leggi la spiegazi-"
;	lang I, line "one delle NOTIZIE."
;	
;	lang S, db   "?"
;	
;	db "@"
	
;.menuTrainerRankingsDesc
;	lang J, db   "３つ<NO>テーマで"
;	lang J, line "ランキング<WO>します！"
;	
;	lang E, db   "Triple-theme"
;	lang E, line "<TRAINER> ranking!"
;	
;	lang D, db   "Dreifache Trainer"
;	lang D, line "Bestenliste!"
;	
;	lang F, db   "Classement des"
;	lang F, line "dresseurs!"
;	
;	lang I, db   "Classifiche alle-"
;	lang I, line "natore a tema."
;	
;	lang S, db   "¡Ranking triple de"
;	lang S, line "entrenadores!"	
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
;	lang J, db   "ニュース<WO>みるのを"
;	lang J, line "やめます"
;	
;	lang E, db   "Finish reading"
;	lang E, line "the NEWS."
;	
;	lang D, db   "Lesen der NACH-"
;	lang D, line "RICHTEN beenden."
;	
;	lang F, db   "Arrêter de lire"
;	lang F, line "les INFOS."
;	
;	lang I, db   "Stop lettura"
;	lang I, line "NOTIZIE."
;	
;	lang S, db   "?"
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
