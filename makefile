all: build run

build:
	zip -r game.love .

run:
	love game.love

clean:
	rm -f game.love
