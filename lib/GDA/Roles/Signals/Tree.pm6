use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Tree {
  has %!signals-gt;

  # GtaTree, GtaTreeNode, gpointer
  method connect-tree-node (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gt{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-tree-node($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, GdaTreeNode, gpointer] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gt{$signal}[0].tap(&handler) with &handler;
    %!signals-gt{$signal}[0];
  }

}

# GdaTree, GdaTreeNode, gpointer
sub g-connect-tree-node (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GdaTreeNode, gpointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
