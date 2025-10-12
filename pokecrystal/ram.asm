INCLUDE "pokecrystal/macros/ram.asm"

IF DEF(_LANG_J)
INCLUDE "pokecrystal/ram/wram.asm"
INCLUDE "pokecrystal/ram/sram.asm"
ELSE
INCLUDE "pokecrystal/ram/wram_int.asm"
INCLUDE "pokecrystal/ram/sram_int.asm"
ENDC

INCLUDE "pokecrystal/ram/hram.asm"
