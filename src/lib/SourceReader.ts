import FileTypes = module("FileTypes");

export module SourceReader {

    /**
    Visits each source file.

    @param sourceDir Directory with source files
    @param recurse   If true, this method also reads source files in all sub directories
    @param callback  Function that will be called for every source file
    @returns         Array with the paths and contents of each file
    */
    export function readSourceFiles(
        sourceDir: string, recurse: boolean): FileTypes.FileInfo[] {
            
            console.log("readSourceFiles");


            return null;
    } 
}
