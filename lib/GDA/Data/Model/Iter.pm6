use v6.c;

use Method::Also;

use NativeCall;


use GDA::Raw::Types;
use GDA::Raw::Data::Model::Iter;

use GLib::Value;
use GDA::Set;

use GDA::Roles::Signals::Data::Model::Iter;

our subset GdaDataModelIterAncestry is export of Mu
  where GdaDataModelIter | GdaSetAncestry;

class GDA::Data::Model::Iter is GDA::Set {
  also does GDA::Roles::Signals::Data::Model::Iter;

  has GdaDataModelIter $!gdmi;

  submethod BUILD ( :$gda-data-model-iter ) {
    self.setGdaDataModelIter($gda-data-model-iter) if $gda-data-model-iter;
  }

  method setGdaDataModelIter (GdaDataModelIterAncestry $_) {
    my $to-parent;

    $!gdmi = do {
      when GdaDataModelIter {
        $to-parent = cast(GdaSet, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataModelIter, $_);
      }
    }
    self.setGdaSet($to-parent);
  }

  method GDA::Raw::Structs::GdaDataModelIter
  { $!gdmi }

  multi method new (
    GdaDataModelIterAncestry  $gda-data-model-iter,
                             :$ref                  = True
  ) {
    return Nil unless $gda-data-model-iter;

    my $o = self.bless( :$gda-data-model-iter );
    $o.ref if $ref;
    $o
  }

  # Type: int
  method current-row is rw  is also<current_row> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('current-row', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('current-row', $gv);
      }
    );
  }

  # Type: GdaDataModel
  method data-model ( :$raw = False ) is rw  is also<data_model> {
    my $gv = GLib::Value.new( GDA::Data::Model.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('data-model', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Model.getTypePair
        );
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('data-model', $gv);
      }
    );
  }

  # Type: GdaDataModel
  method forced-model ( :$raw = False ) is rw  is also<forced_model> {
    my $gv = GLib::Value.new( GDA::Data::Model.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('forced-model', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Model.getTypePair
        )
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('forced-model', $gv);
      }
    );
  }

  # Type: boolean
  method update-model is rw  is also<update_model> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('update-model', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('update-model', $gv);
      }
    );
  }

  # GdaDataModelIter *iter,  gint row --> void
  method row-changed is also<row_changed> {
    self.connect-row-changed($!gdmi);
  }

  # Is originally:
  # GdaDataModelIter *iter --> void
  method end-of-data is also<end_of_data> {
    self.connect-end-of-data($!gdmi);
  }

  method error_quark (
    GDA::Data::Model::Iter:U:
  )
    is also<error-quark>
  {
    gda_data_model_iter_error_quark();
  }

  method get_column_for_param (GdaHolder() $param)
    is also<get-column-for-param>
  {
    gda_data_model_iter_get_column_for_param($!gdmi, $param);
  }

  method get_holder_for_field (Int() $col, :$raw = False)
    is also<get-holder-for-field>
  {
    my gint $c = $col;

    propReturnObject(
      gda_data_model_iter_get_holder_for_field($!gdmi, $c),
      $raw,
      |GDA::Holder.getTypePair
    );
  }

  method get_row is also<get-row> {
    gda_data_model_iter_get_row($!gdmi);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_model_iter_get_type, $n, $t );
  }

  method get_value_at (Int() $col, :$raw = False) is also<get-value-at> {
    my gint $c = $col;

    propReturnObject(
      gda_data_model_iter_get_value_at($!gdmi, $c),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_value_at_e (
    Int()                    $col,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw = False
  )
    is also<get-value-at-e>
  {
    my gint $c = $col;

    clear_error;
    my $v = propReturnObject(
      gda_data_model_iter_get_value_at_e($!gdmi, $col, $error),
      $raw,
      |GLib::Value.getTypePair
    );
    set_error($error);
    $v;
  }

  method get_value_for_field (Str() $field_name, :$raw = False)
    is also<get-value-for-field>
  {
    propReturnObject(
      gda_data_model_iter_get_value_for_field($!gdmi, $field_name),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method invalidate_contents is also<invalidate-contents> {
    gda_data_model_iter_invalidate_contents($!gdmi);
  }

  method is_valid is also<is-valid> {
    so gda_data_model_iter_is_valid($!gdmi);
  }

  method move_next is also<move-next> {
    so gda_data_model_iter_move_next($!gdmi);
  }

  method move_prev is also<move-prev> {
    so gda_data_model_iter_move_prev($!gdmi);
  }

  method move_to_row (Int() $row) is also<move-to-row> {
    my gint $r = $row;

    so gda_data_model_iter_move_to_row($!gdmi, $r);
  }

  method set_value_at (
    Int()                   $col,
    GValue()                $value,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-value-at>
  {
    clear_error;
    my $rv = so gda_data_model_iter_set_value_at($!gdmi, $col, $value, $error);
    set_error($error);
    $rv;
  }

}
