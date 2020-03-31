# Files to compile
SRCS := \
	../module_ext/module_demo_external.F90 \
	module_demo.F90
OBJS := $(SRCS:%.F90=%.o)

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


# test_simple_TESTS := test_module_demo.pf
# test_simple_OTHER_LIBRARIES := -L../module_ext -lsut
# $(eval $(call make_pfunit_test,test_simple))


clean:
	$(RM) *.o *.mod *.a