use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;

use GDA::Raw::Types;

role GDA::Roles::Signals::Holder {
  has %!signals-gh;

  # GdaHolder
  method connect-holder (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gh{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-holder($obj, $signal,
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
    %!signals-gh{$signal}[0].tap(&handler) with &handler;
    %!signals-gh{$signal}[0];
  }

  #  GValue *new_value --> GError *
  method connect-validate-change (
    $obj,
    $signal = 'validate-change',
    &handler?
  ) {
    my $hid;
    %!signals-gh{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-validate-change($obj, $signal,
        -> $, $v {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $v, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gh{$signal}[0].tap(&handler) with &handler;
    %!signals-gh{$signal}[0];
  }

}

# GdaHolder *holder
sub g-connect-holder (
  Pointer $app,
  Str     $name,
          &handler (GdaHolder),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaHolder *holder, GValue *new_value --> GError *
sub g-connect-validate-change (
  Pointer $app,
  Str     $name,
          &handler (GdaHolder, GValue --> GError),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
