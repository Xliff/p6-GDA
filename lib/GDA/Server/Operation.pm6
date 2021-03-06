use v6.c;

use Method::Also;

use NativeCall;

use LibXML::Raw;
use LibXML::Node;

use GDA::Raw::Types;
use GDA::Raw::Server::Operation;

use GDA::Value;

use GLib::Roles::Object;
use GDA::Roles::Signals::Server::Operation;

our subset GdaServerOperationAncestry is export of Mu
  where GdaServerOperation | GObject;

class GDA::Server::Operation {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Server::Operation;

  has GdaServerOperation $!gso;

  submethod BUILD ( :$gda-server-operation ) {
    self.setGdaServerOperation($gda-server-operation) if $gda-server-operation;
  }

  method setGdaServerOperation (GdaServerOperationAncestry $_) {
    my $to-parent;
    $!gso = do {
      when GdaServerOperation {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaServerOperation, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Structs::GdaServerOperation
    is also<GdaServerOperation>
  { $!gso }

  multi method new (
    GdaServerOperationAncestry  $gda-server-operation,
                               :$ref                   = True
  ) {
    return Nil unless $gda-server-operation;

    my $o = self.bless( :$gda-server-operation );
    $o.ref if $ref;
    $o;
  }
  multi method new (Int() $type, Str() $xml_file) {
    my $gda-server-operation = gda_server_operation_new($type, $xml_file);

    $gda-server-operation ?? self.bless( :$gda-server-operation ) !! Nil;
  }

  # Is originally:
  # GdaServerOperation *op,  Str *seq_path,  gint item_index --> void
  method sequence-item-remove is also<sequence_item_remove> {
    self.connect-sequence($!gso, 'sequence-item-remove');
  }

  # Is originally:
  # GdaServerOperation *op,  Str *seq_path,  gint item_index --> void
  method sequence-item-added is also<sequence_item_added> {
    self.connect-sequence($!gso, 'sequence-item-added');
  }

  method add_item_to_sequence (Str() $seq_path) is also<add-item-to-sequence> {
    gda_server_operation_add_item_to_sequence($!gso, $seq_path);
  }

  method del_item_from_sequence (Str() $item_path) is also<del-item-from-sequence> {
    so gda_server_operation_del_item_from_sequence($!gso, $item_path);
  }

  method error_quark ( GDA::Server::Operation:U: ) is also<error-quark> {
    gda_server_operation_error_quark();
  }

  # cw: This is originally a var-arg call. We terminate it at the earliest
  #     possible argument.
  method get_node_info (Str() $path_format, :$raw = False) {
    propReturnObject(
      gda_server_operation_get_node_info($!gso, $path_format, Str),
      $raw,
      |::('GDA::Server::Operation::Node').getTypePair
    );
  }

  method get_node_parent (Str() $path) is also<get-node-parent> {
    gda_server_operation_get_node_parent($!gso, $path);
  }

  method get_node_path_portion (Str $path) is also<get-node-path-portion> {
    gda_server_operation_get_node_path_portion($!gso, $path);
  }

  method get_node_type (Str() $path, Int() $status) is also<get-node-type> {
    my GdaServerOperationNodeStatus $s = $status;

    GdaServerOperationNodeTypeEnum(
      gda_server_operation_get_node_type($!gso, $path, $status)
    );
  }

  method get_op_type is also<get-op-type> {
    GdaServerOperationTypeEnum(
      gda_server_operation_get_op_type($!gso)
    );
  }

  method get_root_nodes ( :$raw = False ) is also<get-root-nodes> {
    my $sa = gda_server_operation_get_root_nodes($!gso);

    $raw ?? $sa !! CArrayToArray($sa);
  }

  method get_sequence_item_names (Str() $path, :$raw = False) is also<get-sequence-item-names> {
    my $sa = gda_server_operation_get_sequence_item_names($!gso, $path);

    $raw ?? $sa !! CArrayToArray($sa);
  }

  method get_sequence_max_size (Str() $path) is also<get-sequence-max-size> {
    gda_server_operation_get_sequence_max_size($!gso, $path);
  }

  method get_sequence_min_size (Str() $path) is also<get-sequence-min-size> {
    gda_server_operation_get_sequence_min_size($!gso, $path);
  }

  method get_sequence_name (Str() $path) is also<get-sequence-name> {
    gda_server_operation_get_sequence_name($!gso, $path);
  }

  method get_sequence_size (Str() $path) is also<get-sequence-size> {
    gda_server_operation_get_sequence_size($!gso, $path);
  }

  method get_sql_identifier_at (
    GdaConnection()     $cnc,
    GdaServerProvider() $prov,
    Str()               $path_format
  )
    is also<get-sql-identifier-at>
  {
    gda_server_operation_get_sql_identifier_at($!gso, $cnc, $prov, $path_format);
  }

  method get_sql_identifier_at_path (
    GdaConnection()     $cnc,
    GdaServerProvider() $prov,
    Str()               $path
  )
    is also<get-sql-identifier-at-path>
  {
    gda_server_operation_get_sql_identifier_at_path($!gso, $cnc, $prov, $path);
  }

  method get_value_at (Str() $path_format, :$raw = False) is also<get-value-at> {
    propReturnObject(
      gda_server_operation_get_value_at($!gso, $path_format),
      $raw,
      |GDA::Value.getTypePair
    );
  }

  method get_value_at_path (Str() $path, :$raw = False) is also<get-value-at-path> {
    propReturnObject(
      gda_server_operation_get_value_at_path($!gso, $path),
      $raw,
      |GDA::Value.getTypePair
    );
  }

  method is_valid (Str() $xml_file, CArray[Pointer[GError]] $error = gerror) is also<is-valid> {
    clear_error;
    my $rv = so gda_server_operation_is_valid($!gso, $xml_file, $error);
    set_error($error);
    $rv;
  }

  method load_data_from_xml (
    anyNode()               $node,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-data-from-xml>
  {
    clear_error;
    my $rv = so gda_server_operation_load_data_from_xml($!gso, $node, $error);
    set_error($error);
    $rv;
  }

  method op_type_to_string (
    GDA::Server::Operation:U:

    Int() $op
  )
    is also<op-type-to-string>
  {
    my GdaServerOperationType $o = $op;

    gda_server_operation_op_type_to_string($o);
  }

  method perform_create_database (
    Str()                   $provider,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<perform-create-database>
  {
    clear_error;
    my $rv = so gda_server_operation_perform_create_database(
      $!gso,
      $provider,
      $error
    );
    set_error($error);
    $rv;
  }

  method perform_create_table (CArray[Pointer[GError]] $error = gerror) is also<perform-create-table> {
    clear_error;
    my $rv = so gda_server_operation_perform_create_table($!gso, $error);
    set_error($error);
    $rv;
  }

  method perform_drop_database (
    Str()                   $provider,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<perform-drop-database>
  {
    clear_error;
    my $rv = so gda_server_operation_perform_drop_database(
      $!gso,
      $provider,
      $error
    );
    set_error($error);
    $rv;
  }

  method perform_drop_table (CArray[Pointer[GError]] $error = gerror) is also<perform-drop-table> {
    clear_error;
    my $rv = so gda_server_operation_perform_drop_table($!gso, $error);
    set_error($error);
    $rv;
  }

  method prepare_create_database (
    Str()                   $db_name,
    CArray[Pointer[GError]] $error    = gerror
  )
    is also<prepare-create-database>
  {
    clear_error;
    my $rv = so gda_server_operation_prepare_create_database(
      $!gso,
      $db_name,
      $error
    );
    set_error($error);
    $rv;
  }

  method prepare_create_table (
    Str()                   $table_name,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<prepare-create-table>
  {
    clear_error
    my $rv = so gda_server_operation_prepare_create_table(
      $!gso,
      $table_name,
      $error
    );
    set_error($error);
    $rv;
  }

  method prepare_drop_database (
    Str()                   $db_name,
    CArray[Pointer[GError]] $error    = gerror
  )
    is also<prepare-drop-database>
  {
    clear_error;
    my $rv = so gda_server_operation_prepare_drop_database(
      $!gso,
      $db_name,
      $error
    );
    set_error($error);
    $rv;
  }

  method prepare_drop_table (
    Str()                   $table_name,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<prepare-drop-table>
  {
    clear_error;
    my $rv = so gda_server_operation_prepare_drop_table(
        $!gso,
      $table_name,
      $error
    );
    set_error($error);
    $rv;
  }

  method save_data_to_xml (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<save-data-to-xml>
  {
    clear_error;
    my $xn = so gda_server_operation_save_data_to_xml($!gso, $error);
    set_error($error);

    return Nil unless $xn;

    role xmlNodeDumper {
      method dump {
        my $buffer = xmlBuffer32.new;
        $buffer.NodeDump(xmlDoc, $xn, 0, 1);
        $buffer.Content;
      }
    }

    $raw ?? $xn
         !! LibXML::Node.box($xn) but xmlNodeDumper
  }

  # cw: Varargs are out-of-scope unless a workaround is determined.
  # method set_value_at (Str() $value, CArray[Pointer[GError]] $error, Str $path_format, ...) {
  #   gda_server_operation_set_value_at($!gso, $value, $error, $path_format);
  # }

  method set_value_at_path (
    Str()                   $value,
    Str()                   $path,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<set-value-at-path>
  {
    clear_error;
    my $rv = so gda_server_operation_set_value_at_path(
      $!gso,
      $value,
      $path,
      $error
    );
    set_error($error);
  }

  method string_to_op_type ( GDA::Server::Operation:U: Str() $op ) is also<string-to-op-type> {
    GdaServerOperationTypeEnum(
      gda_server_operation_string_to_op_type($op)
    );
  }

}
