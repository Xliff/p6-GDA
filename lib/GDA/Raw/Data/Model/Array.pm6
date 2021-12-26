use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Data::Model::Array;

### /usr/include/libgda-5.0/libgda/gda-data-model-array.h

sub gda_data_model_array_clear (GdaDataModelArray $model)
  is native(gda)
  is export
{ * }

sub gda_data_model_array_copy_model (
  GdaDataModel            $src,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModelArray
  is native(gda)
  is export
{ * }

sub gda_data_model_array_copy_model_ext (
  GdaDataModel            $src,
  gint                    $ncols,
  gint                    $cols   is rw,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModelArray
  is native(gda)
  is export
{ * }

sub gda_data_model_array_get_row (
  GdaDataModelArray       $model,
  gint                    $row,
  CArray[Pointer[GError]] $error
)
  returns GdaRow
  is native(gda)
  is export
{ * }

sub gda_data_model_array_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_model_array_new (gint $cols)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_data_model_array_new_with_g_types (gint $cols)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_data_model_array_new_with_g_types_v (gint $cols, GType $types)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_data_model_array_set_n_columns (
  GdaDataModelArray $model,
  gint              $cols
)
  is native(gda)
  is export
{ * }
