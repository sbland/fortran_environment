SRCS := module_demo.F90
OBJS := $(SRCS:%.F90=%.o)

# LATEST_PFUNIT_DIR := $(lastword $(shell echo $(wildcard $(PFUNIT_DIR)/PFUNIT-4.*) | xargs -n1 | sort -V))
# include $(LATEST_PFUNIT_DIR)/include/PFUNIT.mk
FFLAGS += $(PFUNIT_EXTRA_FFLAGS)
FFLAGS += -I../module_ext

# all: libsut.a finishedCompile test_simple
all: libsut.a finishedCompile

libsut.a: $(OBJS)
	$(AR) -r $@ $?

%.o : %.F90
	$(FC) -c $(FFLAGS) $<

finishedCompile:
	@echo -----------------------COMPILED DEMO----------------------------------


# test_simple_TESTS := test_module_demo.pf
# test_simple_OTHER_LIBRARIES := -L../module_ext -lsut
# $(eval $(call make_pfunit_test,test_simple))


clean:
	$(RM) *.o *.mod *.a