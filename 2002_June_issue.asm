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
	
	lang J, db "ポケモンニュース　６";"ポケモンニュース"
	lang E, db "#MON NEWS No.6";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 6";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.6";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº6";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º6"


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, db "ポケモンニュース　６";"ポケモンニュース"
	lang E, db "#MON NEWS No.6";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 6";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.6";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº6";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º6"
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
    lang J, text "おまたせしました　"
    lang J, line "６がつごうです！"
    lang J, cont "６がつごうの　ゲームは"
    lang J, cont "ポケモンもじめいろ　です！"
    lang J, cont "１ども　まちがわず"
    lang J, cont "ポケモンの　なまえを"
    lang J, cont "たどって　うまく"
    lang J, cont "ゴールまで　たどりつけるかな？"


    lang J, para "ランキングの　あたらしい　テーマは"
    lang J, line "ポケモンと　たたかった　かいすうです"
    lang J, cont "いままでに　どれだけの　かずの"
    lang J, cont "やせいポケモンと　たたかったのか"
    lang J, cont "しったら　じぶんでも"
    lang J, cont "きっと　びっくり　するはず！"


    lang J, para "７がつごうは　だい４すいようび"
    lang J, line "６がつ　２６にち　モバイルセンターの"
    lang J, cont "ちょうせいが　おわると　よめます！"
    lang J, cont "むかしの　ポケモンを　しっている"
    lang J, cont "ひとは　いいことが　あるかも"
    lang J, cont "おたのしみに！"

    lang E, text "Here it is!"

    lang E, para "It's the June"
    lang E, line "issue!"

    lang E, para "This month's game"
    lang E, line "is #MON MAZE!"

    lang E, para "Without mistakes,"
    lang E, line "can you follow"
    lang E, cont "the trail of"
    lang E, cont "#MON names to"
    lang E, cont "the goal?"

    lang E, para "The new ranking"
    lang E, line "theme is:"
    lang E, cont "#MON ENCOUNTER!"

    lang E, para "How many wild"
    lang E, line "#MON have you"
    lang E, cont "battled so far?"

    lang E, para "You'll surprise"
    lang E, line "even yourself!"

    lang E, para "The July issue"
    lang E, line "will be available"
    lang E, cont "on June 26th,"
    lang E, cont "after MOBILE"
    lang E, cont "CENTER adjustments"
    lang E, cont "end."

    lang E, para "If you know"
    lang E, line "#MON from the"
    lang E, cont "old days,"
    lang E, cont "something good"
    lang E, cont "may happen!"

    lang E, para "Stay tuned!"

    lang F, text "Là voilà!"

    lang F, para "L'édition de juin!"

    lang F, para "Le jeu du mois?"
    lang F, line "#-LABYRINTHE!"

    lang F, para "Saurez-vous suivre"
    lang F, line "le tracé des noms"
    lang F, cont "de #MON, sans"
    lang F, cont "aucune faute,"
    lang F, cont "jusqu'au bout?"

    lang F, para "La thème du pro-"
    lang F, line "chain classement:"
    lang F, cont "#MON SAUVAGES!"

    lang F, para "Combien de #MON"
    lang F, line "sauvages avez-vous"
    lang F, cont "combattu jusqu'à"
    lang F, cont "maintenant?"

    lang F, para "La réponse vous"
    lang F, line "surprendra vous-"
    lang F, cont "même!"

    lang F, para "L'édition de"
    lang F, line "juillet sera dispo"
    lang F, cont "-nible le 26 juin,"
    lang F, cont "après la fin des"
    lang F, cont "réparations du"
    lang F, cont "CENTRE MOBILE."

    lang F, para "Si vous vous y"
    lang F, line "connaissez quant"
    lang F, cont "aux vieux #MON,"
    lang F, cont "la chance pourrait"
    lang F, cont "vous sourire!"

    lang F, para "Restez branché!"

    lang D, text "Schwuppdiwupp!"

    lang D, para "Hier kommt die"
    lang D, line "Juni-Ausgabe!"

    lang D, para "Das Minispiel des"
    lang D, line "Monats ist das"
    lang D, cont "#MON-LABYRINTH!"

    lang D, para "Kannst du der"
    lang D, line "Spur aus #MON-"
    lang D, cont "Namen bis zum"
    lang D, cont "Ziel folgen, ohne"
    lang D, cont "Fehler zu machen?"

    lang D, para "Das Thema der"
    lang D, line "Rangliste lautet:"
    lang D, cont "#MON-BEGEG-"
    lang D, cont "NUNGEN!"

    lang D, para "Gegen wie viele"
    lang D, line "wilde #MON"
    lang D, cont "hast du bisher"
    lang D, cont "gekämpft?"

    lang D, para "Das wird selbst"
    lang D, line "dich überraschen!"

    lang D, para "Die Juli-Ausgabe"
    lang D, line "wird am 26. Juni"
    lang D, cont "eintreffen - nach"
    lang D, cont "Abschluss der"
    lang D, cont "Anpassungen des"
    lang D, cont "MOBILEN CENTERs."

    lang D, para "Wenn du dich mit"
    lang D, line "#MON aus frü-"
    lang D, cont "heren Zeiten aus-"
    lang D, cont "kennst, könnte"
    lang D, cont "dich etwas Gutes"
    lang D, cont "erwarten!"

    lang D, para "Bleib dran!"

    lang I, text "Eccola quì!"

    lang I, para "È l'edizione di"
    lang I, cont "Giugno! "

    lang I, para "Il gioco del mese"
    lang I, line "è LABIRINTO"
    lang I, cont "#MON!"

    lang I, para "Riesci a seguire"
    lang I, line "le tracce dei"
    lang I, cont "nomi dei #MON"
    lang I, cont "fino al traguar-"
    lang I, cont "do senza fare"
    lang I, cont "errori?"

    lang I, para "Il tema della" 
    lang I, line "nuova classifica" 
    lang I, cont "è: INCONTRI" 
    lang I, cont "#MON!"

    lang I, para "Quanti #MON"
    lang I, line "selvatici hai"
    lang I, cont "combattuto"
    lang I, cont "fin'ora?"

    lang I, para "Sarà una"
    lang I, line "sorpresa anche"
    lang I, cont "per te!"

    lang I, para "L'edizione di"
    lang I, line "Luglio sarà"
    lang I, cont "disponibile il"
    lang I, cont "26 Giugno, dopo"
    lang I, cont "che la manuten-"
    lang I, cont "zione del CENTRO"
    lang I, cont "MOBILE sarà"
    lang I, cont "terminata."

    lang I, para "Se conosci"
    lang I, line "#MON dai"
    lang I, cont "tempi passati,"
    lang I, cont "potrebbe capitare"
    lang I, cont "qualcosa di buono!"

    lang I, para "Restate in"
    lang I, line "ascolto!"

    lang S, text "¡Ha llegado!"

    lang S, para "¡Es la edición"
    lang S, line "de junio!"

    lang S, para "¡El juego de este"
    lang S, line "mes es"
	lang S, cont "#palabras!"

    lang S, para "Sin errar,"
    lang S, line "¿podrás seguir"
    lang S, cont "el rastro de los"
    lang S, cont "nombres #MON"
    lang S, cont "hasta la meta?"

    lang S, para "El nuevo tema"
    lang S, line "clasificatorio es:"
    lang S, cont "ENCUENTROS!"

    lang S, para "¿Con cuántos"
    lang S, line "#MON"
	lang S, cont "#salvajes has?"
    lang S, cont "combatido?"

    lang S, para "Te sorpenderá"
    lang S, line "¡incluso a ti!"

    lang S, para "La ed. de julio"
    lang S, line "estará disponible"
    lang S, cont "el 26 de junio,"
    lang S, cont "tras finalizar"
    lang S, cont "los ajustes del"
    lang S, cont "CENTRO MÓVIL."

    lang S, para "Si conoces #MON"
    lang S, line "#desde hace"
    lang S, cont "tiempo. ¡creo"
    lang S, cont "que te esperan"
    lang S, cont "buenas noticias!"

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
