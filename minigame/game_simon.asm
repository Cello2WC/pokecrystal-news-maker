IF DEF(_MINIGAME_H)

DEF PERSISTENT_MINIGAME_DATA_SIZE EQU 1

DEF wCurrentCrySet EQUS "wNewsScratch0"
DEF wCurrentStreak EQUS "wNewsScratch1"
DEF wCurrentIndex  EQUS "wNewsScratch2"
DEF wCrySequence1  EQUS "wNewsScratch3"
DEF wCrySequence2  EQUS "wNewsScratch4"
DEF wCrySequence3  EQUS "wRankingsCategory"
DEF wCrySequence4  EQUS "wRankingsType"
DEF wCrySequence5  EQUS "wRankingsTable"
DEF wCurDirection  EQUS "wNumListedPlayers"
DEF wMathScratch   EQUS "wOwnRank"
DEF wMathScratch2  EQUS "wNumRankedPlayers"

MACRO minigame_start
	nsc_page CrySetSelect
ENDM

MACRO minigame_name
	; Japanese
	lang J, "ポケモン　つづくかな？"
	
	; English
	lang E, "#RAP IT UP!"
	lang D, "#MON-PLAUDEREI!"
	lang F, "?"
	lang I, "?"
	lang S, "?"
ENDM

; deprecating this, at least for now, 
; as it seems it might not have existed.

;MACRO minigame_desc
;ENDM

ELSE
MinigameStart::
	news_screen CrySetSelect, MUSIC_SHOW_ME_AROUND
	news_def_pals
	
	news_def_boxes
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 1, 2, ""
	minigame_name
	db "@"
	
	news_menu 2, 5, 1, 4, 0, 2, 16, 4, 7, 4, SHOW_DESCRIPTIONS | SHOW_ARROWS, 4
	
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
	
	news_menuitem_names   .menuGameInstructionName,   .menuCrySet1Name,   .menuCrySet2Name,   .menuCrySet3Name,   .menuCancelName
	news_menuitem_scripts .menuGameInstructionScript, .menuCrySet1Script, .menuCrySet2Script, .menuCrySet3Script, .menuCancelScript
	news_menuitem_descs   .menuGameInstructionDesc,   .menuCrySet1Desc,   .menuCrySet2Desc,   .menuCrySet3Desc,   .menuCancelDesc
	
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
.menuCancelScript
	nsc_page NewsRoot
	nsc_ret
	
.menuCrySet1Name
	lang J, "なきごえセット　１"
	lang E, "CRY SET 1"
	lang D, "RUF-SET 1"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuCrySet2Name
	lang J, "なきごえセット　２"
	lang E, "CRY SET 2"
	lang D, "RUF-SET 2"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuCrySet3Name
	lang J, "なきごえセット　３"
	lang E, "CRY SET 3"
	lang D, "RUF-SET 3"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuGameInstructionName
	lang J, "ゲームの　せつめい"
	lang E, "GAME EXPLANATION"
	lang D, "SPIELREGELN"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuCancelName
	lang J, "もどる"
	lang E, "CANCEL"
	lang D, "ZURÜCK"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
	
MACRO def_cryset
DEF CRYSET\1_UP_MON      EQU \2
DEF CRYSET\1_DOWN_MON    EQU \3
DEF CRYSET\1_LEFT_MON    EQU \4
DEF CRYSET\1_RIGHT_MON   EQU \5
DEF CRYSET\1_BIG_PRIZE   EQU \6
DEF CRYSET\1_BIG_PRIZE_2 EQU \7
ENDM
	
	def_cryset 1, IGGLYBUFF, TOGEPI,   CLEFFA,     PICHU,     BIG_PEARL, PNK_APRICORN
	def_cryset 2, BULBASAUR, PIKACHU,  CHARMANDER, SQUIRTLE,  STARDUST,  GRN_APRICORN
	def_cryset 3, POLIWAG,   POLITOED, POLIWRATH,  POLIWHIRL, TM_REST,   YLW_APRICORN
	
.menuCrySet1Script
	nsc_set wCurrentCrySet, 1
	nsc_set wCurrentIndex, -2
	nsc_set wNumListedPlayers, 16
	nsc_page CryGame
	nsc_ret
	
.menuCrySet2Script
	nsc_set wCurrentCrySet, 2
	nsc_set wCurrentIndex, -2
	nsc_set wNumListedPlayers, 16
	nsc_page CryGame
	nsc_ret
.menuCrySet3Script
	nsc_set wCurrentCrySet, 3
	nsc_set wCurrentIndex, -2
	nsc_set wNumListedPlayers, 16
	nsc_page CryGame
	nsc_ret
	
	
.menuGameInstructionScript
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .gameInstructionText
	nsc_ret

.gameInstructionText
	; Japanese
	lang_text J, "まず　ゲームに　つかうための"
	lang_line J, "すきな　なきごえの　セットを"
	lang_cont J, "えらんで　ください"
	
	lang_para J, "えらぶと　ゲームが　はじまります"
	lang_line J, "がめんの　まんなかから　みて"
	lang_cont J, "うえ・した・ひだり・みぎの　どこかに"
	lang_cont J, "ポケモンが　あらわれて　なきます"
	
	lang_para J, "そのあと　ポケモンが　がめんの"
	lang_line J, "どこに　あらわれたか"
	lang_cont J, "じゅうじボタンで　まちがわず"
	lang_cont J, "おすことが　できたら　せいかいです"
	
	lang_para J, "ポケモンの　あらわれる　かずは"
	lang_line J, "だんだん　おおく　なって　いくので"
	lang_cont J, "じゅんばんを　おぼえて"
	lang_cont J, "じゅうじボタンで"
	lang_cont J, "くりかえして　いきましょう"
	
	lang_para J, "ぜんぶで　２０かい　じゅんばんを"
	lang_line J, "ただしく　くりかえせば　クリア！"
	lang_cont J, "それでは　はじめよう！"
	
	; English
	lang_text E, "First, choose a"
	lang_line E, "cry set to use."

	lang_para E, "Pick the one"
	lang_line E, "you like best."

	lang_para E, "Once chosen, the"
	lang_line E, "game will begin!"

	lang_para E, "Watch the center"
	lang_line E, "of the screen."

	lang_para E, "A #MON will let"
	lang_line E, "out a loud cry!"

	lang_para E, "It will come from"
	lang_line E, "up, down, left or"
	lang_cont E, "right--so listen"
	lang_cont E, "up!"

	lang_para E, "Press the matching"
	lang_line E, "direction on the"
	lang_cont E, "Control Pad."

	lang_para E, "Get it right and"
	lang_line E, "you’ll move ahead!"

	lang_para E, "More #MON will"
	lang_line E, "show up each round"
	lang_cont E, "so try to remember"
	lang_cont E, "how they appear!"

	lang_para E, "Wrap up twenty"
	lang_line E, "rounds in a row"
	lang_cont E, "to win the game!"

	lang_para E, "Let's get started!"
	
	; German
	lang_text D, "Wähle zunächst"
	lang_line D, "ein Ruf-Set aus."

	lang_para D, "Wähle dein"
	lang_line D, "Favoriten-Set."

	lang_para D, "Danach beginnt"
	lang_line D, "das Spiel!"

	lang_para D, "Konzentriere dich"
	lang_line D, "auf die Bild-"
	lang_cont D, "schirmmitte."

	lang_para D, "Ein #MON stößt"
	lang_line D, "seinen Ruf aus!"

	lang_para D, "Es kann von oben,"
	lang_line D, "unten, links oder"
	lang_cont D, "rechts kommen."
	lang_cont D, "Also hör gut zu!"

	lang_para D, "Drücke die"
	lang_line D, "passende Richtung"
	lang_cont D, "auf dem"
	lang_cont D, "Steuerkreuz."

	lang_para D, "Liegst du richtig,"
	lang_line D, "geht es in die"
	lang_cont D, "nächste Runde!"

	lang_para D, "Mit jeder Runde"
	lang_line D, "erscheinen mehr"
	lang_cont D, "#MON. Versuche,"
	lang_cont D, "dir die Reihen-"
	lang_cont D, "folge einzuprägen."

	lang_para D, "Schaffst du es,"
	lang_line D, "20 Runden durch-"
	lang_cont D, "zuhalten, gewinnst"
	lang_cont D, "du das Spiel!"

	lang_para D, "Und los geht's!"
		
	lang_text F, "?"
	
	lang_text I, "?"
	
	lang S,      "?"

	para ""
	done
	
; TODO: did this text even exist?
.menuCrySet1Desc
.menuCrySet2Desc
.menuCrySet3Desc
.menuGameInstructionDesc
.menuCancelDesc
	db "?@"
	
	

	
	
	news_screen CryGame, MUSIC_SHOW_ME_AROUND;MUSIC_VIRIDIAN_CITY
	news_def_pals
	
	news_def_boxes
	news_box  0,  0, 20, 18, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 0, 0, "@"
	
	;news_menu 4, 9, 1, 1, 0, 0, -1, 0, 0, 0, 0, 0
	news_menu 2, 14, 1, 1, 0, 0, -1, 0, 0, 0, 0, 0
	
	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript 
	news_buttonscript .start_button
	news_buttonscript .right_button
	news_buttonscript .left_button
	news_buttonscript .up_button
	news_buttonscript .down_button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	
	news_norankingstable
	
	news_menuitem_names   .pressStartText,  .menuDummyName,   .menuDummyName,   .menuDummyName, .menuDummyName
	news_menuitem_scripts .cry_up,          .cry_down,        .cry_left,        .cry_right,     .checkNextDir
	news_menuitem_descs   .menuDummyName,   .menuDummyName,   .menuDummyName,   .menuDummyName, .menuDummyName
	
	; no record of this text actually existing.
	; maybe the whole game worked differently??
.pressStartText
;	lang J, "スタートボタンを　おして！"
;	lang E, "PRESS START!"
;	lang D, "Drücke START!"
;	lang F, "?"
;	lang I, "?"
;	lang S, "?"

	lang J, "なきごえセット"
	lang E, "CRY SET"
	lang D, "RUF-SET"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	
	nts_start
	nts_number wCurrentCrySet, 1, 2
	nts_end
	
	
.menuDummyName
	db "@"
	
.b_button
	nsc_playsound SFX_MENU
	nsc_page CrySetSelect
.nothing
	nsc_ret
	
DEF UP_BITS    EQU %00_00_00_00
DEF DOWN_BITS  EQU %01_01_01_01
DEF LEFT_BITS  EQU %10_10_10_10
DEF RIGHT_BITS EQU %11_11_11_11

.up_button
	nsc_compare wCurrentIndex, .up_button_continue, .nothing, .nothing, 1, -2
.up_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 0
	nsc_select
	nsc_set wCurDirection, UP_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_up
	nsc_compare wCurrentCrySet, .cryset1_up, .cryset2_up, .cryset3_up, 1, 2
.cryset1_up
	nsc_drawmon  6, 1, CRYSET1_UP_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_ret
;	nsc_delay 3
.cryset2_up
	nsc_drawmon  6, 1, CRYSET2_UP_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_ret
.cryset3_up
	nsc_drawmon  6, 1, CRYSET3_UP_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_ret
	
.down_button
	nsc_compare wCurrentIndex, .down_button_continue, .nothing, .nothing, 1, -2
.down_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 1
	nsc_select
	nsc_set wCurDirection, DOWN_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_down
	nsc_compare wCurrentCrySet, .cryset1_down, .cryset2_down, .cryset3_down, 1, 2
.cryset1_down
	nsc_drawmon  6, 9, CRYSET1_DOWN_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_ret
.cryset2_down
	nsc_drawmon  6, 9, CRYSET2_DOWN_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_ret
.cryset3_down
	nsc_drawmon  6, 9, CRYSET3_DOWN_MON, ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_ret
	
.left_button
	nsc_compare wCurrentIndex, .left_button_continue, .nothing, .nothing, 1, -2
.left_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 2
	nsc_select
	nsc_set wCurDirection, LEFT_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_left
	nsc_compare wCurrentCrySet, .cryset1_left, .cryset2_left, .cryset3_left, 1, 2
.cryset1_left
	nsc_drawmon  1, 5, CRYSET1_LEFT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_ret
.cryset2_left
	nsc_drawmon  1, 5, CRYSET2_LEFT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_ret
.cryset3_left
	nsc_drawmon  1, 5, CRYSET3_LEFT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_ret
	
.right_button
	nsc_compare wCurrentIndex, .right_button_continue, .nothing, .nothing, 1, -2
.right_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 3
	nsc_select
	nsc_set wCurDirection, RIGHT_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_right
	nsc_compare wCurrentCrySet, .cryset1_right, .cryset2_right, .cryset3_right, 1, 2
.cryset1_right
	nsc_drawmon  11, 5, CRYSET1_RIGHT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    11, 5, 7, 7
	nsc_ret
.cryset2_right
	nsc_drawmon  11, 5, CRYSET2_RIGHT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    11, 5, 7, 7
	nsc_ret
.cryset3_right
	nsc_drawmon  11, 5, CRYSET3_RIGHT_MON, ANIM_MON_NORMAL, 7
	nsc_clear    11, 5, 7, 7
	nsc_ret
	
.preview
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 0
	nsc_select
	nsc_set wNewsMenuOption, 1
	nsc_select
	nsc_set wNewsMenuOption, 2
	nsc_select
	nsc_set wNewsMenuOption, 3
	nsc_select
	
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_textbox 1, 14, .thisSetText
	nsc_yesno 13, 7, .useThisSet, .notThisSet
.notThisSet
	nsc_page CrySetSelect
	
.useThisSet
	nsc_set wCurrentStreak, 0
	nsc_set wCurrentIndex, -1

	; generate cry sequence
	; (thankfully the powers of two are kind to us)
	nsc_ramcopy hRandomAdd, wCrySequence1, 2
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wCrySequence3, 2
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wCrySequence5, 1
	
	nsc_playmusic MUSIC_VIRIDIAN_CITY
	
	; fall thru
.a_button
.start_button
	nsc_compare wCurrentIndex, .nothing, .preview, .start_button_continue, 1, -2
.start_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
		
DEF cryindex = 0
REPT 20
DEF crysequencebyte = (cryindex/4)+1
DEF nextcryindex = cryindex + 1
.cry{d:cryindex}
	nsc_bit wCrySequence{d:crysequencebyte}, ((cryindex * 2) % 8), .cry{d:cryindex}_odd, .cry{d:cryindex}_even   ; 0
.cry{d:cryindex}_odd
	nsc_bit wCrySequence{d:crysequencebyte}, ((cryindex * 2) % 8) + 1, .cry{d:cryindex}_RIGHT, .cry{d:cryindex}_DOWN ; 1
.cry{d:cryindex}_even
	nsc_bit wCrySequence{d:crysequencebyte}, ((cryindex * 2) % 8) + 1, .cry{d:cryindex}_LEFT, .cry{d:cryindex}_UP    ; 1
.cry{d:cryindex}_UP
	nsc_set wNewsMenuOption, 0
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
.cry{d:cryindex}_DOWN
	nsc_set wNewsMenuOption, 1
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
.cry{d:cryindex}_LEFT
	nsc_set wNewsMenuOption, 2
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
.cry{d:cryindex}_RIGHT
	nsc_set wNewsMenuOption, 3
	nsc_select
	nsc_compare wCurrentStreak, .yourTurn, .yourTurn, .cry{d:nextcryindex}, 1, cryindex
DEF cryindex = cryindex + 1
ENDR
.cry20
.yourTurn

;IF DEF(_LANG_J)
;	nsc_printstring 3, 8, .textYourTurn
;ELSE
;	nsc_printstring 2, 8, .textYourTurn
;ENDC

	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_printstring 1, 14, .textYourTurn

	nsc_playsound SFX_TWINKLE;SFX_HIT_END_OF_EXP_BAR;SFX_TWO_PC_BEEPS
	nsc_set wCurrentIndex, 0
	nsc_ret
	
	
	
.checkNextDir
	nsc_ramcopy wCurrentIndex, wMathScratch, 1
	nsc_flagop wMathScratch, FLAG_CLEAR, 0
	nsc_flagop wMathScratch, FLAG_CLEAR, 1
	
	nsc_compare wMathScratch, .sequence00to03, .sequence04to07, .higher, 1, 1 << 2
.higher
	nsc_compare wMathScratch, .sequence08to11, .sequence12to15, .sequence16to19, 1, 3 << 2
.sequence00to03
	nsc_ramcopy wCrySequence1, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence04to07
	nsc_ramcopy wCrySequence2, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence08to11
	nsc_ramcopy wCrySequence3, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence12to15
	nsc_ramcopy wCrySequence4, wMathScratch2, 1
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin, .sequenceCheckRejoin
.sequence16to19
	nsc_ramcopy wCrySequence5, wMathScratch2, 1
.sequenceCheckRejoin
	nsc_ramcopy wCurrentIndex, wMathScratch, 1
	nsc_flagop wMathScratch, FLAG_CLEAR, 2
	nsc_flagop wMathScratch, FLAG_CLEAR, 3
	nsc_flagop wMathScratch, FLAG_CLEAR, 4
	nsc_flagop wMathScratch, FLAG_CLEAR, 5
	nsc_flagop wMathScratch, FLAG_CLEAR, 6
	nsc_flagop wMathScratch, FLAG_CLEAR, 7
	
	nsc_bit wMathScratch, 0, .sequence_odd, .sequence_even
.sequence_odd
	nsc_bit wMathScratch, 1, .sequence03, .sequence01
.sequence_even
	nsc_bit wMathScratch, 1, .sequence02, .sequence00
.sequence00
	nsc_flagop wCurDirection, FLAG_CLEAR, 2
	nsc_flagop wCurDirection, FLAG_CLEAR, 3
	nsc_flagop wCurDirection, FLAG_CLEAR, 4
	nsc_flagop wCurDirection, FLAG_CLEAR, 5
	nsc_flagop wCurDirection, FLAG_CLEAR, 6
	nsc_flagop wCurDirection, FLAG_CLEAR, 7
	nsc_flagop wMathScratch2, FLAG_CLEAR, 2
	nsc_flagop wMathScratch2, FLAG_CLEAR, 3
	nsc_flagop wMathScratch2, FLAG_CLEAR, 4
	nsc_flagop wMathScratch2, FLAG_CLEAR, 5
	nsc_flagop wMathScratch2, FLAG_CLEAR, 6
	nsc_flagop wMathScratch2, FLAG_CLEAR, 7
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin2, .sequenceCheckRejoin2
.sequence01
	nsc_flagop wCurDirection, FLAG_CLEAR, 0
	nsc_flagop wCurDirection, FLAG_CLEAR, 1
	nsc_flagop wCurDirection, FLAG_CLEAR, 4
	nsc_flagop wCurDirection, FLAG_CLEAR, 5
	nsc_flagop wCurDirection, FLAG_CLEAR, 6
	nsc_flagop wCurDirection, FLAG_CLEAR, 7
	nsc_flagop wMathScratch2, FLAG_CLEAR, 0
	nsc_flagop wMathScratch2, FLAG_CLEAR, 1
	nsc_flagop wMathScratch2, FLAG_CLEAR, 4
	nsc_flagop wMathScratch2, FLAG_CLEAR, 5
	nsc_flagop wMathScratch2, FLAG_CLEAR, 6
	nsc_flagop wMathScratch2, FLAG_CLEAR, 7
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin2, .sequenceCheckRejoin2
.sequence02
	nsc_flagop wCurDirection, FLAG_CLEAR, 0
	nsc_flagop wCurDirection, FLAG_CLEAR, 1
	nsc_flagop wCurDirection, FLAG_CLEAR, 2
	nsc_flagop wCurDirection, FLAG_CLEAR, 3
	nsc_flagop wCurDirection, FLAG_CLEAR, 6
	nsc_flagop wCurDirection, FLAG_CLEAR, 7
	nsc_flagop wMathScratch2, FLAG_CLEAR, 0
	nsc_flagop wMathScratch2, FLAG_CLEAR, 1
	nsc_flagop wMathScratch2, FLAG_CLEAR, 2
	nsc_flagop wMathScratch2, FLAG_CLEAR, 3
	nsc_flagop wMathScratch2, FLAG_CLEAR, 6
	nsc_flagop wMathScratch2, FLAG_CLEAR, 7
	nsc_bit wMathScratch2, 0, .sequenceCheckRejoin2, .sequenceCheckRejoin2
.sequence03
	nsc_flagop wCurDirection, FLAG_CLEAR, 0
	nsc_flagop wCurDirection, FLAG_CLEAR, 1
	nsc_flagop wCurDirection, FLAG_CLEAR, 2
	nsc_flagop wCurDirection, FLAG_CLEAR, 3
	nsc_flagop wCurDirection, FLAG_CLEAR, 4
	nsc_flagop wCurDirection, FLAG_CLEAR, 5
	nsc_flagop wMathScratch2, FLAG_CLEAR, 0
	nsc_flagop wMathScratch2, FLAG_CLEAR, 1
	nsc_flagop wMathScratch2, FLAG_CLEAR, 2
	nsc_flagop wMathScratch2, FLAG_CLEAR, 3
	nsc_flagop wMathScratch2, FLAG_CLEAR, 4
	nsc_flagop wMathScratch2, FLAG_CLEAR, 5
.sequenceCheckRejoin2
	; the big moment!!!!
	nsc_compareram wCurDirection, 1, wMathScratch2, .sequenceWrong, .sequenceRight, .sequenceWrong
	
.sequenceWrong
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_textbox 1, 14, .textWrong
	nsc_playsound SFX_WRONG
	nsc_waitbutton
	
	; intermediate rewards
	nsc_compare wCurrentStreak, .prizeDone, .prize5, .prizeGreater1, 1, 5
.prizeGreater1
	nsc_compare wCurrentStreak, .prize5, .prize10, .prizeGreater2, 1, 10
.prizeGreater2
	nsc_compare wCurrentStreak, .prize10, .prize15, .prize15, 1, 15
.prize5
	nsc_giveitem BERRY, .doPrize5, .prizeDone
.doPrize5
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize10
	nsc_giveitem POKE_DOLL, .doPrize10, .prizeDone
.doPrize10
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize15
	nsc_giveitem PEARL, .doPrize15, .prizeDone
.doPrize15
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent3
	nsc_playsound SFX_ITEM
	nsc_waitbutton
.prizeDone
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
	
.sequenceRight

	nsc_compareram wCurrentIndex, 1, wCurrentStreak, .keepGoing, .sequenceComplete, .sequenceComplete
.sequenceComplete
	

	nsc_add wCurrentStreak, 1
	nsc_drawbox 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	nsc_textbox 1, 14, .textRight
	nsc_playsound SFX_LEVEL_UP
	;nsc_waitbutton
	nsc_compare wCurrentStreak, .nextSequence, .allClear, .allClear, 1, 20
.nextSequence
	nsc_set wCurrentIndex, -1
	nsc_ret
.keepGoing
	nsc_add wCurrentIndex, 1
	nsc_ret
.allClear
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textAllClear
	nsc_waitbutton
	nsc_compare wCurrentCrySet, .allClearCrySet1, .allClearCrySet2, .allClearCrySet3, 1, 2
.allClearCrySet1
	nsc_bit_newsvar sMinigameFlag, 0, .prize20_1_2, .prize20_1_1
.prize20_1_1
	nsc_giveitem CRYSET1_BIG_PRIZE, .doPrize20_1_1, .prizeDone
.doPrize20_1_1
	nsc_flagop_newsvar sMinigameFlag, 0, FLAG_SET
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4A1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize20_1_2
	nsc_giveitem CRYSET1_BIG_PRIZE_2, 5, .doPrize20_1_2, .prizeDone
.doPrize20_1_2
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4A2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.allClearCrySet2
	nsc_bit_newsvar sMinigameFlag, 1, .prize20_2_2, .prize20_2_1
.prize20_2_1
	nsc_giveitem CRYSET2_BIG_PRIZE, .doPrize20_2_1, .prizeDone
.doPrize20_2_1
	nsc_flagop_newsvar sMinigameFlag, 1, FLAG_SET
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4B1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize20_2_2
	nsc_giveitem CRYSET2_BIG_PRIZE_2, 5, .doPrize20_2_2, .prizeDone
.doPrize20_2_2
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4B2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.allClearCrySet3
	nsc_bit_newsvar sMinigameFlag, 2, .prize20_3_2, .prize20_3_1
.prize20_3_1
	nsc_giveitem CRYSET3_BIG_PRIZE, .doPrize20_3_1, .prizeDone
.doPrize20_3_1
	nsc_flagop_newsvar sMinigameFlag, 2, FLAG_SET
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4C1
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
.prize20_3_2
	nsc_giveitem CRYSET3_BIG_PRIZE_2, 5, .doPrize20_3_2, .prizeDone
.doPrize20_3_2
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4C2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_playmusic MUSIC_SHOW_ME_AROUND
	nsc_page CrySetSelect
	
	
.thisSetText
	; Japanese
	lang_text J, "このなきごえセットを　つかいますか？"
	
	; English
	lang_text E, "Do you want to use"
	lang_line E, "this cry set?"
	; German
	lang_text D, "Möchtest du dieses"
	lang_line D, "Ruf-Set auswählen?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
; center-aligned version
;.textYourTurn
;	lang J,      "　　あなたの　ばんです！"
;	lang_next J, "じゅうじボタンを　おしてね！"
;	
;	lang E,      " Your turn! Use"
;	lang_next E, "the Control Pad!"
;	
;	lang D,      "  Du bist dran!"
;   lang_next D, "   Drücke das"
;   lang_next D, "  Steuerkreuz!"
;	
;	lang F,      "?"
;	
;	lang I,      "?"
;	
;	lang S,      "?"
;	
;	db "@"
	
; left-aligned version
.textYourTurn
	; Japanese
	lang J,      "あなたの　ばんです！"
	lang_next J, "じゅうじボタンを　おしてね！"
	
	; English
	lang E,      "Your turn! Use"
	lang_next E, "the Control Pad!"
	
	; German
	lang D,      "Du bist dran!"
	lang_next D, "Drücke das"
	lang_next D, "Steuerkreuz!"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	db "@"

.textRight
	; Japanese
	lang_text J, "せいかい！！"
	
	; English
	lang_text E, "Correct!"
	lang_text D, "Richtig!"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textWrong
	; Japanese
	lang_text J, "ざんねん…まちがえちゃった！"
	
	; English
	lang_text E, "Oops…"
	lang_line E, "You messed up!"
	; German
	lang_text D, "Schade… Das war"
	lang_line D, "nicht richtig!"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textAllClear
	; Japanese
	lang_text J, "２０もんクリア！　おめでとう！"
	
	; English
	lang_text E, "You wrapped up all"
	lang_line E, "twenty! Well done!"
	; German
	lang_text D, "20 Runden ge-"
	lang_line D, "schafft! Klasse!"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
	
	; NOTE: the japanese text uses the same verb in this text
	;       as in the minigame title. literally it would be smth like
	;       "since you continued × times", if the minigame's name is "will it continue?"
.textPresent1
	; Japanese
	lang_text J, "５かい　いじょう　つづいたので"
	lang_line J, "きのみを　プレゼント！"
	lang_para J, "きのみを　もらった！"
	
	; English
	lang_text E, "You wrapped up"
	lang_line E, "five rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "BERRY as a gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "BERRY."
	
	; German
	lang_text D, "Du hast fünf Run-"
	lang_line D, "den durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "BEERE als"
	lang_cont D, "Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "BEERE."
	
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent2
	; Japanese
	lang_text J, "１０かい　いじょう　つづいたので"
	lang_line J, "ピッピにんぎょうを　プレゼント！"
	lang_para J, "ピッピにんぎょうを　もらった！"
	
	; English
	lang_text E, "You wrapped up"
	lang_line E, "ten rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "# DOLL as a"
	lang_cont E, "gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "# DOLL."
	
	; German
	lang_text D, "Du hast zehn Run-"
	lang_line D, "den durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "#PUPPE als"
	lang_cont D, "Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "#PUPPE."
	
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

.textPresent3
	; Japanese
	lang_text J, "１５かい　いじょう　つづいたので"
	lang_line J, "しんじゅを　プレゼント！"
	lang_para J, "しんじゅを　もらった！"
	
	; English
	lang_text E, "You wrapped up"
	lang_line E, "fifteen rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "PEARL as a"
	lang_cont E, "gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "PEARL."
	
	; German
	lang_text D, "Du hast 15 Runden"
	lang_line D, "durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "PERLE als"
	lang_cont D, "Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "PERLE."

	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4A1
	; Japanese
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "おおきなしんじゅを　プレゼント！"
	lang_para J, "おおきなしんじゅを　もらった！"
	
	; English
	lang_text E, "You wrapped up"
	lang_line E, "twenty rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "BIG PEARL as a"
	lang_cont E, "gift!"	
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "BIG PEARL."
	
	; German
	lang_text D, "Du hast 20 Runden"
	lang_line D, "durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "RIESENPERLE als"
	lang_cont D, "Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "RIESENPERLE."

	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4A2
	; Japanese
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "ももぼんぐりを　プレゼント！"
	lang_para J, "ももぼんぐりを　もらった！"
	
	; English
	lang_text E, "You wrapped up"
	lang_line E, "twenty rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "PNK APRICORN"
	lang_cont E, "as a gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "PNK APRICORN."
	
	; German
	lang_text D, "Du hast 20 Runden"
	lang_line D, "durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "APRIKOKO PNK"
	lang_cont D, "als Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "APRIKOKO PNK."
	
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
	
.textPresent4B1
	; Japanese
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "ほしのすなを　プレゼント！"
	lang_para J, "ほしのすなを　もらった！"
	
	; English
	lang_text E, "You wrapped up"
	lang_line E, "twenty rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "STARDUST as a"
	lang_cont E, "gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "STARDUST."
	
	; German
	lang_text D, "Du hast 20 Runden"
	lang_line D, "durchgehalten!"
	
	lang_para D, "Hier! Nimm diesen"
	lang_line D, "STERNENSTAUB als"
	lang_cont D, "Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "STERNENSTAUB."
	
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4B2
	; Japanese
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "みどぼんぐりを　プレゼント！"
	lang_para J, "みどぼんぐりを　もらった！"

	; English	
	lang_text E, "You wrapped up"
	lang_line E, "twenty rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "GRN APRICORN"
	lang_cont E, "as a gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "GRN APRICORN."

	; German
	lang_text D, "Du hast 20 Runden"
	lang_line D, "durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "APRIKOKO GRN"
	lang_cont D, "als Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "APRIKOKO GRN."
	
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
	
.textPresent4C1
	; Japanese
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "わざマシン４４を　プレゼント！"
	lang_para J, "わざマシン４４を　もらった！"

	; English	
	lang_text E, "You wrapped up"
	lang_line E, "twenty rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "TM44 as a gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM44."
	
	; German
	lang_text D, "Du hast 20 Runden"
	lang_line D, "durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "TM44 als"
	lang_cont D, "Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "TM44."
	
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4C2
	; Japanese
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "きぼんぐりを　プレゼント！"
	lang_para J, "きぼんぐりを　もらった！"

	; English		
	lang_text E, "You wrapped up"
	lang_line E, "twenty rounds!"
	
	lang_para E, "Here! Take this"
	lang_line E, "YLW APRICORN"
	lang_cont E, "as a gift!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "YLW APRICORN."
	
	; German
	lang_text D, "Du hast 20 Runden"
	lang_line D, "durchgehalten!"
	
	lang_para D, "Hier! Nimm diese"
	lang_line D, "APRIKOKO GLB"
	lang_cont D, "als Geschenk!"
	lang_para D, ""
IF DEF(_LANG_D)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      D, " erhält"
	lang_line D, "APRIKOKO GLB."
	
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	

ENDC
