/// <reference path="../references/node.d.ts"/>
var SourceReaderTests = require("./lib/SourceReaderTests");

var allTestsPassed = SourceReaderTests.allTestsPassed();

return allTestsPassed ? 0 : 1;

