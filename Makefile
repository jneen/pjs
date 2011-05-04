all:
	[ -d "build" ] || mkdir "build"
	uglifyjs src/limbo.js > build/limbo.min.js
	wc -c build/limbo.min.js
