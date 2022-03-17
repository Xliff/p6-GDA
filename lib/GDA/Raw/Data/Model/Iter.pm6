use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Data::Model::Iter;

### /usr/src/libgda5-5.2.10/libgda/gda-data-model-iter.h

sub gda_data_model_iter_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_get_column_for_param (
  GdaDataModelIter $iter,
  GdaHolder        $param
)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_get_holder_for_field (
  GdaDataModelIter $iter,
  gint             $col
)
  returns GdaHolder
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_get_row (GdaDataModelIter $iter)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_get_value_at (GdaDataModelIter $iter, gint $col)
  returns GdaValue
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_get_value_at_e (
  GdaDataModelIter        $iter,
  gint                    $col,
  CArray[Pointer[GError]] $error
)
  returns GdaValue
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_get_value_for_field (
  GdaDataModelIter $iter,
  Str              $field_name
)
  returns GdaValue
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_invalidate_contents (GdaDataModelIter $iter)
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_is_valid (GdaDataModelIter $iter)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_move_next (GdaDataModelIter $iter)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_move_prev (GdaDataModelIter $iter)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_move_to_row (GdaDataModelIter $iter, gint $row)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_model_iter_set_value_at (
  GdaDataModelIter        $iter,
  gint                    $col,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
