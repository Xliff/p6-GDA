use v6.c;

use Method::Also;
use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Data::Proxy;

use GLib::GList;

use GLib::Roles::Object;
use GDA::Roles::Data::Model;
use GDA::Roles::Signals::Data::Proxy;

our subset GdaDataProxyAncestry is export of Mu
  where GdaDataProxy | GObject;

class GDA::Data::Proxy {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Data::Proxy;

  has GdaDataProxy $!gdp is implementor;

  submethod BUILD ( :$gda-data-proxy ) {
    self.setGdaDataProxy($gda-data-proxy) if $gda-data-proxy;
  }

  method setGdaDataProxy (GdaDataProxyAncestry $_) {
    my $to-parent;

    $!gdp = do {
      when GdaDataProxy {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataProxy, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaDataProxy
    is also<GdaDataProxy>
  { $!gdp }

  multi method new (GdaDataProxyAncestry $gda-data-proxy, :$ref = True) {
    return Nil unless $gda-data-proxy;

    my $o = self.bless( :$gda-data-proxy );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaDataModel() $model) {
    my $gda-data-proxy = gda_data_proxy_new($model);

    $gda-data-proxy ?? self.bless( :$gda-data-proxy ) !! Nil;
  }

  method new_with_data_model (GdaDataModel $model)
    is also<new-with-data-model>
  {
    my $gda-data-proxy = gda_data_proxy_new_with_data_model($model);

    $gda-data-proxy ?? self.bless( :$gda-data-proxy ) !! Nil;
  }

  # Type: boolean
  method cache-changes is rw  is also<cache_changes> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('cache-changes', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('cache-changes', $gv);
      }
    );
  }

  # Type: boolean
  method defer-sync is rw  is also<defer_sync> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('defer-sync', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('defer-sync', $gv);
      }
    );
  }

  # Type: GdaDataModel
  method model ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Data::Model.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('model', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Data::Model.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'model is a construct-only attribute'
      }
    );
  }

  # Type: boolean
  method prepend-null-entry is rw  is also<prepend_null_entry> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('prepend-null-entry', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('prepend-null-entry', $gv);
      }
    );
  }

  # Type: int
  method sample-size is rw  is also<sample_size> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('sample-size', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'sample-size is a construct-only attribute'
      }
    );
  }

  # Is originally:
  # GdaDataProxy *proxy --> void
  method filter-changed is also<filter_changed> {
    self.connect-filter-changed($!gdp);
  }

  # Is originally:
  # GdaDataProxy *proxy,  gint row,  gboolean to_be_deleted --> void
  method row-delete-changed is also<row_delete_changed> {
    self.connect-row-delete-changed($!gdp);
  }

  # Is originally:
  # GdaDataProxy *proxy,  gint row,  gint proxied_row --> GError *
  method validate-row-changes is also<validate_row_changes> {
    self.connect-validate-row-changes($!gdp);
  }

  # Is originally:
  # GdaDataProxy *proxy,  gint sample_size --> void
  method sample-size-changed is also<sample_size_changed> {
    self.connect-sample-size-changed($!gdp);
  }

  # Is originally:
  # GdaDataProxy *proxy,  gint row,  gint proxied_row --> void
  method row-changes-applied is also<row_changes_applied> {
    self.connect-row-changes-applied($!gdp);
  }

  # Is originally:
  # GdaDataProxy *proxy,  gint sample_start,  gint sample_end --> void
  method sample-changed is also<sample_changed> {
    self.connect-sample-changed($!gdp);
  }

  method alter_value_attributes (
    Int() $proxy_row,
    Int() $col,
    Int() $alter_flags
  )
    is also<alter-value-attributes>
  {
    my gint              ($p, $c)  = ($proxy_row, $col);
    my GdaValueAttribute  $a       = $alter_flags;

    gda_data_proxy_alter_value_attributes($!gdp, $p, $c, $a);
  }

  method apply_all_changes (CArray[Pointer[GError]] $error  = gerror)
    is also<apply-all-changes>
  {
    clear_error;
    my $rv = so gda_data_proxy_apply_all_changes($!gdp, $error);
    set_error($error);
    $rv;
  }

  method apply_row_changes (
    Int()                   $proxy_row,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<apply-row-changes>
  {
    my gint $p = $proxy_row;

    clear_error;
    my $rv = so gda_data_proxy_apply_row_changes($!gdp, $p, $error);
    set_error($error);
    $rv;
  }

  method cancel_all_changes is also<cancel-all-changes> {
    so gda_data_proxy_cancel_all_changes($!gdp);
  }

  method cancel_row_changes (Int() $proxy_row, Int() $col)
    is also<cancel-row-changes>
  {
    my gint ($p, $c)  = ($proxy_row, $col);

    gda_data_proxy_cancel_row_changes($!gdp, $p, $c);
  }

  method delete (Int() $proxy_row) {
    my gint $p = $proxy_row;

    gda_data_proxy_delete($!gdp, $p);
  }

  method error_quark (GDA::Data::Proxy:U: ) is also<error-quark> {
    gda_data_proxy_error_quark();
  }

  method get_filter_expr is also<get-filter-expr> {
    gda_data_proxy_get_filter_expr($!gdp);
  }

  method get_filtered_n_rows is also<get-filtered-n-rows> {
    gda_data_proxy_get_filtered_n_rows($!gdp);
  }

  method get_n_modified_rows is also<get-n-modified-rows> {
    gda_data_proxy_get_n_modified_rows($!gdp);
  }

  method get_n_new_rows is also<get-n-new-rows> {
    gda_data_proxy_get_n_new_rows($!gdp);
  }

  method get_proxied_model is also<get-proxied-model> {
    gda_data_proxy_get_proxied_model($!gdp);
  }

  method get_proxied_model_n_cols ( :$raw = False )
    is also<get-proxied-model-n-cols>
  {
    propReturnObject(
      gda_data_proxy_get_proxied_model_n_cols($!gdp),
      $raw,
      |GDA::Data::Model.getTypePair
    );
  }

  method get_proxied_model_n_rows is also<get-proxied-model-n-rows> {
    gda_data_proxy_get_proxied_model_n_rows($!gdp);
  }

  method get_proxied_model_row (Int() $proxy_row)
    is also<get-proxied-model-row>
  {
    my gint $p = $proxy_row;

    gda_data_proxy_get_proxied_model_row($!gdp, $p);
  }

  method get_sample_end is also<get-sample-end> {
    gda_data_proxy_get_sample_end($!gdp);
  }

  method get_sample_size is also<get-sample-size> {
    gda_data_proxy_get_sample_size($!gdp);
  }

  method get_sample_start is also<get-sample-start> {
    gda_data_proxy_get_sample_start($!gdp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_proxy_get_type, $n, $t );
  }

  method get_value_attributes (Int() $proxy_row, Int() $col)
    is also<get-value-attributes>
  {
    my gint ($p, $c)  = ($proxy_row, $col);

    GdaValueAttributeEnum(
      gda_data_proxy_get_value_attributes($!gdp, $p, $c)
    );
  }

  proto method get_values (|)
    is also<get-values>
  { * }

  multi method get_values (
    Int()        $proxy_row,
                 @cols,
                :$raw   = False,
                :$glist = False
  ) {
    samewith(
      $proxy_row,
      ArrayToCArray(gint, @cols),
      @cols.elems,
      :$raw,
      :$glist
    );
  }
  multi method get_values (
    Int()         $proxy_row,
    CArray[gint]  $cols_index,
    Int()         $n_cols,
                 :$raw   = False,
                 :$glist = False
  ) {
    my gint ($p, $n)  = ($proxy_row, $n_cols);

    returnGList(
      gda_data_proxy_get_values($!gdp, $p, $cols_index, $n),
      $raw,
      $glist,
      |GLib::Value.getTypePair
    );
  }

  method has_changed is also<has-changed> {
    so gda_data_proxy_has_changed($!gdp);
  }

  method is_read_only is also<is-read-only> {
    so gda_data_proxy_is_read_only($!gdp);
  }

  method row_has_changed (Int() $proxy_row) is also<row-has-changed> {
    my gint $p = $proxy_row;

    gda_data_proxy_row_has_changed($!gdp, $p);
  }

  method row_is_deleted (Int() $proxy_row) is also<row-is-deleted> {
    my gint $p = $proxy_row;

    gda_data_proxy_row_is_deleted($!gdp, $p);
  }

  method row_is_inserted (Int() $proxy_row) is also<row-is-inserted> {
    my gint $p = $proxy_row;

    gda_data_proxy_row_is_inserted($!gdp, $p);
  }

  method set_filter_expr (
    Str()                   $filter_expr,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<set-filter-expr>
  {
    clear_error;
    my $rv = so gda_data_proxy_set_filter_expr($!gdp, $filter_expr, $error);
    set_error($error);
    $rv;
  }

  method set_ordering_column (
    Int()                   $col,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-ordering-column>
  {
    my gint $c = $col;

    clear_error;
    my $rv = so gda_data_proxy_set_ordering_column($!gdp, $c, $error);
    set_error($error);
    $rv;
  }

  method set_sample_size (Int() $sample_size) is also<set-sample-size> {
    my gint $s = $sample_size;

    gda_data_proxy_set_sample_size($!gdp, $s);
  }

  method set_sample_start (Int() $sample_start) is also<set-sample-start> {
    my gint $s = $sample_start;

    gda_data_proxy_set_sample_start($!gdp, $s);
  }

  method undelete (Int() $proxy_row) {
    my gint $p = $proxy_row;

    gda_data_proxy_undelete($!gdp, $p);
  }

}
