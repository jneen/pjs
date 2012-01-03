exports.P = require('./src/p').P;
exports.version = JSON.parse(require('fs').readFileSync(__dirname + '/package.json')).version;
