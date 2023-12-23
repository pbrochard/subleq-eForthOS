all: eforth-embed

eforth-dec.c: ../eforth.dec
	sed 's/$$/,/' ../eforth.dec > eforth-dec.c

eforth-embed: eforth-dec.c eforth-embed.c
	gcc -o eforth-embed eforth-embed.c

test: eforth-embed
	echo "words bye" | ./eforth-embed

clean:
	rm -f eforth-embed eforth-dec.c
