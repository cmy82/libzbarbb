
#Defines
ZBAR_VERSION_D:=-DZBAR_VERSION=\"0.10\"
ZBAR_VERSION = 0.10

#Includes
ILIBS = -ljpeg #-lpthread
IDIR_LIST = . ./src ./src/decoder ./src/processor ./src/qrcode ./src/video ./src/window ./include ./include/zbar
IDIRS     = $(foreach d, $(IDIR_LIST), -I$d)
 
#Programs
AR = ntoarmv7-ar

#Directories
SRC_DIR = src
OBJ_DIR = objs
LIB_DIR = lib

#Flags
CCFLAGS+= -Wall -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIC
LDFLAGS+= -Wl,-z,relro -Wl,-z,now #-pie

ENABLED_BARCODES = 

SCANNER_SRCS = scanner.c svg.c
SCANNER_OBJS = $(SCANNER_SRCS:.c=.o)

scanner: $(foreach d, $(SCANNER_SRCS), $(SRC_DIR)/$d) 
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) -DDEBUG_SVG $(IDIRS) -c \
	$(foreach d, $(SCANNER_SRCS), $(SRC_DIR)/$d)

DECODER_SRCDIR = src/decoder
DECODER_SRCS = codabar.c code128.c code39.c code93.c databar.c ean.c i25.c pdf417.c qr_finder.c
DECODER_OBJS = $(DECODER_SRCS:.c=.o) decoder.o

decoder: $(foreach d, $(DECODER_SRCS), $(DECODER_SRCDIR)/$d) $(SRC_DIR)/decoder.h
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) $(IDIRS) -c \
	$(foreach d, $(DECODER_SRCS), $(DECODER_SRCDIR)/$d) $(SRC_DIR)/decoder.c

QR_SRCDIR = src/qrcode
QR_SRCS = bch15_5.c binarize.c isaac.c qrdec.c qrdectxt.c rs.c util.c
QR_OBJS = $(QR_SRCS:.c=.o)

qr: $(foreach d, $(QR_SRCS), $(QR_SRCDIR)/$d) $(SRC_DIR)/qrcode.h
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) $(IDIRS) -c \
	$(foreach d, $(QR_SRCS), $(QR_SRCDIR)/$d)

IMGSCANNER_SRCS = img_scanner.c image.c error.c symbol.c refcnt.c
IMGSCANNER_OBJS = $(IMGSCANNER_SRCS:.c=.o)

image_scanner: qr scanner decoder $(foreach d, $(IMGSCANNER_SRCS), $(SRC_DIR)/$d) 
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) $(IDIRS) -c \
	$(foreach d, $(IMGSCANNER_SRCS), $(SRC_DIR)/$d)

PROCESSOR_SRCDIR = src/processor
PROCESSOR_SRCS = posix.c lock.c null.c
PROCESSOR_OBJS = $(PROCESSOR_SRCS:.c=.o) processor.o

processor: $(foreach d, $(PROCESSOR_SRCS), $(PROCESSOR_SRCDIR)/$d) $(SRC_DIR)/processor.c
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) $(IDIRS) -c \
	$(foreach d, $(PROCESSOR_SRCS), $(PROCESSOR_SRCDIR)/$d) $(SRC_DIR)/processor.c

EXTRA_SRCS = config.c convert.c jpeg.c video.c window.c
EXTRA_OBJS = $(EXTRA_SRCS:.c=.o)

extra: $(foreach d, $(EXTRA_SRCS), $(SRC_DIR)/$d)
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) $(IDIRS) -c \
	$(foreach d, $(EXTRA_SRCS), $(SRC_DIR)/$d)

SPECIAL_SRCS = src/window/null.c src/video/null.c
SPECIAL_OBJS = video_null.o window_null.o

special: src/window/null.c src/video/null.c
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) $(IDIRS) -c \
	$(SRC_DIR)/video/null.c -o video_null.o
	$(CXX) $(CCFLAGS) $(ZBAR_VERSION_D) $(foreach d, $(ENABLED_BARCODES), -D$d) $(IDIRS) -c \
	$(SRC_DIR)/window/null.c -o window_null.o

libzbarbb: clean image_scanner processor extra special
	mkdir -p $(LIB_DIR) $(OBJ_DIR)
	$(CC) -shared -Wl,-soname,libzbarbb.so $(LDFLAGS) \
         -o libzbarbb.so.$(ZBAR_VERSION) $(IMGSCANNER_OBJS) $(EXTRA_OBJS) $(PROCESSOR_OBJS) $(QR_OBJS) \
         $(SCANNER_OBJS) $(DECODER_OBJS) $(SPECIAL_OBJS) $(ILIBS)
	mv -v *.o $(OBJ_DIR)
	mv -v libzbarbb.so.$(ZBAR_VERSION) $(LIB_DIR)
	cp $(LIB_DIR)/libzbarbb.so.$(ZBAR_VERSION) $(LIB_DIR)/libzbarbb.so
	
clean:
	rm -fv $(LIB_DIR)/*	
	rm -fv $(OBJ_DIR)/*
	rm -fv *.o

all: libzbarbb
	@:

