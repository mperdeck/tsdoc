/// <reference path="../references/node.d.ts"/> 
import SourceReaderTests = module("./lib/SourceReaderTests");

var allTestsPassed: boolean =
    SourceReaderTests.allTestsPassed();

return allTestsPassed ? 0 : 1;
