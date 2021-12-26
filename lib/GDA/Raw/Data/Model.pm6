use v6.c;

use NativeCall;

use LibXML::Raw;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Data::Model;

### /usr/include/libgda-5.0/libgda/gda-data-model.h

sub gda_data_model_append_row (
  GdaDataModel            $model,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_append_values (
  GdaDataModel            $model,
  GList                   $values,
  CArray[Pointer[GError]] $error
)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_create_iter (GdaDataModel $model)
  returns GdaDataModelIter
  is native(gda)
  is export
{ * }

sub gda_data_model_describe_column (GdaDataModel $model, gint $col)
  returns GdaColumn
  is native(gda)
  is export
{ * }

sub gda_data_model_dump (
  GdaDataModel $model,
  Pointer      $to_stream     # FILE *
)
  is native(gda)
  is export
{ * }

sub gda_data_model_dump_as_string (GdaDataModel $model)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_model_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_data_model_export_to_file (
  GdaDataModel            $model,
  GdaDataModelIOFormat    $format,
  Str                     $file,
  gint                    $cols      is rw,
  gint                    $nb_cols,
  gint                    $rows      is rw,
  gint                    $nb_rows,
  GdaSet                  $options,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_export_to_string (
  GdaDataModel         $model,
  GdaDataModelIOFormat $format,
  gint                 $cols is  rw,
  gint                 $nb_cols,
  gint                 $rows is  rw,
  gint                 $nb_rows,
  GdaSet               $options
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_model_freeze (GdaDataModel $model)
  is native(gda)
  is export
{ * }

sub gda_data_model_get_access_flags (GdaDataModel $model)
  returns GdaDataModelAccessFlags
  is native(gda)
  is export
{ * }

sub gda_data_model_get_attributes_at (
  GdaDataModel $model,
  gint         $col,
  gint         $row
)
  returns GdaValueAttribute
  is native(gda)
  is export
{ * }

sub gda_data_model_get_column_index (GdaDataModel $model, Str $name)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_get_column_name (GdaDataModel $model, gint $col)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_model_get_column_title (GdaDataModel $model, gint $col)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_model_get_exceptions (GdaDataModel $model)
  returns CArray[Pointer[GError]]
  is native(gda)
  is export
{ * }

sub gda_data_model_get_n_columns (GdaDataModel $model)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_get_n_rows (GdaDataModel $model)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_get_notify (GdaDataModel $model)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_get_row_from_values (
  GdaDataModel $model,
  GSList       $values,
  gint         $cols_index is rw
)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_model_get_typed_value_at (
  GdaDataModel            $model,
  gint                    $col,
  gint                    $row,
  GType                   $expected_type,
  gboolean                $nullok,
  CArray[Pointer[GError]] $error
)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_data_model_get_value_at (
  GdaDataModel            $model,
  gint                    $col,
  gint                    $row,
  CArray[Pointer[GError]] $error
)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_data_model_import_from_file (
  GdaDataModel            $model,
  Str                     $file,
  GHashTable              $cols_trans,
  GdaSet                  $options,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_import_from_model (
  GdaDataModel            $to,
  GdaDataModel            $from,
  gboolean                $overwrite,
  GHashTable              $cols_trans,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_import_from_string (
  GdaDataModel            $model,
  Str                     $string,
  GHashTable              $cols_trans,
  GdaSet                  $options,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_at_row (
  GdaDataModel     $model,
  GdaDataModelIter $iter,
  gint             $row
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_next (GdaDataModel $model, GdaDataModelIter $iter)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_prev (GdaDataModel $model, GdaDataModelIter $iter)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_set_value (
  GdaDataModel            $model,
  GdaDataModelIter        $iter,
  gint                    $col,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_remove_row (
  GdaDataModel            $model,
  gint                    $row,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_send_hint (
  GdaDataModel     $model,
  GdaDataModelHint $hint,
  GValue           $hint_value
)
  is native(gda)
  is export
{ * }

sub gda_data_model_set_column_name (
  GdaDataModel $model,
  gint         $col,
  Str          $name
)
  is native(gda)
  is export
{ * }

sub gda_data_model_set_column_title (
  GdaDataModel $model,
  gint         $col,
  Str          $title
)
  is native(gda)
  is export
{ * }

sub gda_data_model_set_notify (
  GdaDataModel $model,
  gboolean     $do_notify_changes
)
  is native(gda)
  is export
{ * }

sub gda_data_model_set_value_at (
  GdaDataModel            $model,
  gint                    $col,
  gint                    $row,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_set_values (
  GdaDataModel            $model,
  gint                    $row,
  GList                   $values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_thaw (GdaDataModel $model)
  is native(gda)
  is export
{ * }

### /usr/include/libgda-5.0/libgda/gda-data-model-private.h

sub gda_data_model_add_data_from_xml_node (
  GdaDataModel            $model,
  anyNode                 $node,
  CArray[Pointer[GError]] $error
)
  is native(gda)
  is export
{ * }
