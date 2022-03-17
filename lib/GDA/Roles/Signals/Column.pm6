use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Column {
  has %!signals-gc;

  # GdaColumn, GType, GType, gpointer
  method connect-g-type-changed (
    $obj,
    $signal = 'g-type-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gc{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-g-type-changed($obj, $signal,
        -> $, $t1, $t2, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $t1, $t2, $ud ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gc{$signal}[0].tap(&handler) with &handler;
    %!signals-gc{$signal}[0];
  }

}

# GdaColumn, GType, GType, gpointer
sub g-connect-g-type-changed(
  Pointer $app,
  Str $name,
  &handler (Pointer, GType, GType, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
