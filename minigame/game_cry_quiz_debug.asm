; This is decompilation of news data
; recovered from the English ROM of
; Pokémon Crystal. It may or may not
; actually have been published.
;
; Decompiled by Cello2WC
; English localization by DS
; German localization by Lesserkuma
; French localization by ISSOtm
; Italian localization TODO
; Spanish localization TODO

IF DEF(_MINIGAME_H)


DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 0
;DEF wCryQuizQuestionNo EQU wNewsScratch0
;DEF wCryQuizAnswerCorrect EQU wNewsScratch1

MACRO minigame_start
	;nsc_set wQuizQuestionNo, 0
	;nsc_set wQuizScore, 0
	nsc_page MinigameStart
ENDM

MACRO minigame_name
	lang J, db "ポケモンなきごえクイズ"
	lang E, db "#MON CRY QUIZ"
	lang D, db "#MON-RUFE-QUIZ"
	lang F, db "QUIZ DES CRIS"
	lang I, db "?"
	lang S, db "?"
ENDM

MACRO minigame_desc
	lang J, db   "#<NO>なきごえ<WO>あててね！"

	lang E, db   "Guess the"
	lang E, line "#MON cry!"

	lang D, db   "Errate den"
	lang D, line "#MON-Ruf!"

	lang F, db   "De quel #MON"
	lang F, line "est-ce le cri?"

	lang I, db   "?"

	lang S, db   "?"
ENDM

ELSE
MinigameStart::

	news_screen CryQuizMain, MUSIC_SHOW_ME_AROUND

	news_def_pals

	news_def_boxes
	news_box 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, ""
	minigame_name
	db "@"

	news_menu 2, 5, 1, 4, 0, 2, 16, $04, $07, $04, SHOW_ARROWS | SHOW_DESCRIPTIONS, $04

	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript .start_button
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4

	news_norankingstable

	news_menuitem_names .menuitem1_name, .menuitem2_name, .menuitem3_name, .menuitem4_name, .menuitem5_name
	news_menuitem_names .menuitem6_name, .menuitem7_name, .menuitem8_name, .menuitem9_name, .menuitem10_name
	news_menuitem_names .menuitem11_name

	news_menuitem_scripts .menuitem1_script, .menuitem2_script, .menuitem3_script, .menuitem4_script, .menuitem5_script
	news_menuitem_scripts .menuitem6_script, .menuitem7_script, .menuitem8_script, .menuitem9_script, .menuitem10_script
	news_menuitem_scripts .menuitem11_script

REPT 10
	news_menuitem_descs .menuitems_desc
ENDR
	news_menuitem_descs .lastmenuitem_desc

.a_button
	nsc_playsound SFX_READ_TEXT
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
	nsc_page NewsRoot
	nsc_ret

.menuitem1_name
	lang J, db "スイクン"
	lang E, db "SUICUNE"
	lang D, db "SUICUNE"
	lang F, db "SUICUNE"
	lang I, db "SUICUNE"
	lang S, db "SUICUNE"
	db "@"
.menuitem2_name
	lang J, db "ピッピ"
	lang E, db "CLEFAIRY"
	lang D, db "PIEPI"
	lang F, db "MELOFEE"
	lang I, db "CLEFAIRY"
	lang S, db "CLEFAIRY"
	db "@"
.menuitem3_name
	lang J, db "オニスズメ"
	lang E, db "SPEAROW"
	lang D, db "HABITAK"
	lang F, db "PIAFABEC"
	lang I, db "SPEAROW"
	lang S, db "SPEAROW"
	db "@"
.menuitem4_name
	lang J, db "ゴース"
	lang E, db "GASTLY"
	lang D, db "NEBULAK"
	lang F, db "FANTOMINUS"
	lang I, db "GASTLY"
	lang S, db "GASTLY"
	db "@"
.menuitem5_name
	lang J, db "トゲピー"
	lang E, db "TOGEPI"
	lang D, db "TOGEPI"
	lang F, db "TOGEPI"
	lang I, db "TOGEPI"
	lang S, db "TOGEPI"
	db "@"
.menuitem6_name
	lang J, db "ズバット"
	lang E, db "ZUBAT"
	lang D, db "ZUBAT"
	lang F, db "NOSFERAPTI"
	lang I, db "ZUBAT"
	lang S, db "ZUBAT"
	db "@"
.menuitem7_name
	lang J, db "ルージュラ"
	lang E, db "JYNX"
	lang D, db "ROSSANA"
	lang F, db "LIPPOUTOU"
	lang I, db "JYNX"
	lang S, db "JYNX"
	db "@"
.menuitem8_name
	lang J, db "エーフィ"
	lang E, db "ESPEON"
	lang D, db "PSIANA"
	lang F, db "MENTALI"
	lang I, db "ESPEON"
	lang S, db "ESPEON"
	db "@"
.menuitem9_name
	lang J, db "ミュウツー"
	lang E, db "MEWTWO"
	lang D, db "MEWTU"
	lang F, db "MEWTWO"
	lang I, db "MEWTWO"
	lang S, db "MEWTWO"
	db "@"
.menuitem10_name
	lang J, db "ノコッチ"
	lang E, db "DUNSPARCE"
	lang D, db "DUMMISEL"
	lang F, db "INSOLOURDO"
	lang I, db "DUNSPARCE"
	lang S, db "DUNSPARCE"
	db "@"
.menuitem11_name
	lang J, db "もどる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "?"
	lang S, db "?"
	db "@"

.menuitem1_script
	nsc_set wNewsScratch0, 0
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem2_script
	nsc_set wNewsScratch0, 1
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem3_script
	nsc_set wNewsScratch0, 2
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem4_script
	nsc_set wNewsScratch0, 3
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem5_script
	nsc_set wNewsScratch0, 4
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem6_script
	nsc_set wNewsScratch0, 5
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem7_script
	nsc_set wNewsScratch0, 6
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem8_script
	nsc_set wNewsScratch0, 7
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem9_script
	nsc_set wNewsScratch0, 8
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem10_script
	nsc_set wNewsScratch0, 9
	nsc_page CryQuizQuestion
	nsc_ret

.menuitem11_script
	nsc_page NewsRoot
	nsc_ret

.menuitems_desc
	lang J, db   "なきごえ<GA>わかる　#を"
	lang J, line "えらんでください！"

	lang E, db   "Choose the cry"
	lang E, line "of this #MON!"

	lang D, db   "Wähle den zum PKMN"
	lang D, line "passenden Ruf!"

	lang F, db   "Trouve le cri de"
	lang F, line "ce #MON!"

	lang I, db   "?"

	lang S, db   "?"

	db "@"

.lastmenuitem_desc
	lang J, db   "なきごえクイズ<WO>やめます"

	lang E, db   "Exit the cry quiz."

	lang D, db   "Rufe-Quiz beenden."

	lang F, db   "Quitter le quiz."

	lang I, db   "?"

	lang S, db   "?"
	db "@"


	news_screen CryQuizQuestion, MUSIC_SHOW_ME_AROUND

	news_def_pals

	news_def_boxes
	news_box 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wNewsScratch0, \
		.cryquizlabel_suicune, \
		.cryquizlabel_clefairy, \
		.cryquizlabel_spearow, \
		.cryquizlabel_gastly, \
		.cryquizlabel_togepi, \
		.cryquizlabel_zubat, \
		.cryquizlabel_jynx, \
		.cryquizlabel_espeon, \
		.cryquizlabel_mewtwo, \
		.cryquizlabel_dunsparce
	;$0506, $0513, $051F, $052D, $0539, $0546, $0553, $0561, $056E, $057C
	nts_end

	news_menu 2, 5, 1, 4, 0, 2, 16, $04, $07, $04, SHOW_DESCRIPTIONS, $04

	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript .start_button
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button

	news_def_menuitems
	;news_menudescription 1, 14, 20, 4
	news_menudescription 1, 14, 18, 4
	news_norankingstable

	news_menuitem_names   .menuitem1_name,   .menuitem2_name,   .menuitem3_name,   .menuitem4_name
	news_menuitem_scripts .menuitem1_script, .menuitem2_script, .menuitem3_script, .menuitem4_script
	news_menuitem_descs   .menuitems_desc,   .menuitems_desc,   .menuitems_desc,   .menuitems_desc

.a_button
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
	nsc_page CryQuizMain
	nsc_ret

.menuitem1_name
	lang J, db "なきごえ１"
	lang E, db "CRY 1"
	lang D, db "RUF 1"
	lang F, db "CRI 1"
	lang I, db "?"
	lang S, db "?"
	db "@"
.menuitem2_name
	lang J, db "なきごえ２"
	lang E, db "CRY 2"
	lang D, db "RUF 2"
	lang F, db "CRI 2"
	lang I, db "?"
	lang S, db "?"
	db "@"
.menuitem3_name
	lang J, db "なきごえ３"
	lang E, db "CRY 3"
	lang D, db "RUF 3"
	lang F, db "CRI 3"
	lang I, db "?"
	lang S, db "?"
	db "@"
.menuitem4_name
	lang J, db "もどる"
	lang E, db "CANCEL"
	lang D, db "ZURÜCK"
	lang F, db "RETOUR"
	lang I, db "ESCI"
	lang S, db "?"
	db "@"



DEF CRY_QUIZ_ANSWER_$1  EQU SUICUNE
DEF CRY_QUIZ_ANSWER_$2  EQU CLEFAIRY
DEF CRY_QUIZ_ANSWER_$3  EQU SPEAROW
DEF CRY_QUIZ_ANSWER_$4  EQU GASTLY
DEF CRY_QUIZ_ANSWER_$5  EQU TOGEPI
DEF CRY_QUIZ_ANSWER_$6  EQU ZUBAT
DEF CRY_QUIZ_ANSWER_$7  EQU JYNX
DEF CRY_QUIZ_ANSWER_$8  EQU ESPEON
DEF CRY_QUIZ_ANSWER_$9  EQU MEWTWO
DEF CRY_QUIZ_ANSWER_$A  EQU DUNSPARCE


MACRO cry_quiz_answers
DEF _ANSWER_NUMBER = \1
.menuitem\1_script
DEF _QUESTION_NUMBER = 1
	nsc_clear 1, 13, 16, 4
	nsc_printstring 1, 14, .this_cry_question;$04E2
REPT _NARG - 1
	nsc_compare wNewsScratch0, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, 1, _QUESTION_NUMBER - 1
.answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}
	nsc_playcry \2;$92
IF CRY_QUIZ_ANSWER_{_QUESTION_NUMBER} == \2
	nsc_set wNewsScratch1, 0
ELSE
	nsc_set wNewsScratch1, 1
ENDC
	nsc_yesno 13, 7, .submitAnswer, .dontSubmit
	nsc_ret
.answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}
SHIFT
DEF _QUESTION_NUMBER = _QUESTION_NUMBER + 1
ENDR
	nsc_ret
ENDM



	cry_quiz_answers 1, MOLTRES, JIGGLYPUFF, NATU,    SPINARAK,  TOGEPI,  ZUBAT,  MANKEY,   PERSIAN, MEW,      DUNSPARCE
	cry_quiz_answers 2, LAPRAS,  TOGETIC,    WEEDLE,  GASTLY,    MARILL,  MAREEP, JYNX,     PHANPY,  MEWTWO,   YANMA
	cry_quiz_answers 3, SUICUNE, CLEFAIRY,   SPEAROW, PIDGEOTTO, GOLDEEN, UNOWN,  CLOYSTER, ESPEON,  PARASECT, QWILFISH

.menuitem4_script
	nsc_page CryQuizMain;$06D9
	nsc_ret
.submitAnswer ; $03B9
	nsc_compare wNewsScratch1, .wrongAnswer, .correctAnswer, .wrongAnswer, 1, 0
.correctAnswer ; $03C5
	nsc_delay 20
	nsc_clear 1, 13, 16, 4,
	nsc_printstring 1, 14, .correct;$04EF
	nsc_playsound SFX_DEX_FANFARE_50_79


DEF _QUESTION_NUMBER = 1
REPT 10
	nsc_compare wNewsScratch0, .answerNotQ{_QUESTION_NUMBER}, .answerQ{_QUESTION_NUMBER}, .answerNotQ{_QUESTION_NUMBER}, 1, _QUESTION_NUMBER-1
.answerQ{_QUESTION_NUMBER} ; $03DF
	nsc_drawmon 11, 5, CRY_QUIZ_ANSWER_{_QUESTION_NUMBER}, $03, $07
	nsc_waitbutton
	nsc_page CryQuizMain
	nsc_ret
.answerNotQ{_QUESTION_NUMBER} ; $03EA
DEF _QUESTION_NUMBER = _QUESTION_NUMBER + 1
ENDR
	nsc_ret


.wrongAnswer ; $04BA
	nsc_delay 20
	nsc_clear 1, 13, 16, 4
	nsc_printstring 1, 14, .incorrect;$04F6
	nsc_playsound SFX_WRONG
	nsc_waitbutton
	nsc_page CryQuizQuestion;$0817
	nsc_ret

.dontSubmit ; $04CD
	nsc_clear 1, 13, 16, 4
	nsc_printstring 1, 14, .which_cry_question_duplicate;$04FC
	nsc_ret

.menuitems_desc
	lang J, db "なきごえは　どれ？"
	lang E, db "Which cry is it?"
	lang D, db "Welcher Ruf passt?"
	lang F, db "Quel cri est-ce?"
	lang I, db "?"
	lang S, db "?"
	db "@"
.this_cry_question ; $04E2
	lang J, db "この　なきごえ　ですか？"
	lang E, db "Is it this cry?"
	lang D, db "Ist es dieser Ruf?"
	lang F, db "Est-ce celui-ci?"
	lang I, db "?"
	lang S, db "?"
	db "@"
.correct ; $04EF
	lang J, db "あたり！！！"
	lang E, db "Correct!"
	lang D, db "Richtig!"
	lang F, db "Bravo!"
	lang I, db "?"
	lang S, db "?"
	db "@"
.incorrect ; $04F6
	lang J, db "はずれ<……>⋯"
	lang E, db "Incorrect…"
	lang D, db "Leider falsch…"
	lang F, db "Eh non..."
	lang I, db "?"
	lang S, db "?"
	db "@"
.which_cry_question_duplicate ; $04FC
	lang J, db "なきごえは　どれ？"
	lang E, db "Which cry is it?"
	lang D, db "Welcher Ruf passt?"
	lang F, db "Quel cri est-ce?"
	lang I, db "?"
	lang S, db "?"
	db "@"
; All of these are max 17 (maybe 18) chars
.cryquizlabel_suicune
	lang J, db "なきごえクイズ　スイクン"
	lang E, db "SUICUNE CRY QUIZ"
	lang D, db "RUFE-QUIZ SUICUNE"
	lang F, db "CRI DE SUICUNE"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_clefairy
	lang J, db "なきごえクイズ　ピッピ"
	lang E, db "CLEFAIRY CRY QUIZ"
	lang D, db "RUFE-QUIZ PIEPI"
	lang F, db "CRI DE MELOFEE"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_spearow
	lang J, db "なきごえクイズ　オニスズメ"
	lang E, db "SPEAROW CRY QUIZ"
	lang D, db "RUFE-QUIZ HABITAK"
	lang F, db "CRI DE PIAFABEC"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_gastly
	lang J, db "なきごえクイズ　ゴース"
	lang E, db "GASTLY CRY QUIZ"
	lang D, db "RUFE-QUIZ NEBULAK"
	lang F, db "CRI DE FANTOMINUS"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_togepi
	lang J, db "なきごえクイズ　トゲピー"
	lang E, db "TOGEPI CRY QUIZ"
	lang D, db "RUFE-QUIZ TOGEPI"
	lang F, db "CRI DE TOGEPI"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_zubat
	lang J, db "なきごえクイズ　ズバット"
	lang E, db "ZUBAT CRY QUIZ"
	lang D, db "RUFE-QUIZ ZUBAT"
	lang F, db "CRI DE NOSFERAPTI"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_jynx
	lang J, db "なきごえクイズ　ルージュラ"
	lang E, db "JYNX CRY QUIZ"
	lang D, db "RUFE-QUIZ ROSSANA"
	lang F, db "CRI DE LIPPOUTOU"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_espeon
	lang J, db "なきごえクイズ　エーフィ"
	lang E, db "ESPEON CRY QUIZ"
	lang D, db "RUF-QUIZ PSIANA"
	lang F, db "CRI DE MENTALI"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_mewtwo
	lang J, db "なきごえクイズ　ミュウツー"
	lang E, db "MEWTWO CRY QUIZ"
	lang D, db "RUFE-QUIZ MEWTU"
	lang F, db "CRI DE MEWTWO"
	lang I, db "?"
	lang S, db "?"
	db "@"
.cryquizlabel_dunsparce
	lang J, db "なきごえクイズ　ノコッチ"
	lang E, db "DUNSPARCE CRY QUIZ"
	lang D, db "RUFE-QUIZ DUMMISEL"
	lang F, db "CRI D'INSOLOURDO"
	lang I, db "?"
	lang S, db "?"
	db "@"

ENDC
