use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Virtual::Connection::Data::Model {
  has %!signals-gvdm;

  # GdaVconnectionDataModel *cnc,  Str *table_name
  method connect-vtable (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gvdm{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-vtable($obj, $signal,
        -> $, $s {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $s ] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gvdm{$signal}[0].tap(&handler) with &handler;
    %!signals-gvdm{$signal}[0];
  }

}

# GdaVconnectionDataModel *cnc,  Str *table_name
sub g-connect-vtable (
  Pointer $app,
  Str     $name,
          &handler (GdaVconnectionDataModel, Str),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
