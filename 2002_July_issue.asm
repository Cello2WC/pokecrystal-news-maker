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
	
	lang J, db "ポケモンニュース　７";"ポケモンニュース"
	lang E, db "#MON NEWS No.7";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 7";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.7";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº7";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º7"


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
	lang E, db "#MON NEWS No.7";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 7";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.7";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº7";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º7"
	db "@"

	;news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, $02, $04
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
    lang J, text "ポケモンニュース"
    lang J, line "７がつごうです！"
    lang J, cont "ごぞんじ　オーキドはかせの　まご"
    lang J, cont "トキワシティの　グリーンが"
    lang J, cont "あなたに　ポケモンクイズで"
    lang J, cont "ちょうせん　します！"


    lang J, para "グリーンの　だす　クイズは"
    lang J, line "３ねんも　まえの　はなし…"
    lang J, cont "レッドと　グリーンの　ぼうけん"
    lang J, cont "どのくらい　おもいだせる　かな？"
    lang J, cont "むかしの　ポケモンを　しらないひとは"
    lang J, cont "おともだちに　たすけて　もらってね！"


    lang J, para "トレーナーランキングは"
    lang J, line "あなたが　これまでに　つかまえた"
    lang J, cont "ポケモンの　かずが"
    lang J, cont "テーマに　くわわりました！"
    lang J, cont "きっと　びっくりするくらい　たくさん"
    lang J, cont "つかまえた　ひとも　いるのでは？"


    lang J, para "ポケモンニュース　８がつごうは"
    lang J, line "７がつ　３１にち　モバイルセンターの"
    lang J, cont "ちょうせいが　おわった　あと"
    lang J, cont "よめるように　なります！"
    lang J, cont "きおくりょくに　じしんのある"
    lang J, cont "あなたの　でばん！　おたのしみに！"

    lang E, text "Here it is!"

    lang E, para "It's the July"
    lang E, line "issue of the"
    lang E, cont "#MON NEWS!"

    lang E, para "Remember PROF."
    lang E, line "OAK's grandson,"
    lang E, cont "BLUE of VIRIDIAN"
    lang E, cont "CITY?"

    lang E, para "He challenges you"
    lang E, line "to a #MON QUIZ!"

    lang E, para "BLUE's quiz is"
    lang E, line "about a story from"
    lang E, cont "three years ago…"

    lang E, para "RED and BLUE's"
    lang E, line "adventure."

    lang E, para "How much can you"
    lang E, line "remember?"

    lang E, para "If you don't know"
    lang E, line "#MON from the"
    lang E, cont "old days, ask your"
    lang E, cont "friends for help!"

    lang E, para "The new ranking"
    lang E, line "theme is:"
    lang E, cont "#MON CAUGHT!"

    lang E, para "I bet some people"
    lang E, line "have caught so"
    lang E, cont "many it'll"
    lang E, cont "surprise you!"

    lang E, para "The August issue"
    lang E, line "of #MON NEWS"
    lang E, cont "will be available"
    lang E, cont "on July 31st,"
    lang E, cont "after MOBILE"
    lang E, cont "CENTER adjustments"
    lang E, cont "end."

    lang E, para "Confident in"
    lang E, line "your memory?"

    lang E, para "Now's your chance!"

    lang E, para "Stay tuned!"

    lang F, text "Là voilà!"

    lang F, para "L'édition de"
    lang F, line "juillet des"
    lang F, cont "INFOS #MON!"

    lang F, para "Vous vous souvenez"
    lang F, line "du petit-fils du-"
    lang F, cont "PROF.CHEN, BLUE,"
    lang F, cont "de JADIELLE?"

    lang F, para "Il vous invite à"
    lang F, line "se frotter à son"
    lang F, cont "questionnaire!"

    lang F, para "Le questionnaire"
    lang F, line "de BLUE concerne"
    lang F, cont "cette histoire d'il"
    lang F, cont "y a trois ans..."

    lang F, para "Les aventures de"
    lang F, line "RED et BLUE."

    lang F, para "De quoi vous"
    lang F, line "souvenez-vous?"

    lang F, para "Si vous ne savez"
    lang F, line "rien sur les vieux"
    lang F, cont "#MON, demandez"
    lang F, cont "de l'aide à un ami!"

    lang F, para "La thème du pro-"
    lang F, line "chain classement:"
    lang F, cont "#MON ATTRAPES!"

    lang F, para "Je parie que"
    lang F, line "certains en ont"
    lang F, cont "attrapé tellement"
    lang F, cont "que ça vous"
    lang F, cont "surprendra!"

    lang F, para "L'édition d'août"
    lang F, line "sera disponible le"
    lang F, cont "31 juillet, après"
    lang F, cont "la fin des"
    lang F, cont "réparations du"
    lang F, cont "CENTRE MOBILE."

    lang F, para "Vous avez foi en"
    lang F, line "votre mémoire?"

    lang F, para "C'est le moment ou"
    lang F, line "jamais!"

    lang F, para "Restez branché!"

    lang D, text "Schwuppdiwupp!"
  
    lang D, para "Hier ist die"
    lang D, line "Juli-Ausgabe der"
    lang D, cont "PKMN-NACHRICHTEN!"

    lang D, para "Erinnerst du dich"
    lang D, line "an PROF. EICHs"
    lang D, cont "Enkel, BLAU, aus"
    lang D, cont "VERTANIA CITY?"

    lang D, para "Er fordert dich zu"
    lang D, line "einem #MON-"
    lang D, cont "QUIZ heraus!"

    lang D, para "BLAUs Quiz handelt"
    lang D, line "von einer"
    lang D, cont "Geschichte von vor"
    lang D, cont "drei Jahren…"

    lang D, para "Das Abenteuer von"
    lang D, line "ROT und BLAU."

    lang D, para "An welche Details"
    lang D, line "kannst du dich"
    lang D, cont "noch erinnern?"

    lang D, para "Falls du #MON"
    lang D, line "aus früheren"
    lang D, cont "Zeiten nicht"
    lang D, cont "kennst, bitte"
    lang D, cont "deine Freunde"
    lang D, cont "um Hilfe!"

    lang D, para "Das neue Thema"
    lang D, line "der Rangliste:"
    lang D, cont "GEFANGENE #MON!"

    lang D, para "Manche haben be-"
    lang D, line "stimmt so viele"
    lang D, cont "gefangen, dass man"
    lang D, cont "es kaum für"
    lang D, cont "möglich hält!"

    lang D, para "Die August-"
    lang D, line "Ausgabe der"
    lang D, cont "PKMN-NACHRICHTEN"
    lang D, cont "trifft am 31."
    lang D, cont "Juli ein - nach"
    lang D, cont "Abschluss der"
    lang D, cont "Anpassungen des"
    lang D, cont "MOBILEN CENTERs."

    lang D, para "Du kannst dich auf"
    lang D, line "dein Gedächtnis"
    lang D, cont "verlassen?"

    lang D, para "Stelle es unter"
    lang D, line "Beweis!"

    lang D, para "Bleib dran!"

    lang I, text "Eccola quì!"

    lang I, para "È l'edizione di"
    lang I, line "Luglio delle"
    lang I, cont "NOTIZIE #MON!"

    lang I, para "Ricordi il nipote"
    lang I, line "del PROF. OAK,"
    lang I, cont "BLU di"
    lang I, cont "SMERALDOPOLI?"

    lang I, para "Vuole sfidarti ad"
    lang I, line "un QUIZ #MON!"

    lang I, para "Il quiz di BLU è"
    lang I, line "a proposito di una"
    lang I, cont "storia di tre anni"
    lang I, cont "fa..."

    lang I, para "La avventura di"
    lang I, line "ROSSO e BLU."

    lang I, para "Quanto te ne"
    lang I, line "ricordi?"

    lang I, para "Se non conosci"
    lang I, line "#MON dai"
    lang I, cont "tempi passati,"
    lang I, cont "chiedi aiuto ai"
    lang I, cont "tuoi amici!"

    lang I, para "Il tema della"
    lang I, line "nuova classifica"
    lang I, cont "è: #MON"
    lang I, cont "CATTURATI!"

    lang I, para "Scommetto che"
    lang I, line "alcune persone ne"
    lang I, cont "hanno catturati"
    lang I, cont "così tanti da"
    lang I, cont "sorprenderti!"

    lang I, para "L'edizione di"
    lang I, line "Agosto delle"
    lang I, cont "NOTIZIE #MON"
    lang I, cont "sarà disponibile"
    lang I, cont "il 31 Luglio,"
    lang I, cont "dopo che la"
    lang I, cont "manutenzione del"
    lang I, cont "CENTRO MOBILE"
    lang I, cont "sarà terminata."

    lang I, para "Ti fidi della tua"
    lang I, line "memoria?"
    lang I, cont "Ora è la tua"
    lang I, cont "occasione!"

    lang I, para "Restate in"
    lang I, line "ascolto!"

    lang S, text "¡Ha llegado!"

    lang S, para "¡Es la edición"
    lang S, line "de julio de"
    lang S, cont "NOTICIAS #MON!"

    lang S, para "¿Recuerdas a"
    lang S, line "AZUL? Nieto"
    lang S, cont "del PROF. OAK"
    lang S, cont "CIUDAD VERDE."

    lang S, para "Te desafía"
    lang S, line "al Acertijo #MON!"

    lang S, para "El test de AZUL"
    lang S, line "es sobre hace"
    lang S, cont "unos tres años…"

    lang S, para "La aventura de"
    lang S, line "ROJO y AZUL."

    lang S, para "¿Cuánto podrás"
    lang S, line "recordar?"

    lang S, para "Si no conoces"
    lang S, line "#MON desde hace"
    lang S, cont "tiempo. ¡busca"
    lang S, cont "ayuda de amigos!"

    lang S, para "El nuevo tema"
    lang S, line "clasificatorio es:"
    lang S, cont "CAPTURADOS"

    lang S, para "¡Estoy seguro de"
    lang S, line "que habrá gente"
    lang S, cont "que atrapan tanto"
    lang S, cont "que sorprenderá!"

    lang S, para "La ed. de agosto"
    lang S, line "de NOTICIAS #MON"
    lang S, cont "estará disponible"
    lang S, cont "el 31 de julio,"
    lang S, cont "tras finalizar"
    lang S, cont "los ajustes del"
    lang S, cont "CENTRO MÓVIL."

    lang S, para "¿Confías en"
    lang S, line "tu memoria?"

    lang S, para "¡Es tu ocasión!"

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
