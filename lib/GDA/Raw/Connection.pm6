use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Connection;

### /usr/include/libgda-5.0/libgda/gda-connection.h

sub gda_connection_add_savepoint (
  GdaConnection           $cnc,
  Str                     $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_async_cancel (
  GdaConnection           $cnc,
  guint                   $task_id,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_async_fetch_result (
  GdaConnection           $cnc,
  guint                   $task_id,
  CArray[GdaSet]          $last_insert_row,
  CArray[Pointer[GError]] $error
)
  returns GObject
  is native(gda)
  is export
{ * }

sub gda_connection_async_statement_execute (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  GdaSet                  $params,
  GdaStatementModelUsage  $model_usage,
  GType                   $col_types,
  gboolean                $need_last_insert_row,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(gda)
  is export
{ * }

sub gda_connection_batch_execute (
  GdaConnection           $cnc,
  GdaBatch                $batch,
  GdaSet                  $params,
  GdaStatementModelUsage  $model_usage,
  CArray[Pointer[GError]] $error
)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_connection_begin_transaction (
  GdaConnection           $cnc,
  Str                     $name,
  GdaTransactionIsolation $level,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_close (GdaConnection $cnc)
  is native(gda)
  is export
{ * }

sub gda_connection_close_no_warning (GdaConnection $cnc)
  is native(gda)
  is export
{ * }

sub gda_connection_commit_transaction (
  GdaConnection           $cnc,
  Str                     $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_create_operation (
  GdaConnection           $cnc,
  GdaServerOperationType  $type,
  GdaSet                  $options,
  CArray[Pointer[GError]] $error
)
  returns GdaServerOperation
  is native(gda)
  is export
{ * }

sub gda_connection_create_parser (GdaConnection $cnc)
  returns GdaSqlParser
  is native(gda)
  is export
{ * }

sub gda_connection_delete_row_from_table (
  GdaConnection           $cnc,
  Str                     $table,
  Str                     $condition_column_name,
  GValue                  $condition_value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_delete_savepoint (
  GdaConnection           $cnc,
  Str                     $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_connection_execute_non_select_command (
  GdaConnection           $cnc,
  Str                     $sql,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_connection_execute_select_command (
  GdaConnection           $cnc,
  Str                     $sql,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_connection_get_authentication (GdaConnection $cnc)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_get_cnc_string (GdaConnection $cnc)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_get_date_format (
  GdaConnection           $cnc,
  GDateDMY                $out_first,
  GDateDMY                $out_second,
  GDateDMY                $out_third,
  Str                     $out_sep,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_get_dsn (GdaConnection $cnc)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_get_events (GdaConnection $cnc)
  returns GList
  is native(gda)
  is export
{ * }

sub gda_connection_get_meta_store (GdaConnection $cnc)
  returns GdaMetaStore
  is native(gda)
  is export
{ * }

sub gda_connection_get_meta_store_data (
  GdaConnection           $cnc,
  GdaConnectionMetaType   $meta_type,
  CArray[Pointer[GError]] $error,
  gint                    $nb_filters
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_connection_get_meta_store_data_v (
  GdaConnection           $cnc,
  GdaConnectionMetaType   $meta_type,
  GList                   $filters,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_connection_get_options (GdaConnection $cnc)
  returns GdaConnectionOptions
  is native(gda)
  is export
{ * }

sub gda_connection_get_provider (GdaConnection $cnc)
  returns GdaServerProvider
  is native(gda)
  is export
{ * }

sub gda_connection_get_provider_name (GdaConnection $cnc)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_get_transaction_status (GdaConnection $cnc)
  returns GdaTransactionStatus
  is native(gda)
  is export
{ * }

sub gda_connection_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_connection_insert_row_into_table (
  GdaConnection           $cnc,
  Str                     $table,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_insert_row_into_table_v (
  GdaConnection           $cnc,
  Str                     $table,
  GSList                  $col_names,
  GSList                  $values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_is_opened (GdaConnection $cnc)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_new_from_dsn (
  Str                     $dsn,
  Str                     $auth_string,
  GdaConnectionOptions    $options,
  CArray[Pointer[GError]] $error
)
  returns GdaConnection
  is native(gda)
  is export
{ * }

sub gda_connection_new_from_string (
  Str                     $provider_name,
  Str                     $cnc_string,
  Str                     $auth_string,
  GdaConnectionOptions    $options,
  CArray[Pointer[GError]] $error
)
  returns GdaConnection
  is native(gda)
  is export
{ * }

sub gda_connection_open (GdaConnection $cnc, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_open_from_dsn (
  Str                     $dsn,
  Str                     $auth_string,
  GdaConnectionOptions    $options,
  CArray[Pointer[GError]] $error
)
  returns GdaConnection
  is native(gda)
  is export
{ * }

sub gda_connection_open_from_string (
  Str                     $provider_name,
  Str                     $cnc_string,
  Str                     $auth_string,
  GdaConnectionOptions    $options,
  CArray[Pointer[GError]] $error
)
  returns GdaConnection
  is native(gda)
  is export
{ * }

sub gda_connection_parse_sql_string (
  GdaConnection           $cnc,
  Str                     $sql,
  CArray[GdaSet]          $params,
  CArray[Pointer[GError]] $error
)
  returns GdaStatement
  is native(gda)
  is export
{ * }

sub gda_connection_perform_operation (
  GdaConnection           $cnc,
  GdaServerOperation      $op,
  CArray[Pointer[GError]] $error
  )
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_quote_sql_identifier (GdaConnection $cnc, Str $id)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_repetitive_statement_execute (
  GdaConnection           $cnc,
  GdaRepetitiveStatement  $rstmt,
  GdaStatementModelUsage  $model_usage,
  GType                   $col_types,
  gboolean                $stop_on_error,
  CArray[Pointer[GError]] $error
)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_connection_rollback_savepoint (
  GdaConnection           $cnc,
  Str                     $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_rollback_transaction (
  GdaConnection           $cnc,
  Str                     $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_statement_execute (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  GdaSet                  $params,
  GdaStatementModelUsage  $model_usage,
  CArray[GdaSet]          $last_insert_row,
  CArray[Pointer[GError]] $error
)
  returns GObject
  is native(gda)
  is export
{ * }

sub gda_connection_statement_execute_non_select (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  GdaSet                  $params,
  CArray[GdaSet]          $last_insert_row,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_connection_statement_execute_select (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  GdaSet                  $params,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_connection_statement_execute_select_full (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  GdaSet                  $params,
  GdaStatementModelUsage  $model_usage,
  GType                   $col_types,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_connection_statement_execute_select_fullv (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  GdaSet                  $params,
  GdaStatementModelUsage  $model_usage,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_connection_statement_prepare (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_statement_to_sql (
  GdaConnection           $cnc,
  GdaStatement            $stmt,
  GdaSet                  $params,
  GdaStatementSqlFlag     $flags,
  CArray[GSList]          $params_used,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_supports_feature (
  GdaConnection        $cnc,
  GdaConnectionFeature $feature
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_update_meta_store (
  GdaConnection           $cnc,
  GdaMetaContext          $context,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_update_row_in_table (
  GdaConnection           $cnc,
  Str                     $table,
  Str                     $condition_column_name,
  GValue                  $condition_value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_update_row_in_table_v (
  GdaConnection           $cnc,
  Str                     $table,
  Str                     $condition_column_name,
  GValue                  $condition_value,
  GSList                  $col_names,
  GSList                  $values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_connection_value_to_sql_string (GdaConnection $cnc, GValue $from)
  returns Str
  is native(gda)
  is export
{ * }
