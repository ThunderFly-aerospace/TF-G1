STL_DIR=STL
IMG_DIR=images
SRC_DIR=src
SLICE_DIR=slicing
GCD_DIR=gcode
PLATE_DIMMENSIONS=130
SIMARRANGE=/usr/local/bin/simarrange
STLSORT=stlsort
OPENSCAD_APP=openscad
SLIC3R_APP=slic3r-prusa3d

SOURCES=$(wildcard $(SRC_DIR)/*.scad)
TARGETS=$(patsubst $(SRC_DIR)/%.scad, $(STL_DIR)/%.stl, $(SOURCES))
IMAGES=$(patsubst $(SRC_DIR)/%.scad, $(IMG_DIR)/%.png, $(SOURCES))

SLICES=$(wildcard $(SLICE_DIR)/*.ini)
STLFILES=$(wildcard $(STL_DIR)/*.stl)
GCODESINI=$(patsubst $(SLICE_DIR)/*.ini, $(GCD_DIR)/%.gcode, $(SLICES))
GCODESSTL=$(patsubst $(STL_DIR)/*.stl, $(GCD_DIR)/%.gcode, $(STLFILES))

all: default images gcode

calibration:
	$(OPENSCAD_APP) -m make -o calibration.stl calibration.scad

default: $(TARGETS)

$(STL_DIR)/%.stl: $(SRC_DIR)/%.scad
	$(OPENSCAD_APP) -m make -o $@ $<
	$(STLSORT) $@ || :

images: $(IMAGES)

$(IMG_DIR)/%.png: $(SRC_DIR)/%.scad
	$(OPENSCAD_APP) -m make --render -o $@ $<

gcode: $(GCODESINI) $(GCODESSTL)
#$(GCD_DIR)/%.gcode: $(STL_DIR)/%.stl
	$(eval CFG_FILE=$(basename $(notdir $<)))
	$(SLIC3R_APP) --load $< -o $(GCD_DIR)/$(CFG_FILE).gcode --no-gui  $(STL_DIR)/$(CFG_FILE).stl

arrange: default
	 $(SIMARRANGE) -x $(PLATE_DIMMENSIONS) -y $(PLATE_DIMMENSIONS) $(ARRANGE_TARGETS)

clean:
	rm -f calibration.stl
	rm -f $(STL_DIR)/*.stl
	rm -f $(IMG_DIR)/*.png
