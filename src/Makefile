SRCS := module_demo.F90
OBJS := $(SRCS:%.F90=%.o)

# Get pFUnit
LATEST_PFUNIT_DIR := $(lastword $(shell echo $(wildcard $(PFUNIT_DIR)/PFUNIT-4.*) | xargs -n1 | sort -V))
include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk

all: libsut.a test_simple 

# Process .o files?
%.o : %.F90
	$(FC) -c $(FFLAGS) $<

# Add any compile flags?
FFLAGS += $(PFUNIT_EXTRA_FFLAGS)
# FFLAGS += -I../src
# WHAT IS THIS DOING??
# ifeq (nagfor,$(findstring nagfor,$(FC)))
#   FFLAGS += -fpp
# endif

# Setup/compile library?
libsut.a: $(OBJS)
	$(AR) -r $@ $?

# WHAT IS THIS DOING??
# test_module_demo.o: module_demo.mod
# module_demo.mod: module_demo.o

# ==== DEFINE TESTS ==== #
# Define Tests and their dependencies

# **test_simple**
test_simple_TESTS := test_module_demo.pf
# test_simple_REGISTRY :=
# test_simple_OTHER_SOURCES :=
test_simple_OTHER_LIBRARIES := -L. -lsut
# test_simple_OTHER_INCS :=
 
$(eval $(call make_pfunit_test,test_simple))


# ==== CLEAN UP ==== #
clean:
	$(RM) *.o *.mod *.a *.inc
	$(RM) test_module_demo.F90
	${RM} test_simple
