GUIDES = $(notdir $(wildcard guide/*.pdc))
HTML_GUIDES = $(addprefix public/,$(GUIDES:.pdc=.html))
PANDOC_DEFAULT_OPTIONS = \
		--to html5 \
		-c css/screen.css \
		-B template/header.html \
		-A template/footer.html \
		-H template/meta.html
PANDOC_GUIDE_OPTIONS = \
		-B template/navigation.html \
		--toc

html: $(HTML_GUIDES)

public/index.html : guide/index.pdc
	pandoc \
		$(PANDOC_DEFAULT_OPTIONS) \
		$< \
		-o $@

public/%.html : guide/%.pdc
	pandoc \
		$(PANDOC_DEFAULT_OPTIONS) \
		$(PANDOC_GUIDE_OPTIONS) \
		$< \
		-o $@

deploy: html
	rsync \
		--recursive \
		--progress \
		--stats \
		--verbose \
		--exclude ".*" \
		public/ \
		debug1:/var/www/nodeguide.com

clean:
	rm -vf public/*.html
