all:
	[ -d "build" ] || mkdir "build"
	uglifyjs src/limbo.js > build/limbo.min.js
	uglifyjs -b build/limbo.min.js > build/limbo.min.pretty.js
	wc -c build/limbo.min.js
