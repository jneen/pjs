SRC_DIR = src
BUILD_DIR = build
CLEAN += $(BUILD_DIR)/*
SRC = $(SRC_DIR)/p.js
UGLIFYJS ?= uglifyjs
UGLY = $(BUILD_DIR)/p.min.js


all: $(BUILD_DIR)/p.min.js report

# -*- minification -*- #
$(UGLY): $(SRC)
	$(UGLIFYJS) $< > $@

$(BUILD_DIR)/%.min.js: $(BUILD_DIR)/%.js
	$(UGLIFYJS) $< > $@

# special builds
COMMONJS = $(BUILD_DIR)/p.commonjs.js

$(BUILD_DIR)/p.%.js: $(SRC) $(SRC_DIR)/p.%.post.js
	cat $^ > $@

.PHONY: commonjs
commonjs: $(BUILD_DIR)/p.commonjs.js $(BUILD_DIR)/p.commonjs.min.js

.PHONY: amd
amd: $(BUILD_DIR)/p.amd.js $(BUILD_DIR)/p.amd.min.js

.PHONY: report
report: $(UGLY)
	wc -c $(UGLY)

# -*- testing -*- #
MOCHA ?= mocha
TESTS = ./test/*.test.js
.PHONY: test
test: $(COMMONJS)
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
