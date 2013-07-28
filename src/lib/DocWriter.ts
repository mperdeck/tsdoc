import ParseTreeTypes = module("ParseTreeTypes");

export module DocWriter {

    /**
    Converts a parse tree to documentation files.

    @param showPrivates   If true, items that are marked private in the code will be included in the
                          documentation.
    */
    export function writeDocs(
        parseTree: ParseTreeTypes.ParseTree, templatesDir: string, docDir: string, showPrivates: boolean): void {

            
            console.log("writedocs");


    }
}
