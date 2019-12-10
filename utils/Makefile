VPATH = $(SRC_DIR):$(DEP_DIR):$(STL_DIR):$(IMG_DIR):$(GCD_DIR)

PLATE_DIMMENSIONS=130
SIMARRANGE=/usr/local/bin/simarrange
STLSORT=stlsort
OPENSCAD_APP=openscad
#SLIC3R_APP=slic3r-prusa3d
SLIC3R_APP=$(GIT_ROOT)/utils/slicer/Slic3r-1.3.1-dev.AppImage
STL_INFO=$(GIT_ROOT)/utils/stl_info
#SLIC3R_APP=$(GIT_ROOT)/utils/slicer/PrusaSlicer-2.1.0.AppImage


SOURCES=$(wildcard $(SRC_DIR)/*.scad)
TARGETS=$(patsubst $(SRC_DIR)/%.scad, $(STL_DIR)/%.stl, $(SOURCES))
IMAGES=$(patsubst $(SRC_DIR)/%.scad, $(IMG_DIR)/%.png, $(SOURCES))

#STL=$(wildcard $(INI_DIR)/*.ini)
#GCODES=$(patsubst $(INI_DIR)/*.ini, $(GCD_DIR)/%.gcode, $(STL))

STL=$(wildcard $(STL_DIR)/*.stl)
GCODES=$(patsubst $(STL_DIR)/%.stl, $(GCD_DIR)/%.gcode, $(STL))

RED=" \e[91m "
GRN=" \e[32m "
YEL=" \e[33m "
DEF=" \e[39m "

all: default images gcode
slice: default images

calibration:
	$(OPENSCAD_APP) -m make -o calibration.stl calibration.scad

default: $(TARGETS)
$(STL_DIR)/%.stl: $(SRC_DIR)/%.scad
	@# Update dependencies and make no-draft version of model.
	@echo $(GRN) "Render" $< "with" $(OPENSCAD_APP) $(DEF) $(YEL)
	@[ -d $(DEP_DIR) ] || mkdir $(DEP_DIR)
	@$(OPENSCAD_APP) -D "draft = false" -D "week = `date +%V`" -m make -o $@ -d $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) $< && echo $(DEF) || echo $(RED) "Chyba v renderovani" % $(YEL)
	@# Remove absolute paths in dependencies.
	@#sed -i "s|$(shell pwd)/||" $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	@#sed -i "s|$(shell git rev-parse --show-toplevel)/|../../../|" $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	@# Sort stl and deps file to keep git changes to minimum.
	@$(STLSORT) $@ || :
	@sort -rf $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@) -o $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	@sed -i 's|[^\]$$|& \\|' $(patsubst $(STL_DIR)/%.stl, $(DEP_DIR)/%.deps, $@)
	@echo $(GRN) "DONE: Render" $< $(DEF)

#-include $(wildcard $(DEP_DIR)/*.deps)

images: $(IMAGES)
$(IMG_DIR)/%.png : $(STL_DIR)/%.stl
	@# Create temporary file for fast image rendering.
	@mkdir tmp > /dev/null || echo " "
	@mkdir tmp/$(STL_DIR) > /dev/null || echo " "
	@$(eval FILE=$(basename $(notdir $<)))
	@#echo "import('../$<'');" > tmp/$<
	@echo "import(\"../$<\");" > tmp/$(FILE).scad

	@# Render PNG image from temporary file.
	@echo $(YEL)
	@$(OPENSCAD_APP) -o $@ tmp/$(FILE).scad
	@rm -f tmp/$<
	@echo $(DEF)


gcode: $(GCODES)
$(GCD_DIR)/%.gcode : $(STL_DIR)/%.stl
	@$(eval BASENAME=$(basename $(notdir $<)))
	@$(eval CFG_FILE=$(BASENAME))
# Obtain configuration file from cfg file
	$(eval INI_FILE=$(PWD)/$(INI_DIR)/$(shell grep $(BASENAME) $(INI_DIR)/cfg -c > /dev/null && echo `grep -m 1 $(BASENAME) $(INI_DIR)/cfg | cut -d',' -f2` || echo `grep default $(INI_DIR)/cfg | cut -d',' -f2`))
	@echo $(GRN) "Slicing " $(STL_DIR)/$(CFG_FILE).stl "with profile" $(INI_FILE) $(YEL)
# Slice file with cfg from file
	@$(SLIC3R_APP) --load $(INI_FILE) -o $(PWD)/$(GCD_DIR)/$(CFG_FILE).gcode --no-gui -j 3 $(PWD)/$(STL_DIR)/$(CFG_FILE).stl
# add STL informations to gcode
	@$(STL_INFO) $(PWD)/$(STL_DIR)/$(CFG_FILE).stl $(PWD)/$(GCD_DIR)/$(CFG_FILE).gcode > /dev/null  || echo $(RED) "Error in STL positioning"
	@echo $(DEF)


gcode_clean:
	rm -f $(GCD_DIR)/*.gcode


arrange: default
	$(SIMARRANGE) -x $(PLATE_DIMMENSIONS) -y $(PLATE_DIMMENSIONS) $(ARRANGE_TARGETS)

clean:
	rm -f calibration.stl
	rm -f $(STL_DIR)/*.stl
	rm -f $(IMG_DIR)/*.png
