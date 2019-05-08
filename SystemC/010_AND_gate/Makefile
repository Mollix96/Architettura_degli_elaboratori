#
# SystemC path.
#
TARGET_ARCH      ?= linux64
SYSTEMC_HOME     ?= /usr/local/systemc-2.3.3
SYSTEMC_INC_DIR  += -I. -I.. -I$(SYSTEMC_HOME)/include 
SYSTEMC_LIB_DIR  += -L$(SYSTEMC_HOME)/lib-$(TARGET_ARCH)

#
# Opzioni per il compilatore.
#
COMPILER         = g++
OPTIONS          = -Wall -Wno-deprecated -fexceptions -O0 -g
C_FLAGS          += ${OPTIONS} ${SYSTEMC_INC_DIR} ${SYSTEMC_LIB_DIR}

#
# Librerie.
#
LIBRARIES        += -lsystemc

#
# File sorgente e file oggetto.
#
CPP_SOURCES      += main.cpp and.cpp datagen.cpp display.cpp
CPP_OBJECTS      = $(CPP_SOURCES:.cpp=.o)

#
# Nome dell'eseguibile.
#
EXECUTABLE       = run_me.x



#
# Build.
#
all: $(EXECUTABLE)

$(EXECUTABLE): $(CPP_OBJECTS)
	$(COMPILER) $(C_FLAGS) -o $@ $(CPP_OBJECTS) $(LIBRARIES) 2>&1
        
%.o:    %.cpp
	$(COMPILER) $(C_FLAGS) -c $<



#
# Soft clean (non elimina l'eseguibile ed il .vcd).
#
softclean:
	rm -f *.o

#
# Clean.
#
clean:
	rm -f *.o $(EXECUTABLE) *.vcd
