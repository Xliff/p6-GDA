use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Server::Provider;

use GDA::Server::Operation;

use GLib::Roles::Object;

our subset GdaServerProviderAncestry is export of Mu
  where GdaServerProvider | GObject;

class GDA::Server::Provider {
  also does GLib::Roles::Object;

  has GdaServerProvider $!gsp;

  submethod BUILD ( :$gda-server-provider ) {
    self.setGdaServerProvider($gda-server-provider) if $gda-server-provider;
  }

  method setGdaServerProvider (GdaServerProviderAncestry $_) {
    my $to-parent;
    $!gsp = do {
      when GdaServerProvider {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaServerProvider, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaServerProvider
    is also<GdaServerProvider>
  { $!gsp }

  multi method new (GdaServerProviderAncestry  $gda-server-provider,
                                              :$ref                  = True
  ) {
    return Nil unless $gda-server-provider;

    my $o = self.bless( :$gda-server-provider );
    $o.ref if $ref;
    $o;
  }

  proto method create_operation (|)
    is also<create-operation>
  { * }

  multi method create_operation (
    Int()                    $type,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False,
    GdaConnection()         :$cnc     = GdaConnection,
    GdaSet()                :$options = GdaSet
  ) {
    samewith($cnc, $type, $options, $error, :$raw);
  }
  multi method create_operation (
    GdaConnection()          $cnc,
    Int()                    $type,
    GdaSet()                 $options,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$raw      = False
  )

  {
    my GdaServerOperationType  $t = $type;

    clear_error;
    my $o = gda_server_provider_create_operation(
      $!gsp,
      $cnc,
      $t,
      $options,
      $error
    );
    set_error($error);

    propReturnObject( $o, $raw, |GDA::Server::Operation.getTypePair )
  }

  method create_parser (GdaConnection() $cnc, :$raw = False) is also<create-parser> {
    propReturnObject(
      gda_server_provider_create_parser($!gsp, $cnc),
      $raw,
      |GDA::SQL::Parser.getTypePair
    );
  }

  method escape_string (GdaConnection() $cnc, Str() $str) is also<escape-string> {
    gda_server_provider_escape_string($!gsp, $cnc, $str);
  }

  method get_data_handler_dbms (
    GdaConnection()  $cnc,
    Str()            $for_type,
                    :$raw = False
  )
    is also<get-data-handler-dbms>
  {
    propReturnObject(
      gda_server_provider_get_data_handler_dbms($!gsp, $cnc, $for_type),
      $raw,
      |GDA::Data::Handler.getTypePair
    );
  }

  method get_data_handler_g_type (
    GdaConnection()  $cnc,
    Int()            $for_type,
                    :$raw       = False
  )
    is also<get-data-handler-g-type>
  {
    my GType $f = $for_type;

    propReturnObject(
      gda_server_provider_get_data_handler_g_type($!gsp, $cnc, $f),
      $raw,
      |GDA::Data::Handler.getTypePair
    );
  }

  method get_default_dbms_type (
    GdaConnection()  $cnc,
    Int()            $type,
                    :$raw = False
  )
    is also<get-default-dbms-type>
  {
    my GType $t = $type;

    propReturnObject(
      gda_server_provider_get_default_dbms_type($!gsp, $cnc, $type),
      $raw,
      |GDA::Data::Handler.getTypePair
    );
  }

  method get_name is also<get-name> {
    gda_server_provider_get_name($!gsp);
  }

  method get_server_version (GdaConnection() $cnc) is also<get-server-version> {
    gda_server_provider_get_server_version($!gsp, $cnc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_server_provider_get_type, $n, $t );
  }

  method get_version is also<get-version> {
    gda_server_provider_get_version($!gsp);
  }

  method perform_operation (
    GdaConnection()         $cnc,
    Int()                   $op,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<perform-operation>
  {
    my GdaServerOperation $o = $op;

    clear_error;
    my $rv = so gda_server_provider_perform_operation($!gsp, $cnc, $op, $error);
    set_error($error);
    $rv;
  }

  proto method render_operation (|)
  { * }

  multi method render_operation (
    Int()                    $op,
    CArray[Pointer[GError]]  $error = gerror,
    GdaConnection()         :$cnc   = GdaConnection,
  ) {
    samewith($cnc, $op, $error);
  }
  multi method render_operation (
    GdaConnection()         $cnc,
    Int()                   $op,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<render-operation>
  {
    my GdaServerOperation $o = $op;

    clear_error;
    my $rv = so gda_server_provider_render_operation($!gsp, $cnc, $op, $error);
    set_error($error);
    $rv;
  }

  proto method string_to_value (|)
    is also<string-to-value>
  { * }

  multi method string_to_value (
    Str()            $string,
    Int()            $preferred_type    = G_TYPE_INVALID,
    GdaConnection() :connection(:$cnc)  = GdaConnection,
    CArray[Str]     :$dbms_type         = CArray[Str],
                    :$raw               = False
  ) {
    samewith($cnc, $string, $preferred_type, $dbms_type, :$raw);
  }
  multi method string_to_value (
    GdaConnection()  $cnc,
    Str()            $string,
    Int()            $preferred_type,
    CArray[Str]      $dbms_type,
                    :$raw             = False
  ) {
    my GType $p = $preferred_type;

    propReturnObject(
      gda_server_provider_string_to_value($!gsp, $cnc, $string, $p, $dbms_type),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method supports_feature (GdaConnection() $cnc, Int() $feature) is also<supports-feature> {
    my GdaConnectionFeature $f = $feature;

    so gda_server_provider_supports_feature($!gsp, $cnc, $feature);
  }

  proto method supports_operation (|)
    is also<supports-operation>
  { * }

  multi method supports_operation (
    Int()            $type,
    GdaConnection() :$cnc     = GdaConnection,
    GdaSet()        :$options = GdaSet
  ) {
    samewith($cnc, $type, $options);
  }
  multi method supports_operation (
    GdaConnection() $cnc,
    Int()           $type,
    GdaSet()        $options
  )
  {
    my GdaServerOperationType $t = $type;

    so gda_server_provider_supports_operation($!gsp, $cnc, $t, $options);
  }

  method unescape_string (GdaConnection() $cnc, Str() $str) is also<unescape-string> {
    gda_server_provider_unescape_string($!gsp, $cnc, $str);
  }

  method value_to_sql_string (GdaConnection() $cnc, GValue() $from) is also<value-to-sql-string> {
    gda_server_provider_value_to_sql_string($!gsp, $cnc, $from);
  }

}
