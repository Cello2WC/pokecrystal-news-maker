



# accpeted ranking IDs include:
#
# GAME_TIME_HOF
# STEP_COUNT_HOF
# HEALINGS_HOF
# BATTLES_HOF
# STEP_COUNT
# BATTLE_TOWER_WINS
# TMS_HMS_TAUGHT
# BATTLES
# WILD_BATTLES
# TRAINER_BATTLES
# UNUSED_1
# HOF_ENTRIES
# WILD_MONS_CAUGHT
# HOOKED_ENCOUNTERS
# EGGS_HATCHED
# MONS_EVOLVED
# FRUIT_PICKED
# HEALINGS
# MYSTERY_GIFT
# TRADES
# FLY
# SURF
# WATERFALL
# WHITE_OUTS
# LUCKY_NUMBER_SHOW
# PHONE_CALLS
# UNUSED_2
# LINK_BATTLES
# SPLASH
# TREE_ENCOUNTERS
# UNUSED_3
# LINK_WINS
# LINK_LOSSES
# LINK_DRAWS
# SELFDESTRUCT
# CURRENT_SLOTS_STREAK
# LONGEST_SLOTS_STREAK
# COINS_EARNED
# MONEY_EARNED
# LONGEST_MAGIKARP
# SHORTEST_MAGIKARP
# BUG_CONTEST_SCORE
RANKING_1 ?= BATTLE_TOWER_WINS
RANKING_2 ?= FRUIT_PICKED
RANKING_3 ?= MONEY_EARNED
MINIGAME  ?= minigame/game_personality.asm





RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBLINK ?= $(RGBDS)rgblink



all: j e d f i s

push:
	cp bin/* /var/lib/mysql/tmp/
	./push.sh $(RANKING_1) $(RANKING_2) $(RANKING_3)
	

andpush: all push
	

define compile_news
	$(RGBASM) issue.asm -o issue.o -D RANKING_1="$(RANKING_1)" -D RANKING_2="$(RANKING_2)" -D RANKING_3="$(RANKING_3)" -D MINIGAME_FILE="$(MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/issue_$(1).bin
	python3 newschecksum.py bin/issue_$(1).bin 
endef

j:
	$(call compile_news,j)

e:
	$(call compile_news,e)

d:
	$(call compile_news,d)

f:
	$(call compile_news,f)

i:
	$(call compile_news,i)

s:
	$(call compile_news,s)
