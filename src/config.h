/* whether to build support for Code 128 symbology */
//#define ENABLE_CODE128 1

/* whether to build support for Code 93 symbology */
#define ENABLE_CODE93 1

/* whether to build support for Code 39 symbology */
#define ENABLE_CODE39 1

/* whether to build support for Codabar symbology */
#define ENABLE_CODABAR 1

/* whether to build support for DataBar symbology */
#define ENABLE_DATABAR 1

/* whether to build support for EAN symbologies */
#define ENABLE_EAN 1

/* whether to build support for Interleaved 2 of 5 symbology */
#define ENABLE_I25 1

/* whether to build support for PDF417 symbology */
#define ENABLE_PDF417 1

/* whether to build support for QR Code */
#define ENABLE_QRCODE 1

//=============================================================================================//

/* Program major version (before the '.') as a number */
#define ZBAR_VERSION_MAJOR 0

/* Program minor version (after '.') as a number */
#define ZBAR_VERSION_MINOR 10

/* Name of package */
#define PACKAGE "zbar"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "spadix@users.sourceforge.net"

/* Define to the full name of this package. */
#define PACKAGE_NAME "zbar"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "zbar 0.10"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "zbar"

/* Define to the version of this package. */
#define PACKAGE_VERSION "0.10"

/* Version number of package */
#define VERSION "0.10"

//===============================================================================================//

/* Define to 1 if you have the ANSI C header files. */
//#define STDC_HEADERS 1

/* Define to 1 if the X Window System is missing or not being used. */
#define X_DISPLAY_MISSING 1

//===============================================================================================//

/* Define for Solaris 2.5.1 so the uint32_t typedef from <sys/synch.h>,
   <pthread.h>, or <semaphore.h> is not used. If the typedef were allowed, the
   #define below would cause a syntax error. */
#undef _UINT32_T

/* Define for Solaris 2.5.1 so the uint8_t typedef from <sys/synch.h>,
   <pthread.h>, or <semaphore.h> is not used. If the typedef were allowed, the
   #define below would cause a syntax error. */
#undef _UINT8_T

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the <jpeglib.h> header file. */
#define HAVE_JPEGLIB_H 1

/* Define to 1 if you have the `jpeg' library (-ljpeg). */
#define HAVE_LIBJPEG 1

/* Define to 1 if you have the `pthread' library (-lpthread). */
#undef HAVE_LIBPTHREAD

/* Define to 1 if you have the <poll.h> header file. */
#define HAVE_POLL_H 1

/* Define to 1 if you have the <pthread.h> header file. */
//#undef HAVE_PTHREAD_H
#define HAVE_PTHREAD_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the <sys/time.h> header file. */
#define HAVE_SYS_TIME_H 1

/* Define to 1 if you have the <errno.h> header file. */
#define HAVE_ERRNO_H 1
