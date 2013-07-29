/// <reference path="../../references/node.d.ts"/>
var TestsLib = require('./TestsLib');
var FileTypes = require("../../src/lib/FileTypes");
var SourceReader = require("../../src/lib/SourceReader");
var assert = require('assert');
var path = require('path');

function allTestsPassed() {
    return TestsLib.runTests("SourceReaderTests", testSourceReader, [
        new Srt("EmptyDir", false, []),
        new Srt("EmptyDir", true, []),
        new Srt("MixtureDTsNonDTsFilesNoSubdirs", false, [
            new FileTypes.FileInfo("empty.d.ts", ""),
            new FileTypes.FileInfo("file1.d.ts", "This is file1.d.ts\r\n\r\n\'quotes\' and \"double quotes\"\r\n\r\nlast line\r\n")
        ]),
        new Srt("MixtureDTsNonDTsFilesNoSubdirs", true, [
            new FileTypes.FileInfo("empty.d.ts", ""),
            new FileTypes.FileInfo("file1.d.ts", "This is file1.d.ts\r\n\r\n\'quotes\' and \"double quotes\"\r\n\r\nlast line\r\n")
        ]),
        new Srt("SubdirsSomeEmpty", false, [
            new FileTypes.FileInfo("file21.d.ts", "This is file21.d.ts")
        ]),
        new Srt("SubdirsSomeEmpty", true, [
            new FileTypes.FileInfo("file21.d.ts", "This is file21.d.ts"),
            new FileTypes.FileInfo("Sub1\\file211.d.ts", "This is file211.d.ts"),
            new FileTypes.FileInfo("Sub2\\file221.d.ts", "This is file221.d.ts"),
            new FileTypes.FileInfo("Sub2\\Sub1\\file2111.d.ts", "This is file2111.d.ts")
        ]),
        new Srt("SubdirsMainEmpty", false, []),
        new Srt("SubdirsMainEmpty", true, [
            new FileTypes.FileInfo("Sub1\\file111.d.ts", "This is file111.d.ts"),
            new FileTypes.FileInfo("Sub1\\file112.d.ts", "This is file112.d.ts")
        ])
    ]);
}
exports.allTestsPassed = allTestsPassed;

var Srt = (function () {
    function Srt(sourceDir, recurse, expected) {
        this.sourceDir = sourceDir;
        this.recurse = recurse;
        this.expected = expected;
    }
    return Srt;
})();

function testSourceReader(testData) {
    var absolutePath = path.resolve(__dirname, "..\\testfiles\\SourceReader\\" + testData.sourceDir);

    var fileInfos = SourceReader.readSourceFiles(absolutePath, testData.recurse);
    TestsLib.deepEqual(fileInfos, testData.expected);
}

