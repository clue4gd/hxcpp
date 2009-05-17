
ifeq ("$(OSTYPE)","linux")
FULL_DLL_NAME = ../../../bin/Linux/$(NDLL_NAME).dso
LD_FLAGS = $(LINUX_LD_FLAGS) -shared -o $(FULL_DLL_NAME) 
else
FULL_DLL_NAME = ../../../bin/Mac/$(NDLL_NAME).dylib
LD_FLAGS = $(MAC_LD_FLAGS) ../../../bin/Mac/hxcpp.dylib -dynamiclib -o $(FULL_DLL_NAME)
endif

LD := g++


ifdef HXCPP_DEBUG
OPTIM := -O2
else
OPTIM := -g
endif


NEKO_SOURCE_DIR := ../neko

CPP := g++
DEFINES += -DNEKO_SOURCES
CPPFLAGS += -I"$(HXCPP)/include" -I"$(NEKO_SOURCE_DIR)" -frtti -c $(OPTIM) $(DEFINES)
OBJ := o

all : obj $(FULL_DLL_NAME)

SOURCE_FILES := $(wildcard *.cpp)

OBJ_FILES += $(SOURCE_FILES:%.cpp=%.$(OBJ))

FULL_OBJ_FILES := $(OBJ_FILES:%=obj/%)



obj/%.$(OBJ):%.cpp
	$(CPP) $(CPPFLAGS) $< -o$@


obj:
	mkdir -p obj


clean:
	-rm -rf obj
clobber:
	-rm -rf obj $(FULL_DLL_NAME)


$(FULL_DLL_NAME) : $(FULL_OBJ_FILES)
	$(LD) $(FULL_OBJ_FILES) $(LD_FLAGS)

