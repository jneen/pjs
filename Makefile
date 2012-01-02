SRC = src/limbo.js
UGLY = build/limbo.min.js
UGLIFYJS ?= uglifyjs

all: $(UGLY) report

$(UGLY): $(SRC)
	$(UGLIFYJS) $(SRC) > $(UGLY)

$(PRETTY): $(SRC)
	$(UGLIFYJS) -b $(SRC) > $(UGLY)

.PHONY: report
report: $(UGLY)
	wc -c $(UGLY)

.PHONY: clean
clean:
	rm -f build/*
