/// <reference path="references/node.d.ts"/> 
import FileTypes = module("lib/FileTypes");
import ParseTreeTypes = module("lib/ParseTreeTypes");

// -------------------

var Parser = require('./lib/Parser').Parser;
var SourceReader = require('./lib/SourceReader').SourceReader;
var DocWriter = require('./lib/DocWriter').DocWriter;

var argv = require('optimist')
    .demand(['_'])
    .usage('Usage: $0 sourcedir')
    .default('d', '.\\tsdoc-out')
    .alias('d', 'destination')
    .string('d')
    .describe('d', 'Directory where documentation files will be placed')
    .default('t', '.\\tsdoc-templates')
    .alias('t', 'templates')
    .string('t')
    .describe('t', 'Directory where templates are stored')
    .boolean('r')
    .describe('r', 'Recurse into subdirectories when looking for source code files')
    .boolean('p')
    .describe('p', 'By default, symbols marked with the @private tag are not included in the output documentation. If this flag is provided, then they will be.')
    .alias('p', 'showprivates')
    .boolean('debug')
    .describe('debug', 'Writes debug information to standard output')
    .argv;

var sourceDir: string = argv._;
var recurse: boolean = argv.r;
var debug: boolean = argv.debug;

var docDir: string = argv.d;
var templatesDir: string = argv.t;
var showPrivates: boolean = argv.p;

// -------------------

if (debug) {
    console.log("-------- tsdoc parameters --------");
    console.log("sourcedir: " + sourceDir);
    console.log("recurse: " + recurse);
    console.log("debug: " + debug);
    console.log("destination: " + docDir);
    console.log("templates: " + templatesDir);
    console.log("showprivates: " + showPrivates);
}

// -------------------

var fileInfos: FileTypes.FileInfo[] = SourceReader.readSourceFiles(sourceDir, recurse);
var parseTree: ParseTreeTypes.ParseTree = Parser.parseSourceFiles(fileInfos, debugCallback);
DocWriter.writeDocs(parseTree, templatesDir, docDir, showPrivates);

// -------------------

function debugCallback(title: string, debugInfo: any): void {
    console.log(title);
    console.log(JSON.stringify(debugInfo, null, '..'));
}





