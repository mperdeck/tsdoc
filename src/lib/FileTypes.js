var FileInfo = (function () {
    /**
    @param relativeFilePath
    The path of the file relative to the root directory of the source files.
    So if the source files are located in c:\src, than the file path is relative to
    c:\src
    */
    function FileInfo(relativeFilePath, fileContent) {
        this.relativeFilePath = relativeFilePath;
        this.fileContent = fileContent;
    }
    return FileInfo;
})();
exports.FileInfo = FileInfo;

