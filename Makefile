SRC_DIR = src
BUILD_DIR = build
SRC = $(SRC_DIR)/p.js
UGLY = $(BUILD_DIR)/p.min.js
UGLIFYJS ?= uglifyjs
CLEAN += $(UGLY)


all: $(UGLY) report

# -*- minification -*- #
$(UGLY): $(SRC)
	$(UGLIFYJS) $(SRC) > $(UGLY)

$(PRETTY): $(SRC)
	$(UGLIFYJS) -b $(SRC) > $(UGLY)

# special builds
COMMONJS = $(BUILD_DIR)/p.commonjs.js
COMMONJS_POST = src/p.commonjs_post.js
CLEAN += $(COMMONJS)
$(COMMONJS): $(SRC) $(COMMONJS_POST)
	cat $(SRC) $(COMMONJS_POST) > $(COMMONJS)

AMD = $(BUILD_DIR)/p.amd.js
AMD_MIN = $(BUILD_DIR)/p.amd.min.js
CLEAN += $(AMD) $(AMD_MIN)
AMD_POST = src/p.amd_post.js
$(AMD): $(SRC) $(AMD_POST)
	cat $(SRC) $(AMD_POST) > $(AMD)

$(AMD_MIN): $(AMD)
	$(UGLIFYJS) $(AMD) > $(AMD_MIN)

.PHONY: commonjs
commonjs: $(COMMONJS)

.PHONY: amd
amd: $(AMD) $(AMD_MIN)

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
