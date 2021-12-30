use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Tree::Node {
  has %!signals-gtn;

  method connect-node (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gtn{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-node($obj, $signal,
        -> $, $tn, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $tn, $ud] );
        },        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gtn{$signal}[0].tap(&handler) with &handler;
    %!signals-gtn{$signal}[0];
  }

}

# GdaTreeNode, GdaTreeNode, gpointer
sub g-connect-node (
  Pointer $app,
  Str     $name,
          &handler (GdaTreeNode, GdaTreeNode, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
