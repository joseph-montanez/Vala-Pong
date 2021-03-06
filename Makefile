OS = LINUX
PKGS = \
    --pkg gio-2.0 \
    --pkg gee-1.0 \
    --pkg gl \
    --pkg glu \
    --pkg gsl \
    --pkg sdl \
    --pkg sdl-image \
    --pkg sdl-mixer
LIBS = \
    -X -lSDL_image \
    -X -lSDL_mixer
FLAGS = -g --save-temps --vapidir=vapi
FILES = \
    src/ball.vala \
    src/darkcore/collision.vala \
    src/darkcore/engine.vala \
    src/darkcore/event.vala \
    src/darkcore/keystate.vala \
    src/darkcore/log.vala \
    src/darkcore/sprite/text.vala \
    src/darkcore/sprite.vala \
    src/darkcore/sound.vala \
    src/darkcore/texture.vala \
    src/darkcore.vala \
    src/darkcore/vector.vala \
    src/main.vala \
    src/paddle.vala

ifeq ($(OS),WIN32)
	LIBS = \
       -X -LC:\Windows\System32 \
       -X -LC:\vala-0.12.0\lib \
       -X "C:\Program Files\Microsoft SDKs\Windows\v7.0A\Lib\OpenGL32.lib" \
       -X -IC:\cygwin\usr\include\w32api \
       -X -IC:\vala-0.12.0\include\SDL \
       -X -lgsl \
       -X -lmingw32 \
       -X -lSDLmain \
       -X -lSDL_image \
       -X -lSDL_mixer \
       -X -lSDL
endif

all: $(FILES)
	valac $(FLAGS) $(PKGS) $(LIBS) -o main $(FILES)
	./main

clean:
	find . -type f -name "*.so" -exec rm -f {} \;
	find . -type f -name "*.a" -exec rm -f {} \;
	find . -type f -name "*.o" -exec rm -f {} \;
	find . -type f -name "*.h" -exec rm -f {} \;
	find . -type f -name "*.c" -exec rm -f {} \;
	rm main

