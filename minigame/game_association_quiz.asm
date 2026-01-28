; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
;
; See: https://www2u.biglobe.ne.jp/~kakeru/pokemon2/mobile/news/02_09.htm
; Thanks to nohm for providing their first-hand account of this minigame!
;
; Re-creation script written by Cello2WC
; English localization by DS
; German localization by Lesserkuma
; French localization by ISSOtm
; Italian localization by svp
; Spanish localization by cat.exe

IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wHint1 EQUS "wNewsScratch0"
DEF wHint2 EQUS "wNewsScratch1"
DEF wHint3 EQUS "wNewsScratch2"
DEF wCorrectAnswer EQUS "wNewsScratch3"
DEF wChain EQUS "wNewsScratch4"

MACRO minigame_start
	nsc_set wChain, 0

	nsc_clear 1, 13, 18, 4
	nsc_compare_newsvar sMinigameFlag, .noIntro, .doIntro, .noIntro, 1, 0
.doIntro
	nsc_textbox 1, 14, .gameIntroText
	nsc_waitbutton
.noIntro
	; TODO: this is a bodge...
	nsc_ramcopy hRandomAdd, wHint1, 1
	nsc_flagop wHint1, 3, FLAG_CLEAR
	nsc_flagop wHint1, 4, FLAG_CLEAR
	nsc_flagop wHint1, 5, FLAG_CLEAR
	nsc_flagop wHint1, 6, FLAG_CLEAR
	nsc_flagop wHint1, 7, FLAG_CLEAR

	nsc_compare wHint1, .preset1, .preset2, .presetGreater, 1, 1
.presetGreater
	nsc_compare wHint1, .preset3, .preset4, .presetGreater2, 1, 3
.presetGreater2
	nsc_compare wHint1, .preset5, .preset6, .presetGreater3, 1, 5
.presetGreater3
	nsc_compare wHint1, .preset7, .preset8, .preset8, 1, 7
.preset1
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset1, wHint1, 4
	nsc_set wHint1, 3
	nsc_set wHint2, 0
	nsc_set wHint3, 7
	nsc_set wCorrectAnswer, TAUROS
	nsc_page ChainQuiz
.preset2
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset2, wHint1, 4
	nsc_set wHint1, 1
	nsc_set wHint2, 2
	nsc_set wHint3, 0
	nsc_set wCorrectAnswer, TOTODILE
	nsc_page ChainQuiz
.preset3
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset3, wHint1, 4
	nsc_set wHint1, 0
	nsc_set wHint2, 0
	nsc_set wHint3, 0
	nsc_set wCorrectAnswer, SNEASEL
	nsc_page ChainQuiz
.preset4
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset4, wHint1, 4
	nsc_set wHint1, 2
	nsc_set wHint2, 1
	nsc_set wHint3, 7
	nsc_set wCorrectAnswer, SANDSHREW
	nsc_page ChainQuiz
.preset5
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset5, wHint1, 4
	nsc_set wHint1, 3
	nsc_set wHint2, 4
	nsc_set wHint3, 9
	nsc_set wCorrectAnswer, MAROWAK
	nsc_page ChainQuiz
.preset6
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset6, wHint1, 4
	nsc_set wHint1, 0
	nsc_set wHint2, 5
	nsc_set wHint3, 5
	nsc_set wCorrectAnswer, HYPNO
	nsc_page ChainQuiz
.preset7
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset7, wHint1, 4
	nsc_set wHint1, 0
	nsc_set wHint2, 7
	nsc_set wHint3, 10
	nsc_set wCorrectAnswer, SLOWPOKE
	nsc_page ChainQuiz
.preset8
	;nsc_ramcopy $A000 + ChainQuiz.questionPreset8, wHint1, 4
	nsc_set wHint1, 2
	nsc_set wHint2, 6
	nsc_set wHint3, 11
	nsc_set wCorrectAnswer, FARFETCH_D
	nsc_page ChainQuiz


.gameIntroText
	; Japanese
	lang J, text "がめんの　ひだりがわに"
	lang J, line "３つの　ヒントが　でます"

	lang J, para "ヒントに　あてはまる　ポケモンを"
	lang J, line "がめんの　みぎがわから　えらんで"
	lang J, cont "エーボタンで　こたえて　ください"

	lang J, para "５もん　つづけて　あたれば　クリア！"
	lang J, line "それでは　はじめよう！"

	; English
	lang E, text "Three hints will"
	lang E, line "appear at the top"
	lang E, cont "of the screen."

	lang E, para "Pick the #MON"
	lang E, line "that fits the"
	lang E, cont "hints."

	lang E, para "Choose from the"
	lang E, line "bottom and press A"
	lang E, cont "to answer."

	lang E, para "Get five right in"
	lang E, line "a row to clear"
	lang E, cont "the quiz!"

	lang E, para "Let's get started!"

	; German
	lang D, text "Du erhältst drei"
	lang D, line "Hinweise am oberen"
	lang D, cont "Bildschirmrand."

	lang D, para "Wähle das #MON,"
	lang D, line "das genau zu den"
	lang D, cont "Hinweisen passt."

	lang D, para "Wähle unten deine"
	lang D, line "Antwort und drücke"
	lang D, cont "dann den A-Knopf."

	lang D, para "Um zu gewinnen,"
	lang D, line "musst du fünf Mal"
	lang D, cont "hintereinander"
	lang D, cont "richtig liegen."

	lang D, para "Und los geht's!"

	; French
	lang F, text "Trois indices vont"
	lang F, line "s'afficher en haut"
	lang F, cont "de l'écran."

	lang F, para "Choisis le #MON"
	lang F, line "qui correspond"
	lang F, cont "aux indices."

	lang F, para "Fais ton choix en"
	lang F, line "bas et appuie sur"
	lang F, cont "A pour valider."

	lang F, para "Réussis cinq fois"
	lang F, line "d'affilée pour"
	lang F, cont "gagner le quiz."

	lang F, para "C'est parti!"

	; Italian
	lang I, text "Tre indizi compa-"
	lang I, line "riranno in cima"
	lang I, cont "allo schermo."

	lang I, para "Scegli il #MON"
	lang I, line "che corrisponde"
	lang I, cont "agli indizi."
	
	lang I, para "Scegli in fondo"
	lang I, line "e premi A per"
	lang I, cont "rispondere."
	
	lang I, para "Indovina cinque"
	lang I, line "volte di fila per"
	lang I, cont "vincere il quiz!"

	lang I, para "Cominciamo!"


	; Spanish
	lang S, text "Verás tres pistas"
	lang S, line "arriba"
	lang S, cont "de la pantalla."
	
	lang S, para "Elige el #MON"
	lang S, line "que encaje con"
	lang S, cont "las pistas."
	
	lang S, para "Elige desde abajo" 
	lang S, line "y pulsa A"
	lang S, cont "para responder."	
	
	lang S, para "¡Acierta cinco"
	lang S, line "para superar"
	lang S, cont "el cuestionario!"
	
	lang S, para "¡Empecemos!"
	
	done
ENDM

MACRO minigame_name
	lang J, db "#　れんそうクイズ！"
	lang E, db "#MON WORD QUIZ"
	lang D, db "#MON-WORT-QUIZ"
	lang F, db "DEVINE LE #MON" ; "Guess the Pokémon", since "QUIZ MOT #MON" sounds awkward.
	lang I, db "#MON QUIZ" ; i tried with a thesaurus, it just isn't meant to be
	lang S, db "PALABRA #MON"
ENDM

; deprecating this, at least for now,
; as it seems it might not have existed.

;MACRO minigame_desc
;ENDM

ELSE
MinigameStart::
	news_screen ChainQuiz, MUSIC_GAME_CORNER
	news_def_pals

	news_def_boxes
	;news_box  0,  0, 20, 18, {NEWS_MAIN_BORDER}
;	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	lang    J, news_string 1, 2, ""
	notlang J, news_string 1, 2, ""
	nts_start
	nts_switch wHint1, .textHintA1, .textHintA2, .textHintA3, .textHintA4
	nts_end

	lang    J, news_string 1, 4, ""
	notlang J, news_string 1, 4, ""
	nts_start
	nts_switch wHint2, .textHintB1, .textHintB2, .textHintB3, .textHintB4,\
					   .textHintB5, .textHintB6, .textHintB7, .textHintB8
	nts_end

	lang    J, news_string 1, 6, ""
	notlang J, news_string 1, 6, ""
	nts_start
	nts_switch wHint3, .textHintC01, .textHintC02, .textHintC03, .textHintC04,\
	                   .textHintC05, .textHintC06, .textHintC07, .textHintC08,\
	                   .textHintC09, .textHintC10, .textHintC11, .textHintC12
	nts_end

	lang    J, news_menu 13, 2, 1, 8, 0, 2, 5, 1, 16, 8, 0, 8
	notlang J, news_menu 5, 10, 1, 4, 0, 2, 10, 9, 7, 3, SHOW_ARROWS, 8

	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript .generate_question;.start_button
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4

	news_norankingstable

	news_menuitem_names   .answer1Name,   .answer2Name,   .answer3Name,   .answer4Name,   .answer5Name,   .answer6Name,   .answer7Name,   .answer8Name
	news_menuitem_scripts .answer1Script, .answer2Script, .answer3Script, .answer4Script, .answer5Script, .answer6Script, .answer7Script, .answer8Script
	news_menuitem_descs   .answer1Desc,   .answer2Desc,   .answer3Desc,   .answer4Desc,   .answer5Desc,   .answer6Desc,   .answer7Desc,   .answer8Desc

.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_drawbox 0, 12, 20, 6, {NEWS_TEXT_BORDER}
	nsc_select
	nsc_ret
.up_button
	nsc_up
	nsc_ret
.down_button
	nsc_down
	nsc_ret
.b_button
.start_button
	nsc_playsound SFX_MENU
.menuCancelScript
	nsc_page NewsRoot
	nsc_ret


.chainComplete
	nsc_compare_newsvar sMinigameFlag, .secondPrize, .firstPrize, .secondPrize, 1, 0
.firstPrize
	nsc_textbox 1, 14, .textChainComplete
	nsc_giveitem TM_SLEEP_TALK, .firstPrizeContinue, .firstPrizeDone
.firstPrizeContinue
	nsc_playsound SFX_GET_TM
	nsc_set wNewsScratch5, 1
	nsc_ramcopy_newsvar wNewsScratch5, sMinigameFlag, 1
.firstPrizeDone
	nsc_waitbutton
	nsc_page NewsRoot
.secondPrize
	nsc_textbox 1, 14, .textChainComplete2
	nsc_giveitem HYPER_POTION, .secondPrizeContinue, .secondPrizeDone
.secondPrizeContinue
	nsc_playsound SFX_ITEM
.secondPrizeDone
	nsc_waitbutton
	nsc_page NewsRoot


.answer1Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, TAUROS
.answer2Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, TOTODILE
.answer3Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, SNEASEL
.answer4Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, SANDSHREW
.answer5Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, MAROWAK
.answer6Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, HYPNO
.answer7Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, SLOWPOKE
.answer8Script
	nsc_compare wCorrectAnswer, .fail, .pass, .fail, 1, FARFETCH_D
.fail
	nsc_set wChain, 0

	nsc_playsound SFX_WRONG
	nsc_textbox 1, 14, .textWrongAnswer
	nsc_waitbutton

	nsc_bit wChain, 0, .generate_question, .generate_question

.pass
	nsc_add wChain, 1

	nsc_playsound SFX_LEVEL_UP


	nsc_compare wChain, .nextQuestion, .chainComplete, .chainComplete, 1, 5
.nextQuestion

	nsc_textbox 1, 14, .textRightAnswer
	nsc_waitbutton
	; fall thru



MACRO define_answers
DEF hintA = \1
DEF hintB = \2
SHIFT 2
DEF hintC = 1
REPT 12
DEF ANSWER_{d:hintA}_{d:hintB}_{d:hintC} EQUS "\1"
DEF hintC = hintC + 1
SHIFT
ENDR
ENDM

define_answers 1, 1, SNEASEL, INVALID, SNEASEL, INVALID, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL
define_answers 1, 2, INVALID, HYPNO, SNEASEL, INVALID, SANDSHREW, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 1, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 1, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 1, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 1, 6, INVALID, INVALID, INVALID, INVALID, MAROWAK, HYPNO, HYPNO, MAROWAK, INVALID, INVALID, INVALID, INVALID
define_answers 1, 7, SNEASEL, INVALID, SNEASEL, INVALID, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL, INVALID, SNEASEL
define_answers 1, 8, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID

define_answers 2, 1, SNEASEL, TAUROS, INVALID, INVALID, TAUROS, SNEASEL, INVALID, INVALID, INVALID, INVALID, TAUROS, SNEASEL
define_answers 2, 2, INVALID, HYPNO, SNEASEL, INVALID, SANDSHREW, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 2, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 2, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 2, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 2, 6, INVALID, INVALID, INVALID, INVALID, MAROWAK, HYPNO, HYPNO, MAROWAK, INVALID, INVALID, INVALID, INVALID
define_answers 2, 7, SNEASEL, TAUROS, INVALID, INVALID, TAUROS, SNEASEL, INVALID, INVALID, INVALID, INVALID, TAUROS, SNEASEL
define_answers 2, 8, INVALID, INVALID, INVALID, SANDSHREW, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, INVALID, INVALID

define_answers 3, 1, INVALID, TAUROS, TAUROS, INVALID, TAUROS, INVALID, INVALID, TAUROS, INVALID, TAUROS, TAUROS, INVALID
define_answers 3, 2, SANDSHREW, HYPNO, INVALID, INVALID, SANDSHREW, HYPNO, HYPNO, SANDSHREW, INVALID, INVALID, INVALID, INVALID
define_answers 3, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 3, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 3, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 3, 6, FARFETCH_D, INVALID, INVALID, INVALID, MAROWAK, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 3, 7, FARFETCH_D, TAUROS, TAUROS, FARFETCH_D, TAUROS, FARFETCH_D, INVALID, INVALID, INVALID, INVALID, TAUROS, FARFETCH_D
define_answers 3, 8, INVALID, INVALID, INVALID, INVALID, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, INVALID, INVALID

define_answers 4, 1, INVALID, TAUROS, TAUROS, INVALID, TAUROS, INVALID, INVALID, TAUROS, INVALID, TAUROS, TAUROS, INVALID
define_answers 4, 2, SANDSHREW, HYPNO, INVALID, INVALID, SANDSHREW, HYPNO, HYPNO, SANDSHREW, INVALID, INVALID, INVALID, INVALID
define_answers 4, 3, TOTODILE, SLOWPOKE, INVALID, INVALID, SLOWPOKE, TOTODILE, SLOWPOKE, TOTODILE, TOTODILE, SLOWPOKE, SLOWPOKE, TOTODILE
define_answers 4, 4, INVALID, SLOWPOKE, INVALID, SANDSHREW, INVALID, TOTODILE, SLOWPOKE, INVALID, TOTODILE, INVALID, SLOWPOKE, INVALID
define_answers 4, 5, INVALID, MAROWAK, INVALID, MAROWAK, MAROWAK, INVALID, INVALID, MAROWAK, INVALID, MAROWAK, INVALID, MAROWAK
define_answers 4, 6, FARFETCH_D, INVALID, INVALID, INVALID, MAROWAK, INVALID, HYPNO, INVALID, INVALID, INVALID, INVALID, INVALID
define_answers 4, 7, FARFETCH_D, TAUROS, TAUROS, FARFETCH_D, TAUROS, FARFETCH_D, INVALID, INVALID, INVALID, INVALID, TAUROS, FARFETCH_D
define_answers 4, 8, INVALID, INVALID, INVALID, INVALID, INVALID, INVALID, SLOWPOKE, INVALID, TOTODILE, INVALID, INVALID, INVALID

MACRO answer_check_2
.hintA\1B\2
	nsc_compare wHint3, .answer{ANSWER_\1_\2_1}, .answer{ANSWER_\1_\2_2}, .answer_\1_\2_greater, 1, 1
.answer_\1_\2_greater
	nsc_compare wHint3, .answer{ANSWER_\1_\2_3}, .answer{ANSWER_\1_\2_4}, .answer_\1_\2_greater2, 1, 3
.answer_\1_\2_greater2
	nsc_compare wHint3, .answer{ANSWER_\1_\2_5}, .answer{ANSWER_\1_\2_6}, .answer_\1_\2_greater3, 1, 5
.answer_\1_\2_greater3
	nsc_compare wHint3, .answer{ANSWER_\1_\2_7}, .answer{ANSWER_\1_\2_8}, .answer_\1_\2_greater4, 1, 7
.answer_\1_\2_greater4
	nsc_compare wHint3, .answer{ANSWER_\1_\2_9}, .answer{ANSWER_\1_\2_10}, .answer_\1_\2_greater5, 1, 9
.answer_\1_\2_greater5
	nsc_compare wHint3, .answer{ANSWER_\1_\2_11}, .answer{ANSWER_\1_\2_12}, .answerINVALID, 1, 11
ENDM

MACRO answer_check
.hintA\1
	nsc_compare wHint2, .hintA\1B1, .hintA\1B2, .hintA\1BGreater, 1, 1
.hintA\1BGreater
	nsc_compare wHint2, .hintA\1B3, .hintA\1B4, .hintA\1BGreater2, 1, 3
.hintA\1BGreater2
	nsc_compare wHint2, .hintA\1B5, .hintA\1B6, .hintA\1BGreater3, 1, 5
.hintA\1BGreater3
	nsc_compare wHint2, .hintA\1B7, .hintA\1B8, .hintA\1B8, 1, 7

	answer_check_2 \1, 1
	answer_check_2 \1, 2
	answer_check_2 \1, 3
	answer_check_2 \1, 4
	answer_check_2 \1, 5
	answer_check_2 \1, 6
	answer_check_2 \1, 7
	answer_check_2 \1, 8
ENDM

.answerINVALID
.generate_question

	nsc_ramcopy hRandomAdd, wHint1, 2
	nsc_flagop wHint1, 2, FLAG_CLEAR
	nsc_flagop wHint1, 3, FLAG_CLEAR
	nsc_flagop wHint1, 4, FLAG_CLEAR
	nsc_flagop wHint1, 5, FLAG_CLEAR
	nsc_flagop wHint1, 6, FLAG_CLEAR
	nsc_flagop wHint1, 7, FLAG_CLEAR
	nsc_flagop wHint2, 3, FLAG_CLEAR
	nsc_flagop wHint2, 4, FLAG_CLEAR
	nsc_flagop wHint2, 5, FLAG_CLEAR
	nsc_flagop wHint2, 6, FLAG_CLEAR
	nsc_flagop wHint2, 7, FLAG_CLEAR
	; wait for new RNG rolls
	nsc_delay 1
	nsc_ramcopy hRandomAdd, wHint3, 1
	nsc_flagop wHint3, 4, FLAG_CLEAR
	nsc_flagop wHint3, 5, FLAG_CLEAR
	nsc_flagop wHint3, 6, FLAG_CLEAR
	nsc_flagop wHint3, 7, FLAG_CLEAR


.getAnswer

	nsc_compare wHint1, .hintA1, .hintA2, .hintAGreater, 1, 1
.hintAGreater
	nsc_compare wHint1, .hintA3, .hintA4, .hintA4, 1, 3

	answer_check 1
	answer_check 2
	answer_check 3
	answer_check 4

.answerTAUROS
	nsc_set wCorrectAnswer, TAUROS ; using species ID because... why not i guess?
	nsc_page ChainQuiz
.answerTOTODILE
	nsc_set wCorrectAnswer, TOTODILE
	nsc_page ChainQuiz
.answerSNEASEL
	nsc_set wCorrectAnswer, SNEASEL
	nsc_page ChainQuiz
.answerSANDSHREW
	nsc_set wCorrectAnswer, SANDSHREW
	nsc_page ChainQuiz
.answerMAROWAK
	nsc_set wCorrectAnswer, MAROWAK
	nsc_page ChainQuiz
.answerHYPNO
	nsc_set wCorrectAnswer, HYPNO
	nsc_page ChainQuiz
.answerSLOWPOKE
	nsc_set wCorrectAnswer, SLOWPOKE
	nsc_page ChainQuiz
.answerFARFETCH_D
	nsc_set wCorrectAnswer, FARFETCH_D
	nsc_page ChainQuiz

.answer1Name
	lang J, db "ケンタロス"
	lang E, db "TAUROS"
	lang D, db "TAUROS"
	lang F, db "TAUROS"
	lang I, db "TAUROS"
	lang S, db "TAUROS"
.answer1Desc
.answer2Desc
.answer3Desc
.answer4Desc
.answer5Desc
.answer6Desc
.answer7Desc
.answer8Desc
	db "@"

.answer2Name
	lang J, db "ワニノコ"
	lang E, db "TOTODILE"
	lang D, db "KARNIMANI"
	lang F, db "KAIMINUS"
	lang I, db "TOTODILE"
	lang S, db "TOTODILE"
	db "@"

.answer3Name
	lang J, db "ニューラ"
	lang E, db "SNEASEL"
	lang D, db "SNIEBEL"
	lang F, db "FARFURET"
	lang I, db "SNEASEL"
	lang S, db "SNEASEL"
	db "@"

.answer4Name
	lang J, db "サンド"
	lang E, db "SANDSHREW"
	lang D, db "SANDAN"
	lang F, db "SABELETTE"
	lang I, db "SANDSHREW"
	lang S, db "SANDSHREW"
	db "@"

.answer5Name
	lang J, db "ガラガラ"
	lang E, db "MAROWAK"
	lang D, db "KNOGGA"
	lang F, db "OSSATUEUR"
	lang I, db "MAROWAK"
	lang S, db "MAROWAK"
	db "@"

.answer6Name
	lang J, db "スリーパー"
	lang E, db "HYPNO"
	lang D, db "HYPNO"
	lang F, db "HYPNOMADE"
	lang I, db "HYPNO"
	lang S, db "HYPNO"
	db "@"

.answer7Name
	lang J, db "ヤドン"
	lang E, db "SLOWPOKE"
	lang D, db "FLEGMON"
	lang F, db "RAMOLOSS"
	lang I, db "SLOWPOKE"
	lang S, db "SLOWPOKE"
	db "@"

.answer8Name
	lang J, db "カモネギ"
	lang E, db "FARFETCH'D"
	lang D, db "PORENTA"
	lang F, db "CANARTICHO"
	lang I, db "FARFETCH'D"
	lang S, db "FARFETCH'D"
	db "@"

; FR NOTE : la grammaire souffre un peu, car il n'y a pas la place de mettre des mots de liaison dans certains cas
; (p.ex. "Pas type TENEBRES." fait exactement 18 caractères), et je pense plus approprié d'avoir une grammaire
; uniformément passable qu'alternant entre correcte et passable. (La traduction allemande semble faire de même.)
.textHintA1
	lang J, db "ノーマル　ではない"
	lang E, db "Not NORMAL type."
	lang D, db "Kein NORMAL-Typ."
	lang F, db "Pas type NORMAL."
	lang I, db "Non è tipo NORMALE"
	lang S, db "No es tipo NORMAL"
	db "@"
.textHintA2
	lang J, db "ひこう　ではない"
	lang E, db "Not FLYING type."
	lang D, db "Kein FLUG-Typ."
	lang F, db "Pas type VOL."
	lang I, db "Non è tipo VOLANTE"
	lang S, db "No es tipo VOLADOR"
	db "@"
.textHintA3
	lang J, db "こおり　ではない"
	lang E, db "Not ICE type."
	lang D, db "Kein EIS-Typ."
	lang F, db "Pas type GLACE."
	lang I, db "Non è tipo GHIACC."
	lang S, db "No es tipo HIELO"
	db "@"
.textHintA4
	lang J, db "あく　ではない"
	lang E, db "Not DARK type."
	lang D, db "Kein UNLICHT-Typ."
	lang F, db "Pas type TENEBRES."
	lang I, db "Non è tipo BUIO."
	lang S, db "No tipo SINIESTRO"
	db "@"

.textHintB1
	lang J, db "しっぽが　わかれてる"
	lang E, db "Its tail is split."
	lang D, db "Schweif gespalten."
	lang F, db "Queue fourchue."
	lang I, db "La coda è divisa."
	lang S, db "Su cola está rota"
	db "@"
.textHintB2
	lang J, db "みみが　とがっている"
	lang E, db "Has pointy ears."
	lang D, db "Spitze Ohren."
	lang F, db "Oreilles pointues."
	lang I, db "Orecchie a punta."
	lang S, db "Tiene orejas"
	db "@"
.textHintB3
	lang J, db "きばが　ある"
	lang E, db "Has pointy teeth."
	lang D, db "Spitze Zähne."
	lang F, db "Dents pointues."
	lang I, db "Denti appuntiti."
	lang S, db "Tiene dientes"
	db "@"
.textHintB4
	lang J, db "しんか　できる"
	lang E, db "It evolves."
	lang D, db "Entwickelt sich."
	lang F, db "Peut évoluer."
	lang I, db "Si evolve."
	lang S, db "Evoluciona."
	db "@"
.textHintB5
	lang J, db "なにか　かぶっている"
	lang E, db "Wears a headpiece."
	lang D, db "Hat Kopfbedeckung."
	lang F, db "A un couvre-chef."
	lang I, db "Ha un copricapo."
	lang S, db "Adorno en cabeza."
	db "@"
.textHintB6
	lang J, db "なにか　もっている"
	lang E, db "Holds something."
	lang D, db "Trägt etwas."
	lang F, db "Tient un truc."
	lang I, db "Tiene qualcosa."
	lang S, db "Sostiene algo"
	db "@"
.textHintB7
	lang J, db "おでこにワンポイント"
	lang E, db "Has forehead mark."
	lang D, db "Stirn-Markerung."
	lang F, db "Truc sur le front."
	lang I, db "Segno sulla fronte"
	lang S, db "Frente marcada."
	db "@"
.textHintB8
	lang J, db "タマゴから　うまれる"
	lang E, db "Comes from an EGG."
	lang D, db "Schlüpft aus EI."
	lang F, db "Eclot d'un OEUF."
	lang I, db "Esce da un UOVO."
	lang S, db "Proviene de HUEVO"
	db "@"

.textHintC01
	lang J, db "いあいぎり　できる"
	lang E, db "Can use CUT."
	lang D, db "Kann ZERSCHNEIDER."
	lang F, db "Apte à COUPE."
	lang I, db "Può usare TAGLIO."
	lang S, db "Puede usar CORTE."
	db "@"
.textHintC02 ; NOTE: Not recorded as existing
	lang J, db "いあいぎり　できない"
	lang E, db "Can't use CUT."
	lang D, db "Kein ZERSCHNEIDER."
	lang F, db "Inapte à COUPE."
	lang I, db "Non impara TAGLIO." ; "can't learn cut, fits char limit better
	lang S, db "No usa CORTE"
	db "@"
.textHintC03
	lang J, db "なみのり　できる"
	lang E, db "Can use SURF."
	lang D, db "Kann SURFER."
	lang F, db "Apte à SURF."
	lang I, db "Può usare SURF."
	lang S, db "Puede usar SURF."
	db "@"
.textHintC04
	lang J, db "なみのり　できない"
	lang E, db "Can't use SURF."
	lang D, db "Kein SURFER."
	lang F, db "Inapte à SURF."
	lang I, db "Non impara SURF."
	lang S, db "No puede usar SURF"
	db "@"
.textHintC05
	lang J, db "かいりき　できる"
	lang E, db "Can use STRENGTH."
	lang D, db "Kann STÄRKE."
	lang F, db "Apte à FORCE."
	lang I, db "Può usare FORZA."
	lang S, db "Puede usar FUERZA"
	db "@"
.textHintC06
	lang J, db "かいりき　できない"
	lang E, db "Can't use STRENGTH."
	lang D, db "Kein STÄRKE."
	lang F, db "Inapte à FORCE."
	lang I, db "Non impara FORZA."
	lang S, db "No usa FUERZA"
	db "@"
.textHintC07
	lang J, db "フラッシュ　できる"
	lang E, db "Can use FLASH."
	lang D, db "Kann BLITZ."
	lang F, db "Apte à FLASH."
	lang I, db "Può usare FLASH."
	lang S, db "Usa DESTELLO"
	db "@"
.textHintC08
	lang J, db "フラッシュ　できない"
	lang E, db "Can't use FLASH."
	lang D, db "Kein BLITZ."
	lang F, db "Inapte à FLASH."
	lang I, db "Non impara FLASH."
	lang S, db "No usa DESTELLO"
	db "@"
.textHintC09
	lang J, db "うずしお　できる"
	lang E, db "Can use WHIRLPOOL."
	lang D, db "Kann WHIRLPOOL."
	lang F, db "Apte à SIPHON."
	lang I, db "Impara MULINELLO."  ; being the longest-named HM move does NOT help at all
	lang S, db "Usa TORBELLINO"
	db "@"
.textHintC10 ; NOTE: Not recorded as existing
	lang J, db "うずしお　できない"
	lang E, db "Can't do WHIRLPOOL" 
	lang D, db "Kein WHIRLPOOL."
	lang F, db "Inapte à SIPHON."
	lang I, db "Non imp. MULINELLO" ; ugh
	lang S, db "No usa TORBELLINO."
	db "@"
.textHintC11
	lang J, db "たいあたり　できる"
	lang E, db "Can use TACKLE."
	lang D, db "Kann TACKLE."
	lang F, db "Apte à CHARGE."
	lang I, db "Può usare AZIONE."
	lang S, db "Puede usar PLACAJE"
	db "@"
.textHintC12 ; NOTE: Not recorded as existing
	lang J, db "たいあたり　できない"
	lang E, db "Can't use TACKLE."
	lang D, db "Kein TACKLE."
	lang F, db "Incompat. CHARGE."
	lang I, db "Non impara AZIONE."
	lang S, db "No usa PLACAJE"
	db "@"



.textWrongAnswer
	; Japanese
	lang J, text "ざんねん！　はずれだよ…"

	; English
	lang E, text "Too bad…"
	lang E, line "That was wrong!"

	; German
	lang D, text "Schade…"
	lang D, line "Falsche Antwort!"

	; French
	lang F, text "Dommage..."
	lang F, line "Mauvaise réponse!"

	lang I, text "Peccato…"
	lang I, line "Hai sbagliato!"

	lang S, text "Qué pena…"
	lang S, line "¡Fallaste!"
	
	done
.textRightAnswer
	; Japanese
	lang J, text "せいかい！"
	lang J, line "つぎの　もんだい　だよ"

	; English
	lang E, text "Correct!"
	lang E, line "Next question!"

	; German
	lang D, text "Richtig!"
	lang D, line "Nächste Frage!"

	; French
	lang F, text "Bravo!"
	lang F, line "Question suivante!"

	lang I, text "Esatto!"
	lang I, text "Prossima domanda!"

	lang S, text "¡Correcto! "
	lang S, line "¡Siguiente"
	
	done
.textChainComplete
	; Japanese
	lang J, text "５もんせいかい　おめでとう！"
	lang J, line "わざマシン３５を　プレゼント！"

	lang J, para "わざマシン３５を　もらった！"

	; English
	lang E, text "Five in a row!"
	lang E, line "Congratulations!"

	lang E, para "Here's TM35 as"
	lang E, line "a gift!"

	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM35."

	; German
	lang D, text "Fünf Treffer!"
	lang D, line "Glückwunsch!"

	lang D, para "Du erhältst TM35"
	lang D, line "als Geschenk!"

	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM35."

	; French
	lang F, text "Cinq d'affilée!"
	lang F, line "Félicitations!"

	lang F, para "En récompense,"
	lang F, line "voici la CT35!"

	lang F, para
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "CT35."

	; Italian
	lang I, text "Cinque di fila!"
	lang I, line "Congratulazioni!"

	lang I, para "Come premio,"
	lang I, line "ecco una MT35!"

	lang I, para
	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db   " riceve"
	lang I, line "MT35."
	
	; Spanish
	lang S, text "¡Cinco seguidos!"
	lang S, line "¡Enhorabuena!"
	
	lang S, para "¡Aquí tienes MT35"
	lang S, line "como regalo!"
	
	lang S, para
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "MT35."
	
	done

.textChainComplete2
	; Japanese
	lang J, text "５もんせいかい　おめでとう！"
	lang J, line "すごいキズぐすりを　プレゼント！"

	lang J, para "すごいキズぐすりを　もらった！"

	; English
	lang E, text "Five in a row!"
	lang E, line "Congratulations!"

	lang E, para "Here's a HYPER"
	lang E, line "POTION as a gift!"

	lang E, para
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "HYPER POTION."

	; German
	lang D, text "Fünf Treffer!"
	lang D, line "Glückwunsch!"

	lang D, para "Du erhältst einen"
	lang D, line "HYPERTRANK"
	lang D, cont "als Geschenk!"

	lang D, para
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "HYPERTRANK."

	; French
	lang F, text "Cinq d'affilée!"
	lang F, line "Félicitations!"

	lang F, para "En récompense,"
	lang F, line "voici une HYPER"
	lang F, cont "POTION!"

	lang F, para
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "HYPER POTION."

	; Italian
	lang I, text "Cinque di fila!"
	lang I, line "Congratulazioni!"

	lang I, para "Come premio,"
	lang I, line "ecco una"
	lang I, cont "IPERPOZIONE!"

	lang I, para
	lang I, nts_start
	lang I, nts_player_name 0
	lang I, nts_end
	lang I, db   " riceve"
	lang I, line "IPERPOZIONE."
	

	; Spanish
	lang S, text "¡Cinco seguidos!"
	lang S, line "¡Enhorabuena!"
	
	lang S, para "¡Aquí tienes HÍPER"
	lang S, line "POCIÓN como"
	
	lang S, para
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "HÍPER POCIÓN."
	
	done

ENDC
