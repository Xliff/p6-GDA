use v6.c;

use Method::Also;
use NativeCall;

use LibXML::Raw;
use GDA::Raw::Types;
use GDA::Raw::Value;

use GLib::Value;

class GDA::Value is GLib::Value {
  has GdaValue $!gv is implementor;

  method new (Int() $type) {
    my GType $t         = $type;
    my       $gda-value = gda_value_new($t);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  proto method new_binary (|)
    is also<new-binary>
  { * }

  multi method new_binary (@val)  {
    samewith( CArray[uint8].new(@val), @val.elems );
  }
  multi method new_binary (Blob() $val) {
    samewith( CArray[uint8].new($val), $val.elems );
  }
  multi method new_binary (CArray[uint8] $val, Int() $size) {
    my glong $s = $size;

    my $gda-value = gda_value_new_binary($val, $size);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  proto method new_blob (|)
    is also<new-blob>
  { * }

  multi method new_blob (Blob() $val)  {
    samewith( CArray[uint8].new($val), $val.elems );
  }
  multi method new_blob (CArray[uint8] $val, Int() $size) {
    my glong $s = $size;

    samewith( cast(gpointer, $val), $size );
  }
  multi method new_blob (gpointer $val, $size) {
    my $gda-value = gda_value_new_blob($val, $size);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  method new_blob_from_file (Str() $filename) is also<new-blob-from-file> {
    my $gda-value = gda_value_new_blob_from_file($filename);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  method new_default (Str() $default_val) is also<new-default> {
    my $gda-value = gda_value_new_default($default_val);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  method new_from_string (Str() $as_string, Int() $type)
    is also<new-from-string>
  {
    my GType $t         = $type;
    my       $gda-value = gda_value_new_from_string($as_string, $t);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  method new_from_xml (anyNode() $node) is also<new-from-xml> {
    my $gda-value = gda_value_new_from_xml($node);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  method new_timestamp_from_timet (time_t $val)
    is also<
      new-timestamp-from-timet
      new_timestamp
      new-timestamp
    >
  {
    my $gda-value = gda_value_new_timestamp_from_timet($val);

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  method new_null is also<new-null> {
    my $gda-value = gda_value_new_null();

    $gda-value ?? self.bless( :$gda-value ) !! Nil;
  }

  method compare (GValue() $value2) {
    so gda_value_compare($!gv, $value2);
  }

  method copy (:$raw = False) {
    propReturnObject(
      gda_value_copy($!gv),
      $raw,
      |GDA::Value.getTypePair
    )
  }

  method differ (GValue() $value2) {
    so gda_value_differ($!gv, $value2);
  }

  method !free {
    gda_value_free($!gv);
  }

  # method gda_default_get_type {
  #   gda_default_get_type();
  # }
  #
  # method gda_null_get_type {
  #   gda_null_get_type();
  # }
  #
  # method gda_short_get_type {
  #   gda_short_get_type();
  # }
  #
  # method gda_string_to_binary {
  #   gda_string_to_binary($!gv);
  # }
  #
  # method gda_string_to_blob {
  #   gda_string_to_blob($!gv);
  # }
  #
  # method gda_ushort_get_type {
  #   gda_ushort_get_type();
  # }

  method get_binary is also<get-binary> {
    gda_value_get_binary($!gv);
  }

  method get_blob is also<get-blob> {
    gda_value_get_blob($!gv);
  }

  method get_geometric_point is also<get-geometric-point> {
    gda_value_get_geometric_point($!gv);
  }

  method get_numeric is also<get-numeric> {
    gda_value_get_numeric($!gv);
  }

  method get_short is also<get-short> {
    gda_value_get_short($!gv);
  }

  method get_time is also<get-time> {
    gda_value_get_time($!gv);
  }

  method get_timestamp is also<get-timestamp> {
    gda_value_get_timestamp($!gv);
  }

  method get_ushort is also<get-ushort> {
    gda_value_get_ushort($!gv);
  }

  method is_null is also<is-null> {
    so gda_value_is_null($!gv);
  }

  method is_number is also<is-number> {
    so gda_value_is_number($!gv);
  }

  method reset_with_type (GType() $type) is also<reset-with-type> {
    gda_value_reset_with_type($!gv, $type);
  }

  method set_binary (GdaBinary() $binary) is also<set-binary> {
    gda_value_set_binary($!gv, $binary);
  }

  method set_blob (GdaBlob() $blob) is also<set-blob> {
    gda_value_set_blob($!gv, $blob);
  }

  method set_from_string (Str() $as_string, Int() $type)
    is also<set-from-string>
  {
    my GType $t = $type;

    gda_value_set_from_string($!gv, $as_string, $t);
  }

  method set_from_value (GValue() $from) is also<set-from-value> {
    gda_value_set_from_value($!gv, $from);
  }

  method set_geometric_point (GdaGeometricPoint() $val)
    is also<set-geometric-point>
  {
    gda_value_set_geometric_point($!gv, $val);
  }

  method set_null is also<set-null> {
    gda_value_set_null($!gv);
  }

  method set_numeric (GdaNumeric() $val) is also<set-numeric> {
    gda_value_set_numeric($!gv, $val);
  }

  method set_short (Int() $val) is also<set-short> {
    my gshort $v = $val;

    gda_value_set_short($!gv, $v);
  }

  method set_time (GdaTime() $val) is also<set-time> {
    gda_value_set_time($!gv, $val);
  }

  method set_timestamp (GdaTimestamp() $val) is also<set-timestamp> {
    gda_value_set_timestamp($!gv, $val);
  }

  method set_ushort (Int() $val) is also<set-ushort> {
    my gushort $v = $val;

    gda_value_set_ushort($!gv, $v);
  }

  method stringify {
    gda_value_stringify($!gv);
  }

  method take_binary (GdaBinary() $binary) is also<take-binary> {
    gda_value_take_binary($!gv, $binary);
  }

  method take_blob (GdaBlob() $blob) is also<take-blob> {
    gda_value_take_blob($!gv, $blob);
  }

  method to_xml is also<to-xml> {
    gda_value_to_xml($!gv);
  }

}
