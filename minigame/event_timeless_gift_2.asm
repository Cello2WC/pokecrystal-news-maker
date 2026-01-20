; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
;
; See: https://web.archive.org/web/20080208121021/http://www.geocities.co.jp/Playtown-Darts/9915/serebi5.htm
; Thanks to nohm for providing their first-hand account of this minigame!
;
; Re-creation script written by Cello2WC
; English localization by DS
; German localization by Lesserkuma
; French localization by ISSOtm
; Italian localization by svp
; Spanish localization TODO

; Dice variant

IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wPlayersRoll    EQUS "wNewsScratch0"
DEF wChiekosRoll    EQUS "wNewsScratch1"
DEF wQuizQuestionNo EQUS "wNewsScratch2"
DEF wQuizScore      EQUS "wNewsScratch3"

MACRO minigame_abuttonhook
	nsc_clear 1, 4, 18, 8
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 4, COOLTRAINERF, 7
ENDM

MACRO minigame_start
	; fake page transition

	; this is probably the wrong music
	; but we don't know the right music...
	nsc_playmusic MUSIC_AZALEA_TOWN
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0

	; dumb dumb dumb dumb stupid dumb
	; certain news text script commands arent processed unless
	; you currently have the final menu option highlighted,
	; or the menu option you have highlighted is < wNumListedPlayers
	nsc_set wNumListedPlayers, 16

	nsc_textbox 1, 14, .maizieIntroText
	;nsc_waitbutton
;	nsc_yesno 13, 7, .maiziedone, .maiziequit
;.maiziequit
;	; quit text potentially goes here
;	nsc_playsound SFX_MENU
;	nsc_page NewsRoot
;	nsc_ret
;.maiziedone

.retry
	; player's roll
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wPlayersRoll, 1
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 3
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 4
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 5
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 6
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 7 ; wPlayersRoll &= %00000111
	nsc_compare wPlayersRoll, .continue, .retry, .retry, 1, 6 ; retry if generated a 7 or 8
.continue
	nsc_add wPlayersRoll, 1

	nsc_waitbutton
	nsc_page LuckTest

.maizieIntroText
	; TODO: PLACEHOLDER TEXT
	;       none of maizie's dialogue was preserved...
	lang J, text "チエコ『かくかくしかじか 　ヒワダ"
	lang J, line "タウン　かくかくしかじか　ガンテツ"
	lang J, cont "かくかくしかじか　タイムトラベル"

	lang E, text "MAIZIE: something"
	lang E, line "something AZALEA"
	lang E, para "something some-"
	lang E, line "thing KURT's"
	lang E, cont "granddaughter"
	lang E, para "something some-"
	lang E, line "thing time travel"

	lang D, text "MAISY: nuschel"
	lang D, line "nuschel AZALEA"
	lang D, para "CITY nuschel"
	lang D, line "nuschel KURT"
	lang D, para "nuschel nuschel"
	lang D, line "Zeitreise"

	lang F, text "LILA: bla bla"
	lang F, line "ECORCIA"
	lang F, para "bla bla petite-"
	lang F, line "fille de FARGAS"
	lang F, para "bla bla voyage"
	lang F, line "temporel"

	lang I, text "MAISY: qualcosa"
	lang I, line "qualcosa AZALINA"
	lang I, para "qualcosa qualcosa"
	lang I, line "la nipote di KURT"
	lang I, para "qualcosa qualcosa"
	lang I, line "viaggio nel tempo"

	lang S, text "MILLIE: bla bla"
	lang S, line "bla bla AZALEA"
	lang S, para "bla bla nieta de"
	lang S, line "CÉSAR"
	lang S, cont "bla bla"
	lang S, para "bla bla viaje"
	lang S, line "temporal"
	done
ENDM

MACRO minigame_name
	lang J, db "ときをこえたプレゼント"
	lang E, db "A TIMELESS GIFT"
	lang D, db "ZEITLOSE GABE"
	lang F, db "CADEAU INTEMPOREL"
	lang I, db "DONO SENZA TEMPO"
	lang S, db "REGALO ATEMPORAL"
ENDM

MACRO minigame_desc
	lang J, db   "?"

	lang E, db   "?"

	lang D, db   "?"

	lang F, db   "?"

	lang I, db   "?"

	lang S, db   "?"
ENDM

ELSE
MinigameStart::

	news_screen LuckTest, MUSIC_GAME_CORNER
	news_def_pals
	news_def_boxes
	; first box only required because maizie's sprite shows up
	news_box 0,  1, 20, 14, {NEWS_MAIN_BORDER}
	news_box 0, 14, 20,  4, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 3, ""

	; TODO: PLACEHOLDER TEXT

	lang J, nts_start
	lang J, nts_player_name 0
	lang J, nts_end
	lang J, db "は"
	lang J, nts_start
	lang J, nts_number wPlayersRoll, 1, 2
	lang J, nts_end
	lang J, db   "を　だしました！"
	lang J, next "チエコの　ロール？"

	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " rolled"
	lang E, next "a"
	lang E, nts_start
	lang E, nts_number wPlayersRoll, 1, 2
	lang E, nts_end
	lang E, db   "!"
	lang E, next "MAIZIE will roll…"

	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " würfelt"
	lang D, next "eine"
	lang D, nts_start
	lang D, nts_number wPlayersRoll, 1, 2
	lang D, nts_end
	lang D, db   "!"
	lang D, next "MAISY würfelt…"

	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db "a tiré"
	lang F, next "un"
	lang F, nts_start
	lang F, nts_number wPlayersRoll, 1, 2
	lang F, nts_end
	lang F, db   "!"
	lang F, next "LILA va tirer..."

	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db " tira"
	lang I, next "un"
	lang I, nts_start
	lang I, nts_number wPlayersRoll, 1, 2
	lang I, nts_end
	lang I, db   "!"
	lang I, next "MAISY tirerà..."

	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db "tirado"
	lang S, next "un"
	lang S, nts_start
	lang S, nts_number wPlayersRoll, 1, 2
	lang S, nts_end
	lang S, db   "!"
	lang S, next "MILLIE tirará"
	
	db "@"



	news_menu 2, 16,   2, 1,   8, 0,   -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01

	news_buttonscript .aButton    ; script pointer a button
	news_buttonscript .bButton    ; script pointer b button
	news_buttonscript             ; script pointer select button
	news_buttonscript .aButton    ; script pointer start button
	news_buttonscript .rightButton  ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript ;.upButton   ; script pointer up button
	news_buttonscript ;.downButton ; script pointer down button

	news_def_menuitems
	news_menudescription 1, 14, 1, 1
	news_norankingstable

	news_menuitem_names   .menuHigherText,   .menuLowerText
	news_menuitem_scripts .menuHigherScript, .menuLowerScript
	news_menuitem_descs   .menuDummyDesc,    .menuDummyDesc ;.textYouRolled,    .textYouRolled

.bButton
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.aButton
	nsc_playsound SFX_READ_TEXT




	;nsc_clear 1, 13, 18, 4
	nsc_clear 1, 15, 18, 2
	;nsc_clear 1,  2, 18, 12

;	nsc_delay 20
;	nsc_printstring 1, 9, .textDot
;;	nsc_delay 20
;	nsc_printstring 2, 9, .textDot
;	nsc_delay 20
;	nsc_printstring 3, 9, .textDot

;	nsc_delay 60

.retry2b
	; maizie's roll
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wChiekosRoll, 1
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 3
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 4
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 5
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 6
	nsc_flagop wChiekosRoll, FLAG_CLEAR, 7 ; wPlayersRoll &= %00000111
	nsc_compare wChiekosRoll, .continue2b, .retry2b, .retry2b, 1, 6 ; retry if generated a 7 or 8
.continue2b
	nsc_add wChiekosRoll, 1
	nsc_printstring 1, 11, .textMaizieRolled


	;nsc_printstring 1, 2, .textMaizieRolled
	nsc_waitbutton
;	nsc_clear 1,  2, 17, 10
;	nsc_clear 1, 13, 18,  4
	nsc_clear 1,  2, 18, 10
	;nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_drawtrainer 6, 3, COOLTRAINERF, 7




	nsc_select



	nsc_ret

;.upButton
	;nsc_up
	;nsc_printstring 1, 14, .textYouRolled

.rightButton
	nsc_right
	nsc_ret

;.downButton
	;nsc_down
	;nsc_printstring 1, 14, .textYouRolled
.leftButton
	nsc_left
	nsc_ret


.menuHigherText
	lang J, db "うえ"
	lang E, db "HIGHER"
	lang D, db "HÖHER"
	lang F, db "PLUS"
	lang I, db "PIù ALTO"
	lang S, db "MÁS ALTO"
	db "@"

.menuLowerText
	lang J, db "した"
	lang E, db "LOWER"
	lang D, db "NIEDRIGER"
	lang F, db "MOINS"
	lang I, db "PIù BASSO"
	lang S, db "MÁS BAJO"
.menuDummyDesc
	db "@"

.menuHigherScript
	nsc_compareram wChiekosRoll, 1, wPlayersRoll, .jankenLose, .jankenTie, .jankenWin

.menuLowerScript
	nsc_compareram wChiekosRoll, 1, wPlayersRoll, .jankenWin, .jankenTie, .jankenLose


;.textDot
;	db "<DOT>"
;	db "@"

.textMaizieRolled
	lang J, db "チエコは"
	lang J, nts_start
	lang J, nts_number wChiekosRoll, 1, 2
	lang J, nts_end
	lang J, db   "を だしました！"

	lang E, db   "MAIZIE rolled a"
	lang E, nts_start
	lang E, nts_number wChiekosRoll, 1, 2
	lang E, nts_end
	lang E, db "!"

	lang D, db "MAISY würfelt eine"
	lang D, nts_start
	lang D, nts_number wChiekosRoll, 1, 2
	lang D, nts_end
	lang D, db "!"

	lang F, db "LILA a tiré un"
	lang F, nts_start
	lang F, nts_number wChiekosRoll, 1, 2
	lang F, nts_end
	lang F, db "!"

	lang I, db "MAISY tira un"
	lang I, nts_start
	lang I, nts_number wChiekosRoll, 1, 2
	lang I, nts_end
	lang I, db "!"

	lang S, db "MILLIE obtuvo un"
	lang S, nts_start
	lang S, nts_number wChiekosRoll, 1, 2
	lang S, nts_end
	lang S, db "!"
	
	db "@"




.jankenTie
	;nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenTieText

.retry3
	; player's roll
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wPlayersRoll, 1
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 3
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 4
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 5
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 6
	nsc_flagop wPlayersRoll, FLAG_CLEAR, 7 ; wPlayersRoll &= %00000111
	nsc_compare wPlayersRoll, .continue3, .retry3, .retry3, 1, 6 ; retry if generated a 7 or 8
.continue3
	nsc_add wPlayersRoll, 1



	nsc_waitbutton
	nsc_page LuckTest
	nsc_ret

	; TODO: PLACEHOLDER TEXT
.jankenTieText
	lang J, text "チエコ『ひきわけ"
	lang E, text "MAIZIE: We tied…"
	lang D, text "MAISY: Unent-"
	lang D, line "schieden…"
	lang F, text "LILA: Egalité..."
	lang I, text "MAISY: Siamo pari…"
	lang S, text "MILLIE: Empate..."
	done

.jankenLose
	;nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenLoseText
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret

	; TODO: PLACEHOLDER TEXT
.jankenLoseText
	lang J, text "チエコ『あたしの　かち"
	lang E, text "MAIZIE: I win!"
	lang D, text "MAISY: Ich"
	lang D, line "gewinne!"
	lang F, text "LILA: J'ai gagné!"
	lang I, text "MAISY: Ho vinto!"
	lang S, text "MILLIE: ¡Yo gano!"
	done

.jankenWin
	;nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenWinText
	nsc_waitbutton
	nsc_page PokemonQuiz
	nsc_ret

	; TODO: PLACEHOLDER TEXT
.jankenWinText
	lang J, text "チエコ『あなたの　かち"
	lang E, text "MAIZIE: You win!"
	lang D, text "MAISY: Du"
	lang D, line "gewinnst!"
	lang F, text "LILA: Tu as gagné!"
	lang I, text "MAISY: Hai vinto!"
	lang S, text "MILLIE: ¡Tú ganas!"
	done

	news_screen PokemonQuiz, MUSIC_GAME_CORNER

	news_def_pals

	news_def_boxes
	;news_box 0,  0, 20, 15, NEWSBORDER_BLOCKY, 1
	;news_box 0, 14, 20,  4, NEWSBORDER_BLOCKY, 5
	news_box 0, 14, 20,  4, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wQuizQuestionNo, \
		.question1Text, \
		.question2Text, \
		.question3Text, \
		.question4Text, \
		.question5Text, \
		.question6Text, \
		.question7Text, \
		.question8Text
	nts_end

	news_menu  2, 16, 3, 1, 5, 2, -1, 0, 0, 0, 0, $04

	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .bButton ; script pointer b button
	news_buttonscript ; script pointer select button
	news_buttonscript .bButton ; script pointer start button
	news_buttonscript .rightButton ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript ; script pointer up button
	news_buttonscript ; script pointer down button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable

	news_menuitem_names   .menuItemYesText,   .menuItemNoText,   .menuItemQuitText
	news_menuitem_scripts .menuItemAnswer1Script, .menuItemAnswer2Script, .menuItemQuitScript
	news_menuitem_descs   .dummyDescription,  .dummyDescription, .dummyDescription

.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret

.rightButton
	nsc_right
	nsc_ret

.leftButton
	nsc_left
	nsc_ret

.bButton
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.menuItemYesText
	lang J, db "はい"
	lang E, db "YES"
	lang D, db "JA"
	lang F, db "OUI"
	lang I, db "Sì"
	lang S, db "SI"
	db "@"

.menuItemNoText
	lang J, db "いいえ"
	lang E, db "NO"
	lang D, db "NEIN"
	lang F, db "NON"
	lang I, db "NO"
	lang S, db "NO"
	db "@"

.menuItemQuitText
	lang J, db "やめる"
	lang E, db "QUIT"
	lang D, db "ZUR."
	lang F, db "RET"
	lang I, db "ESCI"
	lang S, db "SALIR"
	db "@"



MACRO quiz_answers
DEF _ANSWER_NUMBER = \1
.menuItemAnswer\1Script
DEF _QUESTION_NUMBER = 1
	nsc_add wQuizQuestionNo, 1
REPT _NARG - 1
	nsc_compare wQuizQuestionNo, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, 1, {_QUESTION_NUMBER}

.answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}
IF \2 != 0
	nsc_add wQuizScore, \2;1
ENDC
SHIFT
IF _NARG == 1
	nsc_page QuizScoreEvaluation
ELSE
	nsc_page PokemonQuiz
ENDC
	nsc_ret

.answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}
DEF _QUESTION_NUMBER = _QUESTION_NUMBER + 1
ENDR
	nsc_ret
ENDM

	quiz_answers 1,    1, 1, 1, 0, 0, 0, 0, 0
	quiz_answers 2,    0, 0, 0, 1, 1, 1, 1, 1


.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.dummyDescription
	db "@"

.question1Text
	lang J, db   "コガネのちかつうろでしょうばいを"
	lang J, next "しているひとはぜんぶで４にん？"

	lang E, db   "Are there a total"
	lang E, next "of four people"
	lang E, next "doing business"
	lang E, next "in the GOLDENROD"
	lang E, next "UNDERGROUND?"

	lang D, db   "Gibt es im UNTER-"
	lang D, next "GRUND von DUKATIA"
	lang D, next "CITY genau vier"
	lang D, next "Geschäftsleute?"

	lang F, db   "Y a-t-il quatre"
	lang F, next "commerçants dans"
	lang F, next "le SOUTERRAIN de"
	lang F, next "DOUBLONVILLE?"

	lang I, db   "Ci sono in tutto"
	lang I, next "in tutto quattro"
	lang I, next "commercianti nel"
	lang I, next "SOTTERRANEO di"
	lang I, next "FIORDOROPOLI?"

	lang S, db   "¿Hay un total"
	lang S, next "de cuatro personas"
	lang S, next "haciendo negocios"
	lang S, next "en el SUBTERRÁNEO?"
	lang S, next "de TRÍGAL?"

	next "@"

.question2Text
	lang J, db   "ラジオばんぐみ　アオイのあいことばに"
	lang J, next "イトマルというあいことばはある？"

	lang E, db   "Is SPINARAK one"
	lang E, next "of the passwords"
	lang E, next "in the radio show"
	lang E, next "BUENA'S PASSWORD?"

	lang D, db   "Ist WEBARAK eines"
	lang D, next "der Passwörter in"
	lang D, next "BUENAs PASSWORT-"
	lang D, next "SENDUNG?"

	lang F, db   "MIMIGAL fait-il"
	lang F, next "partie des mots de"
	lang F, next "passe de l'émission" ; "l'" is one character!
	lang F, next "du MOT DE PASSE"
	lang F, next "de BUENA?"

	lang I, db   "SPINARAK è una"
	lang I, next "delle password"
	lang I, next "che appare nel"
	lang I, next "PASSWORD SHOW di"
	lang I, next "BUENA alla radio?"

	lang S, db   "¿Es SPINARAK una"
	lang S, next "de las contraseñas"
	lang S, next "del programa radio"
	lang S, next "CONTRASEÑAS BUENA?"
	
	next "@"

.question3Text
	lang J, db   "しぜんこうえんに　はなが"
	lang J, next "さいているところはある？"

	lang E, db   "Are there any"
	lang E, next "flowers in bloom"
	lang E, next "at the NATIONAL"
	lang E, next "PARK?"

	lang D, db   "Gibt es im"
	lang D, next "NATIONALPARK"
	lang D, next "blühende Blumen?"

	lang F, db   "Des fleurs ont-"
	lang F, next "elles fleuri au"
	lang F, next "PARC NATIONAL?"

	lang I, db   "Ci sono dei fiori"
	lang I, next "già sbocciati nel"
	lang I, next "PARCO NAZIONALE?

	lang S, db   "¿Hay alguna"
	lang S, next "flor en plena"
	lang S, next "floración en el"
	lang S, next "PARQUE NACIONAL?"
	
	next "@"

.question4Text
	lang J, db   "アサギの　とうだいで　アカリチャンが"
	lang J, next "いるのはとうだいの５かい？"

	lang E, db   "Is AMPHY found on"
	lang E, next "OLIVINE LIGHTHOUSE"
	lang E, next "5F?" ; Caution: floor numbering scheme is different in Europe! https://en.wikipedia.org/wiki/Storey#Numbering

	lang D, db   "Befand sich AMPHI"
	lang D, next "im 5. Obergeschoss"
	lang D, next "des LEUCHTTURMs"
	lang D, next "von OLIVIANA CITY?"

	lang F, db   "Trouve-t-on PHARY"
	lang F, next "au 4ème étage du"
	lang F, next "PHARE d'OLIVILLE?"

	lang I, db   "AMPHY si trova al"
	lang I, next "4° piano del"
	lang I, next "FARO OLIVINOPOLI?"

	lang S, db   "¿Está AMPHY en"
	lang S, next "el FARO de"
	lang S, next "CIUDAD OLIVO"
	lang S, next "en el 5º piso?"
.question5Text
	lang J, db   "いかりまんじゅうのねだんは４００円"

	lang E, db   "Is the price of"
	lang E, next "a RAGECANDYBAR"
	lang E, next "¥400?"

	lang D, db   "Kostet ein WUTKEKS"
	lang D, next "¥400?"

	lang F, db   "Un BONBON RAGE"
	lang F, next "coûte-t-il 400¥?"

	lang I, db   "Una IRAMELLA costa"
	lang I, next "¥400?"

	lang S, db   "¿Es el precio de"
	lang S, next "un CARAM. FURIA"
	lang S, next "es de 400¥?"
	
	next "@"

.question6Text
	lang J, db   "ロケットだんのアジトの　パスワードは"
	lang J, next "ヤドンのしっぽ　と　オタチのしっぽ？"

	lang E, db   "Are SLOWPOKETAIL"
	lang E, next "and SENTRETTAIL"
	lang E, next "the passwords"
	lang E, next "used to access the"
	lang E, next "boss's room in the"
	lang E, next "ROCKET HIDEOUT?"

	lang D, db   "Sind FLEGMONRUTE"
	lang D, next "und WIESORRUTE die"
	lang D, next "Passwörter für das"
	lang D, next "Büro vom Boss im"
	lang D, next "ROCKET-VERSTECK?"

	lang F, db   "Les mots de passe"
	lang F, next "pour accéder à la"
	lang F, next "salle du chef dans"
	lang F, next "le REPAIRE ROCKET"
	lang F, next "sont-ils"
	lang F, next "QUEUERAMOLOS et"
	lang F, next "QUEUE FOUINETTE?"

	lang I, db   "Le password per la"
	lang I, next "stanza del capo"
	lang I, next "nel COVO TEAM"
	lang I, next "ROCKET sono"
	lang I, next "CODASLOWPOKE e"
	lang I, next "CODASENTRET?"

	lang S, db   "¿Son COLASLOWPOKE"
	lang S, next "y COLASENTRET"
	lang S, next "las contraseñas"
	lang S, next "utilizadsa acceder"
	lang S, next "a la sala del jefe"
	lang S, next "GUARIDA ROCKET?"
	
	next "@"

.question7Text
	lang J, db   "たきのぼりをしたのちは"
	lang J, next "うしろをむいている？"

	lang E, db   "Do you face"
	lang E, next "backwards after"
	lang E, next "using WATERFALL?"

	lang D, db   "Richtet sich dein"
	lang D, next "Blick nach dem"
	lang D, next "Einsatz von KAS-"
	lang D, next "KADE nach unten?"

	lang F, db   "Es-tu tourné vers"
	lang F, next "l'arrière après"
	lang F, next "avoir utilisé"
	lang F, next "CASCADE?"

	lang I, db   "Dopo aver usato"
	lang I, next "CASCATA finisci"
	lang I, next "guardando all'"
	lang I, next "indietro?

	lang S, db   "¿Te encuentras"
	lang S, next "del revés"
	lang S, next "tras usar CASCADA?"
	
	next "@"

.question8Text
	lang J, db   "ポケモンを４たいくりだしてくる"
	lang J, next "ジムリーダーはマツバだけ？"

	lang E, db   "Is MORTY the only"
	lang E, next "GYM LEADER to use"
	lang E, next "four #MON?"

	lang D, db   "Ist JENS der ein-"
	lang D, next "zige ARENALEITER,"
	lang D, next "der vier #MON"
	lang D, next "einsetzt?"

	lang F, db   "MORTIMER est-il"
	lang F, next "le seul CHAMPION"
	lang F, next "d'ARENE à utiliser"
	lang F, next "quatre #MON?"

	lang I, db   "ANGELO è l'unico"
	lang I, next "CAPOPALESTRA che"
	lang I, next "usa quattro"
	lang I, next "#MON?"

	lang S, db   "¿Es MORTI el único"
	lang S, next "LÍDER de GIMNASIO"
	lang S, next "con cuatro #MON?"
	
	next "@"

	; this is probably the wrong music
	; but we don't know the right music...
	news_screen QuizScoreEvaluation, MUSIC_AZALEA_TOWN

	news_def_pals

	news_def_boxes
	news_box  0,  1, 20, 12, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}


	news_def_strings
	news_string 0, 0, "@" ; at least one string must be specified, else game crashes

	lang    J, news_menu  6, 10, 1, 1, 0, 0, -1, 0, 0, 0, SHOW_DESCRIPTIONS, $01
	notlang J, news_menu  3, 10, 1, 1, 0, 0, -1, 0, 0, 0, SHOW_DESCRIPTIONS, $01

	news_buttonscript .aButton ; script pointer a button
	news_buttonscript .aButton ; script pointer b button
	news_buttonscript          ; script pointer select button
	news_buttonscript .aButton ; script pointer start button
	news_buttonscript          ; script pointer right button
	news_buttonscript          ; script pointer left button
	news_buttonscript          ; script pointer up button
	news_buttonscript          ; script pointer down button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable

	news_menuitem_names   .menuItemText ; pointers to text for each menu item
	news_menuitem_scripts .menuItemScript ; pointers to script for each menu item
	news_menuitem_descs   .menuItemDescription ; pointers to description text for each menu item

.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 2, COOLTRAINERF, 7
	nsc_select
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textNotAllCorrect
	nsc_yesno 13, 7, .restartQuiz, .giveUp
;	nsc_page NewsRoot
;	nsc_ret

.restartQuiz
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textTryAgain
	nsc_waitbutton
	nsc_set wQuizQuestionNo, 0
	nsc_set wQuizScore, 0
	nsc_page PokemonQuiz

.giveUp
	nsc_page NewsRoot
	nsc_ret

.menuItemText
	lang J, db "チエコのひょうか"
	lang E, db "MAIZIE's RATING"
	lang D, db "MAISYs BEWERTUNG"
	lang F, db "EVALUATION de LILA"
	lang I, db "VALUTAZ. di MAISY"
	lang S, db "NOTA DE MILLIE"
	db "@"

.menuItemScript
	nsc_textbox 1, 14, .textScoreIntro
	nsc_compare wQuizScore, .fail, .pass, .pass, 1, 8
.fail
	nsc_textbox 1, 14, .textFail
	nsc_playsound SFX_DEX_FANFARE_LESS_THAN_20
	nsc_ret
.pass
	nsc_textbox 1, 14, .textPass
	nsc_playsound SFX_DEX_FANFARE_230_PLUS
	nsc_waitbutton

	nsc_compare sGSBallFlag, .noGSBall, .gift, .noGSBall, 1,    0
.gift
	nsc_set wNewsScratch5, 1
	;nsc_ramcopy wNewsScratch5, sGSBallFlag, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1

	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveGift
	nsc_waitbutton

	;nsc_clear 1, 13, 18, 4
	;nsc_textbox 1, 14, .textFarewell
	;nsc_waitbutton

	nsc_page NewsRoot
	nsc_ret

.noGSBall
	nsc_compare_newsvar sMinigameFlag, .done, .TMgift, .done, 1, 0
.TMgift
	nsc_waitbutton
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveTMGift
	nsc_giveitem TM_SOLARBEAM, .gotGift, .noGift
.gotGift
	nsc_playsound SFX_GET_TM
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
.noGift
	nsc_waitbutton
.done
	nsc_page NewsRoot
	nsc_ret


.menuItemDescription
	lang J, db   "？"

	lang E, db   "?"

	lang D, db   "?"

	lang F, db   "?"

	lang I, db   "?"

	lang S, db   "?"
	
	db "@"

.textScoreIntro
	lang J, text "チエコ『？"

	lang E, text "MAIZIE: ?"

	lang D, text "?"

	lang F, text "LILA: ?"

	lang I, text "MAISY: ?"

	lang S, text "MILLIE: ¿?"

	para "<……>　<……>　<……>"
	para ""
	done
.textFail
	; TODO: PLACEHOLDER TEXT
	lang J, text "チエコ『すべる"

	lang E, text "MAIZIE:"
	lang E, line "quiz failed text"

	lang D, text "MAISY: Du hast"
	lang D, line "nicht bestanden."

	lang F, text "LILA: c'est non"

	lang I, text "MAISY:"
	lang I, line "Quiz fallito."

	lang S, text "MILLIE:"
	lang S, line "prueba fallida"

	done


.textPass
	; TODO: PLACEHOLDER TEXT
	lang J, text "チエコ『ごうかく"

	lang E, text "MAIZIE:"
	lang E, line "quiz passed text"

	lang D, text "MAISY: Du hast"
	lang D, line "bestanden!"

	lang F, text "?"

	lang I, text "MAISY:"	
	lang I, text "Quiz superato!"

	lang S, text "MILLIE:"
	lang S, line "prueba superada"
	
	done

.textNotAllCorrect
	lang J, text "？"

	lang E, text "?"

	lang D, text "?"

	lang F, text "LILA: pouce en"
	lang F, line "l'air"

	lang I, text "?"

	lang S, text "?"
	
	done

.textTryAgain
	lang J, text "チエコ『？"
	lang E, text "MAIZIE: ?"
	lang D, text "MAISY: Versuche es"
	lang D, line "noch einmal!"
	lang F, text "LILA: Essaye"
	lang F, line "encore!"
	lang I, text "MAISY: Riprova!"
	lang S, text "MILLIE: ¿?"
	done

.textGiveGift
	lang J, text "？"

	lang E, text "?"

	lang D, text "?"

	lang F, text "?"

	lang I, text "?"

	lang S, text "?"
	
	done

.textGiveTMGift
	lang J, text "？"
	lang J, para "わざマシン２２を　もらった！"

	lang E, text "?"
	lang E, para ""
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM22."

	lang F, text "?"
	lang F, para ""
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "CT22." ; La moitié du temps c'est traduit avec le pronom, l'autre moiitié sans. x_x

	lang F, text "?"

	lang I, text "?"
	lang I, para ""
	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db   " riceve"
	lang I, line "MT22."

	lang S, text "?"
	lang S, para ""
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "MT22."
	
	done

ENDC
