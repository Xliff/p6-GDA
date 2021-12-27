use v6.c;

use NativeCall;

use LibXML::Raw;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Server::Operation;

### /usr/include/libgda-5.0/libgda/gda-server-operation.h

sub gda_server_operation_add_item_to_sequence (
  GdaServerOperation $op,
  Str                $seq_path
)
  returns guint
  is native(gda)
  is export
{ * }

sub gda_server_operation_del_item_from_sequence (
  GdaServerOperation $op,
  Str                $item_path
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_node_info (
  GdaServerOperation $op,
  Str                $path_format
)
  returns GdaServerOperationNode
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_node_parent (
  GdaServerOperation $op,
  Str                $path
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_node_path_portion (
  GdaServerOperation $op,
  Str                $path
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_node_type (
  GdaServerOperation           $op,
  Str                          $path,
  GdaServerOperationNodeStatus $status
)
  returns GdaServerOperationNodeType
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_op_type (GdaServerOperation $op)
  returns GdaServerOperationType
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_root_nodes (GdaServerOperation $op)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_sequence_item_names (
  GdaServerOperation $op,
  Str                $path
  )
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_sequence_max_size (
  GdaServerOperation $op,
  Str                $path
  )
  returns guint
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_sequence_min_size (
  GdaServerOperation $op,
  Str                $path
  )
  returns guint
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_sequence_name (GdaServerOperation $op, Str $path)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_sequence_size (GdaServerOperation $op, Str $path)
  returns guint
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_sql_identifier_at (
  GdaServerOperation $op,
  GdaConnection      $cnc,
  GdaServerProvider  $prov,
  Str                $path_format
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_sql_identifier_at_path (
  GdaServerOperation $op,
  GdaConnection      $cnc,
  GdaServerProvider  $prov,
  Str                $path
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_value_at (
  GdaServerOperation $op,
  Str                $path_format
)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_server_operation_get_value_at_path (GdaServerOperation $op, Str $path)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_server_operation_is_valid (
  GdaServerOperation      $op,
  Str                     $xml_file,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_load_data_from_xml (
  GdaServerOperation      $op,
  anyNode                 $node,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_new (
  GdaServerOperationType $op_type,
  Str                    $xml_file
)
  returns GdaServerOperation
  is native(gda)
  is export
{ * }

sub gda_server_operation_op_type_to_string (GdaServerOperationType $type)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_server_operation_perform_create_database (
  GdaServerOperation      $op,
  Str                     $provider,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_perform_create_table (
  GdaServerOperation      $op,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_perform_drop_database (
  GdaServerOperation      $op,
  Str                     $provider,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_perform_drop_table (
  GdaServerOperation      $op,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_prepare_create_database (
  Str                     $provider,
  Str                     $db_name,
  CArray[Pointer[GError]] $error
)
  returns GdaServerOperation
  is native(gda)
  is export
{ * }

sub gda_server_operation_prepare_create_table (
  GdaConnection           $cnc,
  Str                     $table_name,
  CArray[Pointer[GError]] $error
)
  returns GdaServerOperation
  is native(gda)
  is export
{ * }

sub gda_server_operation_prepare_drop_database (
  Str                     $provider,
  Str                     $db_name,
  CArray[Pointer[GError]] $error
)
  returns GdaServerOperation
  is native(gda)
  is export
{ * }

sub gda_server_operation_prepare_drop_table (
  GdaConnection           $cnc,
  Str                     $table_name,
  CArray[Pointer[GError]] $error
)
  returns GdaServerOperation
  is native(gda)
  is export
{ * }

sub gda_server_operation_save_data_to_xml (
  GdaServerOperation      $op,
  CArray[Pointer[GError]] $error
)
  returns anyNode
  is native(gda)
  is export
{ * }

sub gda_server_operation_set_value_at (
  GdaServerOperation      $op,
  Str                     $value,
  CArray[Pointer[GError]] $error,
  Str                     $path_format
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_set_value_at_path (
  GdaServerOperation      $op,
  Str                     $value,
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_server_operation_string_to_op_type (Str $str)
  returns GdaServerOperationType
  is native(gda)
  is export
{ * }
