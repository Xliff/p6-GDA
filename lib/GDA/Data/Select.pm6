use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Data::Select;

use GLib::Roles::Object;
use GDA::Roles::Data::Model;

our subset GdaDataSelectAncestry is export of Mu
  where GdaDataSelect | GdaDataModel | GObject;

class GDA::Data::Select {
  also does GLib::Roles::Object;
  also does GDA::Roles::Data::Model;

  has GdaDataSelect $!gds;

  submethod BUILD ( :$gda-data-select ) {
    self.setGdaDataSelect($gda-data-select) if $gda-data-select;
  }

  method setGdaDataSelect (GdaDataSelectAncestry $_) {
    my $to-parent;
    $!gds = do {
      when GdaDataSelect {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GdaDataModel {
        $to-parent = cast(GObject, $_);
        $!gdm      = $_;
        cast(GdaDataSelect, $_);
      }

      default {
        $to-parent = $_;
        cast(GdaDataSelect, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GdaDataModel;
  }

  method GDA::Raw::Definition::GdaDataSelect
    is also<GdaDataSelect>
  { $!gds }

  multi method new (GdaDataSelectAncestry $gda-data-select, :$ref = True) {
    return Nil unless $gda-data-select;

    my $o = self.bless( :$gda-data-select );
    $o.ref if $ref;
    $o;
  }

  # Type: gboolean
  method auto-reset is rw  is also<auto_reset> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('auto-reset', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('auto-reset', $gv);
      }
    );
  }

  # Type: GdaConnection
  method connection ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Connection.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('connection', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Connection.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'connection is a construct-only attribute'
      }
    );
  }

  # Type: GdaStatement
  method delete-stmt ( :$raw = False ) is rw  is also<delete_stmt> {
    my $gv = GLib::Value.new( GDA::Statement.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('delete-stmt', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Statement.getTypePair
        );
      },
      STORE => -> $, GdaStatement() $val is copy {
        $gv.TYPE = $val;
        self.prop_set('delete-stmt', $gv);
      }
    );
  }

  # Type: GdaDataSelect
  method exec-params ( :$raw = False ) is rw  is also<exec_params> {
    my $gv = GLib::Value.new( GDA::Set.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('exec-params', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Set.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'exec-params is a construct-only attribute'
      }
    );
  }

  # Type: gdouble
  method execution-delay is rw  is also<execution_delay> {
    my $gv = GLib::Value.new( G_TYPE_DOUBLE );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('execution-delay', $gv)
        );
        $gv.double;
      },
      STORE => -> $, Num() $val is copy {
        $gv.double = $val;
        self.prop_set('execution-delay', $gv);
      }
    );
  }

  # Type: GdaStatement
  method insert-stmt ( :$raw = False) is rw  is also<insert_stmt> {
    my $gv = GLib::Value.new( GDA::Statement.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('insert-stmt', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Statement.getTypePair
        );
      },
      STORE => -> $, GdaStatement() $val is copy {
        $gv.object = $val;
        self.prop_set('insert-stmt', $gv);
      }
    );
  }

  # Type: guint
  method model-usage is rw  is also<model_usage> {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('model-usage', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'model-usage is a construct-only attribute'
      }
    );
  }

  # Type: GdaPStmt
  method prepared-stmt ( :$raw = False ) is rw  is also<prepared_stmt> {
    my $gv = GLib::Value.new( GDA::PStmt.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('prepared-stmt', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::PStmt.getTypePair
        );
      },
      STORE => -> $, GdaPStmt() $val is copy {
        $gv.object = $val;
        self.prop_set('prepared-stmt', $gv);
      }
    );
  }

  # Type: GdaStatement
  method select-stmt ( :$raw = False ) is rw  is also<select_stmt> {
    my $gv = GLib::Value.new( GDA::Statement.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('select-stmt', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Statement.getTypePair
        );
      },
      STORE => -> $, GdaStatement() $val is copy {
        warn 'select-stmt does not allow writing'
      }
    );
  }

  # Type: gboolean
  method store-all-rows is rw  is also<store_all_rows> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('store-all-rows', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('store-all-rows', $gv);
      }
    );
  }

  # Type: GdaStatement
  method update-stmt ( :$raw = False ) is rw  is also<update_stmt> {
    my $gv = GLib::Value.new( GDA::Statement.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('update-stmt', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Statement.getTypePair
        );
      },
      STORE => -> $, GdaStatement() $val is copy {
        $gv.objects = $val;
        self.prop_set('update-stmt', $gv);
      }
    );
  }

  method compute_columns_attributes (CArray[Pointer[GError]] $error = gerror)
    is also<compute-columns-attributes>
  {
    clear_error;
    my $rv = so gda_data_select_compute_columns_attributes($!gds, $error);
    set_error($error);
    $rv;
  }

  method compute_modification_statements (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<compute-modification-statements>
  {
    clear_error;
    my $rv = so gda_data_select_compute_modification_statements($!gds, $error);
    set_error($error);
    $rv;
  }

  method compute_modification_statements_ext (
    Int()                   $cond_type,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<compute-modification-statements-ext>
  {
    my GdaDataSelectConditionType $c = $cond_type;

    clear_error;
    my $rv = so gda_data_select_compute_modification_statements_ext(
      $!gds,
      $c,
      $error
    );
    set_error($error);
    $rv;
  }

  method compute_row_selection_condition (CArray[Pointer[GError]] $error)
    is also<compute-row-selection-condition>
  {
    gda_data_select_compute_row_selection_condition($!gds, $error);
  }

  method error_quark ( GDA::Data::Select:U: ) is also<error-quark> {
    gda_data_select_error_quark();
  }

  method get_connection (:$raw = False) is also<get-connection> {
    propReturnObject(
      gda_data_select_get_connection($!gds),
      $raw,
      |GDA::Connection.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_select_get_type, $n, $t );
  }

  method prepare_for_offline (CArray[Pointer[GError]] $error = gerror)
    is also<prepare-for-offline>
  {
    clear_error;
    my $rv = so gda_data_select_prepare_for_offline($!gds, $error);
    set_error($error);
    $rv;
  }

  method rerun (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so gda_data_select_rerun($!gds, $error);
    set_error($error);
    $rv;
  }

  method set_modification_statement (
    GdaStatement()          $mod_stmt,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<set-modification-statement>
  {
    clear_error;
    my $rv = so gda_data_select_set_modification_statement(
      $!gds,
      $mod_stmt,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_modification_statement_sql (
    Str()                   $sql,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-modification-statement-sql>
  {
    clear_error;
    my $rv = so gda_data_select_set_modification_statement_sql(
      $!gds,
      $sql,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_row_selection_condition (
    GdaSqlExpr()            $expr,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-row-selection-condition>
  {
    clear_error;
    my $rv = so gda_data_select_set_row_selection_condition(
      $!gds,
      $expr,
      $error
    );
    set_error($error);
    $rv;
  }

  method set_row_selection_condition_sql (
    Str()                   $sql_where,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<set-row-selection-condition-sql>
  {
    clear_error;
    my $rv = so gda_data_select_set_row_selection_condition_sql(
      $!gds,
      $sql_where,
      $error
    );
    set_error($error);
    $rv;
  }

}
