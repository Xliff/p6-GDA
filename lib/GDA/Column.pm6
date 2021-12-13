use v6.c;

use GDA::Raw::Types;
use GDA::Raw::Column;

use GLib::Value;

use GLib::Roles::Object;
use GDA::Roles::Signals::Column;

our subset GdaColumnAncestry is export of Mu
  where GdaColumn | GObject;

class GDA::Column {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Column;

  has GdaColumn $!gc is implementor;

  submethod BUILD ( :$gda-column ) {
    self.setGdaColumn( $gda-column ) if $gda-Column
  }

  method setGdaColumn (GdaColumnAncestry $_) {
    my $to-parent;

    $!gc = do {
      when GdaColumn {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaColumn, $_);
      }
    }
    self!setObject($to-parent)
  }

  method GDA::Raw::Definitions::GdaColumn
  { $!gc }

  multi method new (GdaColumnAncestry $gda-column, :$ref = True) {
    return Nil unless $gda-column;

    my $o = self.bless( :$gda-column );
    $o.ref if $ref;
    $o
  }
  multi method new {
    my $gda-column = gda_column_new();

    $gda-column ?? self.bless( :$gda-column ) !! Nil;
  }

  method allow_null is rw {
    Proxy.new:
      FETCH => -> $     { self.get_allow_null    },
      STORE => -> $, \v { self.set_allow_null(v) }
  }

  method attribute is rw {
    Proxy.new:
      FETCH => -> $     { self.get_attribute    },
      STORE => -> $, \v { self.set_attribute(v) }
  }

  method auto_increment is rw {
    Proxy.new:
      FETCH => -> $     { self.get_auto_increment    },
      STORE => -> $, \v { self.set_auto_increment(v) }
  }

  method dbms_type is rw {
    Proxy.new:
      FETCH => -> $     { self.get_dbms_type    },
      STORE => -> $, \v { self.set_dbms_type(v) }
  }

  method default_value is rw {
    Proxy.new:
      FETCH => -> $     { self.get_default_value    },
      STORE => -> $, \v { self.set_default_value(v) }
  }

  method description is rw {
    Proxy.new:
      FETCH => -> $     { self.get_description    },
      STORE => -> $, \v { self.set_description(v) }
  }

  method g_type is rw {
    Proxy.new:
      FETCH => -> $     { self.get_g_type    },
      STORE => -> $, \v { self.set_g_type(v) }
  }

  method name is rw {
    Proxy.new:
      FETCH => -> $     { self.get_name    },
      STORE => -> $, \v { self.set_name(v) }
  }

  method position is rw {
    Proxy.new:
      FETCH => -> $     { self.get_position    },
      STORE => -> $, \v { self.set_position(v) }
  }

  # Is originally:
  # GdaColumn, GType, GType, gpointer --> void
  method g-type-changed {
    self.connect-g-type-changed($!w);
  }

  # Is originally:
  # GdaColumn, gchar, gpointer --> void
  method name-changed {
    self.connect-string($!gc, 'name-changed');
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_column_copy($!gc),
      $raw,
      |self.getTypePair
    );
  }

  method get_allow_null {
    SO gda_column_get_allow_null($!gc);
  }

  method get_attribute (Str() $attribute) {
    gda_column_get_attribute($!gc, $attribute);
  }

  method get_auto_increment {
    gda_column_get_auto_increment($!gc);
  }

  method get_dbms_type {
    gda_column_get_dbms_type($!gc);
  }

  method get_default_value ( :$raw = False ) {
    propReturnObject(
      gda_column_get_default_value($!gc),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_description {
    gda_column_get_description($!gc);
  }

  method get_g_type {
    gda_column_get_g_type($!gc);
  }

  method get_name {
    gda_column_get_name($!gc);
  }

  method get_position {
    gda_column_get_position($!gc);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_column_get_type, $n, $t );
  }

  method set_allow_null (Int() $allow) {
    my gboolean $a = $allow.so.Int;

    gda_column_set_allow_null($!gc, $allow);
  }

  method set_attribute (
    Str()          $attribute,
    GValue()       $value,
    GDestroyNotify $destroy = gpointer
  ) {
    gda_column_set_attribute($!gc, $attribute, $value, $destroy);
  }

  method set_auto_increment (gboolean $is_auto) {
    my gboolean $i = $is_auto.so.Int;

    gda_column_set_auto_increment($!gc, $i);
  }

  method set_dbms_type (Str() $dbms_type) {
    gda_column_set_dbms_type($!gc, $dbms_type);
  }

  method set_default_value (GValue() $default_value) {
    gda_column_set_default_value($!gc, $default_value);
  }

  method set_description (Str() $title) {
    gda_column_set_description($!gc, $title);
  }

  method set_g_type (Int() $type) {
    my GType $t = $t;
    gda_column_set_g_type($!gc, $type);
  }

  method set_name (Str() $name) {
    gda_column_set_name($!gc, $name);
  }

  method set_position (Int() $position) {
    my gint $p = $position;

    gda_column_set_position($!gc, $p);
  }


}
