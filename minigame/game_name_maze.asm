; This is a RE-CREATION based on records
; from the time and first-hand accounts,
; NOT actual recovered news data!
;
; See: https://www2u.biglobe.ne.jp/~kakeru/pokemon2/mobile/news/02_06.htm
; Thanks to nohm for providing their first-hand account of this minigame!
;
; Re-creation script written by Cello2WC
; English localization by DS
; German localization by Lesserkuma
; French localization by ISSOtm
; Italian localization TODO
; Spanish localization TODO

IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1
DEF NUM_MINIGAMES EQU 2

DEF wSolutionInvalid EQUS "wNewsScratch0"
DEF wCurrentMove     EQUS "wNewsScratch1"
DEF wCurrentPuzzle   EQUS "wNewsScratch2"

MACRO minigame_start

	nsc_clear 1, 13, 18, 4
	nsc_compare_newsvar sMinigameFlag, .noIntro, .doIntro, .noIntro, 1, 0
.doIntro
	nsc_textbox 1, 14, .gameIntroText
	nsc_waitbutton
.noIntro
	nsc_set wSolutionInvalid, 0
	nsc_set wCurrentPuzzle, 0
	nsc_page MinigameStart

.gameIntroText
	; Japanese
	lang J, text "じゅうじボタンを　つかって"
	lang J, line "さんかく　の　カーソルを　うごかし"
	lang J, cont "がめんに　ばらばらに　ならんだ"
	lang J, cont "ポケモンの　なまえの　もじを"
	lang J, cont "ただしい　なまえの　じゅんばんで"
	lang J, cont "たどって　いきます"

	lang J, para "なまえが　とちゅうで　きれたり"
	lang J, line "おなじ　もじを　２ど　とおったり"
	lang J, cont "しないように　ちゅうい　してね！"

	lang J, para "スタートのマークの　×　から"
	lang J, line "ゴールのマークの　！　に　いけたら"
	lang J, cont "エーボタンを　おして"
	lang J, cont "こたえあわせを　して　みよう"
	lang J, cont "それでは　スタート！"

	; English
	lang E, text "Use the Control"
	lang E, line "Pad to move the"
	lang E, cont "cursor."

	lang E, para "Trace the letters"
	lang E, line "of a #MON name"
	lang E, cont "in the correct"
	lang E, cont "order."

	lang E, para "Be careful not"
	lang E, line "to stop halfway"
	lang E, cont "through a name or"
	lang E, cont "go over the same"
	lang E, cont "space twice!"

	lang E, para "Start at the ×"
	lang E, line "mark and go to"
	lang E, cont "the ! mark to"
	lang E, cont "reach the goal."

	lang E, para "Press the A Button"
	lang E, line "to check your "
	lang E, cont "answer."

	lang E, para "Let's get started!"

	; German
	lang D, text "Bewege dich mit"
	lang D, line "dem Steuerkreuz"
	lang D, cont "über die Buchsta-"
	lang D, cont "ben in richtiger"
	lang D, cont "Reihenfolge, um"
	lang D, cont "den #MON-Namen"
	lang D, cont "zu bilden."

	lang D, para "Du darfst dabei"
	lang D, line "nicht stehen blei-"
	lang D, cont "ben oder dich"
	lang D, cont "zurück bewegen!"

	lang D, para "Beginne beim × und"
	lang D, line "bewege dich bis"
	lang D, cont "zum !-Zeichen,"
	lang D, cont "um das Ziel zu"
	lang D, cont "erreichen."

	lang D, para "Drücke den A-"
	lang D, line "Knopf, um deine"
	lang D, cont "Lösung zu prüfen."

	lang D, para "Und los geht's!"

	; French
	lang F, text "Le curseur est"
	lang F, line "contrôlé par la"
	lang F, cont "manette."

	lang F, para "Cheminez tout en"
	lang F, line "épelant une espèce"
	lang F, cont "de #MON dans"
	lang F, cont "le bon ordre."

	lang F, para "Il est interdit de"
	lang F, line "passer deux fois"
	lang F, cont "par la même case,"
	lang F, cont "ainsi que d'épeler"
	lang F, cont "le dernier nom"
	lang F, cont "partiellement."

	lang F, para "Commencez au ×"
	lang F, line "et atteignez"
	lang F, cont "le ! pour"
	lang F, cont "terminer."

	lang F, para "Appuyez sur A pour"
	lang F, line "vérifier votre"
	lang F, cont "tentative."

	lang F, para "C;est parti!"

	; Italian
	lang I, text "?"

	; Spanish
	lang S, text "Usa el panel" 
	lang S, line "direccional para" 
	lang S, cont "mover el cursor."

	lang S, para "Traza las letras"
	lang S, line "del nombre #MON"
	lang S, cont "en el orden"
	lang S, cont "correcto."

	lang S, para "No pares a medio"
	lang S, line "camino, ni a"
	lang S, cont "traves del nombre"
	lang S, cont "ni por el mismo"
	lang S, cont "espacio dos veces!"

	lang S, para "Empieza en la ×"
	lang S, line "y ve a la marca !"
	lang S, cont "para alcanzar"
	lang S, cont "la meta."

	lang S, para "Pulsa el botón A"
	lang S, line "para comprobar tu "
	lang S, cont "respuesta."

	lang S, para "¡Empecemos!"
	
	done
ENDM

MACRO minigame_start_2
	nsc_set wSolutionInvalid, 0
	nsc_set wCurrentPuzzle, 0
	nsc_page PokemonMazeHard
ENDM
; Max 17 chars
MACRO minigame_name
	lang J, db "ポケモンもじめいろ　かんたん"
	lang E, db "EASY #MON MAZE"
	lang D, db "LEICHTES LABYRINTH"
	lang F, db "LABYRINTHE FACILE"
	lang I, db "?"
	lang S, db "LABERINTO #MON"
ENDM
; Max 17 chars
MACRO minigame_name_2
	lang J, db "ポケモンもじめいろ　むずかしい"
	lang E, db "HARD #MON MAZE"
	lang D, db "SCHWERES LABYRINTH"
	lang F, db "LABYRINTHE DIFFICILE"
	lang I, db "?"
	lang S, db "LABERINTO #MON"
ENDM

MACRO minigame_desc
	lang J, db   "？"

	lang E, db   "?"

	lang D, db   "?"

	lang F, db   "?"

	lang I, db   "?"

	lang S, db "?"
ENDM

MACRO minigame_desc_2
	lang J, db   "？"

	lang E, db   "?"

	lang D, db   "?"

	lang F, db   "?"

	lang I, db   "?"

	lang S, db "?"
ENDM

ELSE




MinigameStart::
	news_screen PokemonMazeEasy, MUSIC_SHOW_ME_AROUND
	news_def_pals

	news_def_boxes
	news_box 0,  0, 20, 13, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}


	news_def_strings
	news_string 0, 0, "@" ; potentially label or instructions here

	lang    J, news_menu  6, 4, 4, 4, 2, 2, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01
	notlang J, news_menu  3, 4, 4, 4, 4, 2, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01

	news_buttonscript .checkEasy   ; script pointer a button
	news_buttonscript Quit        ; script pointer b button
	news_buttonscript .resetPuzzle ; script pointer select button
	news_buttonscript .checkEasy   ; script pointer start button
	news_buttonscript .rightButton  ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript .upButton    ; script pointer up button
	news_buttonscript .downButton  ; script pointer down button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable

	news_menuitem_names   \
	.puzzleGFX, .dummyGFX, .dummyGFX, .dummyGFX, \
	.dummyGFX, .dummyGFX, .dummyGFX, .dummyGFX, \
	.dummyGFX, .dummyGFX, .dummyGFX, .dummyGFX, \
	.dummyGFX, .dummyGFX, .dummyGFX, .dummyGFX

	news_menuitem_scripts  \
	.scr00, .scr01, .scr02, .scr03, \
	.scr04, .scr05, .scr06, .scr07, \
	.scr08, .scr09, .scr10, .scr11, \
	.scr12, .scr13, .scr14, .checkAnswer
REPT 4 * 4
	news_menuitem_descs   .menuDescName
ENDR







.upButton
	nsc_compare wNewsMenuCursorY, .nothing, .nothing, .upButton_continue, 1, 1
.upButton_continue
	nsc_set wCurrentMove, UP
	nsc_select
	nsc_up
	nsc_ret
.downButton
	nsc_compare wNewsMenuCursorY, .downButton_continue, .nothing, .nothing, 1, 4
.downButton_continue
	nsc_set wCurrentMove, DOWN
	nsc_select
	nsc_down
	nsc_ret
.rightButton
	nsc_compare wNewsMenuCursorX, .rightButton_continue, .nothing, .nothing, 1, 4
.rightButton_continue
	nsc_set wCurrentMove, RIGHT
	nsc_select
	nsc_right
	nsc_ret
.leftButton
	nsc_compare wNewsMenuCursorX, .nothing, .nothing, .leftButton_continue, 1, 1
.leftButton_continue
	nsc_set wCurrentMove, LEFT
	nsc_select
	nsc_left
	nsc_ret


.wrongPath
	nsc_playsound SFX_WRONG
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, IncorrectText
	nsc_waitbutton
.resetPuzzle
	;nsc_white
	;nsc_playsound SFX_WARP_FROM
	nsc_set wSolutionInvalid, 0
	nsc_page currentScreen
	nsc_ret


.scrUP
	; tile where correct direction is up
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, UP
.scrDN
	; tile where correct direction is down
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, DOWN
.scrLF
	; tile where correct direction is right
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, LEFT
.scrRT
	; tile where correct direction is left
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, RIGHT


.scrXX
	nsc_set wSolutionInvalid, 1
.valid
	; for fun!
	; but also audio feedback to let the player
	; know that the game is registering every
	; d-pad button press.
	nsc_playsound SFX_STOP_SLOT
	nsc_ret

.textMARILL
	lang J, db "『マリル』"
	lang E, db "MARILL"
	lang D, db "MARILL"
	lang F, db "MARILL"
	lang I, db "MARILL"
	lang S, db "MARILL"
	db "@"

	lang J, DEF PUZZLE1_MON EQUS "MARILL"
	lang E, DEF PUZZLE1_MON EQUS "MARILL"
	lang D, DEF PUZZLE1_MON EQUS "MARILL"
	lang F, DEF PUZZLE1_MON EQUS "MARILL"
	lang I, DEF PUZZLE1_MON EQUS "MARILL"
	lang S, DEF PUZZLE1_MON EQUS "MARILL"
	
	lang J, DEF MARILL_MA EQUS "マ"
	lang E, DEF MARILL_MA EQUS "MA"
	lang D, DEF MARILL_MA EQUS "MA"
	lang F, DEF MARILL_MA EQUS "MA"
	lang I, DEF MARILL_MA EQUS "MA"
	lang S, DEF MARILL_MA EQUS "MA"
	
	lang J, DEF MARILL_RI EQUS "リ"
	lang E, DEF MARILL_RI EQUS "RI"
	lang D, DEF MARILL_RI EQUS "RI"
	lang F, DEF MARILL_RI EQUS "RI"
	lang I, DEF MARILL_RI EQUS "RI"
	lang S, DEF MARILL_RI EQUS "RI"

	lang J, DEF MARILL_LL EQUS "ル"
	lang E, DEF MARILL_LL EQUS "LL"
	lang D, DEF MARILL_LL EQUS "LL"
	lang F, DEF MARILL_LL EQUS "LL"
	lang I, DEF MARILL_LL EQUS "LL"
	lang S, DEF MARILL_LL EQUS "LL"
	

.textMUUMA
	lang J, db "『ムウマ』"
	lang E, db "GASTLY"
	lang D, db "NEBULAK"
	lang F, db "FEUFOREVE"
	lang I, db "GASTLY"
	lang S, db "GASTLY"
	db "@"

	lang J, DEF PUZZLE2_MON EQUS "MISDREAVUS"
	lang E, DEF PUZZLE2_MON EQUS "GASTLY"
	lang D, DEF PUZZLE2_MON EQUS "GASTLY"
	lang F, DEF PUZZLE2_MON EQUS "MISDREAVUS"
	lang I, DEF PUZZLE2_MON EQUS "GASTLY"
	lang S, DEF PUZZLE2_MON EQUS "GASTLY"
	
	lang J, DEF MUUMA_MU EQUS "ム"
	lang E, DEF MUUMA_MU EQUS "GA"
	lang D, DEF MUUMA_MU EQUS "NE"
	lang F, DEF MUUMA_MU EQUS "FEU"
	lang I, DEF MUUMA_MU EQUS "GA"
	lang S, DEF MUUMA_MU EQUS "GA"

	lang J, DEF MUUMA_UU EQUS "ウ"
	lang E, DEF MUUMA_UU EQUS "ST"
	lang D, DEF MUUMA_UU EQUS "BU"
	lang F, DEF MUUMA_UU EQUS "FOR"
	lang I, DEF MUUMA_UU EQUS "ST"
	lang S, DEF MUUMA_UU EQUS "ST"

	lang J, DEF MUUMA_MA EQUS "マ"
	lang E, DEF MUUMA_MA EQUS "LY"
	lang D, DEF MUUMA_MA EQUS "LAK"
	lang F, DEF MUUMA_MA EQUS "EVE"
	lang I, DEF MUUMA_MA EQUS "LY"
	lang S, DEF MUUMA_MA EQUS "LY"

.textMOKOKO
	lang J, db "『モココ』"
	lang E, db "RATTATA"
	lang D, db "SMOGMOG"
	lang F, db "RATTATA"
	lang I, db "RATTATA"
	lang S, db "RATTATA"
	db "@"

	lang J, DEF PUZZLE3_MON EQUS "FLAAFFY"
	lang E, DEF PUZZLE3_MON EQUS "RATTATA"
	lang D, DEF PUZZLE3_MON EQUS "WEEZING"
	lang F, DEF PUZZLE3_MON EQUS "RATTATA"
	lang I, DEF PUZZLE3_MON EQUS "RATTATA"
	lang S, DEF PUZZLE3_MON EQUS "RATTATA"

	lang J, DEF MOKOKO_MO EQUS "モ"
	lang E, DEF MOKOKO_MO EQUS "RAT"
	lang D, DEF MOKOKO_MO EQUS "S"
	lang F, DEF MOKOKO_MO EQUS "RAT"
	lang I, DEF MOKOKO_MO EQUS "RAT"
	lang S, DEF MOKOKO_MO EQUS "RAT"

	lang J, DEF MOKOKO_KO EQUS "コ"
	lang E, DEF MOKOKO_KO EQUS "TA"
	lang D, DEF MOKOKO_KO EQUS "MOG"
	lang F, DEF MOKOKO_KO EQUS "TA"
	lang I, DEF MOKOKO_KO EQUS "TA"
	lang S, DEF MOKOKO_KO EQUS "TA"
	
; old DODRIO version
;.textPUTERA
;	lang J, db "『プテラ』"
;	lang E, db "DODRIO"
;	lang D, db "?"
;	lang F, db "DODRIO"
;	lang I, db "DODRIO"
;	lang S, db "DODRIO"
;	db "@"
;.textPUTERA_PU
;	lang J, db "プ"
;	lang E, db "DO"
;	lang D, db "1?"
;	lang F, db "DO"
;	lang I, db "DO"
;	lang S, db "DO"
;	db "@"
;.textPUTERA_TE
;	lang J, db "テ"
;	lang E, db "DR"
;	lang D, db "2?"
;	lang F, db "DR"
;	lang I, db "DR"
;	lang S, db "DR"
;	db "@"
;.textPUTERA_RA
;	lang J, db "ラ"
;	lang E, db "IO"
;	lang D, db "3?"
;	lang F, db "IO"
;	lang I, db "IO"
;	lang S, db "IO"
;	db "@"

; new SUDOWOODO version
.textPUTERA
	lang J, db "『プテラ』"
	lang E, db "SUDOWOODO"
	lang D, db "KEIFEL"
	lang F, db "LIPPOUTOU"
	lang I, db "SUDOWOODO"
	lang S, db "SUDOWOODO"
	db "@"

	lang J, DEF PUZZLE4_MON EQUS "AERODACTYL"
	lang E, DEF PUZZLE4_MON EQUS "SUDOWOODO"
	lang D, DEF PUZZLE4_MON EQUS "PILOSWINE"
	lang F, DEF PUZZLE4_MON EQUS "JYNX"
	lang I, DEF PUZZLE4_MON EQUS "SUDOWOODO"
	lang S, DEF PUZZLE4_MON EQUS "SUDOWOODO"
	
	lang J, DEF PUTERA_PU EQUS "プ"
	lang E, DEF PUTERA_PU EQUS "SUD"
	lang D, DEF PUTERA_PU EQUS "KE"
	lang F, DEF PUTERA_PU EQUS "LIP"
	lang I, DEF PUTERA_PU EQUS "SUD"
	lang S, DEF PUTERA_PU EQUS "SUD"
	
	lang J, DEF PUTERA_TE EQUS "テ"
	lang E, DEF PUTERA_TE EQUS "OWO"
	lang D, DEF PUTERA_TE EQUS "IF"
	lang F, DEF PUTERA_TE EQUS "POU"
	lang I, DEF PUTERA_TE EQUS "OWO"
	lang S, DEF PUTERA_TE EQUS "OWO"
	
	lang J, DEF PUTERA_RA EQUS "ラ"
	lang E, DEF PUTERA_RA EQUS "ODO"
	lang D, DEF PUTERA_RA EQUS "EL"
	lang F, DEF PUTERA_RA EQUS "TOU"
	lang I, DEF PUTERA_RA EQUS "ODO"
	lang S, DEF PUTERA_RA EQUS "ODO"
	
.textPIPPI
	lang J, db "『ピッピ』"
	lang E, db "EEVEE"
	lang D, db "PIEPI"
	lang F, db "TETARTE"
	lang I, db "EEVEE"
	lang S, db "EEVEE"
	db "@"

	lang J, DEF PUZZLE5_MON EQUS "CLEFAIRY"
	lang E, DEF PUZZLE5_MON EQUS "EEVEE"
	lang D, DEF PUZZLE5_MON EQUS "CLEFAIRY"
	lang F, DEF PUZZLE5_MON EQUS "POLIWHIRL"
	lang I, DEF PUZZLE5_MON EQUS "EEVEE"
	lang S, DEF PUZZLE5_MON EQUS "EEVEE"
	
	lang J, DEF PIPPI_PI EQUS "ピ"
	lang E, DEF PIPPI_PI EQUS "EE"
	lang D, DEF PIPPI_PI EQUS "PI"
	lang F, DEF PIPPI_PI EQUS "TE"
	lang I, DEF PIPPI_PI EQUS "EE"
	lang S, DEF PIPPI_PI EQUS "EE"
	
	lang J, DEF PIPPI_PP EQUS "ッ"
	lang E, DEF PIPPI_PP EQUS "V"
	lang D, DEF PIPPI_PP EQUS "E"
	lang F, DEF PIPPI_PP EQUS "TAR"
	lang I, DEF PIPPI_PP EQUS "V"
	lang S, DEF PIPPI_PP EQUS "V"

DEF PUZZLE_COUNT = 0

MACRO define_puzzle
DEF PUZZLE_COUNT = PUZZLE_COUNT + 1
DEF PUZZLE{d:PUZZLE_COUNT}_MON_NAME EQUS ".text\1"
DEF PUZZLE{d:PUZZLE_COUNT}_MON_NAME_2 EQUS "\1"
SHIFT 1
DEF loopindex = 1
REPT 16 - 2
DEF PUZZLE{d:PUZZLE_COUNT}_GFX{02d:loopindex} EQUS "{PUZZLE{d:PUZZLE_COUNT}_MON_NAME_2}_\1"
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
DEF loopindex = 0
REPT 16 - 1
DEF PUZZLE{d:PUZZLE_COUNT}_ANSWER{02d:loopindex} EQU .scr\1
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
ENDM

	define_puzzle MARILL,\
				\
				    LL, MA, MA, \
				MA, RI, RI, LL, \
				LL, RI, RI, MA, \
				LL, MA, LL, \
				\
				DN, RT, DN, XX, \
				RT, UP, RT, DN, \
				XX, XX, DN, LF, \
				XX, XX, RT

	define_puzzle MUUMA,\
				\
				    MU, UU, MA, \
				MU, MA, MA, MU, \
				MA, UU, MU, UU, \
				MU, UU, MA, \
				\
				RT, RT, DN, XX, \
				XX, XX, DN, XX, \
				DN, LF, LF, XX, \
				RT, RT, RT

	define_puzzle MOKOKO,\
				\
				    MO, MO, KO, \
				KO, KO, KO, KO, \
				MO, KO, KO, MO, \
				KO, MO, KO, \
				\
				RT, DN, RT, DN, \
				XX, RT, UP, DN, \
				XX, XX, DN, LF, \
				XX, XX, RT

	define_puzzle PUTERA,\
				\
					RA, PU, TE, \
				PU, TE, TE, RA, \
				PU, RA, TE, RA, \
				TE, RA, PU, \
				\
				DN, XX, XX, XX, \
				RT, DN, XX, XX, \
				DN, LF, RT, DN, \
				RT, RT, UP

	define_puzzle PIPPI,\
				\
				    PI, PP, PI, \
				PI, PP, PI, PP, \
				PI, PI, PP, PP, \
				PP, PI, PI, \
				\
				RT, DN, XX, XX, \
				DN, LF, XX, XX, \
				DN, RT, DN, XX, \
				RT, UP, RT




.checkEasy
	nsc_compare wNewsMenuCursorX, .nothing, .checkAnswer, .nothing, 2, 4, 4
.checkAnswer
	;nsc_playsound SFX_TRANSACTION
	nsc_compare wSolutionInvalid, .wrongPath, .pass, .wrongPath, 1, 0
.pass
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, CorrectText

	nsc_playsound SFX_LEVEL_UP

	nsc_drawbox 5, 3, 9, 9, NEWSBORDER_STRIPED, 5;{NEWS_MAIN_BORDER}


	nsc_add wCurrentPuzzle, 1
;	nsc_compare wCurrentPuzzle, .nextPuzzle, .gift, .gift, 1, 5 ; 5 easy puzzles
	nsc_compare wCurrentPuzzle, .puzzle1complete, .puzzle2complete, .higher, 1, 2
.higher
	nsc_compare wCurrentPuzzle, .puzzle3complete, .puzzle4complete, .puzzle5complete, 1, 4

.puzzle1complete
	nsc_drawmon 6, 4, PUZZLE1_MON,  $03, $07
	nsc_waitbutton
.nextPuzzle
	nsc_page currentScreen
.nothing
	nsc_ret

.puzzle2complete
	nsc_drawmon 6, 4, PUZZLE2_MON,  $03, $07
	nsc_waitbutton
	nsc_page currentScreen
	nsc_ret

.puzzle3complete
	nsc_drawmon 6, 4, PUZZLE3_MON,  $03, $07
	nsc_waitbutton
	nsc_page currentScreen
	nsc_ret

.puzzle4complete
	nsc_drawmon 6, 4, PUZZLE4_MON,  $03, $07
	nsc_waitbutton
	nsc_page currentScreen
	nsc_ret

.puzzle5complete
	nsc_drawmon 6, 4, PUZZLE5_MON,  $03, $07
	nsc_waitbutton
.gift
	nsc_bit_newsvar sMinigameFlag, 0, .noGift, .giveGift
.giveGift
	nsc_giveitem TM_ROLLOUT, .recordGift, .noGift
.recordGift
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .getGiftText
	nsc_flagop sMinigameFlag, 0, FLAG_SET
	nsc_playsound SFX_GET_TM
	nsc_waitbutton
.noGift
	nsc_page NewsRoot

.getGiftText
	lang J, text "わざマシン０４を　もらった！"

	lang E, text
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "TM04."

	; German
	lang D, text
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "TM04."

	lang F, text
	lang F, nts_start
	lang F, nts_player_name 0
	lang F, nts_end
	lang F, db   " reçoit"
	lang F, line "CT04."

	lang I, text "?"

	lang S, text
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "MT04."
	
	done






.menuDescName
	nts_start
	nts_switch wCurrentPuzzle, PUZZLE1_MON_NAME, PUZZLE2_MON_NAME, PUZZLE3_MON_NAME, PUZZLE4_MON_NAME, PUZZLE5_MON_NAME
	nts_end
	db "@"


;textXX:
;	db "×"
;	db "@"
;txtEND:
;	db "!"
;	db "@"


; include puzzles that were defined earlier

;DEF loopindex = 1
.puzzleGFX
	nts_start
	nts_switch wCurrentPuzzle, \
	.puzzle1GFX, \
	.puzzle2GFX, \
	.puzzle3GFX, \
	.puzzle4GFX, \
	.puzzle5GFX
	nts_end
.dummyGFX
	db "@"


lang    J, DEF puzzle_tile_width = 2
notlang J, DEF puzzle_tile_width = 4
DEF puzzleindex = 1
REPT 5
.puzzle{d:puzzleindex}GFX
DEF loopindex = 1
	lang    J, db "× "
	notlang J, db "×   "
REPT (4*4) - 2
	db "{{PUZZLE{d:puzzleindex}_GFX{02d:loopindex}}}"
IF loopindex % 4 != 3
REPT puzzle_tile_width - STRLEN("{{PUZZLE{d:puzzleindex}_GFX{02d:loopindex}}}")
	db " "
ENDR
ELSE
	next
ENDC
	DEF loopindex = loopindex + 1
ENDR
	db "!"
	db "@"
DEF puzzleindex = puzzleindex + 1
ENDR
;REPT 16 - 2
;.txt{02d:loopindex}
;	nts_start
;	nts_switch wCurrentPuzzle, \
;	PUZZLE1_GFX{02d:loopindex}, \
;	PUZZLE2_GFX{02d:loopindex}, \
;	PUZZLE3_GFX{02d:loopindex}, \
;	PUZZLE4_GFX{02d:loopindex}, \
;	PUZZLE5_GFX{02d:loopindex}
;	nts_end
;	db "@"
;DEF loopindex = loopindex + 1
;ENDR

DEF loopindex = 0
REPT 16 - 1
.scr{02d:loopindex}
	nsc_compare wCurrentPuzzle, PUZZLE1_ANSWER{02d:loopindex}, PUZZLE2_ANSWER{02d:loopindex}, .scr{02d:loopindex}greater, 1, 1
.scr{02d:loopindex}greater
	nsc_compare wCurrentPuzzle, PUZZLE3_ANSWER{02d:loopindex}, PUZZLE4_ANSWER{02d:loopindex}, PUZZLE5_ANSWER{02d:loopindex}, 1, 3
DEF loopindex = loopindex + 1
ENDR






	news_screen PokemonMazeHard, MUSIC_SHOW_ME_AROUND
	news_def_pals

	news_def_boxes
	news_box 0,  0, 20, 13, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}


	news_def_strings
	news_string 0, 0, "@" ; potentially label or instructions here

	news_menu  2, 2, 9, 5, 2, 2, -1, $00, $00, $00, SHOW_DESCRIPTIONS, $01

	news_buttonscript .checkHard   ; script pointer a button
	news_buttonscript Quit        ; script pointer b button
	news_buttonscript .resetPuzzle ; script pointer select button
	news_buttonscript .checkHard   ; script pointer start button
	news_buttonscript .rightButton  ; script pointer right button
	news_buttonscript .leftButton ; script pointer left button
	news_buttonscript .upButton    ; script pointer up button
	news_buttonscript .downButton  ; script pointer down button

	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable

	news_menuitem_names .puzzleGFX
REPT 9*5 - 1
	news_menuitem_names .dummyGFX
ENDR

	news_menuitem_scripts  \
	.scr00, .scr01, .scr02, .scr03, .scr04, .scr05, .scr06, .scr07, .scr08, \
	.scr09, .scr10, .scr11, .scr12, .scr13, .scr14, .scr15, .scr16, .scr17, \
	.scr18, .scr19, .scr20, .scr21, .scr22, .scr23, .scr24, .scr25, .scr26, \
	.scr27, .scr28, .scr29, .scr30, .scr31, .scr32, .scr33, .scr34, .scr35, \
	.scr36, .scr37, .scr38, .scr39, .scr40, .scr41, .scr42, .scr43, .checkAnswer
REPT 9 * 5
	news_menuitem_descs   .menuDescName
ENDR







.upButton
	nsc_compare wNewsMenuCursorY, .nothing, .nothing, .upButton_continue, 1, 1
.upButton_continue
	nsc_set wCurrentMove, UP
	nsc_select
	nsc_up
	nsc_ret
.downButton
	nsc_compare wNewsMenuCursorY, .downButton_continue, .nothing, .nothing, 1, 5
.downButton_continue
	nsc_set wCurrentMove, DOWN
	nsc_select
	nsc_down
	nsc_ret
.rightButton
	nsc_compare wNewsMenuCursorX, .rightButton_continue, .nothing, .nothing, 1, 9
.rightButton_continue
	nsc_set wCurrentMove, RIGHT
	nsc_select
	nsc_right
	nsc_ret
.leftButton
	nsc_compare wNewsMenuCursorX, .nothing, .nothing, .leftButton_continue, 1, 1
.leftButton_continue
	nsc_set wCurrentMove, LEFT
	nsc_select
	nsc_left
	nsc_ret

.wrongPath
	nsc_playsound SFX_WRONG
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, IncorrectText
	nsc_waitbutton
.resetPuzzle
	;nsc_white
	;nsc_playsound SFX_WARP_FROM
	nsc_set wSolutionInvalid, 0
	nsc_page currentScreen
	nsc_ret


.scrUP
	; tile where correct direction is up
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, UP
.scrDN
	; tile where correct direction is down
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, DOWN
.scrLF
	; tile where correct direction is right
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, LEFT
.scrRT
	; tile where correct direction is left
	nsc_compare wCurrentMove, .scrXX, .valid, .scrXX, 1, RIGHT


.scrXX
	nsc_set wSolutionInvalid, 1
.valid
	; for fun!
	; but also audio feedback to let the player
	; know that the game is registering every
	; d-pad button press.
	nsc_playsound SFX_STOP_SLOT
	nsc_ret



.textPIKACHU
	lang J, db "『ピカチュウ』"
	lang E, db "PICHU"
	lang D, db "PICHU"
	lang F, db "PICHU"
	lang I, db "PICHU"
	lang S, db "PICHU"
	db "@"

	lang J, DEF HPUZZLE1_MON EQUS "PIKACHU"
	lang E, DEF HPUZZLE1_MON EQUS "PICHU"
	lang D, DEF HPUZZLE1_MON EQUS "PICHU"
	lang F, DEF HPUZZLE1_MON EQUS "PICHU"
	lang I, DEF HPUZZLE1_MON EQUS "PICHU"
	lang S, DEF HPUZZLE1_MON EQUS "PICHU"
	
	lang J, DEF PIKACHU_P EQUS "ピ"
	lang E, DEF PIKACHU_P EQUS "P"
	lang D, DEF PIKACHU_P EQUS "P"
	lang F, DEF PIKACHU_P EQUS "P"
	lang I, DEF PIKACHU_P EQUS "P"
	lang S, DEF PIKACHU_P EQUS "P"
	
	lang J, DEF PIKACHU_I EQUS "カ"
	lang E, DEF PIKACHU_I EQUS "I"
	lang D, DEF PIKACHU_I EQUS "I"
	lang F, DEF PIKACHU_I EQUS "I"
	lang I, DEF PIKACHU_I EQUS "I"
	lang S, DEF PIKACHU_I EQUS "I"
	
	lang J, DEF PIKACHU_C EQUS "チ"
	lang E, DEF PIKACHU_C EQUS "C"
	lang D, DEF PIKACHU_C EQUS "C"
	lang F, DEF PIKACHU_C EQUS "C"
	lang I, DEF PIKACHU_C EQUS "C"
	lang S, DEF PIKACHU_C EQUS "C"
	
	lang J, DEF PIKACHU_H EQUS "ュ"
	lang E, DEF PIKACHU_H EQUS "H"
	lang D, DEF PIKACHU_H EQUS "H"
	lang F, DEF PIKACHU_H EQUS "H"
	lang I, DEF PIKACHU_H EQUS "H"
	lang S, DEF PIKACHU_H EQUS "H"
	
	lang J, DEF PIKACHU_U EQUS "ウ"
	lang E, DEF PIKACHU_U EQUS "U"
	lang D, DEF PIKACHU_U EQUS "U"
	lang F, DEF PIKACHU_U EQUS "U"
	lang I, DEF PIKACHU_U EQUS "U"
	lang S, DEF PIKACHU_U EQUS "U"
	
	

.textKIRINRIKI
	lang J, db "『キリンリキ』"
	lang E, db "HO-OH"
	lang D, db "HO-OH"
	lang F, db "HO-OH"
	lang I, db "HO-OH"
	lang S, db "HO-OH"
	db "@"

	lang J, DEF HPUZZLE2_MON EQUS "GIRAFARIG"
	lang E, DEF HPUZZLE2_MON EQUS "HO_OH"
	lang D, DEF HPUZZLE2_MON EQUS "HO_OH"
	lang F, DEF HPUZZLE2_MON EQUS "HO_OH"
	lang I, DEF HPUZZLE2_MON EQUS "HO_OH"
	lang S, DEF HPUZZLE2_MON EQUS "HO_OH"

	lang J, DEF KIRINRIKI_H EQUS "キ"
	lang E, DEF KIRINRIKI_H EQUS "H"
	lang D, DEF KIRINRIKI_H EQUS "H"
	lang F, DEF KIRINRIKI_H EQUS "H"
	lang I, DEF KIRINRIKI_H EQUS "H"
	lang S, DEF KIRINRIKI_H EQUS "H"
	
	lang J, DEF KIRINRIKI_O EQUS "リ"
	lang E, DEF KIRINRIKI_O EQUS "O"
	lang D, DEF KIRINRIKI_O EQUS "O"
	lang F, DEF KIRINRIKI_O EQUS "O"
	lang I, DEF KIRINRIKI_O EQUS "O"
	lang S, DEF KIRINRIKI_O EQUS "O"
	
	lang J, DEF KIRINRIKI__ EQUS "ン"
	lang E, DEF KIRINRIKI__ EQUS "-"
	lang D, DEF KIRINRIKI__ EQUS "-"
	lang F, DEF KIRINRIKI__ EQUS "-"
	lang I, DEF KIRINRIKI__ EQUS "-"
	lang S, DEF KIRINRIKI__ EQUS "-"
	


.textYANMA
	lang J, db "『ヤンヤンマ』"
	lang E, db "DODUO"
	lang D, db "KOKOWEI"
	lang F, db "DODUO"
	lang I, db "DODUO"
	lang S, db "DODUO"
	db "@"

	lang J, DEF HPUZZLE3_MON EQUS "YANMA"
	lang E, DEF HPUZZLE3_MON EQUS "DODUO"
	lang D, DEF HPUZZLE3_MON EQUS "EXEGGUTOR"
	lang F, DEF HPUZZLE3_MON EQUS "DODUO"
	lang I, DEF HPUZZLE3_MON EQUS "DODUO"
	lang S, DEF HPUZZLE3_MON EQUS "DODUO"
	
	lang J, DEF YANMA_M EQUS "ヤ"
	lang E, DEF YANMA_D EQUS "D"
	lang D, DEF YANMA_K EQUS "K"
	lang F, DEF YANMA_D EQUS "D"
	lang I, DEF YANMA_D EQUS "D"
	lang S, DEF YANMA_D EQUS "D"
	
	lang J, DEF YANMA_U EQUS "ン"
	lang E, DEF YANMA_O EQUS "O"
	lang D, DEF YANMA_O EQUS "O"
	lang F, DEF YANMA_O EQUS "O"
	lang I, DEF YANMA_O EQUS "O"
	lang S, DEF YANMA_O EQUS "O"
	
	lang J, DEF YANMA_K EQUS "マ"
	lang E, DEF YANMA_U EQUS "U"
	lang D, DEF YANMA_W EQUS "W"
	lang F, DEF YANMA_U EQUS "U"
	lang I, DEF YANMA_U EQUS "U"
	lang S, DEF YANMA_U EQUS "U"
	
	lang D, DEF YANMA_E EQUS "E"
	lang D, DEF YANMA_I EQUS "I"


.textHARIISEN
	lang J, db "『ハリーセン』"
	lang E, db "ZUBAT"
	lang D, db "ZUBAT"
	lang F, db "QUAXO"
	lang I, db "ZUBAT"
	lang S, db "ZUBAT"
	db "@"

	lang J, DEF HPUZZLE4_MON EQUS "QWILFISH"
	lang E, DEF HPUZZLE4_MON EQUS "ZUBAT"
	lang D, DEF HPUZZLE4_MON EQUS "ZUBAT"
	lang F, DEF HPUZZLE4_MON EQUS "POLITOED"
	lang I, DEF HPUZZLE4_MON EQUS "ZUBAT"
	lang S, DEF HPUZZLE4_MON EQUS "ZUBAT"
	
	lang J, DEF HARIISEN_Z EQUS "ハ"
	lang E, DEF HARIISEN_Z EQUS "Z"
	lang D, DEF HARIISEN_Z EQUS "Z"
	lang F, DEF HARIISEN_Z EQUS "Q"
	lang I, DEF HARIISEN_Z EQUS "Z"
	lang S, DEF HARIISEN_Z EQUS "Z"
	
	lang J, DEF HARIISEN_U EQUS "リ"
	lang E, DEF HARIISEN_U EQUS "U"
	lang D, DEF HARIISEN_U EQUS "U"
	lang F, DEF HARIISEN_U EQUS "U"
	lang I, DEF HARIISEN_U EQUS "U"
	lang S, DEF HARIISEN_U EQUS "U"
	
	lang J, DEF HARIISEN_B EQUS "ー"
	lang E, DEF HARIISEN_B EQUS "B"
	lang D, DEF HARIISEN_B EQUS "B"
	lang F, DEF HARIISEN_B EQUS "A"
	lang I, DEF HARIISEN_B EQUS "B"
	lang S, DEF HARIISEN_B EQUS "B"
	
	lang J, DEF HARIISEN_A EQUS "セ"
	lang E, DEF HARIISEN_A EQUS "A"
	lang D, DEF HARIISEN_A EQUS "A"
	lang F, DEF HARIISEN_A EQUS "X"
	lang I, DEF HARIISEN_A EQUS "A"
	lang S, DEF HARIISEN_A EQUS "A"
	
	lang J, DEF HARIISEN_T EQUS "ン"
	lang E, DEF HARIISEN_T EQUS "T"
	lang D, DEF HARIISEN_T EQUS "T"
	lang F, DEF HARIISEN_T EQUS "O"
	lang I, DEF HARIISEN_T EQUS "T"
	lang S, DEF HARIISEN_T EQUS "T"
	

.textWINDY
	lang J, db "『ウインディ』"
	lang E, db "ARBOK"
	lang D, db "ARBOK"
	lang F, db "ARBOK"
	lang I, db "ARBOK"
	lang S, db "ARBOK"
	db "@"

	lang J, DEF HPUZZLE5_MON EQUS "ARCANINE"
	lang E, DEF HPUZZLE5_MON EQUS "ARBOK"
	lang D, DEF HPUZZLE5_MON EQUS "ARBOK"
	lang F, DEF HPUZZLE5_MON EQUS "ARBOK"
	lang I, DEF HPUZZLE5_MON EQUS "ARBOK"
	lang S, DEF HPUZZLE5_MON EQUS "ARBOK"

	lang J, DEF WINDY_A EQUS "ウ"
	lang E, DEF WINDY_A EQUS "A"
	lang D, DEF WINDY_A EQUS "A"
	lang F, DEF WINDY_A EQUS "A"
	lang I, DEF WINDY_A EQUS "A"
	lang S, DEF WINDY_A EQUS "A"
	
	lang J, DEF WINDY_R EQUS "イ"
	lang E, DEF WINDY_R EQUS "R"
	lang D, DEF WINDY_R EQUS "R"
	lang F, DEF WINDY_R EQUS "R"
	lang I, DEF WINDY_R EQUS "R"
	lang S, DEF WINDY_R EQUS "R"
	
	lang J, DEF WINDY_B EQUS "ン"
	lang E, DEF WINDY_B EQUS "B"
	lang D, DEF WINDY_B EQUS "B"
	lang F, DEF WINDY_B EQUS "B"
	lang I, DEF WINDY_B EQUS "B"
	lang S, DEF WINDY_B EQUS "B"
	
	lang J, DEF WINDY_O EQUS "デ"
	lang E, DEF WINDY_O EQUS "O"
	lang D, DEF WINDY_O EQUS "O"
	lang F, DEF WINDY_O EQUS "O"
	lang I, DEF WINDY_O EQUS "O"
	lang S, DEF WINDY_O EQUS "O"
	
	lang J, DEF WINDY_K EQUS "ィ"
	lang E, DEF WINDY_K EQUS "K"
	lang D, DEF WINDY_K EQUS "K"
	lang F, DEF WINDY_K EQUS "K"
	lang I, DEF WINDY_K EQUS "K"
	lang S, DEF WINDY_K EQUS "K"
	

DEF PUZZLE_COUNT = 0

MACRO define_hpuzzle
DEF PUZZLE_COUNT = PUZZLE_COUNT + 1
DEF HPUZZLE{d:PUZZLE_COUNT}_MON_NAME EQUS ".text\1"
DEF HPUZZLE{d:PUZZLE_COUNT}_MON_NAME_2 EQUS "\1"
SHIFT 1
DEF loopindex = 1
REPT (5*9) - 2
DEF HPUZZLE{d:PUZZLE_COUNT}_GFX{02d:loopindex} EQUS "{HPUZZLE{d:PUZZLE_COUNT}_MON_NAME_2}_\1"
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
DEF loopindex = 0
REPT (5*9) - 1
DEF HPUZZLE{d:PUZZLE_COUNT}_ANSWER{02d:loopindex} EQU .scr\1
DEF loopindex = loopindex + 1
SHIFT 1
ENDR
ENDM

	define_hpuzzle PIKACHU,\
				\
				   P, I, C, H, U, P, I, C,\
				C, I, U, H, P, C, H, U, U,\
				H, H, U, P, P, I, P, P, H,\
				U, C, C, I, U, C, C, I, U,\
				P, I, U, C, H, U, H, U,\
				\
				RT, DN, XX, XX, XX, XX, XX, XX, XX, \
				DN, LF, XX, XX, XX, RT, RT, DN, XX, \
				DN, RT, RT, DN, RT, UP, XX, DN, XX, \
				DN, UP, XX, DN, UP, XX, DN, LF, XX, \
				RT, UP, XX, RT, UP, XX, RT, RT

	define_hpuzzle KIRINRIKI,\
				\
				   H, O, _, H, O, H, H, O,\
				_, O, _, O, O, _, H, _, H,\
				O, _, O, H, H, _, _, _, O,\
				H, O, O, _, _, H, H, O, H,\
				H, H, H, O, _, O, _, _,\
				\
				RT, DN, XX, XX, XX, XX, XX, XX, XX, \
				XX, DN, XX, XX, XX, XX, XX, XX, XX, \
				XX, DN, XX, XX, XX, XX, XX, RT, DN, \
				XX, DN, XX, XX, XX, RT, RT, UP, DN, \
				XX, RT, RT, RT, RT, UP, XX, XX

IF DEF(_LANG_J)
	define_hpuzzle YANMA,\
				\
				   M, U, U, M, U, M, U, K,\
				M, K, M, U, K, M, U, M, U,\
				U, M, U, K, M, K, U, M, K,\
				M, M, U, M, K, U, M, U, K,\
				U, K, K, U, K, U, K, M,\
				\
				RT, RT, DN, XX, XX, XX, XX, XX, XX, \
				XX, XX, RT, RT, RT, RT, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, DN, LF, LF, \
				XX, XX, XX, XX, XX, XX, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, XX, XX
ELIF DEF(_LANG_D)
	define_hpuzzle YANMA,\
				\
				   K, O, O, K, O, K, O, K, \
				K, E, K, O, W, E, I, K, O, \
				O, K, O, W, I, E, W, O, K, \
				K, E, I, K, K, O, K, E, I, \
				O, W, K, O, K, O, O, W, \
				\
				RT, RT, DN, XX, XX, XX, XX, XX, XX, \
				XX, XX, RT, RT, RT, RT, RT, RT, DN, \
				XX, XX, XX, XX, DN, LF, LF, LF, LF, \
				XX, XX, XX, XX, RT, RT, DN, RT, DN, \
				XX, XX, XX, XX, XX, XX, RT, UP
ELSE
	define_hpuzzle YANMA,\
				\
				   D, O, O, D, O, D, U, O, \
				D, U, D, U, O, D, O, D, U, \
				O, D, U, O, D, O, O, D, O, \
				D, D, O, D, O, U, D, U, O, \
				U, O, O, U, O, U, O, D, \
				\
				RT, RT, DN, XX, XX, XX, XX, XX, XX, \
				XX, XX, RT, RT, RT, RT, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, DN, LF, LF, \
				XX, XX, XX, XX, XX, XX, RT, RT, DN, \
				XX, XX, XX, XX, XX, XX, XX, XX
ENDC

	define_hpuzzle HARIISEN,\
				\
				   Z, A, T, Z, B, A, T, Z,\
				Z, U, B, U, Z, U, U, Z, U,\
				U, A, T, A, T, A, B, A, Z,\
				B, U, Z, B, Z, T, B, A, T,\
				A, T, Z, U, Z, Z, U, Z,\
				\
				DN, XX, XX, XX, XX, RT, RT, DN, XX, \
				DN, XX, XX, XX, RT, UP, DN, LF, XX, \
				DN, XX, XX, RT, UP, DN, LF, XX, XX, \
				DN, XX, XX, UP, XX, DN, RT, RT, DN, \
				RT, RT, RT, UP, XX, RT, UP, XX

	define_hpuzzle WINDY,\
				\
				   A, K, B, O, K, A, R, B,\
				B, R, K, A, R, B, O, R, A,\
				O, B, O, R, R, O, R, A, K,\
				K, B, R, K, A, K, B, O, K,\
				A, R, B, O, R, A, R, R,\
				\
				RT, DN, XX, XX, XX, XX, XX, XX, XX, \
				XX, DN, RT, RT, RT, DN, XX, XX, XX, \
				XX, RT, UP, XX, XX, DN, XX, XX, XX, \
				XX, XX, XX, XX, XX, DN, RT, RT, DN, \
				XX, XX, XX, XX, XX, RT, UP, XX





.checkHard
	nsc_compare wNewsMenuCursorX, .nothing, .checkAnswer, .nothing, 2, 9, 5
.checkAnswer
	;nsc_playsound SFX_TRANSACTION
	nsc_compare wSolutionInvalid, .wrongPath, .pass, .wrongPath, 1, 0
.pass
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, CorrectText
	nsc_playsound SFX_LEVEL_UP

	nsc_drawbox 5, 3, 9, 9, NEWSBORDER_STRIPED, 5;{NEWS_MAIN_BORDER}


	nsc_add wCurrentPuzzle, 1
;	nsc_compare wCurrentPuzzle, .nextPuzzle, .gift, .gift, 1, 5 ; 5 easy puzzles
	nsc_compare wCurrentPuzzle, .puzzle1complete, .puzzle2complete, .higher, 1, 2
.higher
	nsc_compare wCurrentPuzzle, .puzzle3complete, .puzzle4complete, .puzzle5complete, 1, 4

.puzzle1complete
	nsc_drawmon 6, 4, HPUZZLE1_MON,  $03, $07
	nsc_waitbutton
.nextPuzzle
	nsc_page currentScreen
.nothing
	nsc_ret

.puzzle2complete
	nsc_drawmon 6, 4, HPUZZLE2_MON,  $03, $07
	nsc_waitbutton
	nsc_page currentScreen
	nsc_ret

.puzzle3complete
	nsc_drawmon 6, 4, HPUZZLE3_MON,  $03, $07
	nsc_waitbutton
	nsc_page currentScreen
	nsc_ret

.puzzle4complete
	nsc_drawmon 6, 4, HPUZZLE4_MON,  $03, $07
	nsc_waitbutton
	nsc_page currentScreen
	nsc_ret

.puzzle5complete
	nsc_drawmon 6, 4, HPUZZLE5_MON,  $03, $07
	nsc_waitbutton

.gift
	nsc_bit_newsvar sMinigameFlag, 1, .noGift, .giveGift
.giveGift
	nsc_giveitem BLUESKY_MAIL, 3, .recordGift, .noGift
.recordGift
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .getGiftText
	nsc_flagop sMinigameFlag, 1, FLAG_SET
	nsc_playsound SFX_ITEM
	nsc_waitbutton
.noGift
	nsc_page NewsRoot ; TODO: maze selection?

.getGiftText
	; TODO: potentially the wrong string? plz check
	lang J, text "あおそらメールを　もらった！"

	lang E, text
	lang E, nts_start
	lang E, nts_player_name 0
	lang E, nts_end
	lang E, db   " received"
	lang E, line "BLUESKY MAIL."

	; German
	lang D, text
	lang D, nts_start
	lang D, nts_player_name 0
	lang D, nts_end
	lang D, db   " erhält"
	lang D, line "KOBALTBRIEF."

	lang F, text "?"

	lang I, text "?"

	lang S, text
	lang S, nts_start
	lang S, nts_player_name 0
	lang S, nts_end
	lang S, db   " recibido"
	lang S, line "CARTACELESTE."
	
	done





.menuDescName
	nts_start
	nts_switch wCurrentPuzzle, HPUZZLE1_MON_NAME, HPUZZLE2_MON_NAME, HPUZZLE3_MON_NAME, HPUZZLE4_MON_NAME, HPUZZLE5_MON_NAME
	nts_end
	db "@"





; include puzzles that were defined earlier
;DEF loopindex = 1
;REPT (9*5) - 2
;.txt{02d:loopindex}
;	nts_start
;	nts_switch wCurrentPuzzle, \
;	HPUZZLE1_GFX{02d:loopindex}, \
;	HPUZZLE2_GFX{02d:loopindex}, \
;	HPUZZLE3_GFX{02d:loopindex}, \
;	HPUZZLE4_GFX{02d:loopindex}, \
;	HPUZZLE5_GFX{02d:loopindex}
;	nts_end
;	db "@"
;DEF loopindex = loopindex + 1
;ENDR


.puzzleGFX
	nts_start
	nts_switch wCurrentPuzzle, \
	.puzzle1GFX, \
	.puzzle2GFX, \
	.puzzle3GFX, \
	.puzzle4GFX, \
	.puzzle5GFX
	nts_end
.dummyGFX
	db "@"



DEF puzzleindex = 1
REPT 5
.puzzle{d:puzzleindex}GFX
DEF loopindex = 1
	db "× "
REPT (9*5) - 2
	db "{{HPUZZLE{d:puzzleindex}_GFX{02d:loopindex}}}"
;REPT 4 - STRLEN(PUZZLE{d:puzzleindex}_GFX{02d:loopindex})
IF loopindex % 9 != 8
	db " "
;ENDR
;ENDR
ELSE
	next
ENDC
	DEF loopindex = loopindex + 1
ENDR
	db "!"
	db "@"
DEF puzzleindex = puzzleindex + 1
ENDR


DEF loopindex = 0
REPT (9*5) - 1
.scr{02d:loopindex}
	nsc_compare wCurrentPuzzle, HPUZZLE1_ANSWER{02d:loopindex}, HPUZZLE2_ANSWER{02d:loopindex}, .scr{02d:loopindex}greater, 1, 1
	lang S, text "¡Correcto!"
.scr{02d:loopindex}greater
	nsc_compare wCurrentPuzzle, HPUZZLE3_ANSWER{02d:loopindex}, HPUZZLE4_ANSWER{02d:loopindex}, HPUZZLE5_ANSWER{02d:loopindex}, 1, 3
DEF loopindex = loopindex + 1
ENDR








CorrectText:
	lang J, text "せいかい！！"
	lang E, text "Correct!"
	lang D, text "Richtig!"
	lang F, text "?"
	lang I, text "?"
	lang S, text "¡Correcto!"
	done

IncorrectText:
	; Japanese
	lang J, text "ざんねん…まちがえちゃった！"
	; English
	lang E, text "Oops…"
	lang E, line "You messed up!"
	lang D, text "Schade… Das war"
	lang D, line "nicht richtig!"
	lang F, text "?"
	lang I, text "?"
	lang S, text "Uy…"
	lang S, line "¡Te equivocaste!"
	done


Quit:
	nsc_playsound SFX_MENU
	nsc_page NewsRoot
	nsc_ret



;textXX:
;	db "×"
;	db "@"
;txtEND:
;	db "!"
;	db "@"
















ENDC
