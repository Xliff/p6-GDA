use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Server::Operation {
  has %!signals-gso;

  #  Str *seq_path, gint item_index --> void
  method connect-sequence (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gso{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-sequence($obj, $signal,
        -> $, $s, $g {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $s, $g] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gso{$signal}[0].tap(&handler) with &handler;
    %!signals-gso{$signal}[0];
  }

}


# GdaServerOperation *op,  Str *seq_path,  gint item_index
sub g-connect-sequence (
  Pointer $app,
  Str $name,
  &handler (GdaServerOperation, Str, gint),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
