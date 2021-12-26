use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Data::Select;

### /usr/include/libgda-5.0/libgda/gda-data-select.h

sub gda_data_select_compute_columns_attributes (
  GdaDataSelect           $model,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_compute_modification_statements (
  GdaDataSelect           $model,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_compute_modification_statements_ext (
  GdaDataSelect              $model,
  GdaDataSelectConditionType $cond_type,
  CArray[Pointer[GError]]    $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_compute_row_selection_condition (
  GdaDataSelect           $model,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_data_select_get_connection (GdaDataSelect $model)
  returns GdaConnection
  is native(gda)
  is export
{ * }

sub gda_data_select_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_select_prepare_for_offline (
  GdaDataSelect           $model,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_rerun (GdaDataSelect $model, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_set_modification_statement (
  GdaDataSelect           $model,
  GdaStatement            $mod_stmt,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_set_modification_statement_sql (
  GdaDataSelect           $model,
  Str                     $sql,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_set_row_selection_condition (
  GdaDataSelect           $model,
  GdaSqlExpr              $expr,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_select_set_row_selection_condition_sql (
  GdaDataSelect           $model,
  Str                     $sql_where,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
