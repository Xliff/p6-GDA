use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Server::Provider;

### /usr/include/libgda-5.0/libgda/gda-server-provider.h

sub gda_server_provider_create_operation (
  GdaServerProvider       $provider,
  GdaConnection           $cnc,
  GdaServerOperationType  $type,
  GdaSet                  $options,
  CArray[Pointer[GError]] $error
)
  returns GdaServerOperation
  is native(gda)
  is export
{ * }

sub gda_server_provider_create_parser (
  GdaServerProvider $provider,
  GdaConnection     $cnc
)
  returns GdaSqlParser
  is native(gda)
  is export
{ * }

sub gda_server_provider_escape_string (
  GdaServerProvider $provider,
  GdaConnection     $cnc,
  Str               $str
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_provider_get_data_handler_dbms (
  GdaServerProvider $provider,
  GdaConnection     $cnc,
  Str               $for_type
)
  returns GdaDataHandler
  is native(gda)
  is export
{ * }

sub gda_server_provider_get_data_handler_g_type (
  GdaServerProvider $provider,
  GdaConnection     $cnc,
  GType             $for_type
)
  returns GdaDataHandler
  is native(gda)
  is export
{ * }

sub gda_server_provider_get_default_dbms_type (
  GdaServerProvider $provider,
  GdaConnection     $cnc,
  GType             $type
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_provider_get_name (GdaServerProvider $provider)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_provider_get_server_version (
  GdaServerProvider $provider,
  GdaConnection     $cnc
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_provider_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_server_provider_get_version (GdaServerProvider $provider)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_provider_perform_operation (
  GdaServerProvider       $provider,
  GdaConnection           $cnc,
  GdaServerOperation      $op,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_provider_render_operation (
  GdaServerProvider       $provider,
  GdaConnection           $cnc,
  GdaServerOperation      $op,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_provider_string_to_value (
  GdaServerProvider $provider,
  GdaConnection     $cnc,
  Str               $string,
  GType             $preferred_type,
  CArray[Str]       $dbms_type
)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_server_provider_supports_feature (
  GdaServerProvider    $provider,
  GdaConnection        $cnc,
  GdaConnectionFeature $feature
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_provider_supports_operation (
  GdaServerProvider      $provider,
  GdaConnection          $cnc,
  GdaServerOperationType $type,
  GdaSet                 $options
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_provider_unescape_string (
  GdaServerProvider $provider,
  GdaConnection     $cnc,
  Str               $str
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_provider_value_to_sql_string (
  GdaServerProvider $provider,
  GdaConnection     $cnc,
  GValue            $from
)
  returns Str
  is native(gda)
  is export
{ * }
