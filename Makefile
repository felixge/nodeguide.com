GUIDES = $(notdir $(wildcard guides/*.md))
HTML_GUIDES = $(addprefix build/html/,$(GUIDES:.md=.html))

html: $(HTML_GUIDES)

build/html/%.html : guides/%.md
	@mkdir -p build/html
	pandoc -s --toc $< -o $@

clean:
	rm -rf build

