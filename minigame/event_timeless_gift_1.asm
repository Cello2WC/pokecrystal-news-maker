; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
;
; See: https://web.archive.org/web/20080208123820/http://www.geocities.co.jp/Playtown-Darts/9915/serebi.htm
; Thanks to nohm for providing their first-hand account of this minigame!
;
; Re-creation script written by Cello2WC
; English localization by DS
; German localization by Lesserkuma
; French localization by ISSOtm
; Italian localization by svp
; Spanish localization TODO

; Janken variant

IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wChiekosChoice  EQUS "wNewsScratch0"
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

	nsc_textbox 1, 14, .maizieIntroText
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
	lang D, para "nuschel nuschel"
	lang D, line "KURTs Enkelin"
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

	lang S, text "MILLIE: algo"
	lang S, line "algo de AZALEA"
	lang S, para "algo alg-"
	lang S, line "algo de CÉSAR"
	lang S, cont "nieta"
	lang S, para "algo alg-"
	lang S, line "viajar el tiempo"

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
;	news_box 0,  1, 20, 14, NEWSBORDER_BLOCKY, 4
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	;news_box 4,  4, 12,  8, NEWSBORDER_BLOCKY,   3
	news_def_strings
	news_string 0, 0, "@" ; at least one string must be specified, else game crashes
	news_menu 6, 6,   1, 3,   0, 2,   -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01

	news_buttonscript .aButton    ; script pointer a button
	news_buttonscript .bButton    ; script pointer b button
	news_buttonscript             ; script pointer select button
	news_buttonscript .aButton    ; script pointer start button
	news_buttonscript             ; script pointer right button
	news_buttonscript             ; script pointer left button
	news_buttonscript .upButton   ; script pointer up button
	news_buttonscript .downButton ; script pointer down button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable

	news_menuitem_names   .menuRockText,   .menuPaperText,   .menuScissorsText
	news_menuitem_scripts .menuRockScript, .menuPaperScript, .menuScissorsScript
	news_menuitem_descs   .menuDummyDesc,  .menuDummyDesc,   .menuDummyDesc

.bButton
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.aButton
	nsc_playsound SFX_READ_TEXT
	nsc_clear 1,  4, 17,  8
;	nsc_clear 1, 13, 18,  4
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}

.retry
	; CHIE's choice
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wChiekosChoice, 1
	nsc_flagop wChiekosChoice, FLAG_CLEAR, 2
	nsc_flagop wChiekosChoice, FLAG_CLEAR, 3
	nsc_flagop wChiekosChoice, FLAG_CLEAR, 4
	nsc_flagop wChiekosChoice, FLAG_CLEAR, 5
	nsc_flagop wChiekosChoice, FLAG_CLEAR, 6
	nsc_flagop wChiekosChoice, FLAG_CLEAR, 7 ; wChiekosChoice &= %00000011
	nsc_compare wChiekosChoice, .continue, .retry, .retry, 1, 3 ; retry if generated a 3
.continue
	nsc_clear 1, 13, 18, 4
	nsc_drawtrainer 6, 4, COOLTRAINERF, 7
	nsc_printstring 1, 14, .textChieDeclare
	nsc_waitbutton
	nsc_select
	nsc_ret

.upButton
	nsc_up
	nsc_ret

.downButton
	nsc_down
	nsc_ret


.menuRockText
	lang J, db "グー"
	lang E, db "ROCK"
	lang D, db "STEIN"
	lang F, db "PIERRE"
	lang I, db "SASSO"
	lang S, db "PIEDRA"
	db "@"

.menuPaperText
	lang J, db "パー"
	lang E, db "PAPER"
	lang D, db "PAPIER"
	lang F, db "PAPIER" ; Sentez-vous libre de débattre sur "FEUILLE" à la place :)
	lang I, db "CARTA"
	lang S, db "PAPEL"
	db "@"

.menuScissorsText
	lang J, db "チョキ"
	lang E, db "SCISSORS"
	lang D, db "SCHERE"
	lang F, db "CISEAUX"
	lang I, db "FORBICI"
	lang S, db "TIJERAS"
.menuDummyDesc
	db "@"


.textChieDeclare
	nts_start
	nts_switch wChiekosChoice, .textChieRock, .textChiePaper, .textChieScissors
	nts_end
	done

.textChieRock
	lang J, db "チエコ『グー"
	lang E, db "MAIZIE: ROCK"
	lang D, db "MAISY: STEIN"
	lang F, db "LILA: PIERRE"
	lang I, db "MAISY: SASSO"
	lang S, db "MILLIE: PIEDRA"
	db "@"

.textChiePaper
	lang J, db "チエコ『パー"
	lang E, db "MAIZIE: PAPER"
	lang D, db "MAISY: PAPIER"
	lang F, db "LILA: PAPIER" ; Même remarque que pour le joueur.
	lang I, db "MAISY: CARTA"
	lang S, db "MILLIE: PAPEL"
	db "@"

.textChieScissors
	lang J, db "チエコ『チョキ"
	lang E, db "MAIZIE: SCISSORS"
	lang D, db "MAISY: SCHERE"
	lang F, db "LILA: CISEAUX"
	lang I, db "MAISY: FORBICI"
	lang S, db "MILLIE: TIJERAS"
	db "@"

.menuRockScript
	nsc_compare wChiekosChoice, .jankenTie, .jankenLose, .jankenWin, 1, 1

.menuPaperScript
	nsc_compare wChiekosChoice, .jankenWin, .jankenTie, .jankenLose, 1, 1

.menuScissorsScript
	nsc_compare wChiekosChoice, .jankenLose, .jankenWin, .jankenTie, 1, 1

.jankenTie
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenTieText
	nsc_waitbutton
	nsc_page LuckTest
	nsc_ret
.jankenTieText
	; TODO: PLACEHOLDER TEXT
	lang J, text "チエコ『ひきわけ"
	lang E, text "MAIZIE: We tied…"
	lang D, text "MAISY: Unent-"
	lang D, line "schieden…"
	lang F, text "LILA: Egalité..."
	lang I, text "MAISY: Siamo pari…"
	lang S, text "MILLIE: Empate..."
	done

.jankenLose
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenLoseText
	nsc_waitbutton
	nsc_page NewsRoot
	nsc_ret
.jankenLoseText
	; TODO: PLACEHOLDER TEXT
	lang J, text "チエコ『あたしの　かち"
	lang E, text "MAIZIE: I win!"
	lang D, text "MAISY: Ich"
	lang D, line "gewinne!"
	lang F, text "LILA: J'ai gagné!"
	lang I, text "MAISY: Ho vinto!"
	lang S, text "MILLIE: ¡Yo gano!"
	done

.jankenWin
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .jankenWinText
	nsc_waitbutton
	nsc_page PokemonQuiz
	nsc_ret
.jankenWinText
	; TODO: PLACEHOLDER TEXT
	lang J, text "チエコ『あなたの　かち"
	lang E, text "MAIZIE: You win!"
	lang D, text "MAISY: Du"
	lang D, line "gewinnst!"
	lang F, text "LILA: Tu as gagné!"
	lang I, text "MAISY: Hai vinto!"
	lang S, text "MILLIE: ¡TÚ GANAS!"
	done

	news_screen PokemonQuiz, MUSIC_GAME_CORNER

	news_def_pals

	news_def_boxes
;	news_box 0,  0, 20, 15, NEWSBORDER_BLOCKY, 1
;	news_box 0, 14, 20,  4, NEWSBORDER_BLOCKY, 5
	news_box 0, 14, 20,  4, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wQuizQuestionNo, \
		.question1Text, \
		.question2Text, \
		.question3Text, \
		.question4Text, \
		.question5Text
	nts_end

	news_menu  2, 16, 3, 1, 5, 2, -1, $00, $00, $00, 0, $04

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

	quiz_answers 1,    1, 1, 1, 0, 0
	quiz_answers 2,    0, 0, 0, 1, 1


.menuItemQuitScript
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret

.dummyDescription
	db "@"

.question1Text
	lang J, db   "ポケモンはしたし　いがいのひとでも"
	lang J, next "まもった りすけたり　してくれる？"

	lang E, db   "Can #MON help"
	lang E, next "and protect people"
	lang E, next "other than their"
	lang E, next "<TRAINER>S?"

	lang D, db   "Können #MON"
	lang D, next "auch Leuten, die"
	lang D, next "nicht ihr <TRAINER>"
	lang D, next "sind, helfen?"

	lang F, db   "Les #MON"
	lang F, next "peuvent-ils"
	lang F, next "protéger d'autres"
	lang F, next "gens que leurs"
	lang F, next "<TRAINER>S?"

	lang I, db   "I #MON possono"
	lang I, next "aiutare e pro-"	
	lang I, next "teggere persone"
	lang I, next "che non sono i"
	lang I, next "loro ALLENATORI?"

	lang S, db   "¿Los #MON"
	lang S, next "protegen personas" 
	lang S, next "distintas de sus"
	lang S, next "<TRAINER>ES?"

	next "@"

.question2Text
	lang J, db   "にんげんを　こわがる"
	lang J, next "ポケモンがいれば"
	lang J, next "それはにんげんのせい？"

	lang E, db   "If #MON are"
	lang E, next "afraid of humans,"
	lang E, next "is that the fault"
	lang E, next "of humans?"

	lang D, db   "Wenn #MON Angst"
	lang D, next "vor Menschen"
	lang D, next "haben, sind dann"
	lang D, next "Menschen daran"
	lang D, next "schuld?"

	lang F, db   "Si des #MON ont"
	lang F, next "peur des humains,"
	lang F, next "est-ce la faute"
	lang F, next "des humains?"

	lang I, db   "Se i #MON hanno"
	lang I, next "paura degli umani,"
	lang I, next "la colpa è degli"
	lang I, next "umani?"

	lang S, db   "Los #MON temen"
	lang S, next "a los humanos,"
	lang S, next "¿es eso culpa"
	lang S, next "de los humanos?"
	
	next "@"

.question3Text
	lang J, db   "ポケモンをすきなひとが"
	lang J, next "ポケモントレーナー　いがいに"
	lang J, next "めざすものはある？"

	lang E, db   "Can people who"
	lang E, next "love #MON be"
	lang E, next "something aside"
	lang E, next "from a #MON"
	lang E, next "<TRAINER>?"

	lang D, db   "Können Menschen,"
	lang D, next "die #MON mögen,"
	lang D, next "noch etwas anderes"
	lang D, next "sein, als ein"
	lang D, next "#MON-<TRAINER>?"

	lang F, db   "Quelqu'un qui aime"
	lang F, next "les #MON peut-"
	lang F, next "il être autre"
	lang F, next "chose qu'un"
	lang F, next "<TRAINER> #MON?"

	lang I, db   "Le persone che"
	lang I, next "amano i #MON"
	lang I, next "possono non essere"
	lang I, next "degli ALLENATORI"
	lang I, next "di #MON?"

	lang S, db   "¿Pueden quienes"
	lang S, next "aman los #MON"
	lang S, next "ser algo aparte"
	lang S, next "de <TRAINER> #MON"
	lang S, next "?"
.question4Text
	lang J, db   "こどものトレーナーは"
	lang J, next "やっぱりおとなのトレーナー"
	lang J, next "より　よわい？"

	lang E, db   "Are young <TRAINER>S"
	lang E, next "weaker than adult"
	lang E, next "<TRAINER>S?"

	lang D, db   "Sind junge <TRAINER>"
	lang D, next "schwächer als er-"
	lang D, next "wachsene <TRAINER>?"

	lang F, db   "Les jeunes DRES-"
	lang F, next "SEURS sont-ils"
	lang F, next "plus faibles que"
	lang F, next "les <TRAINER>S"
	lang F, next "adultes?"

	lang I, db   "Gli ALLENATORI più"
	lang I, next "giovani sono più"
	lang I, next "deboli degli ALLE-"
	lang I, next "NATORI adulti?"

	lang S, db   "¿Son los jóvenes"
	lang S, next "<TRAINER>ES"
	lang S, next "más débiles los"
	lang S, next "<TRAINER>ES adultos?"
	
	next "@"

.question5Text
	lang J, db   "むかしからの　いいつたえは"
	lang J, next "すべてウソだとおもう？"

	lang E, db   "Do you think the"
	lang E, next "legends of old"
	lang E, next "are made-up?"

	lang D, db   "Glaubst du, die"
	lang D, next "alten Legenden"
	lang D, next "sind alle frei"
	lang D, next "erfunden?"

	lang F, db   "Penses-tu que les"
	lang F, next "anciennes légendes"
	lang F, next "ne soient que"
	lang F, next "que des histoires?" ; "Véridiques" collerait très bien, mais inverse le sens de la question !!

	lang I, db   "Pensi che le leg-"
	lang I, next "gende antiche"
	lang I, next "siano inventate?"

	lang S, db   "¿Crees que las" 
	lang S, next "antiguas leyendas"
	lang S, next "son falsas?"
	
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

	lang J, news_menu  4, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
	notlang J, news_menu  3, 10, 1, 1, 0, 0, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01

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
IF DEF(_LANG_D)
	nsc_yesno 12, 7, .restartQuiz, .giveUp
ELSE
	nsc_yesno 13, 7, .restartQuiz, .giveUp
ENDC

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
	nsc_compare wQuizScore, .fail, .pass, .pass, 1, 5
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
	;nsc_ramcopy wNewsScratch5, sGSBallFlag, $0001
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1

	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textGiveGift
	nsc_waitbutton
;.done
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
	; we have no record of what maizie might have
	; given to players who had already received
	; the GS Ball via reaching a #1 ranking
	;
	; this re-uses the TM gift given by the may issue
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

	lang D, text "MAISY: ?"

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

	lang F, text "LILA: pouce en"
	lang F, line "l'air"

	lang I, text "MAISY:"
	lang I, line "Quiz superato!"

	lang S, text "MILLIE:"
	lang S, line "prueba superada"
	
	done

.textNotAllCorrect
	lang J, text "？"

	lang E, text "?"

	lang D, text "?"

	lang F, text "?"

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

	lang D, text "?"
	lang D, para ""
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM22."

	lang F, text "?"
	lang F, para ""
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "CT22." ; La moitié du temps c'est traduit avec le pronom, l'autre moiitié sans. x_x

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
	lang S, db   " recibió"
	lang S, line "MT22."
	done

ENDC
