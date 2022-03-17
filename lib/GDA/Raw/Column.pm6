use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Column;

### /usr/include/libgda-5.0/libgda/gda-column.h

sub gda_column_copy (GdaColumn $column)
  returns GdaColumn
  is native(gda)
  is export
{ * }

sub gda_column_get_allow_null (GdaColumn $column)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_column_get_attribute (GdaColumn $column, Str $attribute)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_column_get_auto_increment (GdaColumn $column)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_column_get_dbms_type (GdaColumn $column)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_column_get_default_value (GdaColumn $column)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_column_get_description (GdaColumn $column)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_column_get_g_type (GdaColumn $column)
  returns GType
  is native(gda)
  is export
{ * }

sub gda_column_get_name (GdaColumn $column)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_column_get_position (GdaColumn $column)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_column_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_column_new ()
  returns GdaColumn
  is native(gda)
  is export
{ * }

sub gda_column_set_allow_null (GdaColumn $column, gboolean $allow)
  is native(gda)
  is export
{ * }

sub gda_column_set_attribute (
  GdaColumn      $column,
  Str            $attribute,
  GValue         $value,
  GDestroyNotify $destroy
)
  is native(gda)
  is export
{ * }

sub gda_column_set_auto_increment (GdaColumn $column, gboolean $is_auto)
  is native(gda)
  is export
{ * }

sub gda_column_set_dbms_type (GdaColumn $column, Str $dbms_type)
  is native(gda)
  is export
{ * }

sub gda_column_set_default_value (GdaColumn $column, GValue $default_value)
  is native(gda)
  is export
{ * }

sub gda_column_set_description (GdaColumn $column, Str $title)
  is native(gda)
  is export
{ * }

sub gda_column_set_g_type (GdaColumn $column, GType $type)
  is native(gda)
  is export
{ * }

sub gda_column_set_name (GdaColumn $column, Str $name)
  is native(gda)
  is export
{ * }

sub gda_column_set_position (GdaColumn $column, gint $position)
  is native(gda)
  is export
{ * }
