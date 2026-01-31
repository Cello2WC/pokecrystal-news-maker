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
	
	lang J, db "ポケモンニュース　8";"ポケモンニュース"
	lang E, db "#MON NEWS No.8";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 8";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.8";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº8";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º8"


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, db "ポケモンニュース　8";"ポケモンニュース"
	lang E, db "#MON NEWS No.8";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 8";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.8";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº8";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º8"
	db "@"

	;news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, $02, $04
	;news_menu 2, 5, 1, 4, 0, 2, 16, 4, 7, 4, SHOW_ARROWS | SHOW_DESCRIPTIONS, $04
	news_menu 2, 5, 1, 4, 0, 2, 16, 4, 7, 4, SHOW_DESCRIPTIONS, $04

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
	;news_menuitem_names   .menuAboutFeesName, .menuQuitName
	news_menuitem_names   .menuQuitName	
	
	news_menuitem_scripts .menuNewsGuideScript, .menuTrainerRankingsScript
	news_menuitem_scripts .menuMinigameScript
IF DEF(NUM_MINIGAMES)
DEF loopindex = 2
REPT NUM_MINIGAMES-1
	news_menuitem_scripts   .menuMinigame{d:loopindex}Script
ENDR
ENDC
;	news_menuitem_scripts .menuAboutFeesScript, .menuQuitScript
	news_menuitem_scripts .menuQuitScript	
	
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

;.menuAboutFeesName
;	lang J, db "りょうきんについて"
;	lang E, db "ABOUT FEES"
;	lang D, db "GEBÜHREN-INFOS"
;	lang F, db "INFOS TARIFS"
;	lang I, db "INFO COSTI"
;	lang S, db "INFO. DE TARIFAS"
;	db "@"

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

;.menuAboutFeesScript
;	nsc_clear 1, 13, 18, 4
;	nsc_textbox 1, 14, .aboutFeesText
;	nsc_waitbutton
;	nsc_ret
;	
.menuQuitScript
	nsc_exit
	nsc_ret
	
.newsGuideText
    lang J, text "ポケモンニュース　８がつごうです！"
    lang J, line "ゲーム　「ポケモン　つづくかな？」は"
    lang J, cont "つぎつぎ　あらわれる　ポケモンの"
    lang J, cont "じゅんばんを　おぼえる　ゲームです！"
    lang J, cont "なきごえを　ぜんぶ　おぼえるのは"
    lang J, cont "かなり　たいへん…！　がんばろう！"


    lang J, para "あたらしい　ランキングの　テーマは"
    lang J, line "タマゴを　かえした　かいすう　です！"
    lang J, cont "きっと　おどろくほど　たくさん"
    lang J, cont "タマゴを　かえした　トレーナーが"
    lang J, cont "いる　はず！　あなたは　どうかな？"
    lang J, cont "さっそく　みに　いって　みよう！"


    lang J, para "ポケモンニュース　９がつごうは"
    lang J, line "８がつ　２８にち　モバイルセンターの"
    lang J, cont "ちょうせいが　おわった　あと"
    lang J, cont "よめるように　なります！"
    lang J, cont "ポケモンずかんを　しっかり　みて"
    lang J, cont "おくと　いいかも…？　おたのしみに！"

    lang E, text "It's the August"
    lang E, line "issue of the"
    lang E, cont "#MON NEWS!"

    lang E, para "The game #RAP"
    lang E, line "IT UP! is a game"
    lang E, cont "where you remember"
    lang E, cont "the order of"
    lang E, cont "#MON as they"
    lang E, cont "appear!"

    lang E, para "Remembering all"
    lang E, line "the cries is"
    lang E, cont "pretty tough…"

    lang E, para "Do your best!"

    lang E, para "The new ranking"
    lang E, line "theme is:"
    lang E, cont "EGGS HATCHED!"

    lang E, para "I bet some"
    lang E, line "TRAINERS have"
    lang E, cont "hatched so many"
    lang E, cont "EGGS it'll"
    lang E, cont "surprise you!"

    lang E, para "The September"
    lang E, line "issue of #MON"
    lang E, cont "NEWS will be"
    lang E, cont "available on"
    lang E, cont "August 28th,"
    lang E, cont "after MOBILE"
    lang E, cont "CENTER adjustments"
    lang E, cont "end."

    lang E, para "It might be a good"
    lang E, line "idea to look at"
    lang E, cont "your #DEX"
    lang E, cont "beforehand…"

    lang E, para "Stay tuned!"

    lang F, text "Voici l'édition"
    lang F, line "d'août des"
    lang F, cont "INFOS #MON!"

    lang F, para "#RAP MOI CA! Le"
    lang F, line "jeu où vous devez"
    lang F, cont "vous rappeler de"
    lang F, cont "l'ordre dans lequel"
    lang F, cont "les #MON"
    lang F, cont "apparaissent!"

    lang F, para "Se rappeler de"
    lang F, line "tous ces cris est"
    lang F, cont "pas si facile..."

    lang F, para "Faites de votre"
    lang F, line "mieux!"

    lang F, para "La thème du pro-"
    lang F, line "chain classement:"
    lang F, cont "OEUFS ECLOS!"

    lang F, para "Je parie que"
    lang F, line "certains en ont"
    lang F, cont "fais éclore"
    lang F, cont "tellement que ça"
    lang F, cont "vous surprendra!"

    lang F, para "L'édition de"
    lang F, line "septembre sera"
    lang F, cont "disponible le 28"
    lang F, cont "août, après la fin"
    lang F, cont "des réparations du"
    lang F, cont "CENTRE MOBILE."

    lang F, para "Jeter un coup"
    lang F, line "d'oeil à votre"
    lang F, cont "#DEX serait une"
    lang F, cont "bonne idée..."

    lang F, para "Restez branché!"

    lang D, text "Hier ist die"
    lang D, line "August-Ausgabe der"
    lang D, cont "PKMN-NACHRICHTEN!"

    lang D, para "Im Spiel #MON-"
    lang D, line "PLAUDEREI musst"
    lang D, cont "du dir die Reihen-"
    lang D, cont "folge der auftau-"
    lang D, cont "chenden #MON"
    lang D, cont "einprägen!"

    lang D, para "Sich alle Rufe"
    lang D, line "zu merken ist"
    lang D, cont "kein Kinderspiel…"

    lang D, para "Gib dein Bestes!"

    lang D, para "Das neue Rang-"
    lang D, line "listen-Thema ist:"
    lang D, cont "GESCHLÜPFTE EIER!"

    lang D, para "Einige TRAINER"
    lang D, line "haben bestimmt so"
    lang D, cont "viele EIER schlüp-"
    lang D, cont "fen lassen, dass"
    lang D, cont "es für eine Über-"
    lang D, cont "raschung sorgt!"

    lang D, para "Die September-"
    lang D, line "Ausgabe der"
    lang D, cont "PKMN-NACHRICHTEN"
    lang D, cont "kommt heraus am"
    lang D, cont "28. August - nach"
    lang D, cont "Abschluss der"
    lang D, cont "Anpassungen des"
    lang D, cont "MOBILEN CENTERs."

    lang D, para "Es könnte von"
    lang D, line "Vorteil sein, sich"
    lang D, cont "den #DEX vorab"
    lang D, cont "noch einmal"
    lang D, cont "anzuschauen…"

    lang D, para "Bleib dran!"

    lang I, text "È l'edizione di"
    lang I, line "Agosto delle"
    lang I, cont "NOTIZIE #MON!"

    lang I, para "Il gioco CANTA IL"
    lang I, line "#RAP! è un"
    lang I, cont "gioco dove devi"
    lang I, cont "ricordare l'ordine"
    lang I, cont "in cui appaiono i"
    lang I, cont "#MON!"

    lang I, para "Ricordarsi tutti i"
    lang I, line "versi è"
    lang I, cont "difficile…"

    lang I, para "Fai del tuo"
    lang I, line "meglio!"

    lang I, para "Il tema della"
    lang I, line "nuova classifica"
    lang I, cont "è: UOVA SCHIUSE!"

    lang I, para "Scommetto che"
    lang I, line "alcuni ALLENATORI"
    lang I, cont "hanno schiuso così"
    lang I, cont "tante UOVA da"
    lang I, cont "sorprenderti!"

    lang I, para "L'edizione di"
    lang I, line "Settembre delle"
    lang I, cont "NOTIZIE #MON"
    lang I, cont "sarà disponibile"
    lang I, cont "il 28 Agosto, dopo"
    lang I, cont "che la manuten-"
    lang I, cont "zione del CENTRO"
    lang I, cont "MOBILE sarà"
    lang I, cont "terminata."

    lang I, para "Sarebbe una buona"
    lang I, line "idea consultare il"
    lang I, cont "#DEX in"
    lang I, cont "anticipo…"

    lang I, para "Restate in"
    lang I, line "ascolto!"

    lang S, text "¡Es la edición"
    lang S, line "de agosto de"
    lang S, cont "NOTICIAS #MON!"

    lang S, para "#RAPEÁLO"
    lang S, line "¡es un juego"
    lang S, cont "donde debes"
    lang S, cont "recordar el orden"
    lang S, cont "de los #MON"
    lang S, cont "que aparecen!"

    lang S, para "Recordar todos"
    lang S, line "los gritos es"
    lang S, cont "muy difícil…"

    lang S, para "¡Esfuérzate!"

    lang S, para "El nuevo tema"
    lang S, line "clasificatorio es:"
    lang S, cont "HUEVOS NACIDOS!"

    lang S, para "¡Estoy seguro de"
    lang S, line "que habrá ENTREN."
    lang S, cont "eclosionando"
    lang S, cont "tantos HUEVOS"
    lang S, cont "que sorprenderá!"

    lang S, para "La NOTICIAS"
    lang S, line "#MON de"
    lang S, cont "septiembre estará"
    lang S, cont "disponible el 28"
    lang S, cont "de agosto, tras"
    lang S, cont "finalizar los"
    lang S, cont "ajustes del"
	lang S, cont "CENTRO MÓVIL."

    lang S, para "Sería una buena"
    lang S, line "idea mirar tu"
    lang S, cont "#DEX"
    lang S, cont "de antemano…"

    lang S, para "¡Sigue conectado!"
	
	done
	
;.aboutFeesText
;	lang J, text "？"
;	
;	lang E, text "?"
;	
;	lang D, text "?"
;	
;	lang F, text "?"
;	
;	lang I, text "?"
;	
;	lang S, text "?"
;	
;	done

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
