use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Data::Pivot;

use GLib::Roles::Object;

our subset GdaDataPivotAncestry is export of Mu
  where GdaDataPivot | GObject;

class GDA::Data::Pivot {
  also does GLib::Roles::Object;

  has GdaDataPivot $!gdp;

  submethod BUILD ( :$gda-data-pivot ) {
    self.setGdaDataPivot($gda-data-pivot) if $gda-data-pivot;
  }

  method setGdaDataPivot (GdaDataPivotAncestry $_) {
    my $to-parent;
    $!gdp = do {
      when GdaDataPivot {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataPivot, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaDataPivot
    is also<GdaDataPivot>
  { $!gdp }

  multi method new (GdaDataPivotAncestry $gda-data-pivot, :$ref = True) {
    return Nil unless $gda-data-pivot;

    my $o = self.bless( :$gda-data-pivot );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaDataModel() $model = GdaDataModel) {
    my $gda-data-pivot = gda_data_pivot_new($model);

    $gda-data-pivot ?? self.bless( :$gda-data-pivot ) !! Nil;
  }

  # Type: GdaDataModel
  method model ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Data::Model.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('model', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Model.getTypePair
        );
      },
      STORE => -> $, GdaDataModel() $val is copy {
        $gv.object = $val;
        self.prop_set('model', $gv);
      }
    );
  }

  method add_data (
    Int()                   $aggregate_type,
    Str()                   $field,
    Str()                   $alias,
    CArray[Pointer[GError]] $error           = gerror
  )
    is also<add-data>
  {
    my GdaDataPivotAggregate $a = $aggregate_type;

    clear_error;
    my $rv = so gda_data_pivot_add_data($!gdp, $a, $field, $alias, $error);
    set_error($error);
    $rv;
  }

  method add_field (
    Int()                   $field_type,
    Str()                   $field,
    Str()                   $alias,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<add-field>
  {
    my GdaDataPivotFieldType $f = $field_type;

    clear_error;
    my $rv = so gda_data_pivot_add_field(
      $!gdp,
      $field_type,
      $field,
      $alias,
      $error
    );
    set_error($error);
    $rv;
  }

  method error_quark (GDA::Data::Pivot:U: ) is also<error-quark> {
    gda_data_pivot_error_quark();
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_pivot_get_type, $n, $t );
  }

  method populate (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so gda_data_pivot_populate($!gdp, $error);
    set_error($error);
    $rv;
  }

}
