# Target architecture.
TARGET_ARCH      ?= linux64

# SystemC path.
SYSTEMC_HOME     ?= /usr/local/systemc-2.3.3
SYSTEMC_INC_DIR  += -I. -I.. -I$(SYSTEMC_HOME)/include 
SYSTEMC_LIB_DIR  += -L$(SYSTEMC_HOME)/lib-$(TARGET_ARCH)

# Compiler options.
COMPILER = g++
OPTIONS          = -Wall -Wno-deprecated -fexceptions -O0 -g
C_FLAGS          += ${OPTIONS} ${SYSTEMC_INC_DIR} ${SYSTEMC_LIB_DIR}
CPP_FLAGS        += ${C_FLAGS}

# Libraries.
LIBRARIES        += -lsystemc

# Sources and objects.
CPP_SOURCES      += main.cpp datagen.cpp display.cpp xor.cpp
CPP_OBJECTS      = $(CPP_SOURCES:.cpp=.o)

# Executable name.
EXE              = run_me.x



# Build.
all: $(EXE)

$(EXE): $(CPP_OBJECTS)
	$(COMPILER) $(C_FLAGS) -o $@ $(CPP_OBJECTS) $(LIBRARIES) 2>&1
        
%.o:    %.cpp
	$(COMPILER) $(C_FLAGS) -c $<



# Soft clean (does not delete executable and .vcd).
softclean:
	rm -f *.o

# Clean.
clean:
	rm -f *.o $(EXE) *.vcd
