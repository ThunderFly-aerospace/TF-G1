STL_DIR=STL
IMG_DIR=images
SRC_DIR=src
DEP_DIR=dep
GCD_DIR=gcode
SLICE_DIR=slicing

VPATH = $(SRC_DIR):$(DEP_DIR):$(STL_DIR):$(IMG_DIR):$(GCD_DIR)

PLATE_DIMMENSIONS=130
SIMARRANGE=/usr/local/bin/simarrange
STLSORT=stlsort
OPENSCAD_APP=openscad
SLIC3R_APP=slic3r-prusa3d



SOURCES=$(wildcard $(SRC_DIR)/*.scad)
TARGETS=$(patsubst $(SRC_DIR)/%.scad, $(STL_DIR)/%.stl, $(SOURCES))
IMAGES=$(patsubst $(SRC_DIR)/%.scad, $(IMG_DIR)/%.png, $(SOURCES))

STL=$(wildcard $(STL_DIR)/*.stl)
GCODES=$(patsubst $(STL_DIR)/*.stl, $(GCD_DIR)/%.gcode, $(STL))


SLICES=$(wildcard $(SLICE_DIR)/*.ini)

GCODE_TARGETS = $(patsubst $(SRC_DIR)/%.scad,%(GCD_DIR)/%.gcode,$(SRC_DIR)/$(wildcard *.scad))
STLFILES=$(wildcard $(STL_DIR)/*.stl)
GCODESSTL=$(patsubst $(STL_DIR)/*.stl, $(GCD_DIR)/%.gcode, $(STLFILES))

all: default images

calibration:
	$(OPENSCAD_APP) -m make -o calibration.stl calibration.scad

default: $(TARGETS)

$(STL_DIR)/%.stl: $(SRC_DIR)/%.scad
	# Update dependencies and make no-draft version of model.
	$(OPENSCAD_APP) -D "draft = false" -m make -o $@ -d $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) $<
	# Remove absolute paths in dependencies.
	#sed -i "s|$(shell pwd)/||" $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	sed -i "s|$(shell git rev-parse --show-toplevel)/|../../../|" $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	# Sort stl and deps file to keep git changes to minimum.
	$(STLSORT) $@ || :
	sort -rf $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) -o $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	sed -i 's|[^\]$$|& \\|' $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)

images: $(IMAGES)

$(IMG_DIR)/%.png : $(STL_DIR)/%.stl
	# Create temporary file for fast image rendering.
	-echo "import(\"$<\");" > tmp.scad
	# Render PNG image from temporary file.
	$(OPENSCAD_APP) -o $@ tmp.scad
	# Remove temporary file
	rm -f tmp.scad

gcode: $(GCODES)

#$(GCD_DIR)/%.gcode : $(STL_DIR)/%.stl
	echo $(GCODES)
	echo $<
	echo $^
	# get base names for ini file
	$(eval CFG_FILE=$(basename $(notdir $<)))
	echo $(CFG_FILE)
	$(eval CFG_FILE=$(basename $(notdir $<)))
	# skip error from slicing - eg missing ini file
	$(SLIC3R_APP) --load $(SLICE_DIR)/$(CFG_FILE).ini -o $(GCD_DIR)/$(CFG_FILE).gcode --no-gui  $< || true

arrange: default
	 $(SIMARRANGE) -x $(PLATE_DIMMENSIONS) -y $(PLATE_DIMMENSIONS) $(ARRANGE_TARGETS)

clean:
	rm -f calibration.stl
	rm -f $(STL_DIR)/*.stl
	rm -f $(IMG_DIR)/*.png
