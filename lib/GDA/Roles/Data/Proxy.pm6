use v6.c;

use NativeCall;

use GDA::Raw::Types;

role GDA::Roles::Signals::Data::Proxy {
  has %!signals-gdp;

  #  gint sample_start, gint sample_end --> void
  method connect-sample-changed (
    $obj,
    $signal = 'sample-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gdp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-sample-changed($obj, $signal,
        -> $, $g1, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g1, $g2] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdp{$signal}[0].tap(&handler) with &handler;
    %!signals-gdp{$signal}[0];
  }

  #  gint sample_size --> void
  method connect-sample-size-changed (
    $obj,
    $signal = 'sample-size-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gdp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-sample-size-changed($obj, $signal,
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
    %!signals-gdp{$signal}[0].tap(&handler) with &handler;
    %!signals-gdp{$signal}[0];
  }

  #  gint row, gboolean to_be_deleted --> void
  method connect-row-delete-changed (
    $obj,
    $signal = 'row-delete-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gdp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-row-delete-changed($obj, $signal,
        -> $, $g1, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g1, $g2] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdp{$signal}[0].tap(&handler) with &handler;
    %!signals-gdp{$signal}[0];
  }

  #  gint row, gint proxied_row --> GError *
  method connect-validate-row-changes (
    $obj,
    $signal = 'validate-row-changes',
    &handler?
  ) {
    my $hid;
    %!signals-gdp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-validate-row-changes($obj, $signal,
        -> $, $g1, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          my $r = ReturnedValue.new;
          𝒮.emit( [self, $g1, $g2, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdp{$signal}[0].tap(&handler) with &handler;
    %!signals-gdp{$signal}[0];
  }

  #  --> void
  method connect-filter-changed (
    $obj,
    $signal = 'filter-changed',
    &handler?
  ) {
    my $hid;
    %!signals-gdp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-filter-changed($obj, $signal,
        -> $ {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdp{$signal}[0].tap(&handler) with &handler;
    %!signals-gdp{$signal}[0];
  }

  #  gint row,  gint proxied_row --> void
  method connect-row-changes-applied (
    $obj,
    $signal = 'row-changes-applied',
    &handler?
  ) {
    my $hid;
    %!signals-gdp{$signal} //= do {
      my \𝒮 = Supplier.new;
      $hid = g-connect-row-changes-applied($obj, $signal,
        -> $, $g1, $g2 {
          CATCH {
            default { 𝒮.note($_) }
          }

          𝒮.emit( [self, $g1, $g2] );
        },
        Pointer, 0
      );
      [ 𝒮.Supply, $obj, $hid ];
    };
    %!signals-gdp{$signal}[0].tap(&handler) with &handler;
    %!signals-gdp{$signal}[0];
  }

}

# GdaDataProxy *proxy,  gint sample_start,  gint sample_end
sub g-connect-sample-changed (
  Pointer $app,
  Str     $name,
          &handler (GdaDataProxy, gint, gint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaDataProxy *proxy,  gint sample_size
sub g-connect-sample-size-changed (
  Pointer $app,
  Str     $name,
          &handler (GdaDataProxy, int),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaDataProxy *proxy,  gint row,  gboolean to_be_deleted
sub g-connect-row-delete-changed (
  Pointer $app,
  Str     $name,
          &handler (GdaDataProxy, int, gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaDataProxy *proxy, gint row, gint proxied_row --> GError *
sub g-connect-validate-row-changes (
  Pointer $app,
  Str     $name,
          &handler (GdaDataProxy, gint, gint --> GError),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaDataProxy *proxy
sub g-connect-filter-changed (
  Pointer $app,
  Str     $name,
          &handler (Pointer ),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }

# GdaDataProxy *proxy, gint row, gint proxied_row
sub g-connect-row-changes-applied (
  Pointer $app,
  Str     $name,
          &handler (Pointer, gint, gint),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native(gobject)
  is symbol('g_signal_connect_object')
{ * }
