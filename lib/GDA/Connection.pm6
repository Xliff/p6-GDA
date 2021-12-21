use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Connection;

use GLib::GList;
use GLib::GSList;
use GLib::Value;
# use GDA::Connection::Event;
use GDA::Holder;
# use GDA::Meta::Store;
use GDA::Set;
# use GDA::Service::Provider;
use GDA::SQL::Parser;
use GDA::Statement;
# use GDA::TransactionStatus;

use GLib::Roles::Object;
use GDA::Roles::Data::Model;

our subset GdaConnectionAncestry is export of Mu
  where GdaConnection | GObject;

class GDA::Connection {
  also does GLib::Roles::Object;

  has GdaConnection $!gc is implementor;

  submethod BUILD ( :$gda-connection ) {
    self.setGdaConnection( $gda-connection ) if $gda-connection;
  }

  method setGdaConnection (GdaConnectionAncestry $_) {
    my $to-parent;

    $!gc = do {
      when GdaConnection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaConnection, $_);
      }
    }
    self!setObject($to-parent)
  }

  method GDA::Raw::Definitions::GdaConnection
  { $!gc }

  multi method new (GdaConnectionAncestry $gda-connection, :$ref = True) {
    return Nil unless $gda-connection;

    my $o = self.bless( :$gda-connection );
    $o.ref if $ref;
    $o
  }
  multi method new {
    self.open;
  }

  method new_from_dsn (
    Str()                   $dsn,
    Str()                   $auth_string,
    Int()                   $options,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<new-from-dsn>
  {
    my GdaConnectionOptions $o = $options;

    clear_error;
    my $gda-connection = gda_connection_new_from_dsn(
      $dsn,
      $auth_string,
      $o,
      $error
    );
    set_error($error);

    $gda-connection ?? self.bless( :$gda-connection ) !! Nil;
  }

  proto method new_from_string (|)
    is also<new-from-string>
  { * }

  multi method new_from_string (
    Str()                   $provider_name,
    Str()                   $cnc_string,
    CArray[Pointer[GError]] $error          = gerror,
    Str()                   :$auth_string   = Str,
    Int()                   :$options       = GDA_CONNECTION_OPTIONS_NONE
  ) {
    samewith(
      $provider_name,
      $cnc_string,
      $auth_string,
      $options,
      $error
    );
  }
  multi method new_from_string (
    Str()                   $provider_name,
    Str()                   $cnc_string,
    Str()                   $auth_string,
    Int()                   $options,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    my GdaConnectionOptions $o = $options;

    clear_error;
    my $gda-connection = gda_connection_new_from_string(
      $provider_name,
      $cnc_string,
      $auth_string,
      $options,
      $error
    );
    set_error($error);

    $gda-connection ?? self.bless( :$gda-connection ) !! Nil;
  }

  method open (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $gda-connection = gda_connection_open($!gc, $error);
    set_error($error);

    $gda-connection ?? self.bless( :$gda-connection ) !! Nil;
  }

  method open_from_dsn (
    Str()                   $dsn,
    Str()                   $auth_string,
    Int()                   $options,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<open-from-dsn>
  {
    my GdaConnectionOptions $o = $options;

    clear_error;
    my $gda-connection = gda_connection_open_from_dsn(
      $dsn,
      $auth_string,
      $o,
      $error
    );
    set_error($error);

    $gda-connection ?? self.bless( :$gda-connection ) !! Nil;
  }

  proto method open_from_string (|)
    is also<open-from-string>
  { *}

  multi method open_from_string (
    Str()                    $provider_name,
    Str()                    $cnc_string,
    CArray[Pointer[GError]]  $error          = gerror,
    Str()                   :$auth_string    = Str,
    Int()                   :$options        = GDA_CONNECTION_OPTIONS_NONE
  ) {
    samewith($provider_name, $cnc_string, $auth_string, $options, $error);
  }
  multi method open_from_string (
    Str()                   $provider_name,
    Str()                   $cnc_string,
    Str()                   $auth_string,
    Int()                   $options,
    CArray[Pointer[GError]] $error        = gerror
  )

  {
    my GdaConnectionOptions $o = $options;

    clear_error;
    my $gda-connection = gda_connection_open_from_string(
      $provider_name,
      $cnc_string,
      $auth_string,
      $o,
      $error
    );
    set_error($error);

    $gda-connection ?? self.bless( :$gda-connection ) !! Nil;
  }

  # Type: gchar
  method auth-string is rw  is also<auth_string> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('auth-string', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('auth-string', $gv);
      }
    );
  }

  # Type: gchar
  method cnc-string is rw  is also<cnc_string> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('cnc-string', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('cnc-string', $gv);
      }
    );
  }

  # Type: gchar
  method dsn is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('dsn', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('dsn', $gv);
      }
    );
  }

  # Type: gint
  method events-history-size is rw  is also<events_history_size> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('events-history-size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('events-history-size', $gv);
      }
    );
  }

  # Type: guint
  method execution-slowdown is rw  is also<execution_slowdown> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('execution-slowdown', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('execution-slowdown', $gv);
      }
    );
  }

  # Type: gboolean
  method execution-timer is rw  is also<execution_timer> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('execution-timer', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('execution-timer', $gv);
      }
    );
  }

  # Type: GdaMetaStore
  method meta-store ( :$raw = False ) is rw  is also<meta_store> {
    my $gv = GLib::Value.new( GDA::Meta::Store.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('meta-store', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          |GDA::MetaStore.getTypePair
        );
      },
      STORE => -> $, GdaMetaStore() $val is copy {
        $gv.object = $val;
        self.prop_set('meta-store', $gv);
      }
    );
  }

  # Type: GdaConnectionOptions
  method options is rw  {
    my $gv = GLib::Value.new( typeToGType(GdaConnectionOptions) );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('options', $gv)
        );

        getFlags(
          GdaConnectionOptionsEnum,
          $gv.valueFromEnum(GdaConnectionOptions)
        );
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdaConnectionOptions) = $val;
        self.prop_set('options', $gv);
      }
    );
  }

  # Type: GdaServerProvider
  method provider ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::ServerProvider.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('provider', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          |GDA::ServerProvider.getTypePair
        );
      },
      STORE => -> $, GdaServerProvider() $val is copy {
        $gv.object = $val;
        self.prop_set('provider', $gv);
      }
    );
  }

  # Is originally:
  # GdaConnection, gpointer --> void
  method closed {
    self.connect($!gc, 'closed');
  }

  # Is originally:
  # GdaConnection, gpointer --> void
  method dsn-changed is also<dsn_changed> {
    self.connect($!gc, 'dsn-changed');
  }

  # Is originally:
  # GdaConnection, GdaConnectionEvent, gpointer --> void
  method error {
    self.connect-uint($!gc, 'error');
  }

  # Is originally:
  # GdaConnection, gpointer --> void
  method opened {
    self.connect($!gc, 'opened');
  }

  # Is originally:
  # GdaConnection, GdaConnectionStatus, gpointer --> void
  method status-changed is also<status_changed> {
    self.connect-uint($!gc, 'status-changed');
  }

  # Is originally:
  # GdaConnection, gpointer --> void
  method transaction-status-changed is also<transaction_status_changed> {
    self.connect($!gc, 'transaction-status-changed');
  }

  method add_savepoint (Str() $name, CArray[Pointer[GError]] $error = gerror)
    is also<add-savepoint>
  {
    clear_error;
    my $rv = so gda_connection_add_savepoint($!gc, $name, $error);
    set_error($error);
    $rv;
  }

  method async_cancel (Int() $task_id, CArray[Pointer[GError]] $error)
    is also<async-cancel>
  {
    my guint $t = $task_id;

    clear_error;
    my $rv = so gda_connection_async_cancel($!gc, $t, $error);
    set_error($error);
    $rv;
  }

  method async_fetch_result (
    Int()                   $task_id,
    CArray[GdaSet]          $last_insert_row,
    CArray[Pointer[GError]] $error            = gerror
  )
    is also<async-fetch-result>
  {
    my guint $t = $task_id;

    clear_error;
    my $rv = so gda_connection_async_fetch_result(
      $!gc,
      $task_id,
      $last_insert_row,
      $error
    );
    set_error($error);
    $rv;
  }

  method async_statement_execute (
    GdaStatement()          $stmt,
    GdaSet()                $params,
    Int()                   $model_usage,
    Int()                   $need_last_insert_row,
    Int()                   $col_types,
    CArray[Pointer[GError]] $error                 = gerror
  )
    is also<async-statement-execute>
  {
    my GdaStatementModelUsage $m = $model_usage;
    my GType                  $c = $col_types;
    my gboolean               $n = $need_last_insert_row.so.Int;

    clear_error;
    my $rv = so gda_connection_async_statement_execute(
      $!gc,
      $stmt,
      $params,
      $m,
      $c,
      $need_last_insert_row,
      $error
    );
    set_error($error);
    $rv;
  }

  method batch_execute (
    GdaBatch()               $batch,
    GdaSet()                 $params,
    Int()                    $model_usage,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$raw          = False,
                            :$glist        = False
  )
    is also<batch-execute>
  {
    my GdaStatementModelUsage $m = $model_usage;

    clear_error;
    my $rl = so gda_connection_batch_execute($!gc, $batch, $params, $m, $error);
    set_error($error);

    returnGList($rl, $raw, $glist, |GLib::Object.getTypePair);
  }

  method begin_transaction (
    Str()                   $name,
    Int()                   $level,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<begin-transaction>
  {
    my GdaTransactionIsolation $l = $level;

    clear_error;
    my $rv = so gda_connection_begin_transaction($!gc, $name, $l, $error);
    set_error($error);
    $rv;
  }

  method close {
    so gda_connection_close($!gc);
  }

  method close_no_warning is also<close-no-warning> {
    so gda_connection_close_no_warning($!gc);
  }

  method commit_transaction (
    Str()                   $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<commit-transaction>
  {
    clear_error;
    my $rv = so gda_connection_commit_transaction($!gc, $name, $error);
    set_error($error);
    $rv;
  }

  method create_operation (
    Int()                    $type,
    GdaSet()                 $options,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$raw      = False
  )
    is also<create-operation>
  {
    my GdaServerOperationType $t = $type;

    set_error($error);
    my $o = so gda_connection_create_operation($!gc, $t, $options, $error);
    set_error($error);

    propReturnObject($o, $raw, |GDA::ServerOperation.getTypePair);
  }

  method create_parser ( :$raw = False ) is also<create-parser> {
    propReturnObject(
      gda_connection_create_parser($!gc),
      $raw,
      |GDA::SQL::Parser.getTypePair
    );
  }

  method delete_row_from_table (
    Str()                   $table,
    Str()                   $condition_column_name,
    GValue()                $condition_value        = GValue,
    CArray[Pointer[GError]] $error                  = gerror
  )
    is also<delete-row-from-table>
  {
    clear_error;
    my $rv = so gda_connection_delete_row_from_table(
      $!gc,
      $table,
      $condition_column_name,
      $condition_value,
      $error
    );
    set_error($error);
    $rv;
  }

  method delete_savepoint (
    Str()                   $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<delete-savepoint>
  {
    clear_error;
    my $rv = so gda_connection_delete_savepoint($!gc, $name, $error);
    set_error($error);
    $rv;
  }

  method error_quark (GDA::Connection:U: ) is also<error-quark> {
    gda_connection_error_quark();
  }

  method execute_non_select_command (
    Str()                   $sql,
    CArray[Pointer[GError]] $error = gerror;
  )
    is also<execute-non-select-command>
  {
    clear_error;
    my $rv = so gda_connection_execute_non_select_command($!gc, $sql, $error);
    set_error($error);
    $rv;
  }

  method execute_select_command (
    Str                     $sql,
    CArray[Pointer[GError]] $error = gerror;
  )
    is also<execute-select-command>
  {
    clear_error;
    my $rv = so gda_connection_execute_select_command($!gc, $sql, $error);
    set_error($error);
    $rv;
  }

  method get_authentication is also<get-authentication> {
    gda_connection_get_authentication($!gc);
  }

  method get_cnc_string is also<get-cnc-string> {
    gda_connection_get_cnc_string($!gc);
  }

  proto method get_date_format (|)
    is also<get-date-format>
  { *}

  multi method get_date_format (CArray[Pointer[GError]]  $error = gerror) {
    return-with-all( samewith($, $, $, $, $error, :all) );
  }
  multi method get_date_format (
                             $out_first  is rw,
                             $out_second is rw,
                             $out_third  is rw,
                             $out_sep    is rw,
    CArray[Pointer[GError]]  $error      =  gerror,
                            :$all        =  False
  ) {
    my guint ($f, $s, $t) = 0e0 xx 3;
    # cw: We allocate way more (approx double)than necessary to ensure no SEGV
    my $os = CArray[uint8].allocate(4);

    clear_error;
    my $rv = so gda_connection_get_date_format($!gc, $f, $s, $t, $os, $error);
    set_error($error);
    ($out_first, $out_second, $out_third, $out_sep) = ($f, $s, $t, $os[0].chr);

    $all.not ?? $rv !! ($rv, $out_first, $out_second, $out_third, $out_sep)
  }

  method get_dsn is also<get-dsn> {
    gda_connection_get_dsn($!gc);
  }

  method get_events ( :$glist = False, :$raw = False ) is also<get-events> {
    returnGList(
      gda_connection_get_events($!gc),
      $raw,
      $glist,
      |GDA::Connection::Event.getTypePair
    )
  }

  method get_meta_store ( :$raw = False ) is also<get-meta-store> {
    propReturnObject(
      gda_connection_get_meta_store($!gc),
      $raw,
      |GDA::MetaStore.getTypePair
    );
  }

  # cw: var-args are currently out-of-scope
  # method get_meta_store_data (
  #   Int()                   $meta_type,
  #   CArray[Pointer[GError]] $error,     = gerror
  #   Int()                   $nb_filters
  #                           ...         #= Filters (count: $nb_filters)
  # )
  #   is also<get-meta-store-data>
  # {
  #   my GdaConnectionMetaType $m = $meta_type;
  #
  #   gda_connection_get_meta_store_data($!gc, $meta_type, $error, $nb_filters);
  # }

  proto method get_meta_store_data_v (|)
  { * }

  multi method get_meta_store_data_v (
    Int()                   $meta_type,
                            @filters,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    samewith(
      $meta_type,
      GLib::GList.new(@filters, typed => GdaHolder),
      $error
    );
  }
  multi method get_meta_store_data_v (
    Int()                   $meta_type,
    GList()                 $filters,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<get-meta-store-data-v>
  {
    my GdaConnectionMetaType $m = $meta_type;

    gda_connection_get_meta_store_data_v($!gc, $m, $filters, $error);
  }

  method get_options ( :$flags = True ) is also<get-options> {
    my $f = gda_connection_get_options($!gc);

    return $f unless $flags;

    getFlags(GdaConnectionOptionsEnum, $flags);
  }

  method get_provider ( :$raw = False ) is also<get-provider> {
    propReturnObject(
      gda_connection_get_provider($!gc),
      $raw,
      |GDA::Service::Provider.getTypePair
    );
  }

  method get_provider_name is also<get-provider-name> {
    gda_connection_get_provider_name($!gc);
  }

  method get_transaction_status ( :$raw = False ) is also<get-transaction-status> {
    propReturnObject(
      gda_connection_get_transaction_status($!gc),
      $raw,
      |GDA::TransactionStatus.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_connection_get_type, $n, $t );
  }

  # cw: varargs not currently in-scope!
  #method insert_row_into_table (...)

  proto method insert_row_into_table (|)
    is also<insert-row-into-table>
  { * }

  multi method insert_row_into_table ($table, %columns-and-data) {
    samewith($table, |%columns-and-data);
  }
  multi method insert_row_into_table (
    $table,
    *%columns-and-data
  ) {
    my (@cols, @vals);

    for %columns-and-data.pairs {
      @cols.push: .key;
      @vals.push: .value;
    }

    self.insert_row_into_table_v($table, @cols, @vals);
  }

  proto method insert_row_into_table_v (|)
    is also<insert-row-into-table-v>
  { * }

  multi method insert_row_into_table_v (
    Str                     $table,
                            @col_names,
                            @values,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    die '@col_names and @values must have the same number of elements!'
      unless +@col_names == +@values;

    samewith(
      $table,
      GLib::GSList.new(@col_names, typed => Str),
      GLib::GSList.new(@values,    typed => GValue),
      $error
    );
  }
  multi method insert_row_into_table_v (
    Str()                   $table,
    GSList()                $col_names,
    GSList()                $values,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    clear_error;
    my $rv = so gda_connection_insert_row_into_table_v(
      $!gc,
      $table,
      $col_names,
      $values,
      $error
    );
    set_error($error);
    $rv;
  }

  method is_opened is also<is-opened> {
    so gda_connection_is_opened($!gc);
  }

  proto method parse_sql_string (|)
    is also<parse-sql-string>
  { * }

  multi method parse_sql_string (
    Str()                    $sql,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  ) {
    samewith($sql, newCArray(GdaSet), $error, :$raw);
  };
  multi method parse_sql_string (
    Str()                    $sql,
    CArray[GdaSet]           $params,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$all     = False,
                            :$raw     = False
  ) {
    clear_error
    my $s = gda_connection_parse_sql_string($!gc, $sql, $params, $error);
    set_error($error);

    $s = propReturnObject($s, $raw, |GDA::Statement.getTypePair);

    # cw: Consider not doing any work on $params unless $all is set.
    my $p = $all.not
      ?? Nil
      !! propReturnObject($params, $raw, |GDA::Set.getTypePair);

    $all.not ?? $s !! ( $s, $p );
  }

  method perform_operation (
    GdaServerOperation()    $op,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<perform-operation>
  {
    clear_error;
    my $rv = so gda_connection_perform_operation($!gc, $op, $error);
    set_error($error);
    $rv;
  }

  method quote_sql_identifier (Str() $id) is also<quote-sql-identifier> {
    gda_connection_quote_sql_identifier($!gc, $id);
  }

  method repetitive_statement_execute (
    GdaRepetitiveStatement()  $rstmt,
    Int()                     $model_usage,
    Int()                     $col_types,
    Int()                     $stop_on_error,
    CArray[Pointer[GError]]   $error          = gerror,
                             :$raw            = False,
                             :$glist          = False
  )
    is also<repetitive-statement-execute>
  {
    my GdaStatementModelUsage $m = $model_usage;
    my GType                  $c = $col_types;
    my gboolean               $s = $stop_on_error.so.Int;

    clear_error;
    my $ol = gda_connection_repetitive_statement_execute(
      $!gc,
      $rstmt,
      $m,
      $c,
      $s,
      $error
    );
    set_error($error);

    returnGList($ol, $raw, $glist, |GLib::Object.getTypePair);
  }

  method rollback_savepoint (
    Str()                   $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<rollback-savepoint>
  {
    clear_error;
    my $rv = so gda_connection_rollback_savepoint($!gc, $name, $error);
    set_error($error);
    $rv;
  }

  method rollback_transaction (
    Str()                   $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<rollback-transaction>
  {
    clear_error;
    my $rv = so gda_connection_rollback_transaction($!gc, $name, $error);
    set_error($error);
    $rv;
  }

  proto method statement_execute (|)
    is also<statement-execute>
  { * }

  multi method statement_execute (
    GdaStatement()           $stmt,
    GdaSet()                 $params,
    Int()                    $model_usage,
    CArray[Pointer[GError]]  $error            = gerror,
                            :$raw              = False
  ) {
    return-with-all(
      samewith(
        $stmt,
        $params,
        $model_usage,
        newCArray(GdaSet),
        $error,
        :all,
        :$raw
      )
    )
  }
  multi method statement_execute (
    GdaStatement()           $stmt,
    GdaSet()                 $params,
    Int()                    $model_usage,
    CArray[GdaSet]           $last_insert_row,
    CArray[Pointer[GError]]  $error            = gerror,
                            :$all              = False,
                            :$raw              = False
  ) {
    my GdaStatementModelUsage $m = $model_usage;

    clear_error;
    my $o = gda_connection_statement_execute(
      $!gc,
      $stmt,
      $params,
      $model_usage,
      $last_insert_row,
      $error
    );
    set_error($error);

    # cw: Consider not doing the extra work on $lir if $all is unset!
    my $lir = $all.not ?? Nil !! propReturnObject(
      ppr($last_insert_row),
      $raw,
      |GDA::Set.getTypePair
    );

    $o = propReturnObject($o, $raw, |GLib::Object.getTypePair);

    $all.not ?? $o !! ($o, $lir);
  }

  proto method statement_execute_non_select (|)
    is also<statement-execute-non-select>
  { * }

  multi method statement_execute_non_select (
    GdaStatement()           $stmt,
    GdaSet()                 $params  = GdaSet,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  ) {
    return-with-all(
      samewith($stmt, $params, newCArray(GdaSet), $error, :all, :$raw)
    );
  }
  multi method statement_execute_non_select (
    GdaStatement()           $stmt,
    GdaSet()                 $params,
    CArray[Pointer[GdaSet]]  $last_insert_row,
    CArray[Pointer[GError]]  $error            = gerror,
                            :$all              = False,
                            :$raw              = False
  ) {
    clear_error;
    my $nr = gda_connection_statement_execute_non_select(
      $!gc,
      $stmt,
      $params,
      $last_insert_row,
      $error
    );
    set_error($error);

    my $lir = $all.not ?? Nil !! propReturnObject(
      ppr($last_insert_row),
      $raw,
      |GDA::Set.getTypePair
    );

    $all.not ?? $nr !! ($nr, $lir);
  }

  method statement_execute_select (
    GdaStatement()           $stmt,
    GdaSet()                 $params = GdaSet,
    CArray[Pointer[GError]]  $error  = gerror,
                            :$raw    = False
  )
    is also<statement-execute-select>
  {
    clear_error;
    my $m = gda_connection_statement_execute_select(
      $!gc,
      $stmt,
      $params,
      $error
    );
    set_error($error);



    propReturnObject($m, $raw, |GDA::Data::Model.getTypePair);
  }

  proto method statement_execute_select_full (|)
    is also<statement-execute-select-full>
  { * }

  multi method statement_execute_select_full (
      GdaStatement()           $stmt,
      GdaSet()                 $params,
      Int()                    $model_usage,
                               @col_types,
      CArray[Pointer[GError]]  $error        = gerror,
                              :$raw          = False
  ) {
    samewith(
      $stmt,
      $params,
      $model_usage,
      ArrayToCArray(GType, @col_types, :null),
      $error,
      :$raw
    );
  }
  multi method statement_execute_select_full (
    GdaStatement()           $stmt,
    GdaSet()                 $params,
    Int()                    $model_usage,
    CArray[GType]            $col_types,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$raw          = False
  ) {
    my GdaStatementModelUsage $m = $model_usage;

    clear_error;
    my $dm = gda_connection_statement_execute_select_full(
      $!gc,
      $stmt,
      $params,
      $m,
      $col_types,
      $error
    );
    set_error($error);

    propReturnObject($dm, $raw, |GDA::Data::Model.getTypePair);
  }

  # cw: Requires varargs so skipped!
  #method statement_execute_select_fullv (...)

  method statement_prepare (
    GdaStatement()          $stmt,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<statement-prepare>
  {
    clear_error;
    my $rv = so gda_connection_statement_prepare($!gc, $stmt, $error);
    set_error($error);
    $rv;
  }

  proto method statement_to_sql (|)
    is also<statement-to-sql>
  { * }

  multi method statement_to_sql (
    GdaStatement()           $stmt,
    GdaSet()                 $params,
    Int()                    $flags,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$glist        = False,
                            :$raw          = False,
  ) {
    samewith(
      $stmt,
      $params,
      $flags,
      newCArray(GSList),
      :all,
      :$glist,
      :$raw,
      $error
    );
  }
  multi method statement_to_sql (
    GdaStatement()           $stmt,
    GdaSet()                 $params,
    Int()                    $flags,
    CArray[Pointer[GSList]]  $params_used,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$all          = False,
                            :$glist        = False,
                            :$raw          = False
  ) {
    my GdaStatementSqlFlag $f = $flags;

    clear_error;
    my $sql = gda_connection_statement_to_sql(
      $!gc,
      $stmt,
      $params,
      $flags,
      $params_used,
      $error
    );
    set_error($error);

    my $pl = $all.not ?? Nil !! returnGList(
      ppr($params_used),
      $raw,
      $glist,
      |GDA::Holder.getTypePair
    );

    $all.not ?? $sql !! ($sql, $pl);
  }

  method supports_feature (Int() $feature) is also<supports-feature> {
    my GdaConnectionFeature $f = $feature;

    so gda_connection_supports_feature($!gc, $f);
  }

  method update_meta_store (
    GdaMetaContext()        $context,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<update-meta-store>
  {
    clear_error;
    my $rv = so gda_connection_update_meta_store($!gc, $context, $error);
    set_error($error);
    $rv;
  }

  # cw: varargs not supported, so skipped.
  #method update_row_in_table (...)

  proto method update_row_in_table (|)
    is also<update-row-in-table>
  { * }


  multi method update_row_in_table (
    Str()                   $table,
    Pair()                  $condition_column,
                            %col_name_values,
    CArray[Pointer[GError]] $error                   = gerror,
  ) {
    say "URIT: k: { $condition_column.key } / v: { $condition_column.value }";
    %col_name_values.gist.say;
    samewith(
      $table,
      $condition_column.key,
      $condition_column.value,
      $error,
      |%col_name_values
    );
  }
  multi method update_row_in_table (
    Str()                    $table,
    Pair()                   $condition_column,
    CArray[Pointer[GError]]  $error                   = gerror,
                            *%col_name_values
  ) {
    say "URIT: k: { $condition_column.key } / v: { $condition_column.value }";
    %col_name_values.gist.say;
    samewith(
      $table,
      $condition_column.key,
      $condition_column.value,
      $error,
      |%col_name_values
    );
  }
  multi method update_row_in_table (
    Str()                   $table,
    Str()                   $condition_column_name,
    GValue()                $condition_value,
                            %col_name_values,
    CArray[Pointer[GError]] $error                   = gerror,
  ) {
    samewith(
      $table,
      $condition_column_name,
      $condition_value,
      $error
      |%col_name_values
    );
  }
  multi method update_row_in_table (
    Str()                   $table,
    Str()                   $condition_column_name,
    GValue()                $condition_value,
    CArray[Pointer[GError]] $error                   = gerror,
                            *%col_name_values
  ) {
    self.update_row_in_table_v(
      $table,
      $condition_column_name,
      $condition_value,
      %col_name_values.keys,
      # cw: Should break this out into a generic Val -> GValue routine!
      %col_name_values.values,
      $error
    )
  }

  proto method update_row_in_table_v (|)
    is also<update-row-in-table-v>
  { * }

  multi method update_row_in_table_v (
    Str()                   $table,
    Str()                   $condition_column_name,
    GValue()                $condition_value,
                            @col_names,
                            @values,
    CArray[Pointer[GError]] $error                   = gerror
  ) {
    samewith(
      $table,
      $condition_column_name,
      $condition_value,
      GLib::GSList.new(@col_names, typed => Str),
      GLib::GSList.new(@values,    typed => GValue),
      $error
    )
  }
  multi method update_row_in_table_v (
    Str()                   $table,
    Str()                   $condition_column_name,
    GValue()                $condition_value,
    GSList()                $col_names,
    GSList()                $values,
    CArray[Pointer[GError]] $error                   = gerror
  ) {
    say "URIT: $table / $condition_column_name / $condition_value / {
         $col_names.Array.gist } / { $values.Array.gist }";

    clear_error;
    my $rv = so gda_connection_update_row_in_table_v(
      $!gc,
      $table,
      $condition_column_name,
      $condition_value,
      $col_names,
      $values,
      $error
    );
    set_error($error);
    $rv;
  }

  method value_to_sql_string (GValue() $from) is also<value-to-sql-string> {
    gda_connection_value_to_sql_string($!gc, $from);
  }

}
