STL_DIR=STL
IMG_DIR=images
SRC_DIR=src
SLICE_DIR=slicing
GCD_DIR=gcode
PLATE_DIMMENSIONS=130
SIMARRANGE=/usr/local/bin/simarrange
STLSORT=stlsort
OPENSCAD_APP=openscad
CURA_APP=CuraEngine

SOURCES=$(wildcard $(SRC_DIR)/*.scad)
TARGETS=$(patsubst $(SRC_DIR)/%.scad, $(STL_DIR)/%.stl, $(SOURCES))
IMAGES=$(patsubst $(SRC_DIR)/%.scad, $(IMG_DIR)/%.png, $(SOURCES))
#GCODES=$(patsubst slicing/%.json, gcode/%.gcode, $(SOURCES))
#GCODES=$(wildcard ./slicing/%.cfg)
GCODES=$(wildcard $(SLICE_DIR)/*.cfg)

all: default images

calibration:
	$(OPENSCAD_APP) -m make -o calibration.stl calibration.scad

default: $(TARGETS)

$(STL_DIR)/%.stl: $(SRC_DIR)/%.scad
	$(OPENSCAD_APP) -m make -o $@ $<
	$(STLSORT) $@ || :

images: $(IMAGES)

$(IMG_DIR)/%.png: $(SRC_DIR)/%.scad
	$(OPENSCAD_APP) -m make --render -o $@ $<

gcode: $(GCODES)

#$(GCD_DIR)/%.scf: $(SLICE_DIR)/%.json
	echo $<
	$(eval CFG_FILE=$(basename $(notdir $<)))
	echo $(CFG_FILE)
	$(CURA_APP) slice -j utils/slicer/cura/fdmprinter.def.json -o $(GCD_DIR)/$(CFG_FILE).gcode -l $(STL_DIR)/$(CFG_FILE).stl

arrange: default
	 $(SIMARRANGE) -x $(PLATE_DIMMENSIONS) -y $(PLATE_DIMMENSIONS) $(ARRANGE_TARGETS)

clean:
	rm -f calibration.stl
	rm -f $(STL_DIR)/*.stl
	rm -f $(IMG_DIR)/*.png
