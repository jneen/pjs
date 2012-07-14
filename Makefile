# -*- globals -*- #
SRC_DIR = src
BUILD_DIR = build
CLEAN += $(BUILD_DIR)/*
SRC = $(SRC_DIR)/p.js

.PHONY: all
all: minify commonjs amd report

# -*- minification -*- #
UGLIFYJS ?= uglifyjs
UGLIFY_OPTS += --lift-vars --unsafe
UGLY = $(BUILD_DIR)/p.min.js

$(UGLY): $(SRC)
	$(UGLIFYJS) $(UGLIFY_OPTS) $< > $@

%.min.js: %.js
	$(UGLIFYJS) $(UGLIFY_OPTS) $< > $@

minify: $(UGLY)

# special builds
COMMONJS = $(BUILD_DIR)/p.commonjs.js

$(BUILD_DIR)/p.%.js: $(SRC_DIR)/%/pre.js $(SRC) $(SRC_DIR)/%/post.js
	mkdir -p $(BUILD_DIR)
	cat $^ > $@

.PHONY: commonjs
commonjs: $(COMMONJS)

.PHONY: amd
amd: $(BUILD_DIR)/p.amd.js $(BUILD_DIR)/p.amd.min.js

.PHONY: report
report: $(UGLY)
	wc -c $(UGLY)

# -*- testing -*- #
MOCHA ?= mocha
JSHINT ?= jshint
TESTS = ./test/*.test.js
.PHONY: test
test: jshint $(COMMONJS)
	$(MOCHA) $(TESTS)

.PHONY: jshint
jshint:
	# $(JSHINT) $(SRC)

# -*- packaging -*- #

# XXX this is kind of awful, but hey, it keeps the version info in the right place.
VERSION = $(shell node -e 'console.log(JSON.parse(require("fs").readFileSync(__dirname + "/package.json")).version)')
PACKAGE = pjs-$(VERSION).tgz
CLEAN += pjs-*.tgz

$(PACKAGE): clean commonjs test
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
