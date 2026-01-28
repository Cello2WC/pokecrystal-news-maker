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
	
	lang J, db "ポケモンニュース　9";"ポケモンニュース"
	lang E, db "#MON NEWS No.9";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 9";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.9";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº9";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º9"


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, db "ポケモンニュース　9";"ポケモンニュース"
	lang E, db "#MON NEWS No.9";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 9";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.9";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº9";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º9"
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
    lang J, text "ポケモンニュース　９がつごうです！"
    lang J, line "あたらしい　ランキングの　テーマは"
    lang J, cont "とった　きのみの　かず　です！"
    lang J, cont "みのなるきが　あっても　すどおり"
    lang J, cont "していませんか…？　どんどん"
    lang J, cont "きのみや　ぼんぐりを　とりましょう！"


    lang J, para "ポケモン　れんそうクイズ！　は"
    lang J, line "３つの　ヒントに　あてはまる"
    lang J, cont "ポケモンを　あてる　クイズです！"
    lang J, cont "このポケモンは　このタイプだ！"
    lang J, cont "…なんて　おもいこんでいた　ひとは"
    lang J, cont "いがいな　ところで　ひっかかるかも？"


    lang J, para "つぎの　ニュースは　９がつ　２５にち"
    lang J, line "モバイルセンターの　ちょうせいが"
    lang J, cont "おわれば　よめるように　なります！"
    lang J, cont "あなたは　どんな　トレーナーなのか…"
    lang J, cont "わかってしまうかも　しれません！"
    lang J, cont "おたのしみに！"

    lang E, text "It's the September"
    lang E, line "issue of the"
    lang E, cont "#MON NEWS!"

    lang E, para "The new ranking"
    lang E, line "theme is:"
    lang E, cont "FRUIT PICKED!"

    lang E, para "Do you just pass"
    lang E, line "by fruit-bearing"
    lang E, cont "trees?"

    lang E, para "Make sure to pick"
    lang E, line "lots of BERRIES"
    lang E, cont "and APRICORNS!"

    lang E, para "#MON WORD QUIZ"
    lang E, line "is a quiz where"
    lang E, cont "you guess the"
    lang E, cont "#MON with three"
    lang E, cont "hints!"

    lang E, para "If you find"
    lang E, line "yourself thinking"
    lang E, cont "“This #MON is"
    lang E, cont "that type!”"

    lang E, para "Watch out!"

    lang E, para "You could be"
    lang E, line "tripped up where"
    lang E, cont "you least expect!"

    lang E, para "The next issue"
    lang E, line "of #MON NEWS"
    lang E, cont "will be available"
    lang E, cont "on September 25th,"
    lang E, cont "after MOBILE"
    lang E, cont "CENTER adjustments"
    lang E, cont "end."

    lang E, para "What type of"
    lang E, line "TRAINER are you?"

    lang E, para "You might find"
    lang E, line "out!"

    lang E, para "Stay tuned!"

    lang F, text "Voici l'édition"
    lang F, line "de septembre des"
    lang F, cont "INFOS #MON!"

    lang F, para "La thème du pro-"
    lang F, line "chain classement:"
    lang F, cont "FRUITS RAMASSES!"

    lang F, para "Vous ignorez les"
    lang F, line "arbustes à fruits"
    lang F, cont "sur votre chemin?"

    lang F, para "Pensez à ramasser"
    lang F, line "pleins de BAIES et"
    lang F, cont "de NOIGRUMES!"

    lang F, para "DEVINE LE #MON!"
    lang F, line "Le quiz où vous"
    lang F, cont "devez deviner le"
    lang F, cont "#MON avec trois"
    lang F, cont "indices!"

    lang F, para "Si vous pensez,"
    lang F, cont "“Ce #MON est de"
    lang F, cont "ce type!”"

    lang F, para "Faites attention!"

    lang F, para "Vous pourriez vous"
    lang F, line "tromper là où vous"
    lang F, cont "vous y attendez le"
    lang F, cont "moins!"

    lang F, para "L'édition suivante"
    lang F, line "sera disponible le"
    lang F, cont "25 septembre,"
    lang F, cont "après la fin des"
    lang F, cont "réparations du"
    lang F, cont "CENTRE MOBILE."

    lang F, para "What type of"
    lang F, line "TRAINER are you?"

    lang F, para "Vous pourriez le"
    lang F, line "découvrir!"

    lang F, para "Restez branché!"

    lang D, text "Die September-"
    lang D, line "Ausgabe der"
    lang D, cont "PKMN-NACHRICHTEN"
    lang D, cont "ist da!"

    lang D, para "Das neue Thema"
    lang D, line "der Rangliste ist:"
    lang D, cont "GEPFLÜCKTES OBST!"

    lang D, para "Bist du an Obst-"
    lang D, line "bäumen vorbei-"
    lang D, cont "gekommen?"

    lang D, para "All die BEEREN und"
    lang D, line "APRIKOKOS warten"
    lang D, cont "nur darauf, ge-"
    lang D, cont "pflückt zu werden!"

    lang D, para "Das #MON-WORT-"
    lang D, line "QUIZ ist ein"
    lang D, cont "Fragespiel, bei"
    lang D, cont "dem du anhand von"
    lang D, cont "drei Hinweisen ein"
    lang D, cont "#MON erraten"
    lang D, cont "musst!"

    lang D, para "Wenn du plötzlich"
    lang D, line "denkst “Dieses"
    lang D, cont "#MON passt zu"
    lang D, cont "diesem Typ!”"

    lang D, para "Pass auf!"

    lang D, para "Du könntest jeder-"
    lang D, line "zeit auf die"
    lang D, cont "falsche Fährte"
    lang D, cont "gelockt werden!"

    lang D, para "Am 25. September"
    lang D, line "erwartet dich die"
    lang D, cont "nächste Ausgabe"
    lang D, cont "der PKMN-"
    lang D, cont "NACHRICHTEN - nach"
    lang D, cont "Abschluss der"
    lang D, cont "Anpassungen des"
    lang D, cont "MOBILEN CENTERs."

    lang D, para "Welche Art von"
    lang D, line "TRAINER bist du?"

    lang D, para "Du könntest es"
    lang D, line "herausfinden!"

    lang D, para "Bleib dran!"

    lang I, text "È l'edizione di"
    lang I, line "Settembre delle"
    lang I, cont "NOTIZIE #MON!"

    lang I, para "Il tema della"
    lang I, line "nuova classifica"
    lang I, cont "è: FRUTTI"
    lang I, cont "RACCOLTI!"

    lang I, para "Passi solo accanto"
    lang I, line "agli alberi da"
    lang I, cont "frutta?"

    lang I, para "Assicurati di"
    lang I, line "raccogliere tante"
    lang I, cont "BACCHE e"
    lang I, cont "GHICOCCHE!"

    lang I, para "Il #MON WORD"
    lang I, line "QUIZ è un quiz"
    lang I, cont "dove cerchi di"
    lang I, cont "indovinare il"
    lang I, cont "#MON con tre"
    lang I, cont "indizi!"

    lang I, para "Se ti ritrovi a"
    lang I, line "pensare “Questo"
    lang I, cont "#MON è di"
    lang I, cont "quel tipo!"
    lang I, cont "Attenzione!"
    lang I, cont "Potresti sbagliare"
    lang I, cont "quando meno te lo"
    lang I, cont "aspetti!"

    lang I, para "La prossima"
    lang I, line "edizione delle"
    lang I, cont "NOTIZIE #MON"
    lang I, cont "sarà disponibile"
    lang I, cont "il 25 Settembre,"
    lang I, cont "dopo che la manu-"
    lang I, cont "tenzione del"
    lang I, cont "CENTRO MOBILE sarà"
    lang I, cont "terminata."

    lang I, para "Che tipo di"
    lang I, line "ALLENATORE sei?"

    lang I, para "Potresti"
    lang I, line "scoprirlo!"

    lang I, para "Restate in"
    lang I, line "ascolto!"

    lang S, text "¡Es la edición"
    lang S, line "de septiembre de"
    lang S, cont "NOTICIAS #MON!"

    lang S, para "El nuevo tema"
    lang S, line "clasificatorio es:"
    lang S, cont "FRUTA RECOGIDA!"

    lang S, para "¿Pasas de largo"
    lang S, line "de los árboles"
    lang S, cont "con bayas?"

    lang S, para "¡Procura recoger"
    lang S, line "muchas BAYAS"
    lang S, cont "y BONGURIS!"

    lang S, para "¡Acertijo #MON"
    lang S, line "es un test donde"
    lang S, cont "tienes que"
    lang S, cont "adivinar el #MON"
    lang S, cont "con tres pistas!"

    lang S, para "Si dudas"
    lang S, line "del tipo del"
    lang S, cont "“#MON en"
    lang S, cont "cuestión…”"

    lang S, para "¡Cuidado!"

    lang S, para "¡Podrías fallar"
    lang S, line "donde menos"
    lang S, cont "te lo esperas!"

    lang S, para "La siguiente"
    lang S, line "NOTICIAS #MON"
    lang S, cont "saldrá el"
    lang S, cont "25 de septiembre,"
    lang S, cont "tras finalizar"
    lang S, cont "los ajustes del"
    lang S, cont "CENTRO MÓVIL."

    lang S, para "¿Qué tipo de"
    lang S, line "ENTRENADOR eres?"

    lang S, para "¡Quizás descubras"
    lang S, line "algo nuevo!"

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
