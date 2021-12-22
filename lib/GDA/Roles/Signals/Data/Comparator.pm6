use v6.c;

use NativeCall;

role GDA::Roles::Signals::Data::Comparator {
  has %!signals-gdc;

  # GdaDataComparator, gpointer, gpointer --> gboolean
  method connect-diff-computed (
    $obj,
    $signal = 'diff-computed',
    &handler?
  ) {
    my $hid;
    %!signals-gdc{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-diff-computed($obj, $signal,
        -> $, $p, $ud {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $p, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdc{$signal}[0].tap(&handler) with &handler;
    %!signals-gdc{$signal}[0];
  }

}

# GdaDataComparator, gpointer, gpointer --> gboolean
sub g-connect-diff-computed (
  Pointer $app,
  Str     $name,
          &handler (GDataComparator, Pointer, Pointer --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
