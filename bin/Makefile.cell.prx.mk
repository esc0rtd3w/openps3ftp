# OpenPS3FTP Makefile - CELL PRX edition

SCETOOL_FLAGS := -0 SELF
SCETOOL_FLAGS += -1 TRUE
SCETOOL_FLAGS += -s FALSE
SCETOOL_FLAGS += -2 04
SCETOOL_FLAGS += -3 1070000052000001
SCETOOL_FLAGS += -4 01000002
SCETOOL_FLAGS += -5 APP
SCETOOL_FLAGS += -A 0001000000000000
SCETOOL_FLAGS += -6 0003004000000000

CELL_SDK ?= /usr/local/cell
CELL_MK_DIR ?= $(CELL_SDK)/samples/mk
include $(CELL_MK_DIR)/sdk.makedef.mk

PPU_PRX_CCLD = $(PPU_PREFIX)gcc$(EXE_SUFFIX) -mprx-with-runtime
PPU_PRX_CXXLD = $(PPU_PREFIX)g++$(EXE_SUFFIX) -mprx-with-runtime

OBJS_DIR = objs/prx

PPU_SRCS = $(wildcard prx/*.c) $(wildcard prx/*.cpp) $(wildcard helper/*.cpp) $(wildcard feat/*/*.cpp) $(wildcard ../lib/*.cpp)
PPU_PRX_TARGET = openps3ftp.prx
PPU_CPPFLAGS += -DCELL_SDK -DPRX -fno-exceptions -fno-rtti -ffunction-sections -fdata-sections -fno-builtin-printf -nodefaultlibs -Wno-shadow -Wno-unused-parameter

PPU_PRX_LDFLAGS += -Wl,--strip-unused-data -fno-exceptions -fno-rtti -ffunction-sections -fdata-sections -fno-builtin-printf -nodefaultlibs -Wno-shadow -Wno-unused-parameter
PPU_PRX_LDLIBDIR += -L../lib -L./prx/lib

PPU_PRX_LDLIBS += -lnet_stub -lfs_stub -lsysmodule_stub -lc_stub -lstdc++_stub
PPU_PRX_LDLIBS += -lsys_net_export_stub -lallocator_export_stub -lstdc_export_stub -lsysPrxForUser_export_stub

PPU_OPTIMIZE_LV = -Os
PPU_INCDIRS += -I../include -I./helper -I./feat

all:
	$(MAKE) $(PPU_OBJS_DEPENDS)
	$(PPU_PRX_STRIP) --strip-debug --strip-section-header $(PPU_PRX_TARGET)
	scetool $(SCETOOL_FLAGS) -e $(PPU_PRX_TARGET) $(PPU_SPRX_TARGET)

include $(CELL_MK_DIR)/sdk.target.mk
