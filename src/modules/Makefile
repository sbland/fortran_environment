

ifeq ($(TEST_MODE), 1)

export LATEST_PFUNIT_DIR = $(lastword $(shell echo $(wildcard $(PFUNIT_DIR)/PFUNIT-4.*) | xargs -n1 | sort -V))
include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk
FFLAGS += $(PFUNIT_EXTRA_FFLAGS)
all: build testing

else
all: build
endif

build:
ifndef ROOT_DIR
	$(error ROOT_DIR is not set)
endif
	@echo -------------BUILDING MODULES--------------------------------------------
	$(MAKE) -C module_ext all
	$(MAKE) -C module_demo all

	@echo ---------------------------------------------------------

testing: build
	@echo -------------BUILDING TESTS--------------------------------------------
	$(MAKE) -C module_demo tests
	# $(MAKE) -C tests all

%.o : %.F90
	$(FC) -c $(FFLAGS) $<

clean:
	@echo -----------------CLEANING----------------------------------------
	$(MAKE) -C module_ext clean
	$(MAKE) -C module_demo clean
	$(MAKE) -C tests clean
