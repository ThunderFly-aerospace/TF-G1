VPATH = $(SRC_DIR):$(DEP_DIR):$(STL_DIR):$(IMG_DIR):$(GCD_DIR)

PLATE_DIMMENSIONS=130
SIMARRANGE=/usr/local/bin/simarrange
STLSORT=stlsort
OPENSCAD_APP=openscad
#SLIC3R_APP=slic3r-prusa3d
SLIC3R_APP=$(GIT_ROOT)/utils/slicer/Slic3r-1.3.1-dev.AppImage

SOURCES=$(wildcard $(SRC_DIR)/*.scad)
TARGETS=$(patsubst $(SRC_DIR)/%.scad, $(STL_DIR)/%.stl, $(SOURCES))
IMAGES=$(patsubst $(SRC_DIR)/%.scad, $(IMG_DIR)/%.png, $(SOURCES))

STL=$(wildcard $(STL_DIR)/*.stl)
GCODES=$(patsubst $(STL_DIR)/*.stl, $(GCD_DIR)/%.gcode, $(STL))

RED=" \e[91m "
GRN=" \e[32m "
DEF=" \e[39m "


all: default images gcode

calibration:
	$(OPENSCAD_APP) -m make -o calibration.stl calibration.scad

default: $(TARGETS)

$(STL_DIR)/%.stl: $(SRC_DIR)/%.scad
	@# Update dependencies and make no-draft version of model.
	@echo $(GRN) "Render" $< "with" $(OPENSCAD_APP) $(DEF)
	@$(OPENSCAD_APP) -D "draft = false" -m make -o $@ -d $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) $< || echo $(RED) "Chyba v renderovani" $(DEF)
	@# Remove absolute paths in dependencies.
	@#sed -i "s|$(shell pwd)/||" $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	@sed -i "s|$(shell git rev-parse --show-toplevel)/|../../../|" $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	@# Sort stl and deps file to keep git changes to minimum.
	$(STLSORT) $@ || :
	@sort -rf $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) -o $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	@sed -i 's|[^\]$$|& \\|' $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)

#include $(wildcard $(DEP_DIR)/*.deps)


images: $(IMAGES)

$(IMG_DIR)/%.png : $(STL_DIR)/%.stl
	@# Create temporary file for fast image rendering.
	@-echo "import(\"$<\");" > tmp.scad
	@# Render PNG image from temporary file.
	$(OPENSCAD_APP) -o $@ tmp.scad
	@# Remove temporary file
	@rm -f tmp.scad


gcode: $(GCODE_TARGETS)

	echo $(GCODE_TARGETS)
$(GCD_DIR)/%.gcode : $(INI_DIR)/%.ini
	@$(eval CFG_FILE=$(basename $(notdir $<)))
	@echo $(GRN) "Slice" $(STL_DIR)/$(CFG_FILE).stl "with" $(SLIC3R_APP) $(DEF) $(INI_DIR)/$(CFG_FILE).ini
	@$(SLIC3R_APP) --load $(INI_DIR)/$(CFG_FILE).ini -o $(GCD_DIR)/$(CFG_FILE).gcode --no-gui  $(STL_DIR)/$(CFG_FILE).stl || echo $(RED) "Error in slicing" $(DEF)

arrange: default
	 $(SIMARRANGE) -x $(PLATE_DIMMENSIONS) -y $(PLATE_DIMMENSIONS) $(ARRANGE_TARGETS)

clean:
	rm -f calibration.stl
	rm -f $(STL_DIR)/*.stl
	rm -f $(IMG_DIR)/*.png
