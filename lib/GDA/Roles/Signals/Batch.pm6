use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Batch {
  has %!signals-gb;

  #  GdaBatch, GdaStatement *changed_stmt --> void
  method connect-changed (
    $obj,
    $signal = 'changed',
    &handler?
  ) {
    my $hid;
    %!signals-gb{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-changed($obj, $signal,
        -> $, $gs {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gs] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gb{$signal}[0].tap(&handler) with &handler;
    %!signals-gb{$signal}[0];
  }
  
}

# GdaBatch *batch,  GdaStatement *changed_stmt
sub g-connect-changed (
  Pointer $app,
  Str $name,
  &handler (Pointer,  GdaStatement),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
