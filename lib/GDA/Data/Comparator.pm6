use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Data::Comparator;

use GLib::Roles::Object;

our subset GdaDataComparatorAncestry is export of Mu
  where GdaDataComparator | GObject;

class GDA::Data::Comparator {
  also does GLib::Roles::Object;

  has GdaDataComparator $!gdc;

  submethod BUILD ( :$gda-data-comparator ) {
    self.setGdaDataComparator($gda-data-comparator) if $gda-data-comparator;
  }

  method setGdaDataComparator (GdaDataComparatorAncestry $_) {
    my $to-parent;
    $!gdc = do {
      when GdaDataComparator {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataComparator, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaDataComparator
    is also<GdaDataComparator>
  { $!gdc }

  multi method new (GdaDataComparatorAncestry $gda-data-comparator,
                                             :$ref                  = True
  ) {
    return Nil unless $gda-data-comparator;

    my $o = self.bless( :$gda-data-comparator );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaDataModel() $old_model, GdaDataModel() $new_model) {
    my $gda-data-comparator = gda_data_comparator_new($!gdc, $new_model);

    $gda-data-comparator ?? self.bless( :$gda-data-comparator ) !! Nil;
  }

  # Type: GdaDataModel
  method new-model ( :$raw = False ) is rw  is also<new_model> {
    my $gv = GLib::Value.new( GDA::Data::Model.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('new-model', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Model.getTypePair
        )
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('new-model', $gv);
      }
    );
  }

  # Type: GdaDataModel
  method old-model ( :$raw = False ) is rw  is also<old_model> {
    my $gv = GLib::Value.new( GDA::Data::Model.get-type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('old-model', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Model.getTypePair
        )
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('old-model', $gv);
      }
    );
  }

  # Is originally:
  # GdaDataComparator, gpointer, gpointer --> gboolean
  method diff-computed is also<diff_computed> {
    self.connect-diff-computed($!gdc);
  }

  method compute_diff (CArray[Pointer[GError]] $error = gerror)
    is also<compute-diff>
  {
    clear_error;
    my $rv = so gda_data_comparator_compute_diff($!gdc, $error);
    set_error($error);
    $rv;
  }

  method error_quark ( GDA::Data::Comparator:U: ) is also<error-quark> {
    gda_data_comparator_error_quark();
  }

  method get_diff (Int() $pos, :$raw = False) is also<get-diff> {
    my gint $p = $pos;

    propReturnObject(
      gda_data_comparator_get_diff($!gdc, $p),
      $raw,
      |GDA::Diff.getTypePair
    );
  }

  method get_n_diffs is also<get-n-diffs> {
    gda_data_comparator_get_n_diffs($!gdc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_comparator_get_type, $n, $t );
  }

  proto method set_key_columns (|)
    is also<set-key-columns>
  { * }

  multi method set_key_columns (@cols) {
    samewith(
      ArrayToCArray(gint, @cols),
      @cols.elems
    );
  }
  multi method set_key_columns (CArray[gint] $col_numbers, Int() $nb_cols) {
    my gint $nbc =$nb_cols;

    gda_data_comparator_set_key_columns($!gdc, $col_numbers, $nbc);
  }

}
