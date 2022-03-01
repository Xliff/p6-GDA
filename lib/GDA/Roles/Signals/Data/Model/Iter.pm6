use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Data::Model::Iter {
  has %!signals-gdmi;

  # GdaDataModelIter, gint row --> void
  method connect-row-changed (
    $obj,
    $signal = 'row-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gdmi{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-row-changed($obj, $signal,
        -> $, $g {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdmi{$signal}[0].tap(&handler) with &handler;
    %!signals-gdmi{$signal}[0];
  }

  # GdaDataModelIter --> void
  method connect-end-of-data (
    $obj,
    $signal = 'end-of-data',
    &handler?
  ) {
    my $hid;
    %!signals-gdmi{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-end-of-data($obj, $signal,
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
    %!signals-gdmi{$signal}[0].tap(&handler) with &handler;
    %!signals-gdmi{$signal}[0];
  }

}

# GdaDataModelIter *iter,  gint row
sub g-connect-row-changed (
  Pointer $app,
  Str     $name,
          &handler (GdaDataModelIter, gint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaDataModelIter *iter
sub g-connect-end-of-data (
  Pointer $app,
  Str     $name,
          &handler (GdaDataModelIter),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
