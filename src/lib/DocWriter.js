

(function (DocWriter) {
    /**
    Converts a parse tree to documentation files.
    
    @param showPrivates   If true, items that are marked private in the code will be included in the
    documentation.
    */
    function writeDocs(parseTree, templatesDir, docDir, showPrivates) {
        console.log("writedocs");
    }
    DocWriter.writeDocs = writeDocs;
})(exports.DocWriter || (exports.DocWriter = {}));
var DocWriter = exports.DocWriter;

