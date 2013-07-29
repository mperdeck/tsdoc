/// <reference path="../../References/node.d.ts"/>
var fs = require('fs');
var FileTypes = require("./FileTypes");

/**
Visits each source file.

@param sourceDir Directory with source files
@param recurse   If true, this method also reads source files in all sub directories
@param callback  Function that will be called for every source file
@returns         Array with the paths and contents of each file
*/
function readSourceFiles(sourceDir, recurse) {
    // Remove any trailing \
    sourceDir = sourceDir.toString().replace(/\\$/, '');

    return readRelativeSourceFiles(sourceDir, '', recurse);
}
exports.readSourceFiles = readSourceFiles;

/**
Visits each source file.

@param sourceDir Base Directory with source files
@param relativeDir
The directory where this method should look for source file.
This is relative to sourceDir.
@param recurse   If true, this method also reads source files in all sub directories
@param callback  Function that will be called for every source file
@returns         Array with the paths and contents of each file
*/
function readRelativeSourceFiles(sourceDir, relativeDir, recurse) {
    var fileInfos = new Array();
    var fileNames;
    var absoluteDir = sourceDir + ((relativeDir == '') ? '' : ('\\' + relativeDir));

    fileNames = fs.readdirSync(absoluteDir);
    fileNames.forEach(function (fileName) {
        var filePath;
        var relativeFilePath;
        var fileStats;
        var fileContent;
        var subFileInfos = new Array();

        relativeFilePath = (relativeDir == '') ? fileName : (relativeDir + '\\' + fileName);
        filePath = sourceDir + '\\' + relativeFilePath;

        fileStats = fs.statSync(filePath);
        if (fileStats.isDirectory()) {
            if (recurse) {
                subFileInfos = readRelativeSourceFiles(sourceDir, relativeFilePath, true);

                // Add contents of subFileInfos to end of fileInfos
                fileInfos.push.apply(fileInfos, subFileInfos);
            }
        }

        if (fileStats.isFile() && /\.d\.ts$/.test(fileName)) {
            fileContent = fs.readFileSync(filePath).toString();
            fileInfos.push(new FileTypes.FileInfo(relativeFilePath, fileContent));
        }
    });

    return fileInfos;
}

