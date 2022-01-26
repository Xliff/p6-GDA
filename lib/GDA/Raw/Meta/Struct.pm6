use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Meta::Struct;


### /usr/include/libgda-5.0/libgda/gda-meta-struct.h

sub gda_meta_struct_complement (
  GdaMetaStruct           $mstruct,
  GdaMetaDbObjectType     $type,
  GValue                  $catalog,
  GValue                  $schema,
  GValue                  $name,
  CArray[Pointer[GError]] $error
)
  returns GdaMetaDbObject
  is native(gda)
  is export
{ * }

sub gda_meta_struct_complement_all (
  GdaMetaStruct           $mstruct,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_struct_complement_default (
  GdaMetaStruct           $mstruct,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_struct_complement_depend (
  GdaMetaStruct           $mstruct,
  GdaMetaDbObject         $dbo,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_struct_complement_schema (
  GdaMetaStruct           $mstruct,
  GValue                  $catalog,
  GValue                  $schema,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_struct_dump_as_graph (
  GdaMetaStruct           $mstruct,
  GdaMetaGraphInfo        $info,
  CArray[Pointer[GError]] $error
)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_meta_struct_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_meta_struct_get_all_db_objects (GdaMetaStruct $mstruct)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_meta_struct_get_db_object (
  GdaMetaStruct $mstruct,
  GValue        $catalog,
  GValue        $schema,
  GValue        $name
)
  returns GdaMetaDbObject
  is native(gda)
  is export
{ * }

sub gda_meta_struct_get_table_column (GdaMetaStruct $mstruct, GdaMetaTable $table, GValue $col_name)
  returns GdaMetaTableColumn
  is native(gda)
  is export
{ * }

sub gda_meta_struct_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_meta_struct_load_from_xml_file (
  GdaMetaStruct           $mstruct,
  Str                     $catalog,
  Str                     $schema,
  Str                     $xml_spec_file,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_struct_new (GdaMetaStore $store, GdaMetaStructFeature $features)
  returns GdaMetaStruct
  is native(gda)
  is export
{ * }

sub gda_meta_struct_sort_db_objects (
  GdaMetaStruct           $mstruct,
  GdaMetaSortType         $sort_type,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
