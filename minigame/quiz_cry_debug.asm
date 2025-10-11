IF DEF(_MINIGAME_H)


;DEF wCryQuizQuestionNo EQU wMinigameRam0
;DEF wCryQuizAnswerCorrect EQU wMinigameRam1

MACRO minigame_start
	;nsc_set wQuizQuestionNo, 0
	;nsc_set wQuizScore, 0
	nsc_page MinigameStart
ENDM

MACRO minigame_name
	lang J, "ポケモンなきごえクイズ"
	lang E, "#MON CRY QUIZ"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

MACRO minigame_desc
	lang      J, "#<NO>なきごえ<WO>あててね！"
	
	lang      E, "Guess #MON"
	lang_line E, "cries!"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
ENDM

ELSE
MinigameStart::

	news_screen CryQuizMain, MUSIC_SHOW_ME_AROUND
	
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	
	news_def_strings
	news_string 1, 2, ""
	lang J, "ポケモンなきごえクイズ"
	lang E, "#MON CRY QUIZ"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
	news_menu 2, 5, 1, 4, 0, 2, $12, $04, $07, $04, $03, $04
	
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
	lang J, "スイクン"
	lang E, "SUICUNE"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem2_name
	lang J, "ピッピ"
	lang E, "CLEFAIRY"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem3_name
	lang J, "オニスズメ"
	lang E, "SPEAROW"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem4_name
	lang J, "ゴース"
	lang E, "GASTLY"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem5_name
	lang J, "トゲピー"
	lang E, "TOGEPI"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem6_name
	lang J, "ズバット"
	lang E, "ZUBAT"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem7_name
	lang J, "ルージュラ"
	lang E, "JYNX"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem8_name
	lang J, "エーフィ"
	lang E, "ESPEON"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem9_name
	lang J, "ミュウツー"
	lang E, "MEWTWO"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem10_name
	lang J, "ノコッチ"
	lang E, "DUNSPARCE"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem11_name
	lang J, "もどる"
	lang E, "CANCEL"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
.menuitem1_script
	nsc_set wMinigameRam0, 0
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem2_script
	nsc_set wMinigameRam0, 1
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem3_script
	nsc_set wMinigameRam0, 2
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem4_script
	nsc_set wMinigameRam0, 3
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem5_script
	nsc_set wMinigameRam0, 4
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem6_script
	nsc_set wMinigameRam0, 5
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem7_script
	nsc_set wMinigameRam0, 6
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem8_script
	nsc_set wMinigameRam0, 7
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem9_script
	nsc_set wMinigameRam0, 8
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem10_script
	nsc_set wMinigameRam0, 9
	nsc_page CryQuizQuestion
	nsc_ret
	
.menuitem11_script
	nsc_page NewsRoot
	nsc_ret
	
.menuitems_desc
	lang      J, "なきごえ<GA>わかる　#を"
	lang_line J, "えらんでください！"
	
	lang      E, "Choose the cry"
	lang_line E, "of this #MON!"
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	
	db "@"
	
.lastmenuitem_desc
	lang      J, "なきごえクイズ<WO>やめます"
	
	lang      E, "Exit the cry quiz."
	
	lang      D, "?"
	
	lang      F, "?"
	
	lang      I, "?"
	
	lang      S, "?"
	db "@"
	
	
	news_screen CryQuizQuestion, MUSIC_SHOW_ME_AROUND
	
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, NEWSBORDER_INVERTED, 3
	news_box 0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wMinigameRam0, \
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
	
	news_menu 2, 5, 1, 4, 0, 2, $12, $04, $07, $04, $02, $04
	
	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript .start_button
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button
	
	news_def_menuitems
	news_menudescription 1, 14, 20, 4
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
	lang J, "なきごえ１"
	lang E, "Cry 1"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem2_name
	lang J, "なきごえ２"
	lang E, "Cry 2"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem3_name
	lang J, "なきごえ３"
	lang E, "Cry 3"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuitem4_name
	lang J, "もどる"
	lang E, "CANCEL"
	lang D, "ZURÜCK"
	lang F, "RETOUR"
	lang I, "ESCI"
	lang S, "?"
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
	;nsc_add wQuizQuestionNo, 1
	nsc_clear 1, 13, 16, 4
	nsc_printstring 1, 14, .this_cry_question;$04E2 
REPT _NARG - 1
	nsc_compare wMinigameRam0, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}, .answer{_ANSWER_NUMBER}notquestion{_QUESTION_NUMBER}, 1, _QUESTION_NUMBER - 1
.answer{_ANSWER_NUMBER}question{_QUESTION_NUMBER}
	nsc_playcry \2;$92
IF CRY_QUIZ_ANSWER_{_QUESTION_NUMBER} == \2
	nsc_set wMinigameRam1, 0
ELSE
	nsc_set wMinigameRam1, 1
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
	nsc_compare wMinigameRam1, .wrongAnswer, .correctAnswer, .wrongAnswer, 1, 0
.correctAnswer ; $03C5
	nsc_delay 20
	nsc_clear 1, 13, 16, 4, 
	nsc_printstring 1, 14, .correct;$04EF
	nsc_playsound SFX_DEX_FANFARE_50_79
	
	
DEF _QUESTION_NUMBER = 1
REPT 10
	nsc_compare wMinigameRam0, .answerNotQ{_QUESTION_NUMBER}, .answerQ{_QUESTION_NUMBER}, .answerNotQ{_QUESTION_NUMBER}, 1, _QUESTION_NUMBER-1
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
	lang J, "なきごえは　どれ？"
	lang E, "Which cry is it?"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.this_cry_question ; $04E2 
	lang J, "この　なきごえ　ですか？"
	lang E, "Is it this cry?"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.correct ; $04EF
	lang J, "あたり！！！"
	lang E, "Correct!"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.incorrect ; $04F6
	lang J, "はずれ<……>⋯"
	lang E, "Incorrect…"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.which_cry_question_duplicate ; $04FC
	lang J, "なきごえは　どれ？"
	lang E, "Which cry is it?"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_suicune
	lang J, "なきごえクイズ　スイクン"
	lang E, "Cry Quiz:SUICUNE"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_clefairy
	lang J, "なきごえクイズ　ピッピ"
	lang E, "Cry Quiz:CLEFAIRY"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_spearow
	lang J, "なきごえクイズ　オニスズメ"
	lang E, "Cry Quiz:SPEAROW"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_gastly
	lang J, "なきごえクイズ　ゴース"
	lang E, "Cry Quiz:GASTLY"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_togepi
	lang J, "なきごえクイズ　トゲピー"
	lang E, "Cry Quiz:TOGEPI"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_zubat
	lang J, "なきごえクイズ　ズバット"
	lang E, "Cry Quiz:ZUBAT"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_jynx
	lang J, "なきごえクイズ　ルージュラ"
	lang E, "Cry Quiz:JYNX"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_espeon
	lang J, "なきごえクイズ　エーフィ"
	lang E, "Cry Quiz:ESPEON"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_mewtwo
	lang J, "なきごえクイズ　ミュウツー"
	lang E, "Cry Quiz:MEWTWO"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.cryquizlabel_dunsparce
	lang J, "なきごえクイズ　ノコッチ"
	lang E, "Cry Quiz:DUNSPARCE"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"

ENDC