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
;DEF wMathScratch   EQUS "wRankingsCategory"
DEF wCurDirection  EQUS "wNumListedPlayers"
DEF wMathScratch   EQUS "wOwnRank"
DEF wMathScratch2  EQUS "wNumRankedPlayers"

MACRO minigame_start
	
;	nsc_compare_newsvar sMinigameFlag, .noIntro, .doIntro, .noIntro, 1, 0
;.doIntro
;	nsc_textbox 1, 14, .gameIntroText
;	nsc_waitbutton
;.noIntro
	nsc_page CrySetSelect


ENDM

MACRO minigame_name
	lang J, "ポケモン　つづくかな？"
	lang E, "cry simon"
	lang D, "?"
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
	news_box  0, 0, 20, 18, {NEWS_MAIN_BORDER}
	news_box  0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box  0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	
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
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuCrySet2Name
	lang J, "なきごえセット　２"
	lang E, "CRY SET 2"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuCrySet3Name
	lang J, "なきごえセット　３"
	lang E, "CRY SET 3"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuGameInstructionName
	lang J, "ゲームの　せつめい"
	lang E, "INSTRUCTIONS"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	db "@"
.menuCancelName
	lang J, "もどる"
	lang E, "CANCEL"
	lang D, "?"
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
	nsc_drawbox  0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_drawmon  6, 1, CRYSET1_UP_MON,     ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_delay 3
	nsc_drawmon  6, 9, CRYSET1_DOWN_MON,   ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_delay 3
	nsc_drawmon  1, 5, CRYSET1_LEFT_MON,   ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_delay 3
	nsc_drawmon 11, 5, CRYSET1_RIGHT_MON,  ANIM_MON_NORMAL, 7
	nsc_clear   11, 5, 7, 7
	nsc_delay 3
	nsc_set wCurrentCrySet, 0
.menuCrySetScriptCommon
	nsc_set wCurrentStreak, 0
	nsc_drawbox 0, 12, 20,  6, NEWSBORDER_GLOWY,    4
	nsc_delay 3
	nsc_textbox 1, 14, .thisSetText
	;nsc_yesno 13, 7, CrySimonStart, .notThisSet
	nsc_yesno 13, 7, .useThisSet, .notThisSet
.notThisSet
	nsc_page currentScreen
	
	
.menuCrySet2Script
	nsc_drawbox  0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_drawmon  6, 1, CRYSET2_UP_MON,     ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_delay 3
	nsc_drawmon  6, 9, CRYSET2_DOWN_MON,   ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_delay 3
	nsc_drawmon  1, 5, CRYSET2_LEFT_MON,   ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_delay 3
	nsc_drawmon 11, 5, CRYSET2_RIGHT_MON,  ANIM_MON_NORMAL, 7
	nsc_clear   11, 5, 7, 7
	nsc_delay 3
	nsc_set wCurrentCrySet, 1
	nsc_compare wCurrentCrySet, .menuCrySetScriptCommon, .menuCrySetScriptCommon, .menuCrySetScriptCommon, 1, 0
.menuCrySet3Script
	nsc_drawbox  0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_drawmon  6, 1, CRYSET3_UP_MON,     ANIM_MON_NORMAL, 7
	nsc_clear    6, 1, 7, 7
	nsc_delay 3
	nsc_drawmon  6, 9, CRYSET3_DOWN_MON,   ANIM_MON_NORMAL, 7
	nsc_clear    6, 9, 7, 7
	nsc_delay 3
	nsc_drawmon  1, 5, CRYSET3_LEFT_MON,   ANIM_MON_NORMAL, 7
	nsc_clear    1, 5, 7, 7
	nsc_delay 3
	nsc_drawmon 11, 5, CRYSET3_RIGHT_MON,  ANIM_MON_NORMAL, 7
	nsc_clear   11, 5, 7, 7
	nsc_delay 3
	nsc_set wCurrentCrySet, 2
	nsc_compare wCurrentCrySet, .menuCrySetScriptCommon, .menuCrySetScriptCommon, .menuCrySetScriptCommon, 1, 0
.useThisSet

	nsc_set wCurrentIndex, -1

	; generate cry sequence
	; (thankfully the powers of two are kind to us)
	nsc_ramcopy hRandomAdd, wCrySequence1, 2
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wCrySequence3, 2
	nsc_delay 1 ; wait for new RNG rolls
	nsc_ramcopy hRandomAdd, wCrySequence5, 1


	nsc_page CryGame
	nsc_ret
	
	; COMPLETE guess.....
.thisSetText
	lang_text J, "このなきごえセットを　つかいますか？"
	lang_text E, "Use this cry set?"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
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
	; TODO: ROUGH
	lang_text E, "First, pick your"
	lang_line E, "favorite cry set!"
	
	lang_para E, "Then, the game"
	lang_line E, "will begin."
	
	lang_para E, "From the center of"
	lang_line E, "the screen, a"
	lang_cont E, "#MON will app-"
	lang_cont E, "ear and let out"
	lang_cont E, "it's cry somewhere"
	lang_cont E, "above, below,"
	lang_cont E, "left, or right."
	
	lang_para E, "Then, if you can"
	lang_line E, "use the Control"
	lang_cont E, "Pad to indicate"
	lang_cont E, "where each #MON"
	lang_cont E, "appeared, you"
	lang_cont E, "get it right!"
	
	lang_para E, "The number of"
	lang_line E, "#MON that"
	lang_cont E, "appear gradually"
	lang_cont E, "increases, so"
	lang_cont E, "try to memorize"
	lang_cont E, "the sequence!"
	
	lang_para E, "If you correctly"
	lang_line E, "repeat it 20"
	lang_cont E, "times in total,"
	lang_cont E, "you clear it!"
	
	lang_para E, "Now, let's begin!"
	
	lang_text D, "?"
	
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
	
	

	
	
	news_screen CryGame, MUSIC_VIRIDIAN_CITY
	news_def_pals
	
	news_def_boxes
	news_box  0, 0, 20, 18, {NEWS_MAIN_BORDER}
	
	news_def_strings
	news_string 0, 0, "@"
	
	news_menu 4, 9, 1, 1, 0, 0, -1, 0, 0, 0, 0, 0
	
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
	lang J, "スタートボタンを　おして！"
	lang E, "PRESS START!"
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
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
	nsc_compare wCurrentIndex, .up_button_continue, .nothing, .up_button_continue, 1, -1
.up_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 0
	nsc_select
	nsc_set wCurDirection, UP_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_up
	nsc_compare wCurrentCrySet, .cryset1_up, .cryset2_up, .cryset3_up, 1, 1
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
	nsc_compare wCurrentIndex, .down_button_continue, .nothing, .down_button_continue, 1, -1
.down_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 1
	nsc_select
	nsc_set wCurDirection, DOWN_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_down
	nsc_compare wCurrentCrySet, .cryset1_down, .cryset2_down, .cryset3_down, 1, 1
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
	nsc_compare wCurrentIndex, .left_button_continue, .nothing, .left_button_continue, 1, -1
.left_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 2
	nsc_select
	nsc_set wCurDirection, LEFT_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_left
	nsc_compare wCurrentCrySet, .cryset1_left, .cryset2_left, .cryset3_left, 1, 1
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
	nsc_compare wCurrentIndex, .right_button_continue, .nothing, .right_button_continue, 1, -1
.right_button_continue
	nsc_drawbox 0, 0, 20, 18, {NEWS_MAIN_BORDER}
	nsc_set wNewsMenuOption, 3
	nsc_select
	nsc_set wCurDirection, RIGHT_BITS
	nsc_set wNewsMenuOption, 4
	nsc_select
	nsc_ret
	
.cry_right
	nsc_compare wCurrentCrySet, .cryset1_right, .cryset2_right, .cryset3_right, 1, 1
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
	
.a_button
.start_button
	nsc_compare wCurrentIndex, .nothing, .start_button_continue, .nothing, 1, -1
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

IF DEF(_LANG_J)
	nsc_printstring 3, 8, .textYourTurn
ELSE
	nsc_printstring 2, 8, .textYourTurn
ENDC

	nsc_playsound SFX_TWINKLE;SFX_HIT_END_OF_EXP_BAR;SFX_TWO_PC_BEEPS
	;nsc_add wCurrentStreak, 1
	;nsc_compare wCurrentStreak, .cry0, .cry0, .cry0, 1, 1
	nsc_set wCurrentIndex, 0
	nsc_ret
	
	
	
.checkNextDir
	nsc_ramcopy wCurrentIndex, wMathScratch, 1
	nsc_flagop wMathScratch, FLAG_CLEAR, 0
	nsc_flagop wMathScratch, FLAG_CLEAR, 1
	
	nsc_compare wMathScratch, .sequence00to03, .sequence04to07, .higher, 1, 1 << 2
.higher
	nsc_compare wMathScratch, .sequence08to11, .sequence12to15, .sequence16to19, 1, 4 << 2
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
	nsc_playsound SFX_WRONG
	nsc_drawbox 0, 12, 20,  6, NEWSBORDER_GLOWY, 4
	nsc_textbox 1, 14, .textWrong
	nsc_waitbutton
	
	; TODO: intermediate rewards
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
	nsc_page CrySetSelect
.prize10
	nsc_giveitem POKE_DOLL, .doPrize10, .prizeDone
.doPrize10
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_page CrySetSelect
.prize15
	nsc_giveitem PEARL, .doPrize15, .prizeDone
.doPrize15
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent3
	nsc_playsound SFX_ITEM
	nsc_waitbutton
.prizeDone
	nsc_page CrySetSelect
	
.sequenceRight

	nsc_compareram wCurrentIndex, 1, wCurrentStreak, .keepGoing, .sequenceComplete, .sequenceComplete
.sequenceComplete
	

	nsc_add wCurrentStreak, 1
	nsc_playsound SFX_TRANSACTION
	nsc_drawbox 0, 12, 20,  6, NEWSBORDER_GLOWY, 4
	nsc_textbox 1, 14, .textRight
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
	nsc_compare wCurrentCrySet, .allClearCrySet1, .allClearCrySet2, .allClearCrySet3, 1, 1
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
	nsc_page CrySetSelect
.prize20_1_2
	nsc_giveitem CRYSET1_BIG_PRIZE_2, 5, .doPrize20_1_2, .prizeDone
.doPrize20_1_2
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4A2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
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
	nsc_page CrySetSelect
.prize20_2_2
	nsc_giveitem CRYSET2_BIG_PRIZE_2, 5, .doPrize20_2_2, .prizeDone
.doPrize20_2_2
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4B2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
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
	nsc_page CrySetSelect
.prize20_3_2
	nsc_giveitem CRYSET3_BIG_PRIZE_2, 5, .doPrize20_3_2, .prizeDone
.doPrize20_3_2
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .textPresent4C2
	nsc_playsound SFX_ITEM
	nsc_waitbutton
	nsc_page CrySetSelect
	
	
	
; NOTE: i'm center-aligning this text. dunno how else to use it
.textYourTurn
	lang J,      "　　あなたの　ばんです！"
	lang_next J, "じゅうじボタンを　おしてね！"
	
	lang E,      " Your turn! Use"
	lang_next E, "the Control Pad!"
	
	lang D,      "?"
	
	lang F,      "?"
	
	lang I,      "?"
	
	lang S,      "?"
	
	db "@"
	
.textRight
	lang_text J, "せいかい！！"
	lang_text E, "Correct!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textWrong
	lang_text J, "ざんねん…まちがえちゃった！"
	lang_text E, "Sorry… You made"
	lang_line E, "a mistake!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textAllClear
	lang_text J, "２０もんクリア！　おめでとう！"
	lang_text E, "20 rounds clear!"
	lang_line E, "Congratulations!"
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
	
	; NOTE: the japanese text uses the same verb in this text
	;       as in the minigame title. literally it would be smth like
	;       "since you continued × times", if the minigame's name is "will it continue?"
.textPresent1
	lang_text J, "５かい　いじょう　つづいたので"
	lang_line J, "きのみを　プレゼント！"
	lang_para J, "きのみを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "5 rounds, here's"
	lang_cont E, "BERRY!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "BERRY."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent2
	lang_text J, "１０かい　いじょう　つづいたので"
	lang_line J, "ピッピにんぎょうを　プレゼント！"
	lang_para J, "ピッピにんぎょうを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "10 rounds, here's"
	lang_cont E, "# DOLL!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "# DOLL."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done

.textPresent3
	lang_text J, "１５かい　いじょう　つづいたので"
	lang_line J, "しんじゅを　プレゼント！"
	lang_para J, "しんじゅを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "15 rounds, here's"
	lang_cont E, "PEARL!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "PEARL."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4A1
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "おおきなしんじゅを　プレゼント！"
	lang_para J, "おおきなしんじゅを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "20 rounds, here's"
	lang_cont E, "BIG PEARL!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "BIG PEARL."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4A2
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "ももぼんぐりを　プレゼント！"
	lang_para J, "ももぼんぐりを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "20 rounds, here's"
	lang_cont E, "PNK APRICORN!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "PNK APRICORN."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
	
.textPresent4B1
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "ほしのすなを　プレゼント！"
	lang_para J, "ほしのすなを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "20 rounds, here's"
	lang_cont E, "STARDUST!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "STARDUST."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4B2
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "みどぼんぐりを　プレゼント！"
	lang_para J, "みどぼんぐりを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "20 rounds, here's"
	lang_cont E, "GRN APRICORN!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "GRN APRICORN."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
	
.textPresent4C1
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "わざマシン４４を　プレゼント！"
	lang_para J, "わざマシン４４を　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "20 rounds, here's"
	lang_cont E, "TM44!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "TM44."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	
.textPresent4C2
	lang_text J, "２０かい　いじょう　つづいたので"
	lang_line J, "きぼんぐりを　プレゼント！"
	lang_para J, "きぼんぐりを　もらった！"
	
	lang_text E, "Since you cleared"
	lang_line E, "20 rounds, here's"
	lang_cont E, "YLW APRICORN!"
	lang_para E, ""
IF DEF(_LANG_E)
	nts_start
	nts_player_name 0
	nts_end
ENDC
	lang      E, " received"
	lang_line E, "YLW APRICORN."
	
	lang_text D, "?"
	lang_text F, "?"
	lang_text I, "?"
	lang_text S, "?"
	done
	

ENDC
