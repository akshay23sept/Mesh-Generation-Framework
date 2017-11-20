// Copyright (C) 2016-2017
// This file is part of the Hierarchical Data Format query language (HDFql)
// For more information about HDFql, please visit the website http://www.hdfql.com

// $Rev: 135 $



#ifndef HDFQL_CPP_HEADER
	#define HDFQL_CPP_HEADER



/*! \mainpage HDFql C++ Documentation
 *
 *  Library of HDFql C++ functions to manage HDF files
 *
 *  \n
 *  \n
 *  \li \ref SectionGeneralConstants
 *  \n
 *  \n
 *  \li \ref SectionDatatypeConstants
 *  \n
 *  \n
 *  \li \ref SectionEndiannessConstants
 *  \n
 *  \n
 *  \li \ref SectionCharsetConstants
 *  \n
 *  \n
 *  \li \ref SectionExecute
 *  \n
 *  \n
 *  \li \ref SectionCursor
 *  \n
 *  \n
 *  \li \ref SectionVariable
 *  \n
 *  \n
 *  \li \ref SectionMiscellaneous
*/



//===========================================================
// INCLUDE FILES
//===========================================================
#include <string>
#include "HDFql.h"



//===========================================================
// DEFINITIONS
//===========================================================
#ifdef _WIN32
	#define HDFQL_CPP_EXPORT_SYMBOL __declspec(dllexport)
#else
	#define HDFQL_CPP_EXPORT_SYMBOL
#endif



//===========================================================
// NAMESPACE DECLARATION
//===========================================================
namespace HDFql
{



	//===========================================================
	// CLASSES DECLARATION
	//===========================================================
	class Cursor
	{

		public:
			HDFQL_CURSOR cursor;

			HDFQL_CPP_EXPORT_SYMBOL Cursor();

			HDFQL_CPP_EXPORT_SYMBOL ~Cursor();

	};



	/** @defgroup SectionGeneralConstants General Constants
	 *  List of general constants.
	 *  @{
	*/

	const char Version[] = HDFQL_VERSION;

	const int BufferSize = HDFQL_BUFFER_SIZE;

	const int Yes = HDFQL_YES;

	const int No = HDFQL_NO;

	const int Enabled = HDFQL_ENABLED;

	const int Disabled = HDFQL_DISABLED;

	const int Default = HDFQL_DEFAULT;

	const int Undefined = HDFQL_UNDEFINED;

	const int Global = HDFQL_GLOBAL;

	const int Local = HDFQL_LOCAL;

	const int Ascend = HDFQL_ASCEND;

	const int Descend = HDFQL_DESCEND;

	const int Reverse = HDFQL_REVERSE;

	const int Top = HDFQL_TOP;

	const int Bottom = HDFQL_BOTTOM;

	const int Tracked = HDFQL_TRACKED;

	const int Indexed = HDFQL_INDEXED;

	const int Dos = HDFQL_DOS;

	const int Unix = HDFQL_UNIX;

	const int Value = HDFQL_VALUE;

	const int Text = HDFQL_TEXT;

	const int Binary = HDFQL_BINARY;

	const int Memory = HDFQL_MEMORY;


	const int Directory = HDFQL_DIRECTORY;

	const int File = HDFQL_FILE;

	const int Group = HDFQL_GROUP;

	const int Dataset = HDFQL_DATASET;

	const int Attribute = HDFQL_ATTRIBUTE;

	const int SoftLink = HDFQL_SOFT_LINK;

	const int HardLink = HDFQL_HARD_LINK;

	const int ExternalLink = HDFQL_EXTERNAL_LINK;


	const int Contiguous = HDFQL_CONTIGUOUS;

	const int Compact = HDFQL_COMPACT;

	const int Chunked = HDFQL_CHUNKED;

	/** @} */



	/** @defgroup SectionDatatypeConstants Datatype Constants
	 *  List of datatype constants.
	 *  @{
	*/

	const int TinyInt = HDFQL_TINYINT;

	const int UnsignedTinyInt = HDFQL_UNSIGNED_TINYINT;

	const int SmallInt = HDFQL_SMALLINT;

	const int UnsignedSmallInt = HDFQL_UNSIGNED_SMALLINT;

	const int Int = HDFQL_INT;

	const int UnsignedInt = HDFQL_UNSIGNED_INT;

	const int BigInt = HDFQL_BIGINT;

	const int UnsignedBigInt = HDFQL_UNSIGNED_BIGINT;

	const int Float = HDFQL_FLOAT;

	const int Double = HDFQL_DOUBLE;

	const int Char = HDFQL_CHAR;

	const int VarTinyInt = HDFQL_VARTINYINT;

	const int UnsignedVarTinyInt = HDFQL_UNSIGNED_VARTINYINT;

	const int VarSmallInt = HDFQL_VARSMALLINT;

	const int UnsignedVarSmallInt = HDFQL_UNSIGNED_VARSMALLINT;

	const int VarInt = HDFQL_VARINT;

	const int UnsignedVarInt = HDFQL_UNSIGNED_VARINT;

	const int VarBigInt = HDFQL_VARBIGINT;

	const int UnsignedVarBigInt = HDFQL_UNSIGNED_VARBIGINT;

	const int VarFloat = HDFQL_VARFLOAT;

	const int VarDouble = HDFQL_VARDOUBLE;

	const int VarChar = HDFQL_VARCHAR;

	const int Opaque = HDFQL_OPAQUE;

	const int BitField = HDFQL_BITFIELD;

	const int Enumeration = HDFQL_ENUMERATION;

	const int Compound = HDFQL_COMPOUND;

	/** @} */



	/** @defgroup SectionEndiannessConstants Endianness Constants
	 *  List of endianness constants.
	 *  @{
	*/

	const int NativeEndian = HDFQL_NATIVE_ENDIAN;

	const int LittleEndian = HDFQL_LITTLE_ENDIAN;

	const int BigEndian = HDFQL_BIG_ENDIAN;

	/** @} */



	/** @defgroup SectionCharsetConstants Charset Constants
	 *  List of charset constants.
	 *  @{
	*/

	const int Ascii = HDFQL_ASCII;

	const int Utf8 = HDFQL_UTF8;

	/** @} */



	/** @defgroup SectionStatusConstants Status Constants
	 *  List of status constants.
	 *  @{
	*/

	const int Success = HDFQL_SUCCESS;

	const int ErrorParse = HDFQL_ERROR_PARSE;

	const int ErrorNotFound = HDFQL_ERROR_NOT_FOUND;

	const int ErrorNoAccess = HDFQL_ERROR_NO_ACCESS;

	const int ErrorAlreadyExists = HDFQL_ERROR_ALREADY_EXISTS;

	const int ErrorEmpty = HDFQL_ERROR_EMPTY;

	const int ErrorFull = HDFQL_ERROR_FULL;

	const int ErrorBeforeFirst = HDFQL_ERROR_BEFORE_FIRST;

	const int ErrorAfterLast = HDFQL_ERROR_AFTER_LAST;

	const int ErrorNoAddress = HDFQL_ERROR_NO_ADDRESS;

	const int ErrorNotRegistered = HDFQL_ERROR_NOT_REGISTERED;

	const int ErrorOutsideLimit = HDFQL_ERROR_OUTSIDE_LIMIT;

	const int ErrorUnknown = HDFQL_ERROR_UNKNOWN;

	/** @} */



	/** @defgroup SectionExecute Execute Functions
	 *  List of execute functions.
	 *  @{
	*/

	HDFQL_CPP_EXPORT_SYMBOL int execute(const char *script);

	HDFQL_CPP_EXPORT_SYMBOL int execute(const std::string script);

	HDFQL_CPP_EXPORT_SYMBOL int executeGetStatus(void);

	/** @} */



	/** @defgroup SectionError Error Functions
	 *  List of error functions.
	 *  @{
	*/

	HDFQL_CPP_EXPORT_SYMBOL int errorGetLine(void);

	HDFQL_CPP_EXPORT_SYMBOL int errorGetPosition(void);

	HDFQL_CPP_EXPORT_SYMBOL char *errorGetMessage(void);

	/** @} */



	/** @defgroup SectionCursor Cursor Functions
	 *  List of cursor functions.
	 *  @{
	*/

	HDFQL_CPP_EXPORT_SYMBOL int cursorInitialize(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorUse(Cursor *cursor);

	HDFQL_CPP_EXPORT_SYMBOL int cursorUseDefault(void);

	HDFQL_CPP_EXPORT_SYMBOL int cursorClear(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorClone(Cursor *cursorClone);

	HDFQL_CPP_EXPORT_SYMBOL int cursorClone(Cursor *cursorOriginal, Cursor *cursorClone);

	HDFQL_CPP_EXPORT_SYMBOL int cursorGetDatatype(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorGetCount(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorGetCount(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorGetPosition(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorGetPosition(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorFirst(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorFirst(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorLast(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorLast(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorNext(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorNext(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorPrevious(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorPrevious(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int cursorAbsolute(int position);

	HDFQL_CPP_EXPORT_SYMBOL int cursorAbsolute(Cursor *cursor, int position);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorAbsolute(int position);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorAbsolute(Cursor *cursor, int position);

	HDFQL_CPP_EXPORT_SYMBOL int cursorRelative(int position);

	HDFQL_CPP_EXPORT_SYMBOL int cursorRelative(Cursor *cursor, int position);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorRelative(int position);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorRelative(Cursor *cursor, int position);

	HDFQL_CPP_EXPORT_SYMBOL int cursorGetSize(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int subcursorGetSize(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL void *cursorGet(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL void *subcursorGet(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL char *cursorGetTinyInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL char *subcursorGetTinyInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned char *cursorGetUnsignedTinyInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned char *subcursorGetUnsignedTinyInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL short *cursorGetSmallInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL short *subcursorGetSmallInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned short *cursorGetUnsignedSmallInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned short *subcursorGetUnsignedSmallInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int *cursorGetInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL int *subcursorGetInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned int *cursorGetUnsignedInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned int *subcursorGetUnsignedInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL long long *cursorGetBigInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL long long *subcursorGetBigInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned long long *cursorGetUnsignedBigInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL unsigned long long *subcursorGetUnsignedBigInt(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL float *cursorGetFloat(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL float *subcursorGetFloat(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL double *cursorGetDouble(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL double *subcursorGetDouble(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL char *cursorGetChar(Cursor *cursor = NULL);

	HDFQL_CPP_EXPORT_SYMBOL char *subcursorGetChar(Cursor *cursor = NULL);

	/** @} */



	/** @defgroup SectionVariable Variable Functions
	 *  List of variable functions.
	 *  @{
	*/

	HDFQL_CPP_EXPORT_SYMBOL int variableRegister(const void *variable);

	HDFQL_CPP_EXPORT_SYMBOL int variableUnregister(const void *variable);

	HDFQL_CPP_EXPORT_SYMBOL int variableGetNumber(const void *variable);

	HDFQL_CPP_EXPORT_SYMBOL int variableGetDatatype(const void *variable);

	HDFQL_CPP_EXPORT_SYMBOL int variableGetCount(const void *variable);

	HDFQL_CPP_EXPORT_SYMBOL int variableGetSize(const void *variable);

	HDFQL_CPP_EXPORT_SYMBOL int variableGetDimensionCount(const void *variable);

	HDFQL_CPP_EXPORT_SYMBOL int variableGetDimension(const void *variable, int index);

	HDFQL_CPP_EXPORT_SYMBOL int variableGetElementCount(const void *variable, int index);

	/** @} */



	/** @defgroup SectionMiscellaneous Miscellaneous Functions
	 *  List of miscellaneous functions.
	 *  @{
	*/

	HDFQL_CPP_EXPORT_SYMBOL char *getCanonicalPath(const char *objectName);

	HDFQL_CPP_EXPORT_SYMBOL char *getCanonicalPath(const std::string script);

	/** @} */

};



/** @} */



#endif	// HDFQL_CPP_HEADER

