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
	
	lang J, db "ポケモンニュース　10";"ポケモンニュース"
	lang E, db "#MON NEWS No.10";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 10";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.10";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº10";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º10"


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, db "ポケモンニュース　10";"ポケモンニュース"
	lang E, db "#MON NEWS No.10";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 10";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.10";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº10";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º10"
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
    lang J, text "ポケモンニュース　１０がつごうです！"
    lang J, line "モバイル　たいせん　では　みんな"
    lang J, cont "いろいろな　トレーナーに　なるけど"
    lang J, cont "あなたは　ほんとうは　どんなタイプ？"
    lang J, cont "「トレーナー　しんだん！」で"
    lang J, cont "さっそく　しらべて　みよう！"


    lang J, para "あたらしい　ランキングの　テーマは"
    lang J, line "ポケモンが　しんかした　かいすう！"
    lang J, cont "バトルタワーや　コロシアムで"
    lang J, cont "たいせんする　ために　ポケモンを"
    lang J, cont "たくさん　そだてている　あなた！"
    lang J, cont "きっと　ランクイン　できますよ！"


    lang J, para "つぎのニュースは　１０がつ　３０にち"
    lang J, line "モバイルセンターの　ちょうせいが"
    lang J, cont "おわれば　よめるように　なります！"
    lang J, cont "あの　ジムリーダーが　あなたに"
    lang J, cont "ちょうせん！　え？　だれかって？"
    lang J, cont "それは　らいげつごうの　おたのしみ！"

    lang E, text "It's the October"
    lang E, line "issue of the"
    lang E, cont "#MON NEWS!"

    lang E, para "In mobile battles,"
    lang E, line "everyone becomes"
    lang E, cont "all kinds of"
    lang E, cont "TRAINERS, but"
    lang E, cont "what type are you"
    lang E, cont "really?"

    lang E, para "In <TRAINER>"
    lang E, line "CHECKUP! you'll"
    lang E, cont "find out!"

    lang E, para "The new ranking"
    lang E, line "theme is:"
    lang E, cont "#MON EVOLVED"

    lang E, para "By raising lots of"
    lang E, line "#MON for the"
    lang E, cont "BATTLE TOWER and"
    lang E, cont "COLOSSEUM, surely"
    lang E, cont "you'll make it"
    lang E, cont "into the rankings!"

    lang E, para "The next issue"
    lang E, line "of #MON NEWS"
    lang E, cont "will be available"
    lang E, cont "on October 30th,"
    lang E, cont "after MOBILE"
    lang E, cont "CENTER adjustments"
    lang E, cont "end."

    lang E, para "A GYM LEADER"
    lang E, line "challenges you!"

    lang E, para "Who is it?"

    lang E, para "You'll find out in"
    lang E, line "the next issue!"

    lang F, text "Voici l'édition"
    lang F, line "d'octobre des"
    lang F, cont "INFOS #MON!"

    lang F, para "Lors des combats"
    lang F, line "mobiles on devient"
    lang F, cont "un DRESSEUR"
    lang F, cont "différent, mais"
    lang F, cont "lequel êtes-vous"
    lang F, cont "vraiment?"

    lang F, para "Découvrez-le grâce"
    lang F, cont "au BILAN <TRAINER>!"

    lang F, para "La thème du pro-"
    lang F, line "chain classement:"
    lang F, cont "#MON EVOLUES!"

    lang F, para "En entrainant des"
    lang F, line "tas de #MON à"
    lang F, cont "la TOUR de COMBAT"
    lang F, cont "et au COLISEE vous"
    lang F, cont "allez surement"
    lang F, cont "figurer dans le"
    lang F, cont "classement!"

    lang F, para "L'édition suivante"
    lang F, line "sera disponible le"
    lang F, cont "30 octobre, après"
    lang F, cont "les réparations du"
    lang F, cont "CENTRE MOBILE."

    lang F, para "Un CHAMPION d'ARENE"
    lang F, line "vous défie!"

    lang F, para "Mais qui donc?"

    lang F, para "Vous le découvri-"
    lang F, line "rez dans l'édition"
    lang F, cont "suivante!"

    lang D, text "Die Oktober-"
    lang D, line "Ausgabe der"
    lang D, cont "PKMN-NACHRICHTEN"
    lang D, cont "ist da!"

    lang D, para "In mobilen Kämpfen"
    lang D, line "kann man jede Art"
    lang D, cont "von TRAINER sein."
    lang D, cont "Aber welcher Typ"
    lang D, cont "passt wirklich"
    lang D, cont "zu dir?"

    lang D, para "Im <TRAINER>-"
    lang D, line "CHECK-UP wirst"
    lang D, cont "du es heraus-"
    lang D, cont "finden!"

    lang D, para "Das neue Thema"
    lang D, line "der Rangliste ist:"
    lang D, cont "ENTWICKELTE PKMN"

    lang D, para "Wer #MON für"
    lang D, line "den KAMPFTURM und"
    lang D, cont "das KOLOSSEUM auf-"
    lang D, cont "zieht, kommt mit"
    lang D, cont "Sicherheit in die"
    lang D, cont "Rangliste!"

    lang D, para "Die nächste"
    lang D, line "PKMN-NACHRICHTEN-"
    lang D, cont "Ausgabe erscheint"
    lang D, cont "am 30. Oktober -"
    lang D, cont "nach Abschluss"
    lang D, cont "der Anpassungen"
    lang D, cont "des MOBILEN"
    lang D, cont "CENTERs."

    lang D, para "Ein ARENALEITER"
    lang D, line "wird dich heraus-"
    lang D, cont "fordern!"

    lang D, para "Wer könnte das"
    lang D, line "sein?"

    lang D, para "In der nächsten"
    lang D, line "Ausgabe wirst du"
    lang D, cont "schlauer!"

    lang D, para "Bleib dran!"

    lang I, text "È l'edizione di"
    lang I, line "Ottobre delle"
    lang I, cont "NOTIZIE #MON!"

    lang I, para "Nelle lotte"
    lang I, line "mobile, tutti"
    lang I, cont "quanti diventano"
    lang I, cont "tanti tipi di"
    lang I, cont "ALLENATORE"
    lang I, cont "diversi, ma che"
    lang I, cont "tipo sei tu?"

    lang I, para "Nel CHECKUP"
    lang I, line "ALLENATORE lo"
    lang I, cont "scoprirai!"

    lang I, para "Il tema della"
    lang I, line "nuova classifica"
    lang I, cont "è: #MON"
    lang I, cont "EVOLUTI!"

    lang I, para "Se fai crescere"
    lang I, line "molti #MON per"
    lang I, cont "la TORRE LOTTA e"
    lang I, cont "il COLOSSEO, di"
    lang I, cont "sicuro finirai in"
    lang I, cont "classifica!"

    lang I, para "La prossima"
    lang I, line "edizione delle"
    lang I, cont "NOTIZIE #MON"
    lang I, cont "sarà disponibile"
    lang I, cont "il 30 Ottobre,"
    lang I, cont "dopo che la"
    lang I, cont "manutenzione del"
    lang I, cont "CENTRO MOBILE sarà"
    lang I, cont "terminata."

    lang I, para "Un CAPOPALESTRA"
    lang I, line "ti sfida!"

    lang I, para "Chi sarà mai?"

    lang I, para "Lo scoprirai nella"
    lang I, line "prossima edizione!"

    lang S, text "¡Es la edición"
    lang S, line "de octubre de"
    lang S, cont "NOTICIAS #MON!"

    lang S, para "En combates"
    lang S, line "móviles todos son"
    lang S, cont "cualquier tipo de"
    lang S, cont "ENTRENADOR"
    lang S, cont "¿que tipo"
    lang S, cont "eres tú?"

    lang S, para "En la EVALUACIÓN"
    lang S, line "de <TRAINER>!"
    lang S, cont "¡Lo descubrirás!"

    lang S, para "El nuevo tema"
    lang S, line "clasificatorio es:"
    lang S, cont "EVOLUCIONADOS"

    lang S, para "Alzando muchos"
    lang S, line "#MON por la"
    lang S, cont "TORRE BATALLA y"
    lang S, cont "COLISEO, seguro"
    lang S, cont "que entrarás"
    lang S, cont "en la clasific.!"

    lang S, para "La siguiente"
    lang S, line "NOTICIAS #MON"
    lang S, cont "saldrá el"
    lang S, cont "30 de octubre,"
    lang S, cont "tras finalizar"
    lang S, cont "los ajustes del"
    lang S, cont "CENTRO MÓVIL."

    lang S, para "¡UN LÍDER de"
    lang S, line "GIMNASIO te reta!"

    lang S, para "¿Quién será?"

    lang S, para "Lo descubrirás en"
    lang S, line "¡la próxima!"

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
