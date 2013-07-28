


(function (Parser) {
    /**
    Parses all source files, converting them to a complete parse tree.
    
    @param fileInfos Array with the names and contents of all source files
    @param debugCallback   If not null, called each time interesting internal state has been generated.
    Allows the caller to somehow output this state for debug purposes.
    This callback gets a title describing the debug info, and the debug info itself.
    @returns         Parse tree representing all the sources.
    */
    function parseSourceFiles(fileInfos, debugCallback) {
        console.log("parseSourceFiles");

        return null;
    }
    Parser.parseSourceFiles = parseSourceFiles;
})(exports.Parser || (exports.Parser = {}));
var Parser = exports.Parser;

