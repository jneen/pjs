exports.Limbo = require('./src/limbo.js').Limbo;
exports.version = JSON.parse(require('fs').readFileSync(__dirname + '/package.json')).version;
