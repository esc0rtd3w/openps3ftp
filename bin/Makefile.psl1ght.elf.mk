# OpenPS3FTP Makefile

include $(PSL1GHT)/ppu_rules

TARGET		:= openps3ftp.elf

# Libraries
LIBPATHS	:= -L../lib -L$(PORTLIBS)/lib $(LIBPSL1GHT_LIB)
LIBS		:= -lopenps3ftp_psl1ght -lNoRSX -lfreetype -lgcm_sys -lrsx -lnetctl -lnet -lsysutil -lsysmodule -lrt -lsysfs -llv2 -lm -lz

# Includes
INCLUDE		:= -I../include -I./feat -I$(PORTLIBS)/include/freetype2 -I$(PORTLIBS)/include $(LIBPSL1GHT_INC)

# Source Files
SRCS		:= $(wildcard psl1ght/*.cpp)
OBJS		:= $(SRCS:.cpp=.cc.ppu.o)

C_SRCS		:= $(wildcard feat/*/*.c)
OBJS		+= $(C_SRCS:.c=.c.ppu.o)

# Define compilation options
DEFINES		:= -DPSL1GHT_SDK
CXXFLAGS	= -O2 -mregnames -Wall -mcpu=cell $(MACHDEP) $(INCLUDE) $(DEFINES)
CFLAGS		= $(CXXFLAGS)
LDFLAGS		= -s $(MACHDEP) $(LIBPATHS) $(LIBS)

# Make rules
.PHONY: all clean

all: $(TARGET)

clean: 
	rm -f $(TARGET) $(OBJS)

$(TARGET): $(OBJS)
	$(CXX) $^ $(LDFLAGS) -o $@
	$(SPRX) $@

%.cc.ppu.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.c.ppu.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@
