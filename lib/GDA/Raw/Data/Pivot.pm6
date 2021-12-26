use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Data::Pivot;

### /usr/include/libgda-5.0/libgda/gda-data-pivot.h

sub gda_data_pivot_add_data (
  GdaDataPivot            $pivot,
  GdaDataPivotAggregate   $aggregate_type,
  Str                     $field,
  Str                     $alias,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_pivot_add_field (
  GdaDataPivot            $pivot,
  GdaDataPivotFieldType   $field_type,
  Str                     $field,
  Str                     $alias,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_pivot_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_data_pivot_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_pivot_new (GdaDataModel $model)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_data_pivot_populate (
  GdaDataPivot            $pivot,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
