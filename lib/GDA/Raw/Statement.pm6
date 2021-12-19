use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Statement;

### /usr/include/libgda-5.0/libgda/gda-statement.h

sub gda_statement_check_structure (
  GdaStatement            $stmt,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_statement_check_validity (
  GdaStatement            $stmt,
  GdaConnection           $cnc,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_statement_copy (GdaStatement $orig)
  returns GdaStatement
  is native(gda)
  is export
{ * }

sub gda_statement_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_statement_get_parameters (
  GdaStatement            $stmt,
  CArray[Pointer[GdaSet]] $out_params,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_statement_get_statement_type (GdaStatement $stmt)
  returns GdaSqlStatementType
  is native(gda)
  is export
{ * }

sub gda_statement_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_statement_is_useless (GdaStatement $stmt)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_statement_new ()
  returns GdaStatement
  is native(gda)
  is export
{ * }

sub gda_statement_normalize (
  GdaStatement            $stmt,
  GdaConnection           $cnc,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_statement_serialize (GdaStatement $stmt)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_statement_to_sql_extended (
  GdaStatement            $stmt,
  GdaConnection           $cnc,
  GdaSet                  $params,
  GdaStatementSqlFlag     $flags,
  CArray[Pointer[GSList]] $params_used,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gda)
  is export
{ * }
