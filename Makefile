# These options require OpenScad snapshot
OPENSCAD="/Applications/OpenSCAD Snapshot.app/Contents/MacOS/OpenSCAD" --enable=manifold

# This will work with the stable openscad
#OPENSCAD="/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD"

OPENSCAD_OPTIONS=--export-format binstl
OPENSCAD_CMD=$(OPENSCAD) $(OPENSCAD_OPTIONS)

mbk-corne:
	$(OPENSCAD_CMD) --render -o stl/mbk-corne.stl src/keycap_cutter.scad
