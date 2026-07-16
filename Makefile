dbuser ?=
dbpass ?=

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

2001_JANUARY_RANKING_1 ?= BATTLE_TOWER_WINS
2001_JANUARY_RANKING_2 ?= BUG_CONTEST_SCORE
2001_JANUARY_RANKING_3 ?= LONGEST_MAGIKARP
2001_JANUARY_MINIGAME  ?= minigame/pkmnquiz_oak.asm

2002_JUNE_RANKING_1 ?= BATTLE_TOWER_WINS
2002_JUNE_RANKING_2 ?= TREE_ENCOUNTERS
2002_JUNE_RANKING_3 ?= WILD_BATTLES
2002_JUNE_MINIGAME  ?= minigame/game_name_maze.asm

2002_JULY_RANKING_1 ?= BATTLE_TOWER_WINS
2002_JULY_RANKING_2 ?= WILD_BATTLES
2002_JULY_RANKING_3 ?= WILD_MONS_CAUGHT
2002_JULY_MINIGAME  ?= minigame/pkmnquiz_blue.asm

2002_AUGUST_RANKING_1 ?= BATTLE_TOWER_WINS
2002_AUGUST_RANKING_2 ?= WILD_MONS_CAUGHT
2002_AUGUST_RANKING_3 ?= EGGS_HATCHED
2002_AUGUST_MINIGAME  ?= minigame/game_cry_memory.asm

2002_SEPTEMBER_RANKING_1 ?= BATTLE_TOWER_WINS
2002_SEPTEMBER_RANKING_2 ?= EGGS_HATCHED
2002_SEPTEMBER_RANKING_3 ?= FRUIT_PICKED
2002_SEPTEMBER_MINIGAME  ?= minigame/game_association_quiz.asm

2002_OCTOBER_RANKING_1 ?= BATTLE_TOWER_WINS
2002_OCTOBER_RANKING_2 ?= FRUIT_PICKED
2002_OCTOBER_RANKING_3 ?= MONS_EVOLVED
2002_OCTOBER_MINIGAME  ?= minigame/game_personality.asm

2002_NOVEMBER_RANKING_1 ?= BATTLE_TOWER_WINS
2002_NOVEMBER_RANKING_2 ?= MONS_EVOLVED
2002_NOVEMBER_RANKING_3 ?= HOOKED_ENCOUNTERS
2002_NOVEMBER_MINIGAME  ?= minigame/pkmnquiz_blaine.asm

2002_DECEMBER_RANKING_1 ?= BATTLE_TOWER_WINS
2002_DECEMBER_RANKING_2 ?= HOOKED_ENCOUNTERS
2002_DECEMBER_RANKING_3 ?= MYSTERY_GIFT
2002_DECEMBER_MINIGAME  ?= minigame/game_hi_lo.asm

RGBDS ?=
RGBASM  ?= $(RGBDS)rgbasm
RGBLINK ?= $(RGBDS)rgblink
PYTHON ?= python3
REON_BXT_DIR ?= ../reon-main/app/auto-schedule/files/bxt

.PHONY: all build-news auto-schedule install-auto-schedule push andpush j e d f i s

all: install-auto-schedule

build-news: j e d f i s

push:
	cp bin/* /var/lib/mysql/tmp/
	./push.sh "$(dbuser)" "$(dbpass)" $(RANKING_1) $(RANKING_2) $(RANKING_3)

andpush: all push
install-auto-schedule: auto-schedule

auto-schedule: build-news
	@set -e; \
	dest="$(REON_BXT_DIR)"; \
	for mapping in j:j e:e e:p e:u d:d f:f i:i s:s; do \
		src_lang="$${mapping%%:*}"; \
		dest_region="$${mapping##*:}"; \
		mkdir -p "$$dest/$$dest_region"; \
		for issue in January:2001 June:2002 July:2002 August:2002 September:2002 October:2002 November:2002 December:2002; do \
			month="$${issue%%:*}"; \
			year="$${issue##*:}"; \
			lower="$$(printf '%s' "$$month" | tr '[:upper:]' '[:lower:]')"; \
			cp "bin/$$year/$$month/issue_$$src_lang.bin" "$$dest/$$dest_region/$${lower}_$${year}.bin"; \
			cp "bin/$$year/$$month/issue_$$src_lang.bin.message" "$$dest/$$dest_region/$${lower}_$${year}.bin.message"; \
		done; \
	done
	@echo "Installed news binaries and .message files to $(REON_BXT_DIR)"

define compile_news
	@mkdir -p bin
	$(RGBASM) 2001_January_issue.asm -o issue.o -D RANKING_1="$(2001_JANUARY_RANKING_1)" -D RANKING_2="$(2001_JANUARY_RANKING_2)" -D RANKING_3="$(2001_JANUARY_RANKING_3)" -D MINIGAME_FILE="$(2001_JANUARY_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2001/January/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2001/January/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2001/January/issue_$(1).bin
	$(RGBASM) 2002_June_issue.asm -o issue.o -D RANKING_1="$(2002_JUNE_RANKING_1)" -D RANKING_2="$(2002_JUNE_RANKING_2)" -D RANKING_3="$(2002_JUNE_RANKING_3)" -D MINIGAME_FILE="$(2002_JUNE_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2002/June/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2002/June/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2002/June/issue_$(1).bin
	$(RGBASM) 2002_July_issue.asm -o issue.o -D RANKING_1="$(2002_JULY_RANKING_1)" -D RANKING_2="$(2002_JULY_RANKING_2)" -D RANKING_3="$(2002_JULY_RANKING_3)" -D MINIGAME_FILE="$(2002_JULY_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2002/July/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2002/July/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2002/July/issue_$(1).bin
	$(RGBASM) 2002_August_issue.asm -o issue.o -D RANKING_1="$(2002_AUGUST_RANKING_1)" -D RANKING_2="$(2002_AUGUST_RANKING_2)" -D RANKING_3="$(2002_AUGUST_RANKING_3)" -D MINIGAME_FILE="$(2002_AUGUST_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2002/August/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2002/August/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2002/August/issue_$(1).bin
	$(RGBASM) 2002_September_issue.asm -o issue.o -D RANKING_1="$(2002_SEPTEMBER_RANKING_1)" -D RANKING_2="$(2002_SEPTEMBER_RANKING_2)" -D RANKING_3="$(2002_SEPTEMBER_RANKING_3)" -D MINIGAME_FILE="$(2002_SEPTEMBER_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2002/September/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2002/September/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2002/September/issue_$(1).bin
	$(RGBASM) 2002_October_issue.asm -o issue.o -D RANKING_1="$(2002_OCTOBER_RANKING_1)" -D RANKING_2="$(2002_OCTOBER_RANKING_2)" -D RANKING_3="$(2002_OCTOBER_RANKING_3)" -D MINIGAME_FILE="$(2002_OCTOBER_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2002/October/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2002/October/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2002/October/issue_$(1).bin
	$(RGBASM) 2002_November_issue.asm -o issue.o -D RANKING_1="$(2002_NOVEMBER_RANKING_1)" -D RANKING_2="$(2002_NOVEMBER_RANKING_2)" -D RANKING_3="$(2002_NOVEMBER_RANKING_3)" -D MINIGAME_FILE="$(2002_NOVEMBER_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2002/November/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2002/November/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2002/November/issue_$(1).bin
	$(RGBASM) 2002_December_issue.asm -o issue.o -D RANKING_1="$(2002_DECEMBER_RANKING_1)" -D RANKING_2="$(2002_DECEMBER_RANKING_2)" -D RANKING_3="$(2002_DECEMBER_RANKING_3)" -D MINIGAME_FILE="$(2002_DECEMBER_MINIGAME)" -D _LANG_$(shell echo '$1' | tr '[:lower:]' '[:upper:]')
	mkdir -p bin/2002/December/bin
	$(RGBLINK) issue.o -l pokecrystal/layout.link -o bin/2002/December/issue_$(1).bin
	$(PYTHON) newschecksum.py bin/2002/December/issue_$(1).bin

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
