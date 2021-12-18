use v6.c

use NativeCall;

use GLib::Raw::ReturnedValue;

use GDA::Raw::Types;

role GDA::Roles::Signals::Set {
  has %!signals-gs;

  #  GdaSet --> GError *
  method connect-validate-set (
    $obj,
    $signal = 'validate-set',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-validate-set($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

  #  GdaSet, GdaHolder holder,  Str attr_name,  GValue attr_value --> void
  method connect-holder-attr-changed (
    $obj,
    $signal = 'holder-attr-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-holder-attr-changed($obj, $signal,
        -> $, $gh, $s, $v {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gh, $s, $v] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

  #  GdaSet, GdaHolder holder --> void
  method connect-holder-type-set (
    $obj,
    $signal = 'holder-type-set',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-holder($obj, $signal,
        -> $, $gh {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gh] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

  #  GdaSet, GdaSetSource *source --> void
  method connect-source-model-changed (
    $obj,
    $signal = 'source-model-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-source-model-changed($obj, $signal,
        -> $, $gss {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gss] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

  #  GdaSet, GdaHolder *holder, GValue *new_value --> GError *
  method connect-validate-holder-change (
    $obj,
    $signal = 'validate-holder-change',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-validate-holder-change($obj, $signal,
        -> $, $gh, $v, $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $gh, $v, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

  #  GdaSet, GdaHolder holder --> void
  method connect-holder-changed (
    $obj,
    $signal = 'holder-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-holder($obj, $signal,
        -> $, $gh {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $gh] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gs{$signal}[0].tap(&handler) with &handler;
    %!signals-gs{$signal}[0];
  }

  #  GdaSet, --> void
  method connect-public-data-changed (
    $obj,
    $signal = 'public-data-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gs{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-public-data-changed($obj, $signal,
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

}

# GdaSet *set --> GError *
sub g-connect-validate-set (
  Pointer $app,
  Str     $name,
          &handler (Pointer --> GError),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaSet *set, GdaHolder *holder, Str attr_name, GValue *attr_value
sub g-connect-holder-attr-changed (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GdaHolder, Str, GValue),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaSet set, GdaSetSource source
sub g-connect-source-model-changed (
  Pointer $app,
  Str     $name,
          &handler (Pointer, GdaSetSource),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaSet set, GdaHolder holder, GValue new_value --> GError
sub g-connect-validate-holder-change (
  Pointer $app,
  Str     $name,
          &handler (GdaSet, GdaHolder, GValue --> GError),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaSet set, GdaHolder *holder
sub g-connect-holder (
  Pointer $app,
  Str     $name,
          &handler (GdaSet, GdaHolder),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaSet set
sub g-connect-public-data-changed (
  Pointer $app,
  Str     $name,
          &handler (GdaSet),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
