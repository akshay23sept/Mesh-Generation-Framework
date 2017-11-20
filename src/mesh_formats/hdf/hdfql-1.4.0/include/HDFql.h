// Copyright (C) 2016-2017
// This file is part of the Hierarchical Data Format query language (HDFql)
// For more information about HDFql, please visit the website http://www.hdfql.com

// $Rev: 138 $



#ifndef HDFQL_HEADER
	#define HDFQL_HEADER



/*! \mainpage HDFql C Documentation
 *
 *  Library of HDFql C functions to manage HDF files
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
 *  \li \ref SectionCreate
 *  \n
 *  \n
 *  \li \ref SectionRename
 *  \n
 *  \n
 *  \li \ref SectionCopy
 *  \n
 *  \n
 *  \li \ref SectionDrop
 *  \n
 *  \n
 *  \li \ref SectionInsert
 *  \n
 *  \n
 *  \li \ref SectionSelect
 *  \n
 *  \n
 *  \li \ref SectionShow
 *  \n
 *  \n
 *  \li \ref SectionUse
 *  \n
 *  \n
 *  \li \ref SectionFlush
 *  \n
 *  \n
 *  \li \ref SectionClose
 *  \n
 *  \n
 *  \li \ref SectionEnable
 *  \n
 *  \n
 *  \li \ref SectionDisable
 *  \n
 *  \n
 *  \li \ref SectionRun
 *  \n
 *  \n
 *  \li \ref SectionCursor
 *  \n
 *  \n
 *  \li \ref SectionVariable
 *  \n
 *  \n
 *  \li \ref SectionTimer
*/



//===========================================================
// INCLUDE FILES
//===========================================================
#ifdef _WIN32
	#include <windows.h>
#endif
#include "hdf5.h"
#include "antlr3.h"



//===========================================================
// ENABLE USAGE FROM C++
//===========================================================
#ifdef __cplusplus
	extern "C"
	{
#endif



//===========================================================
// DEFINITIONS
//===========================================================
#ifdef _WIN32
	#define HDFQL_EXPORT_SYMBOL __declspec(dllexport)
#else
	#define HDFQL_EXPORT_SYMBOL
#endif

#define PCRE_STATIC



/** @defgroup SectionGeneralConstants General Constants
 *  List of general constants.
 *  @{
*/

#define HDFQL_VERSION                  "1.4.0"

#define HDFQL_BUFFER_SIZE              1024

#define HDFQL_YES                      0

#define HDFQL_NO                       -1

#define HDFQL_ENABLED                  0

#define HDFQL_DISABLED                 -1

#define HDFQL_DEFAULT                  -1

#define HDFQL_UNDEFINED                -1

#define HDFQL_GLOBAL                   1

#define HDFQL_LOCAL                    2

#define HDFQL_ASCEND                   1

#define HDFQL_DESCEND                  2

#define HDFQL_REVERSE                  4

#define HDFQL_TOP                      1

#define HDFQL_BOTTOM                   2

#define HDFQL_TRACKED                  1

#define HDFQL_INDEXED                  2

#define HDFQL_DOS                      1

#define HDFQL_UNIX                     2

#define HDFQL_VALUE                    1

#define HDFQL_TEXT                     2

#define HDFQL_BINARY                   4

#define HDFQL_MEMORY                   8


#define HDFQL_DIRECTORY                1

#define HDFQL_FILE                     2

#define HDFQL_GROUP                    4

#define HDFQL_DATASET                  8

#define HDFQL_ATTRIBUTE                16

#define HDFQL_SOFT_LINK                32

#define HDFQL_HARD_LINK                64

#define HDFQL_EXTERNAL_LINK            128


#define HDFQL_CONTIGUOUS               1

#define HDFQL_COMPACT                  2

#define HDFQL_CHUNKED                  4

/** @} */



/** @defgroup SectionDatatypeConstants Datatype Constants
 *  List of datatype constants.
 *  @{
*/

#define HDFQL_TINYINT                  1

#define HDFQL_UNSIGNED_TINYINT         2

#define HDFQL_SMALLINT                 4

#define HDFQL_UNSIGNED_SMALLINT        8

#define HDFQL_INT                      16

#define HDFQL_UNSIGNED_INT             32

#define HDFQL_BIGINT                   64

#define HDFQL_UNSIGNED_BIGINT          128

#define HDFQL_FLOAT                    256

#define HDFQL_DOUBLE                   512

#define HDFQL_CHAR                     1024

#define HDFQL_VARTINYINT               2048

#define HDFQL_UNSIGNED_VARTINYINT      4096

#define HDFQL_VARSMALLINT              8192

#define HDFQL_UNSIGNED_VARSMALLINT     16384

#define HDFQL_VARINT                   32768

#define HDFQL_UNSIGNED_VARINT          65536

#define HDFQL_VARBIGINT                131072

#define HDFQL_UNSIGNED_VARBIGINT       262144

#define HDFQL_VARFLOAT                 524288

#define HDFQL_VARDOUBLE                1048576

#define HDFQL_VARCHAR                  2097152

#define HDFQL_OPAQUE                   4194304

#define HDFQL_BITFIELD                 8388608

#define HDFQL_ENUMERATION              16777216

#define HDFQL_COMPOUND                 33554432

/** @} */



/** @defgroup SectionEndiannessConstants Endianness Constants
 *  List of endianness constants.
 *  @{
*/

#define HDFQL_NATIVE_ENDIAN            1

#define HDFQL_LITTLE_ENDIAN            2

#define HDFQL_BIG_ENDIAN               4

/** @} */



/** @defgroup SectionCharsetConstants Charset Constants
 *  List of charset constants.
 *  @{
*/

#define HDFQL_ASCII                    1

#define HDFQL_UTF8                     2

/** @} */



/** @defgroup SectionStatusConstants Status Constants
 *  List of status constants.
 *  @{
*/

#define HDFQL_SUCCESS                  0

#define HDFQL_ERROR_PARSE              -1

#define HDFQL_ERROR_NOT_FOUND          -2

#define HDFQL_ERROR_NO_ACCESS          -3

#define HDFQL_ERROR_ALREADY_EXISTS     -4

#define HDFQL_ERROR_EMPTY              -5

#define HDFQL_ERROR_FULL               -6

#define HDFQL_ERROR_BEFORE_FIRST       -7

#define HDFQL_ERROR_AFTER_LAST         -8

#define HDFQL_ERROR_NO_ADDRESS         -9

#define HDFQL_ERROR_NOT_REGISTERED     -10

#define HDFQL_ERROR_OUTSIDE_LIMIT      -11

#define HDFQL_ERROR_UNKNOWN            -99

/** @} */



//===========================================================
// STRUCTURES
//===========================================================
typedef struct hdfql_cursor
{
	int                      datatype;
	int                      count;
	int                      position;
	struct hdfql_cursor_data *head;
	struct hdfql_cursor_data *tail;
	struct hdfql_cursor_data *current;
}HDFQL_CURSOR;

struct hdfql_cursor_data
{
	void                     *data;
	char                     metadata;
	int                      size;
	struct hdfql_cursor_data *next;
	struct hdfql_cursor_data *previous;
	struct hdfql_cursor      *subcursor;
};

struct hdfql_variable
{
	uintptr_t address;
	int       datatype;
	int       count;
	int       size;
	int       dimension_count;
	int       dimension_list[H5S_MAX_RANK];
	int       element_count;
	int       *element_list;
};

struct hdfql_file
{
	char              file_name[HDFQL_BUFFER_SIZE];
	char              group_name[HDFQL_BUFFER_SIZE];
	char              group_name_list[32][HDFQL_BUFFER_SIZE];
	int               group_name_list_count;
	hid_t             file_id;
	hid_t             group_id;
	hid_t             property_access_list;
	struct hdfql_file *next;
	struct hdfql_file *previous;
};

#ifdef _WIN32
	struct hdfql_adapter
	{
		ADAPTER_STATUS status;
		NAME_BUFFER    buffer[30];
	};
#endif



//===========================================================
// FUNCTIONS PROTOTYPE
//===========================================================
/** @defgroup SectionExecute Execute Functions
 *  List of execute functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_execute(const char *script);

HDFQL_EXPORT_SYMBOL int hdfql_execute_get_status(void);

/** @} */



/** @defgroup SectionError Error Functions
 *  List of error functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_error_get_line(void);

HDFQL_EXPORT_SYMBOL int hdfql_error_get_position(void);

HDFQL_EXPORT_SYMBOL char *hdfql_error_get_message(void);

/** @} */



/** @defgroup SectionCreate Create Functions
 *  List of create functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_create_directory(pANTLR3_BASE_TREE directory_list);

HDFQL_EXPORT_SYMBOL int hdfql_create_file(pANTLR3_BASE_TREE file_list, int file_parallel, int file_truncate);

HDFQL_EXPORT_SYMBOL int hdfql_create_group(pANTLR3_BASE_TREE group_list, int object_order, int object_max_compact, int object_min_dense, int attribute_order, int attribute_max_compact, int attribute_min_dense, int group_truncate);

HDFQL_EXPORT_SYMBOL int hdfql_create_dataset(pANTLR3_BASE_TREE dataset_list, int dataset_type, int dataset_endianness, hsize_t *dataset_dimension_list, int dataset_dimension_count, hsize_t *extendible_dimension_list, int extendible_flag, int char_set, const char *tag_value, pANTLR3_BASE_TREE dataset_default_list, int storage_type, hsize_t *storage_dimension_list, int storage_dimension_count, int attribute_order, int attribute_max_compact, int attribute_min_dense, int filter_shuffle, int filter_scaleoffset, int filter_nbit_precision, int filter_nbit_offset, int filter_zlib, int filter_fletcher32, int dataset_truncate);

HDFQL_EXPORT_SYMBOL int hdfql_create_attribute(pANTLR3_BASE_TREE attribute_list, int attribute_type, int attribute_endianness, hsize_t *attribute_dimension_list, int attribute_dimension_count, int char_set, const char *tag_value, pANTLR3_BASE_TREE attribute_default_list, int attribute_truncate);

HDFQL_EXPORT_SYMBOL int hdfql_create_link(pANTLR3_BASE_TREE link_list, pANTLR3_BASE_TREE object_list, int link_type, int link_truncate);

HDFQL_EXPORT_SYMBOL int hdfql_create_external_link(pANTLR3_BASE_TREE link_list, pANTLR3_BASE_TREE object_list, int link_truncate);

/** @} */



/** @defgroup SectionAlter Alter Functions
 *  List of alter functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_alter_dimension(pANTLR3_BASE_TREE dataset_list, pANTLR3_BASE_TREE dimension_list);

/** @} */



/** @defgroup SectionRename Rename Functions
 *  List of rename functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_rename_directory(pANTLR3_BASE_TREE directory_list, pANTLR3_BASE_TREE directory_new_list);

HDFQL_EXPORT_SYMBOL int hdfql_rename_file(pANTLR3_BASE_TREE file_list, pANTLR3_BASE_TREE file_new_list, int file_truncate);

HDFQL_EXPORT_SYMBOL int hdfql_rename_object(pANTLR3_BASE_TREE object_list, pANTLR3_BASE_TREE object_new_list, int object_type, int object_truncate);

/** @} */



/** @defgroup SectionCopy Copy Functions
 *  List of copy functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_copy_file(pANTLR3_BASE_TREE file_list, pANTLR3_BASE_TREE file_new_list, int file_truncate);

HDFQL_EXPORT_SYMBOL int hdfql_copy_object(pANTLR3_BASE_TREE object_list, pANTLR3_BASE_TREE object_new_list, int object_type, int object_truncate);

/** @} */



/** @defgroup SectionDrop Drop Functions
 *  List of drop functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_drop_directory(pANTLR3_BASE_TREE directory_list);

HDFQL_EXPORT_SYMBOL int hdfql_drop_file(pANTLR3_BASE_TREE file_list);

HDFQL_EXPORT_SYMBOL int hdfql_drop_object(pANTLR3_BASE_TREE object_list, int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_drop_object_like(const char *object_name, int object_type, const char *regular_expression, pANTLR3_BASE_TREE deep_list);

/** @} */



/** @defgroup SectionInsert Insert Functions
 *  List of insert functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_insert(pANTLR3_BASE_TREE object_list, int object_type, pANTLR3_BASE_TREE hyperslab_list, int source_type, pANTLR3_BASE_TREE value_list, const char *file_name, int file_eof, const char *file_separator, const char *file_subseparator, int variable_number, int variable_size);

/** @} */



/** @defgroup SectionSelect Select Functions
 *  List of select functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_select(const char *object_name, int object_type, pANTLR3_BASE_TREE hyperslab_list, int cache_enabled, int cache_slots, int cache_size, double cache_preemption, int source_type, int order_type, pANTLR3_BASE_TREE order_reverse_list, const char *file_name, int file_truncate, int file_eof, const char *file_separator, const char *file_subseparator, int file_split, int variable_number, int variable_size);

/** @} */



/** @defgroup SectionShow Show Functions
 *  List of show functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_show_file_validity(pANTLR3_BASE_TREE file_list);

HDFQL_EXPORT_SYMBOL int hdfql_show_use_directory(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_use_file(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_all_use_file(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_use_group(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_object(const char *object_name, int object_type, int order_creation);

HDFQL_EXPORT_SYMBOL int hdfql_show_object_like(const char *object_name, int object_type, const char *regular_expression, pANTLR3_BASE_TREE deep_list, int order_creation);

HDFQL_EXPORT_SYMBOL int hdfql_show_type(pANTLR3_BASE_TREE object_list);

HDFQL_EXPORT_SYMBOL int hdfql_show_storage_type(pANTLR3_BASE_TREE dataset_list);

HDFQL_EXPORT_SYMBOL int hdfql_show_datatype(pANTLR3_BASE_TREE object_list, int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_endianness(pANTLR3_BASE_TREE object_list, int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_charset(pANTLR3_BASE_TREE object_list, int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_storage_dimension(const char *dataset_name);

HDFQL_EXPORT_SYMBOL int hdfql_show_dimension(const char *object_name, int object_type, int dimension_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_order(pANTLR3_BASE_TREE object_list, int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_tag(pANTLR3_BASE_TREE object_list, int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_file_size(pANTLR3_BASE_TREE file_list);

HDFQL_EXPORT_SYMBOL int hdfql_show_size(pANTLR3_BASE_TREE object_list, int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_license(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_release_date(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_hdfql_version(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_hdf_version(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_pcre_version(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_zlib_version(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_directory(const char *directory_name);

HDFQL_EXPORT_SYMBOL int hdfql_show_file(const char *file_name);

HDFQL_EXPORT_SYMBOL int hdfql_show_mac_address(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_cache(int object_type, int parameter_type);

HDFQL_EXPORT_SYMBOL int hdfql_show_flush(void);

HDFQL_EXPORT_SYMBOL int hdfql_show_debug(void);

/** @} */



/** @defgroup SectionUse Use Functions
 *  List of use functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_use_directory(const char *directory_name);

HDFQL_EXPORT_SYMBOL int hdfql_use_file(pANTLR3_BASE_TREE file_list, int file_readonly, int file_parallel, int cache_enabled, int cache_slots, int cache_size, double cache_preemption);

HDFQL_EXPORT_SYMBOL int hdfql_use_group(const char *group_name);

/** @} */



/** @defgroup SectionFlush Flush Functions
 *  List of flush functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_flush(int flush_type);

/** @} */



/** @defgroup SectionClose Close Functions
 *  List of close functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_close_file(pANTLR3_BASE_TREE file_list);

HDFQL_EXPORT_SYMBOL int hdfql_close_all_file(void);

HDFQL_EXPORT_SYMBOL int hdfql_close_group(void);

/** @} */




/** @defgroup SectionSet Set Functions
 *  List of set functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_set_cache(int object_type, int cache_slots, int cache_size, double cache_preemption);

/** @} */




/** @defgroup SectionEnable Enable Functions
 *  List of enable functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_enable_flush(int object_type);

HDFQL_EXPORT_SYMBOL int hdfql_enable_debug(void);

/** @} */



/** @defgroup SectionDisable Disable Functions
 *  List of disable functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_disable_flush(void);

HDFQL_EXPORT_SYMBOL int hdfql_disable_debug(void);

/** @} */



/** @defgroup SectionRun Run Functions
 *  List of run functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_run(pANTLR3_BASE_TREE command_list);

/** @} */



/** @defgroup SectionCursor Cursor Functions
 *  List of cursor functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_cursor_initialize(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_use(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_use_default(void);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_clear(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_clone(HDFQL_CURSOR *cursor_original, HDFQL_CURSOR *cursor_clone);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_get_datatype(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_get_count(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_get_count(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_get_position(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_get_position(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_first(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_first(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_last(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_last(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_next(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_next(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_previous(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_previous(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_absolute(HDFQL_CURSOR *cursor, int position);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_absolute(HDFQL_CURSOR *cursor, int position);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_relative(HDFQL_CURSOR *cursor, int position);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_relative(HDFQL_CURSOR *cursor, int position);

HDFQL_EXPORT_SYMBOL int hdfql_cursor_get_size(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int hdfql_subcursor_get_size(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL void *hdfql_cursor_get(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL void *hdfql_subcursor_get(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL char *hdfql_cursor_get_tinyint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL char *hdfql_subcursor_get_tinyint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned char *hdfql_cursor_get_unsigned_tinyint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned char *hdfql_subcursor_get_unsigned_tinyint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL short *hdfql_cursor_get_smallint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL short *hdfql_subcursor_get_smallint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned short *hdfql_cursor_get_unsigned_smallint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned short *hdfql_subcursor_get_unsigned_smallint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int *hdfql_cursor_get_int(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL int *hdfql_subcursor_get_int(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned int *hdfql_cursor_get_unsigned_int(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned int *hdfql_subcursor_get_unsigned_int(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL long long *hdfql_cursor_get_bigint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL long long *hdfql_subcursor_get_bigint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned long long *hdfql_cursor_get_unsigned_bigint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL unsigned long long *hdfql_subcursor_get_unsigned_bigint(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL float *hdfql_cursor_get_float(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL float *hdfql_subcursor_get_float(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL double *hdfql_cursor_get_double(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL double *hdfql_subcursor_get_double(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL char *hdfql_cursor_get_char(HDFQL_CURSOR *cursor);

HDFQL_EXPORT_SYMBOL char *hdfql_subcursor_get_char(HDFQL_CURSOR *cursor);

/** @} */



/** @defgroup SectionVariable Variable Functions
 *  List of variable functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL int hdfql_variable_register(const void *variable);

HDFQL_EXPORT_SYMBOL int hdfql_variable_unregister(const void *variable);

HDFQL_EXPORT_SYMBOL int hdfql_variable_get_number(const void *variable);

HDFQL_EXPORT_SYMBOL int hdfql_variable_get_datatype(const void *variable);

HDFQL_EXPORT_SYMBOL int hdfql_variable_get_count(const void *variable);

HDFQL_EXPORT_SYMBOL int hdfql_variable_get_size(const void *variable);

HDFQL_EXPORT_SYMBOL int hdfql_variable_get_dimension_count(const void *variable);

HDFQL_EXPORT_SYMBOL int hdfql_variable_get_dimension(const void *variable, int index);

HDFQL_EXPORT_SYMBOL int hdfql_variable_get_element_count(const void *variable, int index);

/** @} */



/** @defgroup SectionTimer Timer Functions
 *  List of timer functions.
 *  @{
*/

HDFQL_EXPORT_SYMBOL void hdfql_timer_start(void);

HDFQL_EXPORT_SYMBOL void hdfql_timer_stop(void);

HDFQL_EXPORT_SYMBOL int hdfql_timer_elapsed(void);

/** @} */



void _hdfql_initialize(void);

void _hdfql_finalize(void);

void _hdfql_recognition_error(pANTLR3_BASE_RECOGNIZER recognizer, pANTLR3_UINT8 *token_list);

int _hdfql_execute(pANTLR3_BASE_TREE statement_list);

HDFQL_EXPORT_SYMBOL char *_hdfql_get_canonical_path(const char *object_name, char *object_name_result);

HDFQL_EXPORT_SYMBOL char *_hdfql_get_canonical_path_with_size(const char *object_name, int *object_name_size);

int _hdfql_drop_object(const char *object_name, int object_type);

int _hdfql_duplicate_attribute(char *attribute_name, char *attribute_name_canonical, char *attribute_new_name, char *attribute_new_name_canonical, int attribute_truncate, int attribute_copy, int flag);

void _hdfql_insert_fixed(int object_type, int object_size, pANTLR3_BASE_TREE value_list, hsize_t *dimension_list, int dimension_count, int dimension_current, char *data, int *position);

void _hdfql_insert_variable(int object_type, int object_size, pANTLR3_BASE_TREE value_list, hsize_t *dimension_list, int dimension_count, int dimension_current, char *data0, int *position0, hvl_t *data1, int *position1, int flag);

void _hdfql_insert_variable_char(pANTLR3_BASE_TREE value_list, hsize_t *dimension_list, int dimension_count, int dimension_current, char **data, int *position);

void _hdfql_insert_opaque(int object_size, pANTLR3_BASE_TREE value_list, hsize_t *dimension_list, int dimension_count, int dimension_current, char *data, int *position);

void _hdfql_insert_calculate(pANTLR3_BASE_TREE value_list, hsize_t *dimension_list, int dimension_count, int dimension_current, int *position0, int *position1, int flag);

void _hdfql_merge_tinyint(char *data, int data_count, int *index, int threads, int order_type);

void _hdfql_merge_smallint(short *data, int data_count, int *index, int threads, int order_type);

void _hdfql_merge_int(int *data, int data_count, int *index, int threads, int order_type);

void _hdfql_merge_bigint(long long *data, int data_count, int *index, int threads, int order_type);

void _hdfql_merge_float(float *data, int data_count, int *index, int threads, int order_type);

void _hdfql_merge_double(double *data, int data_count, int *index, int threads, int order_type);

void _hdfql_merge_char(char *data, int data_count, int *index, int threads, int order_type);

void _hdfql_merge_tinyint_sections(char *section_left, char *section_right, int section_left_position, int section_right_position, int order_type);

void _hdfql_merge_smallint_sections(short *section_left, short *section_right, int section_left_position, int section_right_position, int order_type);

void _hdfql_merge_int_sections(int *section_left, int *section_right, int section_left_position, int section_right_position, int order_type);

void _hdfql_merge_bigint_sections(long long *section_left, long long *section_right, int section_left_position, int section_right_position, int order_type);

void _hdfql_merge_float_sections(float *section_left, float *section_right, int section_left_position, int section_right_position, int order_type);

void _hdfql_merge_double_sections(double *section_left, double *section_right, int section_left_position, int section_right_position, int order_type);

void _hdfql_merge_char_sections(char *section_left, char *section_right, int section_left_position, int section_right_position, int order_type);

int _hdfql_compare_tinyint_ascend(const void *value_1, const void *value_2);

int _hdfql_compare_tinyint_descend(const void *value_1, const void *value_2);

int _hdfql_compare_smallint_ascend(const void *value_1, const void *value_2);

int _hdfql_compare_smallint_descend(const void *value_1, const void *value_2);

int _hdfql_compare_int_ascend(const void *value_1, const void *value_2);

int _hdfql_compare_int_descend(const void *value_1, const void *value_2);

int _hdfql_compare_bigint_ascend(const void *value_1, const void *value_2);

int _hdfql_compare_bigint_descend(const void *value_1, const void *value_2);

int _hdfql_compare_float_ascend(const void *value_1, const void *value_2);

int _hdfql_compare_float_descend(const void *value_1, const void *value_2);

int _hdfql_compare_double_ascend(const void *value_1, const void *value_2);

int _hdfql_compare_double_descend(const void *value_1, const void *value_2);

int _hdfql_compare_char_ascend(const void *value_1, const void *value_2);

int _hdfql_compare_char_descend(const void *value_1, const void *value_2);

void _hdfql_order_reverse_fixed(int object_size, pANTLR3_BASE_TREE order_reverse_list, hsize_t *dimension_list, int dimension_count, char *data, int flag);

void _hdfql_order_reverse_variable(int object_size, pANTLR3_BASE_TREE order_reverse_list, hsize_t *dimension_list, int dimension_count, hvl_t *data);

void _hdfql_order_reverse_variable_char(pANTLR3_BASE_TREE order_reverse_list, hsize_t *dimension_list, int dimension_count, char **data);

HDFQL_EXPORT_SYMBOL char *_hdfql_show_use_group(void);

int _hdfql_flush(int type);

void _hdfql_show_debug_information(void);

int _hdfql_get_object(const char *object_name, const char *object_name_canonical, int object_type, int order_creation, int return_object_type, int return_type_flag);

int _hdfql_get_object_like(const char *object_name, int object_type, const char *regular_expression, pANTLR3_BASE_TREE deep_list, int order_creation);

int _hdfql_get_object_like_recursive(int object_type, int deep_list[], int deep_use, int deep_current, const char *current_path, const char *current_path_canonical, const char *regular_expression_list, int regular_expression_count, int regular_expression_current, int order_creation, int flag);

int _hdfql_show_file_system_entries(const char *path_name, int type);

hid_t _hdfql_get_datatype(int type, int endianness);

int _hdfql_order(int order_type, pANTLR3_BASE_TREE order_reverse_list);

int _hdfql_range(int range_type, int range_position, int range_step);

int _hdfql_into(const char *file_name, int file_type, int file_truncate, int file_eof, const char *file_separator, int file_split, int variable_number, int variable_size);

HDFQL_EXPORT_SYMBOL char *_hdfql_cursor_get_char_with_size(HDFQL_CURSOR *cursor, int *size);

HDFQL_EXPORT_SYMBOL char *_hdfql_subcursor_get_char_with_size(HDFQL_CURSOR *cursor, int *size);

HDFQL_EXPORT_SYMBOL int _hdfql_cursor_get_last_count(void);

HDFQL_EXPORT_SYMBOL void _hdfql_cursor_set_datatype(int datatype);

HDFQL_EXPORT_SYMBOL void _hdfql_cursor_add(const void *data, int size);

HDFQL_EXPORT_SYMBOL void _hdfql_subcursor_add(const void *data, int size);

HDFQL_EXPORT_SYMBOL uintptr_t _hdfql_cursor_create(void);

HDFQL_EXPORT_SYMBOL void _hdfql_cursor_destroy(uintptr_t address);

void _hdfql_variable_register(int number, uintptr_t address);

void _hdfql_variable_unregister(int number);

int _hdfql_variable_get_datatype(int number);

int _hdfql_variable_get_count(int number);

int _hdfql_variable_get_size(int number);

int _hdfql_variable_get_dimension_count(int number);

int _hdfql_variable_get_dimension(int number, int index);

void _hdfql_variable_create(int number, int size);

void _hdfql_variable_destroy(int number);

void _hdfql_variable_set_char(int number, char data, int position);

void _hdfql_variable_set_short(int number, short data, int position);

void _hdfql_variable_set_int(int number, int data, int position);

void _hdfql_variable_set_long(int number, long long data, int position);

void _hdfql_variable_set_float(int number, float data, int position);

void _hdfql_variable_set_double(int number, double data, int position);

char _hdfql_variable_get_char(int number, int position);

short _hdfql_variable_get_short(int number, int position);

int _hdfql_variable_get_int(int number, int position);

long _hdfql_variable_get_long(int number, int position);

float _hdfql_variable_get_float(int number, int position);

double _hdfql_variable_get_double(int number, int position);

char *_hdfql_variable_get_string(int number, int position);

unsigned int _hdfql_crc32(const char *text, int size);

HDFQL_EXPORT_SYMBOL char *_hdfql_get_compiler(void);

HDFQL_EXPORT_SYMBOL char *_hdfql_get_architecture(void);

herr_t _hdfql_object_callback(hid_t object_id, const char *object_name, const H5L_info_t *link_information, void *operator_data);

herr_t _hdfql_object_type_callback(hid_t object_id, const char *object_name, const H5L_info_t *link_information, void *operator_data);

herr_t _hdfql_attribute_callback(hid_t object_id, const char *attribute_name, const H5A_info_t *attribute_info, void *operator_data);

herr_t _hdfql_attribute_type_callback(hid_t object_id, const char *attribute_name, const H5A_info_t *attribute_info, void *operator_data);



#ifdef __cplusplus
	}
#endif



#endif	// HDFQL_HEADER

