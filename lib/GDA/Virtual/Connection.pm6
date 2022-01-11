use v6.c;

use NativeCall;

use GDA::Raw::Types;

use GDA::Connection;

our subset GdaVirtualConnectionAncestry is export of Mu
  where GdaVirtualConnection | GdaConnectionAncestry;

class GDA::Virtual::Connection is GDA::Connection {
  has GdaVirtualConnection $!gvc is implementor;

  method open (Int() $options, CArray[Pointer[GError]] $error = gerror) {
    my GdaConnectionOptions $o = $options;

    clear_error;
    my $gda-virtual-connection = gda_virtual_connection_open(
      $!gvc,
      $options,
      $error
    );
    set_error($error);

    $gda-virtual-connection ?? self.bless( :$gda-virtual-connection ) !! Nil;
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_virtual_connection_get_type, $n, $t );
  }

  method internal_get_provider_data {
    gda_virtual_connection_internal_get_provider_data($!gvc);
  }

  method internal_set_provider_data (
    gpointer       $data,
    GDestroyNotify $destroy_func = gpointer
  ) {
    gda_virtual_connection_internal_set_provider_data($!gvc, $data, $destroy_func);
  }


}


### /usr/src/libgda/libgda/sqlite/virtual/gda-virtual-connection.h

sub gda_virtual_connection_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_virtual_connection_internal_get_provider_data (GdaVirtualConnection $vcnc)
  returns Pointer
  is native(gda)
  is export
{ * }

sub gda_virtual_connection_internal_set_provider_data (
  GdaVirtualConnection $vcnc,
  gpointer             $data,
  GDestroyNotify       $destroy_func
)
  is native(gda)
  is export
{ * }

sub gda_virtual_connection_open (
  GdaVirtualProvider      $virtual_provider,
  GdaConnectionOptions    $options,
  CArray[Pointer[GError]] $error
)
  returns GdaVirtualConnection
  is native(gda)
  is export
{ * }
