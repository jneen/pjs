exports.P = require('./src/p.js').P;
exports.version = JSON.parse(require('fs').readFileSync(__dirname + '/package.json')).version;
