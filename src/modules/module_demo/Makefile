# Files to compile
SRCS := \
	../module_ext/module_demo_external.F90 \
	module_demo.F90
OBJS := $(SRCS:%.F90=%.o)


FFLAGS += $(PFUNIT_EXTRA_FFLAGS)

FFLAGS += -I../module_ext

# Dependency locations

# all: libsut.a finishedCompile test_simple
all: libsut.a finishedCompile

libsut.a: $(OBJS)
	# creates an archive of the objs and saves it as libsut.a
	$(AR) -r $@ $?

%.o : %.F90
	$(FC) -c $(FFLAGS) $<

finishedCompile:
	@echo -----------------------COMPILED DEMO----------------------------------


# ==== ======================================================DEFINE TESTS ==== #
# Define Tests and their dependencies
tests: demo_tests
# Get pFUnit
ifeq ($(TEST_MODE), 1)
ifndef LATEST_PFUNIT_DIR
	$(error LATEST_PFUNIT_DIR is not set)
endif
include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk
endif

# include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk

OTHER_LIBRARIES = -L../module_demo -L../module_ext -lsut

# **run_tests**
demo_tests_TESTS := module_demo_test.pf
demo_tests_OTHER_LIBRARIES := $(OTHER_LIBRARIES)

$(eval $(call make_pfunit_test,demo_tests))


# test_simple_TESTS := test_module_demo.pf
# test_simple_OTHER_LIBRARIES := -L../module_ext -lsut
# $(eval $(call make_pfunit_test,test_simple))


clean:
	$(RM) *.o *.mod *.a *_test.F90 *.inc
