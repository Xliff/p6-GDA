use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Virtual::Connection::Data::Model;

### /usr/src/libgda/libgda/sqlite/virtual/gda-vconnection-data-model.h

sub gda_vconnection_data_model_add (
  GdaVconnectionDataModel     $cnc,
  GdaVconnectionDataModelSpec $spec,
  GDestroyNotify              $spec_free_func,
  Str                         $table_name,
  CArray[Pointer[GError]]     $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_vconnection_data_model_add_model (
  GdaVconnectionDataModel $cnc,
  GdaDataModel            $model,
  Str                     $table_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_vconnection_data_model_foreach (
  GdaVconnectionDataModel $cnc,
                          &func, #= GdaVconnectionDataModelFunc
  gpointer                $data
)
  is native(gda)
  is export
{ * }

sub gda_vconnection_data_model_get (
  GdaVconnectionDataModel $cnc,
  Str                     $table_name
)
  returns GdaVconnectionDataModelSpec
  is native(gda)
  is export
{ * }

sub gda_vconnection_data_model_get_model (
  GdaVconnectionDataModel $cnc,
  Str                     $table_name
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_vconnection_data_model_get_table_name (
  GdaVconnectionDataModel $cnc,
  GdaDataModel            $model
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_vconnection_data_model_remove (
  GdaVconnectionDataModel $cnc,
  Str                     $table_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
