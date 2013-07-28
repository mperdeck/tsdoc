

(function (SourceReader) {
    /**
    Visits each source file.
    
    @param sourceDir Directory with source files
    @param recurse   If true, this method also reads source files in all sub directories
    @param callback  Function that will be called for every source file
    @returns         Array with the paths and contents of each file
    */
    function readSourceFiles(sourceDir, recurse) {
        console.log("readSourceFiles");

        return null;
    }
    SourceReader.readSourceFiles = readSourceFiles;
})(exports.SourceReader || (exports.SourceReader = {}));
var SourceReader = exports.SourceReader;

