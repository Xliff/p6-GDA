use v6.c;

use NativeCall;
use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Holder;

use GLib::Roles::Object;
use GDA::Roles::Data::Model;
use GDA::Roles::Signals::Holder;

our subset GdaHolderAncestry is export of Mu
  where GdaHolder | GObject;

class GDA::Holder {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Holder;

  has GdaHolder $!gh;

  submethod BUILD ( :$gda-holder ) {
    self.setGdaHolder($gda-holder) if $gda-holder;
  }

  method setGdaHolder (GdaHolderAncestry $_) {
    my $to-parent;
    $!gh = do {
      when GdaHolder {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaHolder, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaHolder
    is also<GdaHolder>
  { $!gh }

  multi method new (GdaHolderAncestry $gda-holder, :$ref = True) {
    return Nil unless $gda-holder;

    my $o = self.bless( :$gda-holder );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $type) {
    my GType $t          = $type;
    my       $gda-holder = gda_holder_new($t);

    $gda-holder ?? self.bless( :$gda-holder ) !! Nil;
  }

  method attribute is rw {
    Proxy.new:
      FETCH => -> $     { self.get_attribute    },
      STORE => -> $, \v { self.set_attribute(v) }
  }

  method bind is rw {
    Proxy.new:
      FETCH => -> $     { self.get_bind    },
      STORE => -> $, \v { self.set_bind(v) }
  }

  method default_value is rw {
    Proxy.new:
      FETCH => -> $     { self.get_default_value    },
      STORE => -> $, \v { self.set_default_value(v) }
  }

  method not_null is rw {
    Proxy.new:
      FETCH => -> $     { self.get_not_null    },
      STORE => -> $, \v { self.set_not_null(v) }
  }

  method source_model is rw {
    Proxy.new:
      FETCH => -> $     { self.get_source_model    },
      STORE => -> $, \v { self.set_source_model(v) }
  }

  method value is rw {
    Proxy.new:
      FETCH => -> $     { self.get_value    },
      STORE => -> $, \v { self.set_value(v) }
  }

  method value_str is rw {
    Proxy.new:
      FETCH => -> $     { self.get_value_str    },
      STORE => -> $, \v { self.set_value_str(v) }
  }

  # Is originally:
  # GdaHolder *holder --> void
  method source-changed is also<source_changed> {
    self.connect-holder($!gh, 'source-changed');
  }

  # Is originally:
  # GdaHolder *holder --> void
  method changed {
    self.connect-holder($!gh, 'changed');
  }

  # Is originally:
  # GdaHolder *holder,  GValue *new_value --> GError *
  method validate-change is also<validate_change> {
    self.connect-validate-change($!gh);
  }


  # cw: var-arg handling currently out of scope.
  # method new_inline (GType $type, Str $id) {
  #   gda_holder_new_inline($!gh, $type, $id);
  # }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_holder_copy($!gh),
      $raw,
      |self.getTypePair
    );
  }

  method error_quark (GDA::Holder:U: ) is also<error-quark> {
    gda_holder_error_quark();
  }

  method force_invalid is also<force-invalid> {
    gda_holder_force_invalid($!gh);
  }

  method force_invalid_e (GError() $error) is also<force-invalid-e> {
    gda_holder_force_invalid_e($!gh, $error);
  }

  method get_alphanum_id is also<get-alphanum-id> {
    gda_holder_get_alphanum_id($!gh);
  }

  method get_attribute (Str() $attribute, :$raw = False)
    is also<get-attribute>
  {
    propReturnObject(
      gda_holder_get_attribute($!gh, $attribute),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_bind ( :$raw = False ) is also<get-bind> {
    propReturnObject(
      gda_holder_get_bind($!gh),
      $raw,
      |self.getTypePair
    );
  }

  method get_default_value ( :$raw = False ) is also<get-default-value> {
    propReturnObject(
      gda_holder_get_default_value($!gh),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_g_type is also<get-g-type> {
    gda_holder_get_g_type($!gh);
  }

  method get_id is also<get-id> {
    gda_holder_get_id($!gh);
  }

  method get_not_null is also<get-not-null> {
    so  gda_holder_get_not_null($!gh);
  }

  proto method get_source_model (|)
    is also<get-source-model>
  { * }

  multi method get_source_model ( :$col where *.not, :$raw = False ) {
    propReturnObject(
      gda_holder_get_source_model($!gh, Pointer),
      $raw,
      |GDA::Data::Model.getTypePair
    );
  }
  multi method get_source_model ( :$col is required, :$raw = False ) {
    my $c;
    my $m = samewith($c, :$raw);
    ($m, $c);
  }
  multi method get_source_model ($col is rw, :$raw = False) {
    my gint $c = 0;

    my $m = gda_holder_get_source_model($!gh, $c);
    $col = $c;
    propReturnObject($m, $raw, |GDA::Data::Model.getTypePair);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_holder_get_type, $n, $t );
  }

  method get_value ( :$raw = False ) is also<get-value> {
    propReturnObject(
      gda_holder_get_value($!gh),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_value_str (GdaDataHandler() $dh) is also<get-value-str> {
    gda_holder_get_value_str($!gh, $dh);
  }

  method is_valid is also<is-valid> {
    so gda_holder_is_valid($!gh);
  }

  method is_valid_e (CArray[Pointer[GError]] $error = gerror)
    is also<is-valid-e>
  {
    clear_error;
    my $rv = so gda_holder_is_valid_e($!gh, $error);
    set_error($error);
    $rv;
  }

  method set_attribute (
    Str()          $attribute,
    GValue()       $value,
    GDestroyNotify $destroy    = gpointer
  )
    is also<set-attribute>
  {
    gda_holder_set_attribute($!gh, $attribute, $value, $destroy);
  }

  method set_bind (
    GdaHolder()             $bind_to,
    CArray[Pointer[GError]] $error    = gerror
  )
    is also<set-bind>
  {
    clear_error;
    my $rv = so gda_holder_set_bind($!gh, $bind_to, $error);
    set_error($error);
    $rv;
  }

  method set_default_value (GValue() $value) is also<set-default-value> {
    gda_holder_set_default_value($!gh, $value);
  }

  method set_not_null (Int() $not_null) is also<set-not-null> {
    my gboolean $n = $not_null.so.Int;

    gda_holder_set_not_null($!gh, $n);
  }

  method set_source_model (
    GdaDataModel()          $model,
    Int()                   $col,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-source-model>
  {
    my gint $c = $col;

    clear_error;
    my $rv = so gda_holder_set_source_model($!gh, $model, $c, $error);
    set_error($error);
    $rv;
  }

  method set_value (GValue() $value, CArray[Pointer[GError]] $error = gerror)
    is also<set-value>
  {
    clear_error;
    my $rv = so gda_holder_set_value($!gh, $value, $error);
    set_error($error);
    $rv;
  }

  method set_value_str (
    GdaDataHandler()        $dh,
    Str()                   $value,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-value-str>
  {
    clear_error;
    my $rv = so gda_holder_set_value_str($!gh, $dh, $value, $error);
    set_error($error);
    $rv;
  }

  method set_value_to_default is also<set-value-to-default> {
    so gda_holder_set_value_to_default($!gh);
  }

  method take_static_value (
    GValue()                 $value,
    Int()                    $value_changed,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  )
    is also<take-static-value>
  {
    my gboolean $v = $value_changed.so.Int;

    clear_error;
    my $val = gda_holder_take_static_value($!gh, $value, $v, $error);
    set_error($error);

    propReturnObject($val, $raw, |GLib::Value.getTypePair);
  }

  method take_value (
    GValue()                $value,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<take-value>
  {
    clear_error;
    my $rv = so gda_holder_take_value($!gh, $value, $error);
    set_error($error);
    $rv;
  }

  method value_is_default is also<value-is-default> {
    so gda_holder_value_is_default($!gh);
  }

}
