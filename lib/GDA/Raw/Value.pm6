use v6.c;

use NativeCall;

use LibXML::Raw;             #= for anyNode
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Value;

### /usr/include/libgda-5.0/libgda/gda-value.h

sub gda_value_compare (GValue $value1, GValue $value2)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_value_copy (GValue $value)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_differ (GValue $value1, GValue $value2)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_value_free (GValue $value)
  is native(gda)
  is export
{ * }

sub gda_value_get_binary (GValue $value)
  returns GdaBinary
  is native(gda)
  is export
{ * }

sub gda_value_get_blob (GValue $value)
  returns GdaBlob
  is native(gda)
  is export
{ * }

sub gda_value_get_geometric_point (GValue $value)
  returns GdaGeometricPoint
  is native(gda)
  is export
{ * }

sub gda_value_get_numeric (GValue $value)
  returns GdaNumeric
  is native(gda)
  is export
{ * }

sub gda_value_get_short (GValue $value)
  returns gshort
  is native(gda)
  is export
{ * }

sub gda_value_get_time (GValue $value)
  returns GdaTime
  is native(gda)
  is export
{ * }

sub gda_value_get_timestamp (GValue $value)
  returns GdaTimestamp
  is native(gda)
  is export
{ * }

sub gda_value_get_ushort (GValue $value)
  returns gushort
  is native(gda)
  is export
{ * }

sub gda_value_is_null (GValue $value)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_value_is_number (GValue $value)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_value_new (GType $type)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_new_binary (Str $val, glong $size)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_new_blob (Str $val, glong $size)
  returns GValue
  is native(gda)
  is export
{ * }
sub gda_value_new_blob_from_file (Str $filename)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_new_default (Str $default_val)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_new_from_string (Str $as_string, GType $type)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_new_from_xml (anyNode $node)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_new_null ()
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_new_timestamp_from_timet (time_t $val)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_value_reset_with_type (GValue $value, GType $type)
  is native(gda)
  is export
{ * }

sub gda_value_set_binary (GValue $value, GdaBinary $binary)
  is native(gda)
  is export
{ * }

sub gda_value_set_blob (GValue $value, GdaBlob $blob)
  is native(gda)
  is export
{ * }

sub gda_value_set_from_string (GValue $value, Str $as_string, GType $type)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_value_set_from_value (GValue $value, GValue $from)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_value_set_geometric_point (GValue $value, GdaGeometricPoint $val)
  is native(gda)
  is export
{ * }

sub gda_value_set_null (GValue $value)
  is native(gda)
  is export
{ * }

sub gda_value_set_numeric (GValue $value, GdaNumeric $val)
  is native(gda)
  is export
{ * }

sub gda_value_set_short (GValue $value, gshort $val)
  is native(gda)
  is export
{ * }

sub gda_value_set_time (GValue $value, GdaTime $val)
  is native(gda)
  is export
{ * }

sub gda_value_set_timestamp (GValue $value, GdaTimestamp $val)
  is native(gda)
  is export
{ * }

sub gda_value_set_ushort (GValue $value, gushort $val)
  is native(gda)
  is export
{ * }

sub gda_value_stringify (GValue $value)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_value_take_binary (GValue $value, GdaBinary $binary)
  is native(gda)
  is export
{ * }

sub gda_value_take_blob (GValue $value, GdaBlob $blob)
  is native(gda)
  is export
{ * }

sub gda_value_to_xml (GValue $value)
  returns anyNode
  is native(gda)
  is export
{ * }

sub gda_default_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_null_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_short_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_string_to_binary (Str $str)
  returns GdaBinary
  is native(gda)
  is export
{ * }

sub gda_string_to_blob (Str $str)
  returns GdaBlob
  is native(gda)
  is export
{ * }

sub gda_ushort_get_type ()
  returns GType
  is native(gda)
  is export
{ * }
