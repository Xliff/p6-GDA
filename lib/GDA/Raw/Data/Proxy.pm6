use v6.c;

use GLib::Raw::Definitions;
use GDA::Raw::Definitions;

unit package GDA::Raw::Data::Proxy;

### /usr/include/libgda-5.0/libgda/gda-data-proxy.h

sub gda_data_proxy_alter_value_attributes (
  GdaDataProxy      $proxy,
  gint              $proxy_row,
  gint              $col,
  GdaValueAttribute $alter_flags
)
  is native(gda)
  is export
{ * }

sub gda_data_proxy_apply_all_changes (
  GdaDataProxy            $proxy,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_apply_row_changes (
  GdaDataProxy            $proxy,
  gint                    $proxy_row,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_cancel_all_changes (GdaDataProxy $proxy)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_cancel_row_changes (
  GdaDataProxy $proxy,
  gint         $proxy_row,
  gint         $col
)
  is native(gda)
  is export
{ * }

sub gda_data_proxy_delete (GdaDataProxy $proxy, gint $proxy_row)
  is native(gda)
  is export
{ * }

sub gda_data_proxy_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_filter_expr (GdaDataProxy $proxy)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_filtered_n_rows (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_n_modified_rows (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_n_new_rows (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_proxied_model (GdaDataProxy $proxy)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_proxied_model_n_cols (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_proxied_model_n_rows (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_proxied_model_row (GdaDataProxy $proxy, gint $proxy_row)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_sample_end (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_sample_size (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_sample_start (GdaDataProxy $proxy)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_value_attributes (
  GdaDataProxy $proxy,
  gint         $proxy_row,
  gint         $col
)
  returns GdaValueAttribute
  is native(gda)
  is export
{ * }

sub gda_data_proxy_get_values (
  GdaDataProxy $proxy,
  gint         $proxy_row,
  gint         $cols_index is rw,
  gint         $n_cols
)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_data_proxy_has_changed (GdaDataProxy $proxy)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_is_read_only (GdaDataProxy $proxy)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_new (GdaDataModel $model)
  returns GdaDataProxy
  is native(gda)
  is export
{ * }

sub gda_data_proxy_new_with_data_model (GdaDataModel $model)
  returns GdaDataProxy
  is native(gda)
  is export
{ * }

sub gda_data_proxy_row_has_changed (GdaDataProxy $proxy, gint $proxy_row)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_row_is_deleted (GdaDataProxy $proxy, gint $proxy_row)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_row_is_inserted (GdaDataProxy $proxy, gint $proxy_row)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_set_filter_expr (
  GdaDataProxy            $proxy,
  Str                     $filter_expr,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_set_ordering_column (
  GdaDataProxy            $proxy,
  gint                    $col,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_proxy_set_sample_size (GdaDataProxy $proxy, gint $sample_size)
  is native(gda)
  is export
{ * }

sub gda_data_proxy_set_sample_start (GdaDataProxy $proxy, gint $sample_start)
  is native(gda)
  is export
{ * }

sub gda_data_proxy_undelete (GdaDataProxy $proxy, gint $proxy_row)
  is native(gda)
  is export
{ * }
