exports.P = require('./build/p.commonjs').P;
exports.version = JSON.parse(require('fs').readFileSync(__dirname + '/package.json')).version;
