PKGS = \
    --pkg gee-1.0 \
    --pkg gl \
    --pkg glu \
    --pkg gsl \
    --pkg glut \
    --pkg sdl \
    --pkg sdl-mixer \
    --pkg sdl-image \
    --pkg sdl-gfx 
LIBS = -X -lSDL_gfx -X -lSDL_image -X -lSDL_mixer
FLAGS = --vapidir=vapi
FLAGS = -g --save-temps --vapidir=vapi
FILES = \
    src/ball.vala \
    src/darkcore/collision.vala \
    src/darkcore/engine.vala \
    src/darkcore/event.vala \
    src/darkcore/keystate.vala \
    src/darkcore/sprite/text.vala \
    src/darkcore/sprite.vala \
    src/darkcore/texture.vala \
    src/darkcore.vala \
    src/darkcore/vector.vala \
    src/main.vala \
    src/paddle.vala

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

