// Grammar of TypeScript declaration files
//
// Based on the TypeScript Language Specification, Version 0.8, October 2012
//
// Note that this is an extension of the ECMAScript grammer, provided in:
// http://www.ecma-international.org/ecma-262/5.1/

{
    function JsDocParamSection(parameter, description) {
        this.type = "JsDocParamSection";
        this.parameter = parameter;
        this.description = description;
    }

    function JsDocReturnSection(description) {
        this.type = "JsDocReturnSection";
        this.description = description;
    }

    function JsDocComment(initialComment, sections) {
        this.type = "JsDocComment";
        this.initialComment = initialComment;
        this.sections = sections;
    }

    function AmbientVariableDeclaration(accessType, varName, varType) {
        this.description = "";
        this.private = false;
        this.accessType = accessType;
        this.varName = varName;
        this.varType = varType;
        this.type = "AmbientVariableDeclaration";
    }

	function AmbientClassDeclaration(className, classHeritage, classBody) {
        this.description = "";
        this.private = false;
        this.className = className;
        this.classHeritage = classHeritage;
        this.classBody = classBody;
        this.type = "AmbientClassDeclaration";
    }
    function AmbientConstructorDeclaration(parameterList) {
        this.description = "";
        this.private = false;
        this.parameterList = parameterList;
        this.type = "AmbientConstructorDeclaration";
    }

	function ClassElementDeclaration(accessType, declaration) {
        this.accessType = accessType;
        this.declaration = declaration;
        this.type = "AmbientModuleDeclaration";
    }
	
	function AmbientModuleDeclaration(moduleIdentification, moduleBody) {
        this.description = "";
        this.private = false;
        this.moduleIdentification = moduleIdentification;
        this.moduleBody = moduleBody;
        this.type = "AmbientModuleDeclaration";
    }
	
	// Do not use extends as a parameter name, because PEG sees that as a reserved word
	function ClassHeritage(extending, implementing) {
        this.extending = extending;
        this.implementing = implementing;
        this.type = "ClassHeritage";
    }
	
	function FunctionSignature(accessType, functionName, optional, parameterList, returnType) {
        this.returnDescription = "";
        this.description = "";
        this.private = false;
        this.accessType = accessType;
        this.functionName = functionName;
        this.optional = optional;
        this.parameterList = parameterList;
        this.returnType = returnType;
        this.type = "FunctionSignature";
    }
	
	function InterfaceDeclaration(interfaceName, extending, body) {
        this.description = "";
        this.private = false;
        this.interfaceName = interfaceName;
        this.extending = extending;
        this.body = body;
        this.type = "InterfaceDeclaration";
    }
	
	function ParameterList(parameters, restParameter) {
        this.parameters = parameters;
        this.restParameter = restParameter;
        this.type = "ParameterList";
    }
	
	function FormalParameter(access, parameterName, optional, parameterType) {
        this.description = "";
        this.private = false;
        this.access = access;
        this.parameterName = parameterName;
        this.optional = optional;
        this.parameterType = parameterType;
        this.type = "FormalParameter";
    }

	function PredefinedType(givenType) {
        this.givenType = givenType;
        this.type = "PredefinedType";
    }
	
	function ModuleName(moduleName) {
        this.moduleName = moduleName;
        this.type = "ModuleName";
    }
	
	function TypeName(typeName) {
        this.url = ""; // url of the specific type within a module
        this.typeName = typeName; // array of identifiers (name within module/class within module ...)
        this.type = "TypeName";
    }

	function ObjectType(typeBody) {
        this.typeBody = typeBody;
        this.type = "ObjectType";
    }

	function CallSignature(parameters, returnType) {
        this.description = "";
        this.private = false;
        this.parameters = parameters;
        this.returnType = returnType;
        this.type = "CallSignature";
    }

	function ConstructSignature(parameters, constructType) {
        this.description = "";
        this.private = false;
        this.parameters = parameters;
        this.constructType = constructType;
        this.type = "ConstructSignature";
    }

	function IndexSignature(parameter, arrayType) {
        this.description = "";
        this.private = false;
        this.parameter = parameter;
        this.arrayType = arrayType;
        this.type = "IndexSignature";
    }

	function PropertySignature(propertyName, optional, propertyType) {
        this.description = "";
        this.private = false;
        this.propertyName = propertyName;
        this.optional = optional;
        this.propertyType = propertyType;
        this.type = "PropertySignature";
    }
	
	function FunctionType(parameterList, returnType) {
        this.parameterList = parameterList;
        this.returnType = returnType;
        this.type = "FunctionType";
    }

	function ConstructorType(parameterList, returnType) {
        this.parameterList = parameterList;
        this.returnType = returnType;
        this.type = "ConstructorType";
    }

	function ExternalModuleReference(path) {
        this.path = path;
        this.type = "ExternalModuleReference";
    }

	function ImportDeclaration(importedName, moduleReference) {
        this.importedName = importedName;
        this.moduleReference = moduleReference;
        this.type = "ImportDeclaration";
    }

	function JsDocPrivateSection() {
        this.type = "JsDocPrivateSection";
    }

	function WhiteSpace() {
        this.type = "WhiteSpace";
    }
}

// ------------------------------------------------
// 10.1	Ambient Declarations

start
 = AmbientDeclaration*

AmbientDeclaration =
   RequiredWhiteSpace
 / JsDocCommentBlock 
 / CommentBlock      
 / CommentLine    
 / "declare"? ws declaration:DeclareAmbientDeclaration { return declaration; }
 / declaration:InterfaceDeclaration { return declaration; }

DeclareAmbientDeclaration
 = AmbientVariableDeclaration
 / AmbientFunctionDeclaration
 / AmbientClassDeclaration
 / AmbientModuleDeclaration

// ------------------------------------------
// 10.1.1	Ambient Variable Declarations

AmbientVariableDeclaration 
 = "var" ws varName:Identifier varType:TypeAnnotation? ";" 
   { return new AmbientVariableDeclaration(null, varName, varType); }

// ------------------------------------------
// 10.1.2	Ambient Function Declarations

AmbientFunctionDeclaration
 = "function" ws functionSignature:FunctionSignature ";" { return functionSignature; }

// ------------------------------------------
// 10.1.3	Ambient Class Declarations

AmbientClassDeclaration = 
  "class" ws className:Identifier classHeritage:ClassHeritage "{" classBody:AmbientClassBody "}" 
  { return new AmbientClassDeclaration(className, classHeritage, classBody);  }
  
AmbientClassBody = 
AmbientClassBodyElement*

AmbientClassBodyElement = 
   RequiredWhiteSpace
 / Comment
 / AmbientConstructorDeclaration
 / AmbientMemberDeclaration
 / AmbientStaticDeclaration

AmbientConstructorDeclaration = 
   "constructor" ws LeftBracket parameterList:ParameterList? RightBracket ";" 
   { return new AmbientConstructorDeclaration(parameterList); }

AmbientMemberDeclaration = 
   access:PublicOrPrivate? varName:Identifier varType:TypeAnnotation? ";" 
      { return new AmbientVariableDeclaration(access, varName, varType); }
 / access:PublicOrPrivate? functionSignature:FunctionSignature ";"
      { functionSignature.accessType = access; return functionSignature; }

AmbientStaticDeclaration = 
   "static" ws   varName:Identifier varType:TypeAnnotation? ";"
      { return new AmbientVariableDeclaration("static", varName, varType); }
 / "static" ws   functionSignature:FunctionSignature ";"
      { functionSignature.accessType = access; return functionSignature; }

// -----------------------------------------------
// 10.1.4	Ambient Module Declarations

AmbientModuleDeclaration =
  "module" ws   moduleIdentification:AmbientModuleIdentification   "{" moduleBody:AmbientModuleBody   "}"
  { return new AmbientModuleDeclaration(moduleIdentification, moduleBody);  }

AmbientModuleIdentification =
   IdentifierPath
 / StringLiteral

AmbientModuleBody =
AmbientElement*

AmbientElement =
   RequiredWhiteSpace
 / Comment
 / ("export" ws)? ExportAmbientElement
 / ImportDeclaration

ExportAmbientElement =
   AmbientVariableDeclaration
 / AmbientFunctionDeclaration
 / AmbientClassDeclaration
 / InterfaceDeclaration
 / AmbientModuleDeclaration


// ------------------------------------------
// 8.1.1	Class Heritage Specification

ClassHeritage =
   extending:ClassExtendsClause?   implementing:ImplementsClause?
   { return new ClassHeritage(extending, implementing); }

ClassExtendsClause =
   "extends" ws className:ClassName
   { return className; }

ClassName =
   TypeName

ImplementsClause =
   "implements" ws interfaces:InterfaceNameList { return interfaces; }

// ---------------------------------------------------------------
// 7.1	Interface Declarations

InterfaceDeclaration =
   "interface" ws   interfaceName:Identifier   extending:InterfaceExtendsClause?   body:ObjectType
   { return new InterfaceDeclaration(interfaceName, extending, body); }
   
InterfaceExtendsClause =
"extends" ws interfaces:InterfaceNameList { return interfaces; }

InterfaceNameList =
   first:InterfaceName ws list:AdditionalInterfaceName* { list.unshift(first); return list; }

AdditionalInterfaceName =
   "," ws interfaceName:InterfaceName ws { return interfaceName; }
   
InterfaceName =
   TypeName

// ---------------------------------------------------------------
// 6.2	Function Signatures

// Both 6.2 and 3.5.3.5 define FunctionSignature. Using the more general 3.5.3.5 version (allows ? after function name)

// Simplified version of what's found in section 6.2, to make it work as a PEG grammar.

ParameterList =
   parameters:FormalParameterList restParameter:AdditionalRestParameter?
   { return new ParameterList(parameters, restParameter); }

AdditionalRestParameter =
   Comma restParameter:RestParameter { return restParameter; }

FormalParameterList =
   first:FormalParameter ws list:AdditionalFormalParameter* { list.unshift(first); return list; }
   
AdditionalFormalParameter =
   Comma parameter:FormalParameter ws { return parameter; }

FormalParameter =
   access:PublicOrPrivate? parameterName:Identifier questionMark:QuestionMark? parameterType:TypeAnnotation?
   { return new FormalParameter(access, parameterName, (questionMark == "?"), parameterType); }
   
PublicOrPrivate =
   "public"
 / "private"

// The language specification gives this alternative for an optional parameter, but only 
// for function implementations, while this grammar is only for declaration files.
//
// / PublicOrPrivate?   Identifier   TypeAnnotation?   Initialiser

RestParameter =
"..." ws parameter:FormalParameter ws { return parameter; }

ReturnTypeAnnotation =
   Colon returnType: ReturnType { return returnType; }

ReturnType =
   Type
 / "void"

// --------------------------------
// 3.5	Specifying Types

Type =
   arrayItemType: ArrayItemType { return arrayItemType; }

ArrayItemType =
   PredefinedType
 / TypeName
 / TypeLiteral

PredefinedType =
   type:("any" / "number" / "bool" / "string") ws 
   { return new PredefinedType(type); }

TypeName =
   typeName: ModuleOrTypeName
   { return new TypeName(typeName); }

ModuleOrTypeName =
   IdentifierPath 

ModuleName =
   moduleName: ModuleOrTypeName
   { return new ModuleName(moduleName); }

TypeLiteral =
   ObjectType
 / FunctionType
 / ConstructorType

// ----------------------------------------
// 3.5.3	Object Type Literals

ObjectType =
   "{" ws   typeBody:TypeBody   "}" ws
   { return new ObjectType(typeBody); }

TypeBody =
   TerminatedTypeMember*
   
TerminatedTypeMember =    
   typeMember:TypeMember ws SemiColon { return typeMember; }

TypeMember =
   CallSignature
 / ConstructSignature
 / IndexSignature
 / FunctionSignature
 / PropertySignature

// ----------------------------------------
// 3.5.3.1	Call Signatures

CallSignature =
   LeftBracket   parameters:ParameterList?   RightBracket   returnType:ReturnTypeAnnotation?
   { return new CallSignature(parameters, returnType); }

// ----------------------------------------
// 3.5.3.2	Construct Signatures

ConstructSignature =
   "new" ws   LeftBracket   parameters:ParameterList?   RightBracket   constructType:TypeAnnotation?
   { return new ConstructSignature(parameters, constructType); }

// ----------------------------------------
// 3.5.3.3	Index Signatures

IndexSignature =
   "[" ws parameter:FormalParameter   "]" ws arrayType:TypeAnnotation?
   { return new IndexSignature(parameter, arrayType); }

// ----------------------------------------
// 3.5.3.4	Property Signatures

PropertySignature =
   propertyName:Identifier questionMark:QuestionMark?   propertyType:TypeAnnotation?
   { return new PropertySignature(propertyName, questionMark == "?", propertyType); }

// ----------------------------------------
// 3.5.3.5	Function Signatures

FunctionSignature =
   functionName:Identifier   questionMark:QuestionMark?   LeftBracket   parameterList:ParameterList?   RightBracket   returnType:ReturnTypeAnnotation?
   { return new FunctionSignature(null, functionName, (questionMark == "?"), parameterList, returnType); }


// ----------------------------------------
// 3.5.4	Array Type Literals

// ArrayType is not used, because it leads to left recursion, which can't be done in PEG grammars.
// Instead, ArrayItemType (further above) was introduced.

// ArrayType =
// Type   "[" ws   "]" ws

// ----------------------------------------
// 3.5.5	Function Type Literals

FunctionType =
   LeftBracket   parameterList:ParameterList?   RightBracket   "=>" ws   returnType:ReturnType
   { return new FunctionType(parameterList, returnType); }

// ----------------------------------------
// to do
// 3.5.6	Constructor Type Literals

ConstructorType =
   "new"   LeftBracket   parameterList:ParameterList?   RightBracket   "=>" ws   returnType:Type
   { return new ConstructorType(parameterList, returnType); }

// 5.1	Variable Statements

TypeAnnotation =
   Colon type:Type { return type; }

// ----------------------------------------
// to do
// 9.2	Module Declarations

IdentifierPath =
   first:Identifier list:AdditionalIdentifier* { list.unshift(first); return list; }

AdditionalIdentifier =
   "." id:Identifier { return id; }

   
// ----------------------------------------
// to do
// 9.2.2	Import Declarations

ImportDeclaration =
   "import" ws   importedName:Identifier   "=" ws   moduleReference:ModuleReference   SemiColon
   { return new ImportDeclaration(importedName, moduleReference); }

ModuleReference =
   ExternalModuleReference
 / ModuleName

ExternalModuleReference =
   "module" ws   LeftBracket   path:StringLiteral   RightBracket
   { return new ExternalModuleReference(path); }

// ---------------------------------------------------------------
// Own definitions

StringLiteral "string literal" =
   "'" chars:[^']* "'" ws { return "'" + chars.join("") + "'"; }
 / '"' chars:[^"]* '"' ws { return '"' + chars.join("") + '"'; }

Identifier "identifier" =
   chars:[^ \t\r\n:?(){},.=\[\];]+ ws { return chars.join(""); }

Comma =
   "," ws

LeftBracket =
   "(" ws

RightBracket =
   ")" ws

SemiColon =
   ";" ws

Colon = 
   ":" ws

QuestionMark =
   char:"?" ws { return char; }


// ws can be matched without advancing the position.
// Do not use in a repetition (such as * or +) where the parser can keep looping
// matching only ws - it will hang.
ws =
   WhiteSpace Comment*

Comment =
   JsDocCommentBlock
 / CommentBlock
 / CommentLine

JsDocCommentBlock =
   "/**" jsDocComment: JsDocComment "*/" WhiteSpace    { return jsDocComment; }
 
CommentBlock =
   "/*" CommentChar* "*/" WhiteSpace     { return new WhiteSpace(); }
 
CommentLine =
   "//" [^\n]* "\n" WhiteSpace    { return new WhiteSpace(); }
 
CommentChar =
   !"*/" .   

// -----------------------------------------------------------
// JsDoc Comments 

JsDocComment =
   initialComment: JsDocCommentNonSection? sections: JsDocCommentSection*
   { return new JsDocComment(initialComment, sections); }

JsDocCommentNonSection =
   chars: JsDocCommentNonSectionChar* { return chars.join(""); }

JsDocCommentNonSectionChar =
   !("*/" / JsDocCommentSectionStart) char: . { return char; }

JsDocCommentSectionStart =
   "@param" / "@return" / "@private"

JsDocCommentSection =
   JsDocParamSection
 / JsDocReturnSection
 / JsDocPrivateSection

JsDocParamSection =
   "@param" WhiteSpaceChar+ JsDocType? parameter: JsDocIdentifier description: JsDocSectionBody? JsDocCommentNonSection?
   { return new JsDocParamSection(parameter, description); }

JsDocReturnSection =
   "@return" WhiteSpaceChar+ JsDocType? description: JsDocSectionBody? JsDocCommentNonSection?
   { return new JsDocReturnSection(description); }

JsDocPrivateSection =
   "@private" WhiteSpaceChar+
   { return new JsDocPrivateSection(); }

JsDocSectionBody =
   chars: JsDocSectionBodyChar* { return chars.join(""); }

JsDocSectionBodyChar =
   !("*/" / "@") char: . { return char; }

JsDocIdentifier =
   chars:JsDocIdentifierChar+ { return chars.join(""); }

JsDocIdentifierChar =
   !("*/" / "@" / "-" / WhiteSpaceChar) char: . { return char; }

JsDocType =
   "{" [^}]* "}" WhiteSpace

RequiredWhiteSpace =
   WhiteSpaceChar+ { return new WhiteSpace(); }

WhiteSpace =
   WhiteSpaceChar* { return new WhiteSpace(); }

WhiteSpaceChar =
   [ \t\r\n]










