# The default stagger value is corne, which corresponds to 2.375,
# but you can change it by running `make all STAGGER=5.5`
STAGGER ?= corne

# These options require OpenScad snapshot
OPENSCAD="/Applications/OpenSCAD Snapshot.app/Contents/MacOS/OpenSCAD" --enable=manifold

# This will work with the stable openscad
#OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

OPENSCAD_OPTIONS=--export-format binstl
OPENSCAD_CMD=$(OPENSCAD) $(OPENSCAD_OPTIONS)

# Directories
SRC_DIR := src
STL_DIR := stl

# Source files
SRCS := $(wildcard $(SRC_DIR)/gen_*.scad)

# Base names without prefix and suffix
BASE_NAMES := $(patsubst $(SRC_DIR)/gen_%.scad,%,$(SRCS))

# Convert stagger to integer or string parameter
STAGGER_VAL=$(shell if echo $(STAGGER) | grep -qE '^[-+]?[0-9]*\.?[0-9]+$$'; then echo $(STAGGER); else echo \\\\\"$(STAGGER)\\\\\"; fi)

# Rule to generate the target names
define GEN_TARGETS
$(STL_DIR)/$(1)/$(1)_$(STAGGER)_preview.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"preview\" -D key_stagger=$(STAGGER_VAL) -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_top_left.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"top_left\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_top_right.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"top_right\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_bottom_left.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"bottom_left\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_bottom_right.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"bottom_right\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_sprued.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"sprued\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<
endef

# Default rule
all: $(foreach base,$(BASE_NAMES),$(STL_DIR)/$(base)/$(base)_$(STAGGER)_preview.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_top_left.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_top_right.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_bottom_left.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_bottom_right.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_sprued.stl)

# Generate targets for all source files
$(foreach base,$(BASE_NAMES),$(eval $(call GEN_TARGETS,$(base))))

# Dynamic clean target
clean:
	rm -f $(foreach base,$(BASE_NAMES),$(STL_DIR)/$(base)/$(base)_$(STAGGER)_preview.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_top_left.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_top_right.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_bottom_left.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_bottom_right.stl $(STL_DIR)/$(base)/$(base)_$(STAGGER)_sprued.stl)

# Help target
help:
	@echo "Available targets:\n"
	@$(foreach base,$(sort $(BASE_NAMES)), \
		echo "$(base):"; \
		$(foreach target,$(TARGET_VALUES), \
			echo "  $(SRC_DIR)/gen_$(base)_$(target).scad"; \
		) \
		echo; \
	)
