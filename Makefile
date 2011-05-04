all:
	[ -d "build" ] || mkdir "build"
	uglifyjs src/limbo.js > build/limbo.min.js
