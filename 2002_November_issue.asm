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
	
	lang J, db "ポケモンニュース　11";"ポケモンニュース"
	lang E, db "#MON NEWS No.11";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 11";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.11";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº11";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º11"


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, db "ポケモンニュース　11";"ポケモンニュース"
	lang E, db "#MON NEWS No.11";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 11";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.11";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº11";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º11"
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
    lang J, text "ポケモンニュース　１１がつごうです！"
    lang J, line "トレードコーナーからの　おしらせ！"
    lang J, cont "こうかん　したい　ポケモンは"
    lang J, cont "１１がつまつ　まで　あずけられます！"
    lang J, cont "ひきとりは　１２がつ１４にちまで！"
    lang J, cont "いそいで　こうかん　しにいこう！"


    lang J, para "こんげつの　「ポケモンクイズ！」は"
    lang J, line "カントーでの　ぼうけんに　ついて"
    lang J, cont "カツラが　あなたに　ちょうせん！"
    lang J, cont "ふゆが　ちかづいて　いるけど"
    lang J, cont "もえる　おとこ　カツラのクイズで"
    lang J, cont "みんなで　あつくなろう！"


    lang J, para "ポケモンニュースは　いよいよ"
    lang J, line "あと　１かいで　おしまいです…！"
    lang J, cont "１２がつごうは　１１がつ２７にちから"
    lang J, cont "１２がつ１４にち　まで　よめます！"
    lang J, cont "おとくな　じょうほうが　ありますので"
    lang J, cont "わすれずに　よもう！　おたのしみに！"

    lang E, text "It's the November"
    lang E, line "issue of the"
    lang E, cont "#MON NEWS!"

    lang E, para "A notice from"
    lang E, line "the TRADE CORNER!"

    lang E, para "You can deposit"
    lang E, line "#MON for trade"
    lang E, cont "until the end of"
    lang E, cont "November!"

    lang E, para "Pick them up by"
    lang E, line "December 14th!"

    lang E, para "Hurry and trade!"

    lang E, para "This month's"
    lang E, line "#MON QUIZ is"
    lang E, cont "about your KANTO"
    lang E, cont "adventure!"

    lang E, para "BLAINE challenges"
    lang E, line "you!"

    lang E, para "Winter is near,"
    lang E, line "but BLAINE's quiz"
    lang E, cont "burns hot!"

    lang E, para "Let's heat up"
    lang E, line "together!"

    lang E, para "#MON NEWS is"
    lang E, line "ending in just"
    lang E, cont "one more issue…!"

    lang E, para "The December issue"
    lang E, line "can be read from"
    lang E, cont "November 27th"
    lang E, cont "to December 14th!"

    lang E, para "There's useful"
    lang E, line "information, so"
    lang E, cont "don't forget to"
    lang E, cont "read it!"

    lang E, para "Stay tuned!"


    lang F, text "Voici l'édition"
    lang F, line "de novembre des"
    lang F, cont "INFOS #MON!"

    lang F, para "Un message du"
    lang F, line "COIN TROC!"

    lang F, para "Vous pouvez échan-"
    lang F, line "ger vos #MON"
    lang F, cont "jusqu'à la fin du"
    lang F, cont "mois de novembre."

    lang F, para "Reprenez les avant"
    lang F, line "le 14 décembre!"

    lang F, para "Dépechez-vous"
    lang F, line "d'échanger!"

    lang F, para "Le questionnaire"
    lang F, line "de ce mois-ci à"
    lang F, cont "pour thème votre"
    lang F, cont "aventure à KANTO!"

    lang F, para "AUGUSTE vous met"
    lang F, line "au défi!"

    lang F, para "L'hiver approche,"
    lang F, line "mais AUGUSTE et"
    lang F, cont "son questionnaire"
    lang F, cont "restent bouillant!"

    lang F, para "Réchauffons nous"
    lang F, line "tous ensemble!"

    lang F, para "Les INFOS #MON"
    lang F, line "toucheront à leur"
    lang F, cont "fin dans l'édition"
    lang F, cont "suivante."

    lang F, para "L'édition de"
    lang F, line "décembre peut être"
    lang F, cont "lue du 27 novembre"
    lang F, cont "au 14 décembre!"

    lang F, para "Il y aura des info"
    lang F, line "-rmations utiles"
    lang F, cont "dedans, n'oubliez"
    lang F, cont "de la lire!"

    lang F, para "Restez branché!"

    lang D, text "Hier ist die"
    lang D, line "November-Ausgabe"
    lang D, cont "der PKMN-NACH-"
    lang D, cont "RICHTEN!"

    lang D, para "Eine Nachricht von"
    lang D, line "der TAUSCHECKE!"

    lang D, para "Du kannst noch bis"
    lang D, line "Ende November"
    lang D, cont "#MON zum"
    lang D, cont "Tausch abgeben!"

    lang D, para "Nimm sie bis zum"
    lang D, line "14. Dezember"
    lang D, cont "wieder entgegen!"

    lang D, para "Beeile dich und"
    lang D, line "tausche so viel"
    lang D, cont "du kannst!"

    lang D, para "Das #MON-QUIZ"
    lang D, line "diesen Monat han-"
    lang D, cont "delt von deinem"
    lang D, cont "KANTO-Abenteuer!"

    lang D, para "PYRO fordert"
    lang D, line "dich heraus!"

    lang D, para "Der Winter kehrt"
    lang D, line "ein, aber PYROs"
    lang D, cont "Quiz brennt heiß!"

    lang D, para "Zeit sich aufzu-"
    lang D, line "wärmen!"

    lang D, para "Die nächste Aus-"
    lang D, line "gabe der PKMN-"
    lang D, cont "NACHRICHTEN wird"
    lang D, cont "die letzte sein…!"

    lang D, para "Die Dezember-Aus-"
    lang D, line "gabe kann vom"
    lang D, cont "27. November bis"
    lang D, cont "zum 14. Dezember"
    lang D, cont "gelesen werden!"

    lang D, para "Es erwarten dich"
    lang D, line "einige nützliche"
    lang D, cont "Informationen."
    lang D, cont "Verpasse sie also"
    lang D, cont "nicht!"

    lang D, para "Bleib dran!"

    lang I, text "È l'edizione di"
    lang I, line "Novembre delle"
    lang I, cont "NOTIZIE #MON!"

    lang I, para "Un avviso dal"
    lang I, line "CENTRO SCAMBI!"

    lang I, para "Puoi depositare"
    lang I, line "#MON da"
    lang I, cont "scambiare fino"
    lang I, cont "alla fine di"
    lang I, cont "Novembre!"

    lang I, para "Recuperali entro"
    lang I, line "il 14 Dicembre!"

    lang I, para "Sbrigati a"
    lang I, line "scambiare!"

    lang I, para "Il QUIZ #MON"
    lang I, line "di questo mese"
    lang I, cont "riguarda la tua"
    lang I, cont "avventura a KANTO!"

    lang I, para "BLAINE ti sfida!"

    lang I, para "L'inverno si"
    lang I, line "avvicina, ma il"
    lang I, cont "quiz di BLAINE è"
    lang I, cont "rovente!"

    lang I, para "Scaldiamoci"
    lang I, line "insieme!"

    lang I, para "Le NOTIZIE"
    lang I, line "#MON finiranno"
    lang I, cont "con la prossima"
    lang I, cont "edizione…!"

    lang I, para "L'edizione di"
    lang I, line "Dicembre potrà"
    lang I, cont "essere letta dal"
    lang I, cont "27 Novembre al"
    lang I, cont "14 Dicembre!"

    lang I, para "Ci saranno delle"
    lang I, line "informazioni"
    lang I, cont "utili, quindi non"
    lang I, cont "dimenticatevi di"
    lang I, cont "leggerla!"

    lang I, para "Restate in"
    lang I, line "ascolto!"

    lang S, text "¡Es la edición"
    lang S, line "de noviembre de"
    lang S, cont "NOTICIAS #MON!"

    lang S, para "¡Un aviso del"
    lang S, line "CENTRO DE CAMBIO!"

    lang S, para "¡Puedes depositar"
    lang S, line "#MON para interc."
    lang S, cont "hasta finales de"
    lang S, cont "noviembre!"

    lang S, para "Recógelos antes"
    lang S, line "del 14 de dici.!"

    lang S, para "¡Interca. pronto!"

    lang S, para "El nuevo tema"
    lang S, line "clasificatorio es:"
    lang S, cont "¡tu aventura"
    lang S, cont "en KANTO!"

    lang S, para "¡BLAINE te"
    lang S, line "desafía a tí!"

    lang S, para "El invie. acecha,"
    lang S, line "¡y sus acertijos"
    lang S, cont "arden con fuerza!"

    lang S, para "¡calentémonos"
    lang S, line "juntos!"

    lang S, para "NOTICIAS #MON"
    lang S, line "¡solo tendrá una"
    lang S, cont "edición más…!"

    lang S, para "¡La de diciembre"
    lang S, line "será del 27 de"
    lang S, cont "noviembre al 14"
    lang S, cont "de diciembre!"

    lang S, para "Habrá información"
    lang S, line "útil, ¡así que"
    lang S, cont "no te olvides"
    lang S, cont "de leerla!"

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
