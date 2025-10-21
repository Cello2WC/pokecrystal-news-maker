INCLUDE "ranking_types.asm"

IF !DEF(RANKING_1)
DEF RANKING_1 EQUS "BATTLE_TOWER_WINS"
ENDC

IF !DEF(RANKING_{RANKING_1}_FULLNAME)
DEF RANKING_{RANKING_1}_FULLNAME EQUS "{RANKING_{RANKING_1}_NAME}"
ENDC
IF !DEF(RANKING_{RANKING_2}_FULLNAME)
DEF RANKING_{RANKING_2}_FULLNAME EQUS "{RANKING_{RANKING_2}_NAME}"
ENDC
IF !DEF(RANKING_{RANKING_3}_FULLNAME)
DEF RANKING_{RANKING_3}_FULLNAME EQUS "{RANKING_{RANKING_3}_NAME}"
ENDC

IF !DEF(RANKING_{RANKING_1}_FMT_PLAYER)
DEF RANKING_{RANKING_1}_FMT_PLAYER EQUS "{RANKING_{RANKING_1}_FMT}"
ENDC
IF !DEF(RANKING_{RANKING_2}_FMT_PLAYER)
DEF RANKING_{RANKING_2}_FMT_PLAYER EQUS "{RANKING_{RANKING_2}_FMT}"
ENDC
IF !DEF(RANKING_{RANKING_3}_FMT_PLAYER)
DEF RANKING_{RANKING_3}_FMT_PLAYER EQUS "{RANKING_{RANKING_3}_FMT}"
ENDC










	news_screen TrainerRankings, MUSIC_PROF_ELM
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string	1, 2, ""
	lang J, "トレーナーランキング"
	lang E, "<TRAINER> RANKINGS"
	lang D, "BESTENLISTE"
	lang F, "CLASSEMENT"
	lang I, "CLASSIFICA ALLEN."
	lang S, "?"
	db "@"
	
	news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, SHOW_DESCRIPTIONS, $04
	
	news_buttonscript .a_button
	news_buttonscript .b_button
	news_buttonscript
	news_buttonscript
	news_buttonscript
	news_buttonscript
	news_buttonscript .up_button
	news_buttonscript .down_button
	
	news_def_menuitems
	news_menudescription 1, 14, 18, 4
	news_norankingstable
	
	news_menuitem_names   .menuViewRankingsText,   .menuUpdateRankingsText,   .menuRankingsDescriptionText,   .menuReturnText
	news_menuitem_scripts .menuViewRankingsScript, .menuUpdateRankingsScript, .menuRankingsDescriptionScript, .menuReturnScript
	news_menuitem_descs   .menuViewRankingsDesc,   .menuUpdateRankingsDesc,   .menuRankingsDescriptionDesc,   .menuReturnDesc
	

.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret

.b_button
	nsc_playsound SFX_MENU
	nsc_page openingScreen
	nsc_ret

.up_button
	nsc_up
	nsc_ret

.down_button
	nsc_down
	nsc_ret

.menuViewRankingsText
	lang J, "ランキング　<WO>みる"
	lang E, "VIEW RANKINGS"
	lang D, "BETRACHTEN"
	lang F, "VOIR CLASSEMENT"
	lang I, "VEDI CLASSIFICHE"
	lang S, "?"
	db "@"

.menuUpdateRankingsText
	lang J, "ランキング　<NO>こうしん"
	lang E, "UPDATE RANKINGS"
	lang D, "ÜBERTRAGEN"
	lang F, "MàJ CLASSEMENT"
	lang I, "AGG. CLASSIFICHE"
	lang S, "?"
	db "@"

.menuRankingsDescriptionText
	lang J, "ランキング　<NO>せつめい"
	lang E, "RANKING INFO"
	lang D, "BESTENL.-INFO"
	lang F, "INFO CLASSEMENT"
	lang I, "INFO CLASSIFICA"
	lang S, "?"
	db "@"
	
.menuReturnText
	lang J, "やめる"
	lang E, "CANCEL"
	lang D, "ZURÜCK"
	lang F, "RETOUR"
	lang I, "ESCI"
	lang S, "?"
	db "@"

.menuViewRankingsScript
	nsc_compareram sNewsId, 12, sNewsIdBackup, .noRankingsData, .continueToCategoriesScreen, .noRankingsData

.continueToCategoriesScreen
	nsc_page RankingsCategories
	nsc_ret

.noRankingsData
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .noRankingsDataText
	nsc_ret

.menuUpdateRankingsScript
	nsc_update_rankings
	nsc_compare wRankingsUpdateResult, .rankingsUpdated, .rankingsUpdateCancelled, .rankingsUpdateFailed, 1, 1

.rankingsUpdated
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsUpdatedText
	nsc_waitbutton
	nsc_ret

.rankingsUpdateCancelled
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsUpdateCancelledText
	nsc_waitbutton
	nsc_ret

.rankingsUpdateFailed
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsUpdateFailedText
	nsc_waitbutton
	nsc_ret

.rankingsUpdatedText
	lang_text J, "ランキング<NO>こうしんを"
	lang_line J, "しました！"
	
	lang_text E, "Rankings update"
	lang_line E, "was successful!"
	
	lang_text D, "Bestenlisten wur-"
	lang_line D, "den übertragen!"
	
	lang_text F, "Mise à jour du"
	lang_line F, "classement"
	lang_cont F, "réussie!"
	
	lang_text I, "Classifiche"
	lang_line I, "aggiornate!"
	
	lang_text S, "?"
	lang_line S, "?"
	
	done

.rankingsUpdateCancelledText
	lang_text J, "ランキング<NO>こうしんを"
	lang_line J, "やめました"

	lang_text E, "Rankings update"
	lang_line E, "was stopped."
	
	lang_text D, "Die Übertragung"
	lang_line D, "wurde abgebrochen."
	
	lang_text F, "Mise à jour du"
	lang_line F, "classement"
	lang_cont F, "arrêtée!"
	
	lang_text I, "Aggiornam. classi-"
	lang_line I, "fiche interrotto."
	
	lang_text S, "?"
	lang_line S, "?"
	
	done

.rankingsUpdateFailedText
	lang_text J, "ランキング<NO>こうしんに"
	lang_line J, "しっぱい⋯"
	lang_para J, "あたらしい　ニュースを"
	lang_line J, "よみこんで　ください"

	lang_text E, "Rankings update"
	lang_line E, "has failed…"
	lang_para E, "Please download"
	lang_line E, "the latest NEWS."
	
	lang_text D, "Die Übertragung"
	lang_line D, "schlug fehl…"
	lang_para D, "Die NACHRICHTEN"
	lang_line D, "bitte neu laden."
	
	lang_text F, "Mise à jour du"
	lang_line F, "classement"
	lang_cont F, "échouée..."
	lang_para F, "Télécharger les"
	lang_line F, "dernières INFOS"
	lang_cont F, "s.v.p."
	
	lang_text I, "Aggiornamento"
	lang_line I, "classifiche…"
	lang_cont I, "fallito…"
	lang_para I, "Riscarica le"
	lang_line I, "NOTIZIE."
	
	lang_text S, "?"
	lang_line S, "?"
	lang_para S, "?"
	lang_line S, "?"
	
	
	done

.menuRankingsDescriptionScript
	nsc_clear 1, 13, 18, 4
	nsc_textbox 1, 14, .rankingsDescriptionText
	nsc_waitbutton
	nsc_ret

.menuReturnScript
	nsc_page NewsRoot
	nsc_ret

.rankingsDescriptionText
	text "{RANKING_{RANKING_1}_FULLNAME}"
	lang J, "は"
	line "{RANKING_{RANKING_1}_DESC}"
	; matching weirdness in JP issue 1
	para "{RANKING_{RANKING_3}_FULLNAME}"
	lang J, "は"
	line "{RANKING_{RANKING_3}_DESC}"

	para "{RANKING_{RANKING_2}_FULLNAME}"
	lang J, "は"
	line "{RANKING_{RANKING_2}_DESC}"

	;para "{RANKING_{RANKING_3}_FULLNAME}"
	;lang J, "は"
	;line "{RANKING_{RANKING_3}_DESC}"
	done

.noRankingsDataText
	lang_text J, "ランキングデータ<GA>ありません"
	lang_line J, "ランキング<NO>こうしん<WO>すれば"
	lang_cont J, "みること<GA>できます"
	
	lang_text E, "There is no"
	lang_line E, "ranking data."
	lang_para E, "Link to obtain" 
	lang_line E, "ranking data."
	
	lang_text D, "Keine Daten zur"
	lang_line D, "Bestenliste vor-"
	lang_cont D, "handen."
	lang_para D, "Aktualisiere die"
	lang_line D, "die Daten, um die"
	lang_para D, "Bestenliste zu"
	lang_line D, "betrachten."
	
	lang_text F, "Il n'y a aucune"
	lang_line F, "données"
	lang_cont F, "de classement."
	lang_para F, "Connectez-vous"
	lang_line F, "pour obtenir"
	lang_cont F, "les données"
	lang_cont F, "de classement."
	
	lang_text I, "Dati classifiche"
	lang_line I, "assenti."
	lang_para I, "Collegati per" 
	lang_line I, "ottenere i dati."
	
	lang_text S, "?"
	lang_line S, "?"
	lang_cont S, "?"
	
	para
	done

.menuViewRankingsDesc
	lang      J, "いろいろな　ランキングが"
	lang_line J, "みれます"
	
	lang      E, "View the various"
	lang_line E, "rankings."
	
	lang      D, "Betrachte versch."
	lang_line D, "Bestenlisten."
	
	lang      F, "Voir les diffé-"
	lang_line F, "rents classements."
	
	lang      I, "Guarda le varie"
	lang_line I, "classifiche."
	
	lang      S, "?"
	lang_line S, "?"
	
	db "@"

.menuUpdateRankingsDesc
	lang      J, "ランキング<WO>よみこみなおします"
	lang_line J,  "あなた<NO>せいせきも　かわります"
	
	lang      E, "Reload rankings to"
	lang_line E, "update your score."
	
	lang      D, "Übertrage und em-"
	lang_line D, "pfange Daten."
	
	lang      F, "MàJ du classement"
	lang_line F, "et de vos scores."
	
	lang      I, "Ricarica classi-"
	lang_line I, "fiche e punteggi."
	
	lang      S, "?"
	lang_line S, "?"
	
	db "@"

.menuRankingsDescriptionDesc
	lang      J, "こんかい<NO>ランキングの"
	lang_line J,  "テーマ<NI>ついて　せつめいします"
	
	lang      E, "An explanation of"
	lang_line E, "ranking themes."
	
	lang      D, "Eine Erklärung zu"
	lang_line D, "einzelnen Listen."
	
	lang      F, "Infos sur les thé-"
	lang_line F, "mes de classement."
	
	lang      I, "Spiegazione temi"
	lang_line I, "classifiche."
	
	lang      S, "?"
	lang_line S, "?"
	
	db "@"

.menuReturnDesc
	lang      J, "さいしょ<NO>ぺージ<NI>もどります"
	
	lang      E, "Return to the"
	lang_line E, "first page."
	
	lang      D, "Zurück zur ersten"
	lang_line D, "Seite."
	
	lang      F, "Retourner à la"
	lang_line F, "première page."
	
	lang      I, "Torna alla"
	lang_line I, "prima pagina."
	
	lang      S, "?"
	
	db "@"


	news_screen RankingsCategories, MUSIC_PROF_ELM
	news_def_pals

	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}

	news_def_strings
	news_string	1, 2, ""
	lang J, "トレーナーランキング"
	lang E, "<TRAINER> RANKINGS"
	lang D, "BESTENLISTE"
	lang F, "CLASSEMENT"
	lang I, "CLASSIFICA ALLEN."
	lang S, "?"
	db "@"
	
	news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, SHOW_DESCRIPTIONS, $04
	
	
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
	
	news_menuitem_names   .menuitem1_name,   .menuitem2_name,   .menuitem3_name,   .menuitem4_name
	news_menuitem_scripts .menuitem1_script, .menuitem2_script, .menuitem3_script, .menuitem4_script
	news_menuitem_descs   .menuitem1_desc,   .menuitem2_desc,   .menuitem3_desc,   .menuitem4_desc
	
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
	; fall through
.menuitem4_script
	nsc_page TrainerRankings
	nsc_ret
	
.menuitem1_name
	db "{RANKING_{RANKING_1}_NAME}@"
.menuitem2_name
	db "{RANKING_{RANKING_2}_NAME}@"
.menuitem3_name
	db "{RANKING_{RANKING_3}_NAME}@"
.menuitem4_name
	lang J, "もどる"
	lang E, "CANCEL"
	lang D, "ZURÜCK"
	lang F, "RETOUR"
	lang I, "ESCI"
	lang S, "?"
	db "@"
	
.menuitem1_script
	nsc_set wRankingsTable, 0
	nsc_set wRankingsCategory, 0
	nsc_page RankingsAreaChoice
	nsc_ret
.menuitem2_script
	nsc_set wRankingsTable, 3
	nsc_set wRankingsCategory, 1
	nsc_page RankingsAreaChoice
	nsc_ret
.menuitem3_script
	nsc_set wRankingsTable, 6
	nsc_set wRankingsCategory, 2
	nsc_page RankingsAreaChoice
	nsc_ret
	
.menuitem1_desc
.menuitem2_desc
.menuitem3_desc
.menuitem4_desc
	lang      J, "みたい　ランキングを"
	lang_line J, "えらんで　ください"
	
	lang      E, "Please choose a"
	lang_line E, "RANKING to view."
	
	lang      D, "Wähle eine"
	lang_line D, "Bestenliste."
	
	lang      F, "Choisir le classe-"
	lang_line F, "ment à voir s.v.p."
	
	lang      I, "Scegli quale"
	lang_line I, "classifica vedere."
	
	lang      S, "?"
	lang_line S, "?"
	
	db "@"
	
	news_screen RankingsAreaChoice, MUSIC_PROF_ELM
	
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wRankingsCategory, .ranking1_label, .ranking2_label, .ranking3_label
	nts_end
	
	news_menu 2, 5, 1, 4, 0, 2, $10, $04, $07, $04, SHOW_DESCRIPTIONS, $04
	
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
	
	news_menuitem_names   .menuitem1_name,   .menuitem2_name,   .menuitem3_name,   .menuitem4_name
	news_menuitem_scripts .menuitem1_script, .menuitem2_script, .menuitem3_script, .menuitem4_script
	news_menuitem_descs   .menuitem1_desc,   .menuitem2_desc,   .menuitem3_desc,   .menuitem4_desc
	
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
.start_button
	nsc_playsound SFX_MENU
	nsc_page TrainerRankings
	nsc_ret

.menuitem1_name
	lang J, "ぜんこく　<NO>ランキング"
	lang E, "NATIONAL RANKINGS"
	lang D, "LANDESLISTE"
	lang F, "CLASSEMENT NATIO."
	lang I, "CLASSIFICA NAZ."
	lang S, "?"
	db "@"
.menuitem2_name
	nts_start
	nts_player_region_backup
	nts_end
	lang J, "　<NO>ランキング"
	lang E, " RANKINGS"
	lang D, "-LISTE"
	lang F, "CLASSEMENT" ; TODO; should there be a space here?
	lang I, " CLASSIFICA"
	lang S, "?"
	db "@"
.menuitem3_name
	lang J, "■" ; post code symbol
	nts_start
	nts_player_zip_backup 3
	nts_end
	lang J, "　<NO>ランキング"
	lang E, "×× RANKINGS"
	lang D, "-LISTE"
	lang F, "CLASSEMENT" ; TODO; should there be a space here?
	lang I, " CLASSIFICA"
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
	
.menuitem1_script
	nsc_set wRankingsType, 0
	nsc_page Rankings
	nsc_ret
.menuitem2_script
	nsc_add wRankingsTable, 1
	nsc_set wRankingsType, 1
	nsc_page Rankings
	nsc_ret
.menuitem3_script
	nsc_add wRankingsTable, 2
	nsc_set wRankingsType, 2
	nsc_page Rankings
	nsc_ret
.b_button
	nsc_playsound SFX_MENU
	; fall through
.menuitem4_script
	nsc_page RankingsCategories
	nsc_ret
	
.menuitem1_desc
.menuitem2_desc
.menuitem3_desc
.menuitem4_desc
	lang      J, "みたい　ちいき　を"
	lang_line J, "えらんで　ください"
	
	lang      E, "Choose an area to"
	lang_line E, "view the RANKINGS."
	
	lang      D, "Für welche Region"
	lang_line D, "anzeigen?"
	
	lang      F, "Choisir la zone de"
	lang_line F, "classement à voir."
	
	lang      I, "Scegli dove ved-"
	lang_line I, "ere la classifica."
	
	lang      S, "?"
	lang_line S, "?"
	
	db "@"
.ranking1_label
	db "{RANKING_{RANKING_1}_NAME}@"
.ranking2_label
	db "{RANKING_{RANKING_2}_NAME}@"
.ranking3_label
	db "{RANKING_{RANKING_3}_NAME}@"
	
	news_screen Rankings, MUSIC_PROF_ELM
	
	news_def_pals
	
	news_def_boxes
	news_box 0,  3, 20, 10, {NEWS_MAIN_BORDER}
	news_box 0, 12, 20,  6, {NEWS_TEXT_BORDER}
	
	news_def_strings
	news_string 1, 2, ""
	nts_start
	nts_switch wRankingsCategory, .ranking1_title, .ranking2_title, .ranking3_title
	nts_end
IF DEF(_LANG_J)
	news_string 2, 5, ""
ELSE
	news_string 2, 4, ""
ENDC
	nts_start
	nts_switch wRankingsType, .national_top_10_string, .prefectural_top_10_string, .local_top_10_string
	nts_end

IF DEF(_LANG_J)
	news_menu 2, 7, 1, 3, 0, 2, 16, 4, 7, 3, SHOW_DESCRIPTIONS, $03
ELSE
	news_menu 2, 6, 1, 3, 0, 2, 16, 4, 7, 3, SHOW_DESCRIPTIONS, $03
ENDC
	
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
	news_loadrankingstable
	
REPT 10
	news_menuitem_names .menuitems_name
ENDR
	news_menuitem_names .lastmenuitem_name
REPT 10
	news_menuitem_scripts .menuitems_script
ENDR
	news_menuitem_scripts .lastmenuitem_script
REPT 11
	news_menuitem_descs .menuitems_desc
ENDR
	
.a_button
	nsc_playsound SFX_READ_TEXT
	nsc_select
	nsc_ret
.b_button
	nsc_playsound SFX_MENU
	nsc_subram wRankingsTable, wRankingsType
	nsc_page RankingsAreaChoice
	nsc_ret
.up_button
	nsc_up
	nsc_ret
.down_button
	nsc_down
	nsc_ret
.start_button
	nsc_playsound SFX_MENU
	nsc_page TrainerRankings
	nsc_ret
.menuitems_name
	nts_start
	nts_switch wRankingsCategory, .menuitems_ranking1, .menuitems_ranking2, .menuitems_ranking3
	nts_end
	
.menuitems_ranking1
	nts_start
	nts_placement 2, 3
IF DEF(_LANG_J)
	nts_ranking_string $0000, 6, 5+{RANKING_{RANKING_1}_SPACING};6
	nts_ranking_number $0018, {RANKING_{RANKING_1}_FMT}
ELSE
	nts_ranking_string $0000, 8, SCREEN_WIDTH+{RANKING_{RANKING_1}_SPACING}
	nts_ranking_number $0014, {RANKING_{RANKING_1}_FMT} ; compensating for smaller EZChat messages
ENDC
	nts_end
	db "{RANKING_{RANKING_1}_UNIT}@"
	
.menuitems_ranking2
	nts_start
	nts_placement 2, 3
IF DEF(_LANG_J)
	nts_ranking_string $0000, 6, 5+{RANKING_{RANKING_2}_SPACING}
	nts_ranking_number $0018, {RANKING_{RANKING_2}_FMT}
ELSE
	nts_ranking_string $0000, 8, SCREEN_WIDTH+{RANKING_{RANKING_2}_SPACING};20
	nts_ranking_number $0014, {RANKING_{RANKING_2}_FMT} ; compensating for smaller EZChat messages
ENDC
	nts_end
	db "{RANKING_{RANKING_2}_UNIT}@"
	
.menuitems_ranking3
	nts_start
	nts_placement 2, 3
IF DEF(_LANG_J)
	nts_ranking_string $0000, 6, 5+{RANKING_{RANKING_3}_SPACING}
	nts_ranking_number $0018, {RANKING_{RANKING_3}_FMT}
ELSE
	nts_ranking_string $0000, 8, SCREEN_WIDTH+{RANKING_{RANKING_3}_SPACING}
	nts_ranking_number $0014, {RANKING_{RANKING_3}_FMT} ; compensating for smaller EZChat messages
ENDC
	nts_end
	db "{RANKING_{RANKING_3}_UNIT}@"
.lastmenuitem_name
	lang F, "RANG de "
	lang I, "GRADO di "
	nts_start
	nts_player_name 0
	nts_end
	lang J, "　<NO>じゅんい"
	lang E, "'s RANK"
	lang D, "s RANG"
	lang F, ":"
	lang I, ":"
	lang S, "?"
	db "@"
.menuitems_script
	nsc_compareram wNewsMenuOption, 1, wNumListedPlayers, .less, .notless, .notless
.less
	nsc_clear  1, 13, 18, 4
	nsc_printstring 1, 14, .ranked_player_info
	nsc_clear  1, 13, 18, 4
	nsc_printstring 1, 14, .ranked_player_ezchat
	nsc_ret
.notless
	nsc_clear  1, 13, 18, 4
	nsc_printstring 1, 14, .no_one_is_ranked_here_text
	nsc_ret

.no_one_is_ranked_here_text
	lang      J, "ここに<WA>だれも"
	lang_next J, "ランクイン　してません"
	
	lang      E, "No one is"
	lang_next E, "ranked here."
	
	lang      D, "Hier gibt es"
	lang_next D, "keinen Eintrag."
	
	lang      F, "Il n'y a personne"
	lang_next F, "de classé ici."
	
	lang      I, "Nessun classi-"
	lang_next I, "ficato qui."
	
	lang      S, "?"
	lang_next S, "?"
	
	para   "@"
	
.lastmenuitem_script
	nsc_compareram wOwnRank, 4, wNumRankedPlayers, .lastmenuitem_lessorequal, .lastmenuitem_lessorequal, .lastmenuitem_greater
	
.lastmenuitem_lessorequal
	nsc_clear 1, 13, 18, 4
	nsc_printstring 1, 14, .players_ranking_placed
	nsc_compare wOwnRank, .playerplaced_ret, .playerplaced_first, .playerplaced_ret, 4,   $00,$00,$00,$01
.playerplaced_first
	nsc_compare sGSBallFlag, .playerplaced_ret, .not_received_gs_ball, .playerplaced_ret, 1,    0
.not_received_gs_ball
	nsc_set wNewsScratch5, 1
	nsc_ramcopy wNewsScratch5, sGSBallFlag, $0001
	nsc_clear 1, 13, 18, 4 
	nsc_textbox 1, 14, .gs_ball_present_text
	nsc_waitbutton
.playerplaced_ret
	nsc_ret
.lastmenuitem_greater
	nsc_clear 1, 13, 18, 4
	nsc_printstring 1, 14, .players_ranking
	nsc_ret
	
.gs_ball_present_text
	lang_text J, "ランキングで　トップ<WO>とった"
	lang_next J, "あなたに⋯"
	lang_cont J, "すてきな　プレゼント<GA>あります"
	lang_cont J, "おたのしみに！"
	
	lang_text E, "For receiving such"
	lang_next E, "a high rank,"
	lang_para E, "we have a nice"
	lang_line E, "gift for you."
	lang_cont E, "Enjoy!"
	
	lang_text D, "Wer so einen hohen"
	lang_next D, "Rang erreicht,"
	lang_para D, "verdient ein"
	lang_line D, "tolles Geschenk."
	lang_cont D, "Bitte schön!"
	
	lang_text F, "Pour avoir atteint"
	lang_next F, "un rang si haut,"
	lang_para F, "voici un beau"
	lang_line F, "cadeau pour vous."
	lang_cont F, "Profitez-en bien!"
	
	lang_text I, "Per aver ricevuto"
	lang_next I, "un grado così"
	lang_cont I, "alto,"
	lang_para I, "ecco un regalo"
	lang_line I, "per te."
	lang_cont I, "Buon divertimento!"
	
	lang_text S, "?"
	
	done
.ranked_player_info
;IF DEF(_LANG_J)
	nts_start 
	nts_ranking_gender $000B, 4
	nts_ranking_number $000A, 1, 3, 4 
	nts_end
	lang J, "さい　"
	lang E, "yrs. "
	lang D, "?"
	lang F, "?"
	lang I, "?"
	lang S, "?"
	nts_start
	nts_ranking_region $0007, $7, 
	nts_end
;ELSE
;	nts_start 
;	nts_ranking_number $000A, 1, 3, 3
;	nts_end
;	lang E, "-year-old "
;	lang D, ""
;	lang F, ""
;	lang I, ""
;	lang S, ""
;	nts_start
;	nts_ranking_gender $000B, 4, 
;	nts_end
;	lang_line E, "from "
;	lang_line D, ""
;	lang_line F, ""
;	lang_line I, ""
;	lang_line S, ""
;	nts_start
;	nts_ranking_region $0007, $7, 
;	nts_end
;ENDC
	para "@"
.ranked_player_ezchat
	nts_start
	nts_ranking_ezchat $000C
	nts_end
	para "@"
.players_ranking_placed
	nts_start
	nts_switch wRankingsCategory, .players_ranking1, .players_ranking2, .players_ranking3
	lang F, "Le RANG de "
	lang I, "GRADO di "
	nts_start
	nts_player_name, 0
	nts_end
	lang J, "　<NO>じゅんいは⋯"
	lang E, "'s RANK is…"
	lang D, "s RANG ist…"
	lang F, "<NEXT>est…"
	lang I, "è…"
	lang S, "?"
	para
	lang E, "RANK "
	nts_start
	nts_number wOwnRank, 4, 4
	nts_end
	lang      J, "　ばん　<NI>ランクイン！"
	lang_line J, "おめでとう！"
	
	lang      E, "!"
	lang_line E, "Congratulations!"
	
	lang      D, "!"
	lang_line D, "Glückwunsch!"
	
	lang      F, "!"
	lang_line F, "Félicitations!"
	
	lang      I, "!"
	lang_line I, "Complimenti!"
	
	lang      S, "?"
	lang_line S, "?"
	para "@"
.players_ranking
	nts_start
	nts_switch wRankingsCategory, .players_ranking1, .players_ranking2, .players_ranking3 
	lang F, "Le RANG de "
	lang I, "GRADO di "
	nts_start
	nts_player_name, 0
	nts_end
	lang      J, "　<NO>じゅんいは⋯"
	lang_para J,  "ランクイン　しなかった⋯"
	lang_line J, "ざんねん⋯"
	
	lang E,      "'s RANK is…"
	lang_para E, "Not currently in"
	lang_line E, "the RANKINGS."
	
	lang      D, "s RANG ist…"
	lang_para D, "leider außerhalb"
	lang_line D, "der Bestenliste."
	
	lang      F, "<NEXT>est…"
	lang_para F, "Absent du"
	lang_line F, "classement."
	
	lang      I, "è…"
	lang_para I, "Attualmente non"
	lang_line I, "in classifica."
	
	lang      S, "?"
	lang_para S, "?"
	lang_line S, "?"
	para "@"
	
.players_ranking1
	lang F, "SCORE de "
	lang I, "PUNTEG. di "
	nts_start
	nts_player_name 0 
	nts_end
	lang J, "　<NO>せいせきは"
	lang E, "'s SCORE:"
	lang D, "s PUNKTZAHL:"
	lang F, ":"
	lang I, ":"
	lang S, "?"
	line ""
	nts_start
	nts_number {RANKING_{RANKING_1}_ADDR}, {RANKING_{RANKING_1}_FMT_PLAYER}
	nts_end
	db "{RANKING_{RANKING_1}_UNIT}"
	para "@" 
	
.players_ranking2
	lang F, "SCORE de "
	lang I, "PUNTEG. di "
	nts_start
	nts_player_name 0 
	nts_end
	lang J, "　<NO>せいせきは"
	lang E, "'s SCORE:"
	lang D, "s PUNKTZAHL:"
	lang F, ":"
	lang I, ":"
	lang S, "?"
	line
	nts_start
	nts_number {RANKING_{RANKING_2}_ADDR}, {RANKING_{RANKING_2}_FMT_PLAYER}
	nts_end
	db "{RANKING_{RANKING_2}_UNIT}"
	para "@"
	
.players_ranking3
	lang F, "SCORE de "
	lang I, "PUNTEG. di "
	nts_start
	nts_player_name 0 
	nts_end
	lang J, "　<NO>せいせきは"
	lang E, "'s SCORE:"
	lang D, "s PUNKTZAHL:" ; TODO; check about PUNKTZAHL vs REKORD
	lang F, ":"
	lang I, ":"
	lang S, "?"
	line
	nts_start
	nts_number {RANKING_{RANKING_3}_ADDR}, {RANKING_{RANKING_3}_FMT_PLAYER}
	nts_end 
	db "{RANKING_{RANKING_3}_UNIT}"
	para "@"
.menuitems_desc
	; cry quiz debug issue text
;	lang      J, "えらんだ　ひと<NO>データを"
;	lang_line J, "みること<GA>できます"
	; first issue text
	lang      J, "えらんだ　ひと<NO>プロフィールを"
	lang_line J, "みること<GA>できます"
	
	lang      E, "View the profile"
	lang_line E, "of this <TRAINER>."
	
	lang      D, "Profil des"
	lang_line D, "<TRAINER>s anzeigen."
	
	lang      F, "Voir le profil"
	lang_line F, "de ce DRESSEUR."
	
	lang      I, "Guarda il profilo"
	lang_line I, "di questo ALLEN."
	
	lang      S, "?"
	lang_line S, "?"
	
	db "@"
.ranking1_title
	db "{RANKING_{RANKING_1}_NAME}@"
.ranking2_title
	db "{RANKING_{RANKING_2}_NAME}@"
.ranking3_title
	db "{RANKING_{RANKING_3}_NAME}@"
.national_top_10_string
	lang J, "ぜんこく　<NO>トップ１０！"
	lang E, "NATIONAL TOP 10!"
	lang D, "LANDES-TOP-10!"
	lang F, "TOP 10 NATIONAL!"
	lang I, "TOP 10 NAZIONALE"
	lang S, "?"
	db "@" 
.prefectural_top_10_string
	nts_start
	nts_player_region_backup
	nts_end
	lang J, "　<NO>トップ１０！"
	lang E, " TOP 10!"
	lang D, " TOP-10!"
	lang F, " TOP 10!"
	lang I, " TOP 10!"
	lang S, "?"
	db "@"
.local_top_10_string
	lang J, "■" ; post code symbol
	nts_start
	nts_player_zip_backup 3
	nts_end
	lang J, "　<NO>トップ１０！"
	lang E, "×× TOP 10!"
	lang D, " TOP-10!"
	lang F, " TOP 10!"
	lang I, " TOP 10!"
	lang S, "?"
	db "@"
