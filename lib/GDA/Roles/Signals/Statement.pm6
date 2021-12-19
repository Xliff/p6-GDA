use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Statement {
  has %!signals-gs;

  #  GdaStatement --> void
  method connect-reset (
    $obj,
    $signal = 'reset',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-reset($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( self );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

  #  GdaStatement, GdaConnection *cnc, gboolean checked --> void
  method connect-checked (
    $obj,
    $signal = 'checked',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-checked($obj, $signal,
        -> $, $gc, $g {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gc, $g] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

}

# GdaStatement *stmt
sub g-connect-reset (
  Pointer $app,
  Str $name,
  &handler (GdaStatement),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaStatement *stmt,  GdaConnection *cnc,  gboolean checked
sub g-connect-checked (
  Pointer $app,
  Str $name,
  &handler (GdaStatement, GdaConnection, gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
