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
PROJECT_NAME       := $(shell grep -e 'project.name'     $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
PROJECT_DIR        := $(shell grep -e 'project.dir'      $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
PROJECT_TOP        := $(shell grep -e 'project.name'     $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
PROJECT_TCL        := $(shell grep -e 'project.tcl'      $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
HDL_FILES_FILENAME := $(shell grep -e 'files.hdl'        $(CONFIG_NAME) | sed 's/[^:]*:\s*//')
XDC_FILES_FILENAME := $(shell grep -e 'files.xdc'        $(CONFIG_NAME) | sed 's/[^:]*:\s*//')

# -------
# Targets
# -------
.PHONY: all clean project

all: project

project:        $(PROJECT_NAME).xpr

# Vivado workflow steps
# ---------------------

#project file generation.
$(PROJECT_NAME).xpr:
	@echo -e "\033[1;92mBuilding: $@\033[0m"
	@mkdir -p $(LOG_DIR)
	@vivado -mode batch -m64 -source $(PROJECT_TCL) -tclarg --origin_dir "fpga/srcs/tcl/" 2>&1 | tee $(LOG_DIR)/project.log
ifeq ($(SO), LINUX)
	@! grep -e '^ERROR' $(LOG_DIR)/project.log
endif

# Cleaning
# --------

clean:
	@echo -e "\033[1;92mDeleting all generated files\033[0m"
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
	@echo -e "\033[1;92mDeleting project files\033[0m"
	@rm -rf $(OUTPUT_DIR)/$(PROJECT_DIR)
	@rm -rf `find . -maxdepth 2 -type d -name '.Xil'`

