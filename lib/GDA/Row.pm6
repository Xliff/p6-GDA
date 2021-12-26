use v6.c;

use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Row;

use GLib::Roles::Object;

our subset GdaRowAncestry is export of Mu
  where GdaRow | GObject;

class GDA::Row {
  also does GLib::Roles::Object;

  has GdaRow $!gr;

  submethod BUILD ( :$gda-row ) {
    self.setGdaRow($gda-row)
      if $gda-row;
  }

  method setGdaRow (GdaRowAncestry $_) {
    my $to-parent;
    $!gr = do {
      when GdaRow {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaRow, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaRow
    is also<GdaRow>
  { $!gr }

  multi method new (GdaRowAncestry  $gda-row,
                                   :$ref      = True
  ) {
    return Nil unless $gda-row;

    my $o = self.bless( :$gda-row );
    $o.ref if $ref;
    $o;
  }

  multi method new (Int() $count) {
    my gint $c       = $count;
    my      $gda-row = gda_row_new($c);

    $gda-row ?? self.bless( :$gda-row ) !! Nil;
  }

  method get_length is also<get-length> {
    gda_row_get_length($!gr);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_row_get_type, $n, $t );
  }

  method get_value (Int() $num, :$raw = False) is also<get-value> {
    my gint $n = $num;

    propReturnObject(
      gda_row_get_value($!gr, $n),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method invalidate_value (GValue() $value) is also<invalidate-value> {
    gda_row_invalidate_value($!gr, $value);
  }

  method invalidate_value_e (
    GValue() $value,
    GError   $error  = gerror
  )
    is also<invalidate-value-e>
  {
    gda_row_invalidate_value_e($!gr, $value, $error);
  }

  method value_is_valid (GValue() $value) is also<value-is-valid> {
    gda_row_value_is_valid($!gr, $value);
  }

  method value_is_valid_e (GValue() $value, GError $error)
    is also<value-is-valid-e>
  {
    gda_row_value_is_valid_e($!gr, $value, $error);
  }

}
