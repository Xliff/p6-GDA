use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::SQL::Parser;

### /usr/include/libgda-5.0/libgda/sql-parser/gda-sql-parser.h

sub gda_sql_parser_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_sql_parser_new ()
  returns GdaSqlParser
  is native(gda)
  is export
{ * }

sub gda_sql_parser_parse_file_as_batch (
  GdaSqlParser            $parser,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns GdaBatch
  is native(gda)
  is export
{ * }

sub gda_sql_parser_parse_string (
  GdaSqlParser            $parser,
  Str                     $sql,
  CArray[Str]             $remain,
  CArray[Pointer[GError]] $error
)
  returns GdaStatement
  is native(gda)
  is export
{ * }

sub gda_sql_parser_parse_string_as_batch (
  GdaSqlParser            $parser,
  Str                     $sql,
  CArray[Str]             $remain,
  CArray[Pointer[GError]] $error
)
  returns GdaBatch
  is native(gda)
  is export
{ * }

sub gda_sql_parser_set_overflow_error (GdaSqlParser $parser)
  is native(gda)
  is export
{ * }

sub gda_sql_parser_set_syntax_error (GdaSqlParser $parser)
  is native(gda)
  is export
{ * }
