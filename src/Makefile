# List of source files in build order - built left to right unless overriden below
SRCS := module_demo.F90 module_demo_external.F90 
OBJS := $(SRCS:%.F90=%.o)
# FC set in env vars

# Get pFUnit
LATEST_PFUNIT_DIR := $(lastword $(shell echo $(wildcard $(PFUNIT_DIR)/PFUNIT-4.*) | xargs -n1 | sort -V))
include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk

all: libsut.a test_simple 

# Add any compile flags?
FFLAGS += $(PFUNIT_EXTRA_FFLAGS)
FFLAGS += -I./
# WHAT IS THIS DOING??
# ifeq (nagfor,$(findstring nagfor,$(FC)))
#   FFLAGS += -fpp
# endif

# Setup/compile library?
libsut.a: $(OBJS)
	$(AR) -r $@ $?

# Set build order - this forces module_demo_external to be built before module_demo
module_demo.o: module_demo_external.mod
module_demo_external.mod: module_demo_external.o


# Tells make to Compile using FC compiler
%.o : %.F90
	$(FC) -c $(FFLAGS) $<
# WHAT IS THIS DOING??

# ==== DEFINE TESTS ==== #
# Define Tests and their dependencies

# **test_simple**
test_simple_TESTS := test_module_demo.pf
# test_simple_REGISTRY := 
# test_simple_OTHER_SOURCES := module_demo_external.F90 module_demo_external.mod
test_simple_OTHER_LIBRARIES := -L. -lsut
# test_simple_OTHER_LIBRARIES := -L../src -lsut
# test_simple_OTHER_INCS := module_demo_external.F90
 
$(eval $(call make_pfunit_test,test_simple))


# ==== CLEAN UP ==== #
clean:
	$(RM) *.o *.mod *.a *.inc
	$(RM) test_module_demo.F90
	${RM} test_simple
