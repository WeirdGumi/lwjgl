TARGET = liblwjgl.so
JAR_TARGET = lwjgl-platform-natives-linux.jar

CC = cc
STRIP = strip
JAR = jar

CFLAGS = -fPIC -std=c99 -O2 \
	-Iinclude -I/usr/include \
	-I$(JAVA_HOME)/include \
	-I$(JAVA_HOME)/include/linux \

LDFLAGS = -shared -lm -lpthread \
	-L$(JAVA_HOME)/lib -ljawt

SRCS = $(wildcard src/*.c)
OBJS = $(SRCS:.c=.o)

all: $(JAR_TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^
	$(STRIP) $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

$(JAR_TARGET): $(TARGET)
	$(JAR) -cf $@ $(TARGET)
