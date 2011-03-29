GUIDES = $(notdir $(wildcard guide/*.md))
HTML_GUIDES = $(addprefix public/,$(GUIDES:.md=.html))

html: $(HTML_GUIDES)

public/%.html : guide/%.md
	pandoc \
		-5 \
		-c css/screen.css \
		-B template/header.html \
		-A template/footer.html \
		--toc \
		$< \
		-o $@

clean:
	rm -vf public/*.html
