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
	
	lang J, db "ポケモンニュース　12";"ポケモンニュース"
	lang E, db "#MON NEWS No.12";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 12";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.12";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº12";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º12"


SECTION "News", ROM0[$0000]

	news_begin
	news_screen NewsRoot, MUSIC_PROF_ELM

	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, "";"<TRAINER> RANKING@"
	lang J, db "ポケモンニュース　12";"ポケモンニュース"
	lang E, db "#MON NEWS No.12";"#MON NEWS No.0"
	lang D, db "NACHRICHTEN Nr. 12";"NACHRICHTEN Nr. 0"
	lang F, db "INFOS PKMN No.12";"INFOS PKMN No.0"
	lang I, db "NOTIZIE PKMN Nº12";"NOTIZIE PKMN Nº0"
	lang S, db "NOTICIA PKMN N.º12"
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
    lang J, text "ポケモンニュース　１２がつごう"
    lang J, line "さいごの　ポケモンニュース　です！"
    lang J, cont "いままで　どうも　ありがとう！"
    lang J, cont "この　ニュースを　よんで　くれた"
    lang J, cont "みんなに　とっておきの　じょうほうを"
    lang J, cont "プレゼント　します！"


    lang J, para "ニンテンドウ　ホームページの　なかの"
    lang J, line "モバイルシステムの　ページを"
    lang J, cont "いますぐ　みてみよう！　スイクンの"
    lang J, cont "バナーを　みつけたら　クリック！"
    lang J, cont "あとは　みての　おたのしみ…！"
    lang J, cont "あいことばは　モバイル　ですよ！"


    lang J, para "ポケモンニュース　バトルタワー"
    lang J, line "モバイルスタジアム　そして"
    lang J, cont "トレードコーナー　での　ひきとりは"
    lang J, cont "１４にちで　おしまいに　なります！"
    lang J, cont "ごりよう　ありがとう　ございました！"
    lang J, cont "ともだちとモバイルで　たのしんでね！"

    lang E, text "#MON NEWS,"
    lang E, line "December issue."

    lang E, para "This is the final"
    lang E, line "#MON NEWS!"

    lang E, para "Thank you for"
    lang E, line "everything so far!"

    lang E, para "For everyone who"
    lang E, line "read this NEWS,"
    lang E, cont "we're giving you"
    lang E, cont "special info as"
    lang E, cont "a gift!"

    lang E, para "Go to the Mobile"
    lang E, line "System page on the"
    lang E, cont "Nintendo homepage."

    lang E, para "Find and click"
    lang E, line "SUICUNE's banner!"

    lang E, para "After that, it's"
    lang E, line "for you to see…!"

    lang E, para "The password is"
    lang E, line "“MOBILE”!"

    lang E, para "#MON NEWS,"
    lang E, line "BATTLE TOWER,"
    lang E, cont "MOBILE STADIUM"
    lang E, cont "and TRADE CORNER"
    lang E, cont "pickups will end"
    lang E, cont "on the 14th!"

    lang E, para "Thank you for"
    lang E, line "using the service!"

    lang E, para "Have fun on MOBILE"
    lang E, line "with your friends!"

	
    lang F, text "Voici l'édition de"
    lang F, line "décembre."

    lang F, para "Le dernier numéro"
    lang F, line "des INFOS #MON!"

    lang F, para "Merci pour tout!"

    lang F, para "Pour tous ceux qui"
    lang F, line "lisent ces INFOS,"
    lang F, cont "on vous confie un"
    lang F, cont "scoop rien que"
    lang F, cont "pour vous!"

    lang F, para "Allez sur le site"
    lang F, line "web officiel de"
    lang F, cont "Nintendo, sur la"
    lang F, cont "page dédiée au"
    lang F, cont "Système Mobile."

    lang F, para "Cliquez sur la"
    lang F, line "bannière SUICUNE."

    lang F, para "Et ensuite? C'est"
    lang F, line "un secret...!"

    lang F, para "Le mot de passe"
    lang F, line "c'est “MOBILE”!"

    lang F, para "Les INFOS #MON,"
    lang F, line "la TOUR de COMBAT,"
    lang F, cont "le STADE MOBILE,"
    lang F, cont "et les admissions"
    lang F, cont "au COIN TROC prend"
    lang F, cont "-rons fin le 14!"

    lang F, para "Merci d'avoir uti-"
    lang F, line "lisé nos services!"

    lang F, para "Amusez-vous sur"
    lang F, line "MOBILE avec vos"
    lang F, cont "amis!"
	
    lang D, text "Die allerletzte"
    lang D, line "Ausgabe der"
    lang D, cont "PKMN-NACHRICHTEN,"
    lang D, cont "die Dezember-"
    lang D, cont "Ausgabe, ist da!"

    lang D, para "Danke für alles"
    lang D, line "bis hierhin!"

    lang D, para "Alle, die diese"
    lang D, line "NACHRICHTEN lesen,"
    lang D, cont "erhalten als"
    lang D, cont "Geschenk eine"
    lang D, cont "besondere Geheim-"
    lang D, cont "Information!"

    lang D, para "Begib dich auf der"
    lang D, line "Nintendo-Homepage"
    lang D, cont "auf die Seite des"
    lang D, cont "Mobilen Systems."

    lang D, para "Klicke auf den"
    lang D, line "SUICUNE-Banner!"

    lang D, para "Finde heraus, was"
    lang D, line "dich dort"
    lang D, cont "erwartet…!"

    lang D, para "Das Passwort ist:"
    lang D, line "“MOBILE”!"

    lang D, para "PKMN-NACHRICHTEN,"
    lang D, line "KAMPFTURM, MOBILES"
    lang D, cont "STADION und"
    lang D, cont "Abholungen an der"
    lang D, cont "TAUSCHECKE enden"
    lang D, cont "am 14. Dezember!"

    lang D, para "Danke, dass du den"
    lang D, line "Dienst genutzt"
    lang D, cont "hast!"

    lang D, para "Hab weiterhin viel"
    lang D, line "MOBIL-Spaß mit"
    lang D, cont "deinen Freunden!"
	
    lang I, text "NOTIZIE #MON,"
    lang I, line "edizione di"
    lang I, cont "Dicembre."

    lang I, para "Questa è la fine"
    lang I, line "delle NOTIZIE"
    lang I, cont "#MON!"

    lang I, para "Grazie di cuore"
    lang I, line "per tutto!"

    lang I, para "Per tutti coloro"
    lang I, line "che leggono queste"
    lang I, cont "NOTIZIE, stiamo"
    lang I, cont "per darvi delle"
    lang I, cont "informazioni"
    lang I, cont "speciali come"
    lang I, cont "regalo!"

    lang I, para "Andate sulla"
    lang I, line "pagina del Mobile"
    lang I, cont "System sul sito di"
    lang I, cont "Nintendo."

    lang I, para "Trovate e fate"
    lang I, line "clic sul banner"
    lang I, cont "di SUICUNE!"

    lang I, para "Cosa troverai,"
    lang I, line "sta a te"
    lang I, cont "scoprirlo…"

    lang I, para "La password è:"
    lang I, line "“MOBILE”!"

    lang I, para "Le NOTIZIE"
    lang I, line "#MON, la TORRE"
    lang I, cont "LOTTA, lo STADIO"
    lang I, cont "MOBILE e le"
    lang I, cont "raccolte del"
    lang I, cont "CENTRO SCAMBI"
    lang I, cont "termineranno il"
    lang I, cont "giorno 14!"

    lang I, para "Grazie per aver"
    lang I, line "usato il servizio!"

    lang I, para "Divertiti con i"
    lang I, line "tuoi amici sul"
    lang I, cont "MOBILE!"
	
    lang S, text "Ed. de diciembre,"
    lang S, line "de NOTICIAS"
	lang S, cont "#MON."

    lang S, para "La última edición"
    lang S, line "de NOTICIAS"
	lang S, cont "#MON!"

    lang S, para "¡Gracias por"
    lang S, line "el tiempo juntos!"

    lang S, para "Para quienes leen"
    lang S, line "estas NOTICIAS,"
    lang S, cont "les ofrecemos"
    lang S, cont "¡info. especial"
    lang S, cont "de regalo!"

    lang S, para "Ve a la página de"
    lang S, line "Mobile System de"
    lang S, cont "Nintendo."

    lang S, para "¡Clica en el"
    lang S, line "cartel SUICUNE!"

    lang S, para "¡Después de eso"
    lang S, line "verás una cosa!"

    lang S, para "¡La clave es"
    lang S, line "“MOBILE”!"

    lang S, para "¡Las entregas de"
    lang S, line "NOTICIAS #MON,"
    lang S, cont "TORRE BATALLA,"
    lang S, cont "ESTADIO MÓVIL"
    lang S, cont "y el CENTRO DE"
    lang S, cont "CAMBIO acaban el"
    lang S, cont "día 14!"

    lang S, para "¡Gracias por"
    lang S, line "usar el servicio!"

    lang S, para "Diviértete con tus"
    lang S, line "amigos en MÓVIL!"

	
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
	lang S, line "menù, per favore."
	
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
