
LATEST_PFUNIT_DIR := $(lastword $(shell echo $(wildcard $(PFUNIT_DIR)/PFUNIT-4.*) | xargs -n1 | sort -V))
include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk
FFLAGS += $(PFUNIT_EXTRA_FFLAGS)
FFLAGS += -I../module_ext
FFLAGS += -I../module_demo

all: test_simple

%.o : %.F90
	$(FC) -c $(FFLAGS) $<

test_simple_TESTS := test_module_demo.pf
test_simple_OTHER_LIBRARIES := -L../module_demo -L../module_ext -lsut
$(eval $(call make_pfunit_test,test_simple))


clean:
	$(RM) *.o *.mod *.a
	$(RM) test_module_demo.F90
	${RM} test_simple