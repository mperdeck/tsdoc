export class FileInfo {
    /**
    @param relativeFilePath
        The path of the file relative to the root directory of the source files.
        So if the source files are located in c:\src, than the file path is relative to
        c:\src             
    */
    constructor(public relativeFilePath: string, public fileContent: string) {
    }
}
