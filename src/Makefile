SRCS := \
	./modules/module_demo/*.F90 \
	./modules/module_ext/*.F90
OBJS := $(SRCS:%.F90=%.o)

FFLAGS += -I./modules/module_demo
FFLAGS += -I./modules/module_ext

ifeq ($(TEST_MODE), 1)
all: build_modules
else
all: build_modules build
endif


build_modules:
ifndef ROOT_DIR
	$(error ROOT_DIR is not set)
endif
	@echo ------------BUILD MODULES---------------------------------------------
	$(MAKE) -C modules all

%.o : %.F90
	$(FC) -c $(FFLAGS) $<

build: build_modules
	@echo ------------BUILDING PROGRAM---------------------------------------------
	$(FC) -c $(FFLAGS) main.f90
	$(FC) $(FFLAGS) -o ./run main.f90 $(OBJS)
clean:
	@echo -----------------CLEANING----------------------------------------
	$(MAKE) -C modules clean
	$(RM) *.o *.mod *.a
	$(RM) run