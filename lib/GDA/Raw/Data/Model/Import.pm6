use v6.c;

use NativeCall;

use LibXML::Raw;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Model::Data::Import;

### /usr/include/libgda-5.0/libgda/gda-data-model-import.h

sub gda_data_model_import_clean_errors (GdaDataModelImport $model)
  is native(gda)
  is export
{ * }

sub gda_data_model_import_get_errors (GdaDataModelImport $model)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_data_model_import_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_model_import_new_file (
  Str      $filename,
  gboolean $random_access,
  GdaSet   $options
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_data_model_import_new_mem (
  Str      $data,
  gboolean $random_access,
  GdaSet   $options
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_data_model_import_new_xml_node (anyNode $node)
  returns GdaDataModel
  is native(gda)
  is export
{ * }
