SRC = src/p.js
UGLY = build/p.min.js
UGLIFYJS ?= uglifyjs
CLEAN += $(UGLY)


all: $(UGLY) report

# -*- minification -*- #
$(UGLY): $(SRC)
	$(UGLIFYJS) $(SRC) > $(UGLY)

$(PRETTY): $(SRC)
	$(UGLIFYJS) -b $(SRC) > $(UGLY)

.PHONY: report
report: $(UGLY)
	wc -c $(UGLY)

# -*- testing -*- #
MOCHA ?= mocha
TESTS = ./test/*.test.js
.PHONY: test
test: $(UGLY)
	$(MOCHA) $(TESTS)

# -*- packaging -*- #

# XXX this is kind of awful, but hey, it keeps the version info in the right place.
VERSION = $(shell node -e 'console.log(JSON.parse(require("fs").readFileSync(__dirname + "/package.json")).version)')
PACKAGE = pjs-$(VERSION).tgz
CLEAN += $(PACKAGE)

$(PACKAGE): test
	npm pack .

.PHONY: package
package: $(PACKAGE)

.PHONY: publish
publish: $(PACKAGE)
	npm publish $(PACKAGE)

# -*- cleanup -*- #
.PHONY: clean
clean:
	rm -f $(CLEAN)
