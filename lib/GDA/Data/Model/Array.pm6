use v6.c;

use NativeCall;
use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Data::Model::Array;

use GDA::Row;

use GLib::Roles::Object;

our subset GdaDataModelArrayAncestry is export of Mu
  where GdaDataModelArray | GObject;

class GDA::Data::Model::Array {
  also does GLib::Roles::Object;

  has GdaDataModelArray $!gdma;

  submethod BUILD ( :$gda-data-model-array ) {
    self.setGdaDataModelArray($gda-data-model-array)
      if $gda-data-model-array;
  }

  method setGdaDataModelArray (GdaDataModelArrayAncestry $_) {
    my $to-parent;
    $!gdma = do {
      when GdaDataModelArray {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataModelArray, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaDataModelArray
    is also<GdaDataModelArray>
  { $!gdma }

  multi method new (GdaDataModelArrayAncestry  $gda-data-model-array,
                                              :$ref                   = True
  ) {
    return Nil unless $gda-data-model-array;

    my $o = self.bless( :$gda-data-model-array );
    $o.ref if $ref;
    $o;
  }

  multi method new (Int() $cols) {
    my gint $c = $cols;

    my $gda-data-model-array = gda_data_model_array_new($c);

    $gda-data-model-array ?? self.bless( :$gda-data-model-array ) !! Nil;
  }

  method new_with_g_types (@cols) is also<new-with-g-types> {
    self.new_with_g_types_v( @cols.elems, ArrayToCArray(Int, @cols) );
  }

  method new_with_g_types_v (Int() $cols, CArray[GType] $types)
    is also<new-with-g-types-v>
  {
    my gint $c = $cols;

    my $gda-data-model-array = gda_data_model_array_new_with_g_types_v(
      $cols,
      $types
    );

    $gda-data-model-array ?? self.bless( :$gda-data-model-array ) !! Nil;
  }

  # Type: guint
  method n-columns is rw  is also<n_columns> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('n-columns', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('n-columns', $gv);
      }
    );
  }

  # Type: gboolean
  method read-only is rw  is also<read_only> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('read-only', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('read-only', $gv);
      }
    );
  }

  method clear {
    gda_data_model_array_clear($!gdma);
  }

  method copy_model (
    GDA::Data::Model::Array:U:

    GdaDataModel()           $src,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<copy-model>
  {
    clear_error;
    my $na = gda_data_model_array_copy_model($src, $error);
    set_error($error);

    propReturnObject($na, $raw, |self.getTypePair)
  }

  proto method copy_model_ext (|)
    is also<copy-model-ext>
  { * }

  multi method copy_model_ext (
    GDA::Data::Model::Array:U:

    GdaDataModel()          $src;
                            @cols,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith( $src, @cols.elems, ArrayToCArray(Int, @cols), $error );
  }
  multi method copy_model_ext (
    GDA::Data::Model::Array:U:

    GdaDataModel()           $src,
    Int()                    $ncols,
    CArray[gint]             $cols,
    CArray[Pointer[GError]]  $error  = gerror,
                            :$raw    = False
  ) {
    my gint $n = $ncols;

    clear_error;
    my $na = gda_data_model_array_copy_model_ext($src, $n, $cols, $error);
    set_error($error);

    propReturnObject($na, $raw, |self.getTypePair)
  }

  method get_row (
    Int()                    $row,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw = False
  )
    is also<get-row>
  {
    my gint $r = $row;

    clear_error;
    my $gr = gda_data_model_array_get_row($!gdma, $r, $error);
    set_error($error);

    propReturnObject($gr, $raw, |GDA::Row.getTypePair);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_model_array_get_type, $n, $t );
  }

  method set_n_columns (Int() $cols) is also<set-n-columns> {
    my gint $c = $cols;

    gda_data_model_array_set_n_columns($!gdma, $cols);
  }

}
