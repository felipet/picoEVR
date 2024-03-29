################################################################################
#
# Makefile for the picoEVR project
# --------------------------------
#
################################################################################

# Debug Flag: Vivado verbose mode and reports
DEBUG ?= 0
# Import already generated DCPs. Usefull for the generation of reports after
# the compilation.
IMPORT_PRODUCTS ?= 0

# config file name
SCRIPT_DIR=fpga/srcs/script
CONFIG_NAME=$(SCRIPT_DIR)/project.options

# read config file into variables
BUILD_DIR          := $(shell grep -e 'directory.build'  $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
SRC_ROOT           := $(shell grep -e 'directory.src'    $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
OUTPUT_DIR         := $(shell grep -e 'directory.output' $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
LOG_DIR            := $(shell grep -e 'directory.log'    $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
BINARY_DIR         := $(shell grep -e 'directory.bin'    $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
PROJECT_NAME       := $(shell grep -e 'project.name'     $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
PROJECT_DIR        := $(shell grep -e 'project.dir'      $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
PROJECT_TOP        := $(shell grep -e 'project.name'     $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
PROJECT_TCL        := $(shell grep -e 'project.tcl'      $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
HDL_FILES_FILENAME := $(shell grep -e 'files.hdl'        $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
XDC_FILES_FILENAME := $(shell grep -e 'files.xdc'        $(CONFIG_NAME) | sed 's/[^:]*:\s*//')

# Parameteres for the project generation
# --------------------------------------
# Specify which carrier board hw version will be used
CARRIER_REV  ?= $(shell grep -e 'firmware.carrier'  $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
# Enable debugging ILA cores
ENABLE_DEBUG ?= $(shell grep -e 'firmware.en_db'    $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
# Enable the DIO FMC in the design
ENABLE_DIO   ?= $(shell grep -e 'firmware.en_dio'   $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
# Enable the ECATS FMC in the design
ENABLE_ECATS ?= $(shell grep -e 'firmware.en_ecats' $(CONFIG_NAME) | sed 's/[^:]*:\s*//')

# -------
# Targets
# -------
.PHONY: all clean project synthesis implementation bitstream

all: project synthesis implementation bitstream

project:        $(OUTPUT_DIR)/$(PROJECT_NAME).xpr
synthesis:      $(BUILD_DIR)/$(PROJECT_TOP).dcp
implementation: $(BUILD_DIR)/$(PROJECT_TOP)_routed.dcp
bitstream:      $(BUILD_DIR)/$(PROJECT_TOP).bit

bin_dir:
	@mkdir -p $(BINARY_DIR)

# Vivado workflow steps
# ---------------------

#project file generation.
$(OUTPUT_DIR)/$(PROJECT_NAME).xpr:
	@echo "\033[1;92mBuilding project: $@ ($(CARRIER_REV))\033[0m"
	@mkdir -p $(LOG_DIR)
	@vivado -mode batch -m64 -source $(PROJECT_TCL) -tclarg --origin_dir "fpga/srcs/tcl/" --carrier_rev "$(CARRIER_REV)" --enable_dio "$(ENABLE_DIO)" --enable_debug "$(ENABLE_DEBUG)" --enable_ecats "$(ENABLE_ECATS)" 2>&1 | tee $(LOG_DIR)/project.log

$(BUILD_DIR)/$(PROJECT_TOP).dcp:
	@echo "\033[1;92mRunning synthesis: $@\033[0m"
	@mkdir -p $(BUILD_DIR)
	@vivado -mode batch -source $(SCRIPT_DIR)/run_steps.tcl -tclargs synth $(CARRIER_REV) | tee $(LOG_DIR)/project.log

$(BUILD_DIR)/$(PROJECT_TOP)_routed.dcp:
	@echo "\033[1;92mRunning implementation: $@\033[0m"
	@mkdir -p $(BUILD_DIR)
	@vivado -mode batch -source $(SCRIPT_DIR)/run_steps.tcl -tclargs impl $(CARRIER_REV) | tee $(LOG_DIR)/project.log

$(BUILD_DIR)/$(PROJECT_TOP).bit: bin_dir
	@echo "\033[1;92mGenerating bitstream: $@\033[0m"
	@mkdir -p $(BUILD_DIR)
	@vivado -mode batch -source $(SCRIPT_DIR)/run_steps.tcl -tclargs  bitstream $(CARRIER_REV) | tee $(LOG_DIR)/project.log

# Binary collect & stamping
# ---------------

BINARY_PATH := $(subst .bit,,$(shell find $(BUILD_DIR) -name "*.bit" 2> /dev/null))
ifneq ($(BINARY_PATH),)
DEBUG := $(shell find $(BUILD_DIR) -name "*.ltx")
BINARY_NAME := $(shell basename $(BINARY_PATH))
EXT := ".bit"
ifneq ($(DEBUG),)
EXT := .bit .ltx
endif
else
EXT :=
endif

gather_bit: bin_dir
ifeq ($(EXT),)
	@echo "\033[1;31mError:\033[0m No binary found"
else
	@echo "\033[1;92mFiles will be stored at: \033[0m$(BINARY_DIR)"
	$(foreach e, $(EXT), $(shell cp $(BINARY_PATH)$(e) $(BINARY_DIR)/))
	@echo "\033[1;92mFound files:\033[0m"
	@ls $(BINARY_DIR)
endif

# Check wether the compiled products come from a tagged version or not
RELEASE ?= $(shell git describe --exact-match --tags $(git log -n1 --pretty='%h') 2> /dev/null)
HASH := $(shell git rev-parse --short HEAD)
# Timestamp output files?
TS ?= $(shell grep -e 'project.tsoutputs' $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
ifeq ($(TS),yes)
DATE = "_$(shell date +%Y%m%d_%H%M)"
endif

stamp: gather_bit
ifeq ($(EXT),)
	@echo "\033[1;31mError:\033[0m No binary to rename"
else
ifeq ($(RELEASE),)
	@echo "\033[1;92mBinaries will be tagged using the commit hash\033[0m ($(HASH))"
	$(foreach e, $(EXT), $(shell mv $(BINARY_DIR)/$(BINARY_NAME)$(e) $(BINARY_DIR)/$(PROJECT_NAME)_$(CARRIER_REV)_$(HASH)$(DATE)$(e)))
else
	@echo "\033[1;92mBinaries will be tagged using the release tag\033[0m ($(RELEASE))"
	$(foreach e, $(EXT), $(shell mv $(BINARY_DIR)/$(BINARY_NAME)$(e) $(BINARY_DIR)/$(PROJECT_NAME)_$(CARRIER_REV)_$(RELEASE)$(DATE)$(e)))
endif
	@ls $(BINARY_DIR)
endif

# Cleaning
# --------

clean:
	@echo "\033[1;92mDeleting all generated files\033[0m"
	@rm -rf $(BUILD_DIR)
	@rm -rf $(LOG_DIR)
	@rm -f *.jou
	@rm -f *.log
	@rm -f *.dmp
	@rm -f *.os
	@rm -f *.html
	@rm -f *.str
	@rm -rf $(OUTPUT_DIR)/$(PROJECT_DIR)
	@rm -rf `find . -maxdepth 2 -type d -name '.Xil'`

clean_project:
	@echo "\033[1;92mDeleting project files\033[0m"
	@rm -rf $(OUTPUT_DIR)/$(PROJECT_DIR)
	@rm -rf `find . -maxdepth 2 -type d -name '.Xil'`
