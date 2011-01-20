JS=lib/qwerly.js

# find all test files (ones that end with the string _test)
TEST_COFFEE=`find test -name '*_test.coffee'`

all: $(JS)

clean:
	-rm -f $(JS)

test: $(JS)
	nodeunit --reporter minimal $(TEST_COFFEE)

%.js: %.coffee
	coffee -b -c $<

.PHONY: clean test
