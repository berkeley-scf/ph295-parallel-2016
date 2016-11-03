all: parallel_slides.html

parallel_slides.html: parallel.Rmd
	./make_slides parallel

clean:
	rm -rf parallel*.html parallel.md
