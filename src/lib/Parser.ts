import ParseTreeTypes = module("ParseTreeTypes");
import FileTypes = module("FileTypes");

export module Parser {

    /**
    Parses all source files, converting them to a complete parse tree.

    @param fileInfos Array with the names and contents of all source files
    @param debugCallback   If not null, called each time interesting internal state has been generated.
                           Allows the caller to somehow output this state for debug purposes.
                           This callback gets a title describing the debug info, and the debug info itself.
    @returns         Parse tree representing all the sources.
    */
    export function parseSourceFiles(
        fileInfos: FileTypes.FileInfo[], debugCallback: (title: string, debugInfo: any) => void ): ParseTreeTypes.ParseTree {
            
            console.log("parseSourceFiles");


            return null;
    }
}
