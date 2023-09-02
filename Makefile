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

# Outputs to generate
OUTPUTS := preview sprued top_left top_right bottom_left bottom_right

# Source files
SRCS := $(wildcard $(SRC_DIR)/gen_*.scad)

# Base names without prefix and suffix
BASE_NAMES := $(patsubst $(SRC_DIR)/gen_%.scad,%,$(SRCS))

# Convert stagger to integer or string parameter
STAGGER_VAL=$(shell if echo $(STAGGER) | grep -qE '^[-+]?[0-9]*\.?[0-9]+$$'; then echo $(STAGGER); else echo \\\\\"$(STAGGER)\\\\\"; fi)

# Rule to generate the target names
define GEN_TARGETS
$(STL_DIR)/$(1)/$(1)_$(STAGGER)_preview.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"preview\" -D key_stagger=$(STAGGER_VAL) -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_sprued.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"sprued\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_top_left.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"top_left\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_top_right.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"top_right\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_bottom_left.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"bottom_left\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(STL_DIR)/$(1)/$(1)_$(STAGGER)_bottom_right.stl: $(SRC_DIR)/gen_$(1).scad src/keycap_cutter.scad src/stl_combiner.scad $(if $(filter cs_%,$(1)),src/cs_keys.scad)
	mkdir -p $(STL_DIR)/$(1)
	$(OPENSCAD) -D output=\"bottom_right\" -D key_stagger=$(STAGGER_VAL)  -o $$@ $$<

$(1): $(foreach output,$(OUTPUTS),$(STL_DIR)/$(base)/$(base)_$(STAGGER)_$(output).stl)

endef

# Default rule
all: $(foreach base,$(BASE_NAMES),$(foreach output,$(OUTPUTS),$(STL_DIR)/$(base)/$(base)_$(STAGGER)_$(output).stl))

# Generate targets for all source files
$(foreach base,$(BASE_NAMES),$(eval $(call GEN_TARGETS,$(base))))

previews: $(foreach base,$(BASE_NAMES),$(STL_DIR)/$(base)/$(base)_$(STAGGER)_preview.stl)

sprued: $(foreach base,$(BASE_NAMES),$(STL_DIR)/$(base)/$(base)_$(STAGGER)_sprued.stl)

# Clean target
clean:
	rm -f $(foreach base,$(BASE_NAMES),$(foreach output,$(OUTPUTS),$(STL_DIR)/$(base)/$(base)_$(STAGGER)_$(output).stl))

# Help target
help:
	@echo "Available targets:\n"
	@$(foreach base,$(sort $(BASE_NAMES)), \
		echo "$(base):"; \
		$(foreach output,$(OUTPUTS), \
			echo "  $(SRC_DIR)/gen_$(base)_$(output).scad"; \
		) \
		echo; \
	)
	@echo "preview:"
	@echo "  Generate only preview stls."
	@echo
	@echo "sprued:"
	@echo "  Generate only sprued stls."