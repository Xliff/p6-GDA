use v6.c;

use NativeCall;

use GDA::Raw::Types;

use GLib::Roles::Signals::Generic;

role GDA::Roles::Signals::Meta::Store {
  also does GLib::Roles::Signals::Generic;

  has %!signals-gms;

  # GdaMetaStore, gpointer
  method connect-meta-reset (
    $obj,
    $signal = 'meta-reset',
    &handler?
  ) {
    my $hid;
    %!signals-gms{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-meta-reset($obj, $signal,
        -> $, $p {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $p] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gms{$signal}[0].tap(&handler) with &handler;
    %!signals-gms{$signal}[0];
  }

}

# GdaMetaStore, gpointer
sub g-connect-meta-reset (
  Pointer $app,
  Str     $name,
          &handler (GdaMetaStore, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
