use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Data::Model {
  has %!signals-gdm;

  #  GdaModelRow
  method connect-model (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gdm{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-model($obj, $signal,
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
    %!signals-gdm{$signal}[0].tap(&handler) with &handler;
    %!signals-gdm{$signal}[0];
  }


  # GdaModelRow, gint
  method connect-row (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gdm{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-model-row($obj, $signal,
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
    %!signals-gdm{$signal}[0].tap(&handler) with &handler;
    %!signals-gdm{$signal}[0];
  }

}

# GdaDataModel *model
sub g-connect-model (
  Pointer $app,
  Str     $name,
          &handler (Pointer ),
  Pointer $data,
  uint32  $flagsS
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaDataModel *model,  gint row
sub g-connect-model-row (
  Pointer $app,
  Str     $name,
          &handler (GdaDataModel, gint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
