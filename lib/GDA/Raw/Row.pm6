use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Row;

### /usr/include/libgda-5.0/libgda/gda-row.h

sub gda_row_get_length (GdaRow $row)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_row_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_row_get_value (GdaRow $row, gint $num)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_row_invalidate_value (GdaRow $row, GValue $value)
  is native(gda)
  is export
{ * }

sub gda_row_invalidate_value_e (
  GdaRow          $row,
  GValue          $value,
  Pointer[GError] $error
)
  is native(gda)
  is export
{ * }

sub gda_row_new (gint $count)
  returns GdaRow
  is native(gda)
  is export
{ * }

sub gda_row_value_is_valid (GdaRow $row, GValue $value)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_row_value_is_valid_e (
  GdaRow                  $row,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
