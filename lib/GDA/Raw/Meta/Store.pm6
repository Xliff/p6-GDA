use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Meta::Store;

### /usr/include/libgda-5.0/libgda/gda-meta-store.h

sub gda_meta_context_copy (GdaMetaContext $ctx)
  returns GdaMetaContext
  is native(gda)
  is export
{ * }

sub gda_meta_context_free (GdaMetaContext $ctx)
  is native(gda)
  is export
{ * }

sub gda_meta_context_get_table (GdaMetaContext $ctx)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_meta_context_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_meta_context_new ()
  returns GdaMetaContext
  is native(gda)
  is export
{ * }

sub gda_meta_context_set_column (
  GdaMetaContext $ctx,
  Str            $column,
  GValue         $value,
  GdaConnection  $cnc
)
  is native(gda)
  is export
{ * }

sub gda_meta_context_set_columns (
  GdaMetaContext $ctx,
  GHashTable     $columns,
  GdaConnection  $cnc
)
  is native(gda)
  is export
{ * }

sub gda_meta_context_set_table (GdaMetaContext $ctx, Str $table)
  is native(gda)
  is export
{ * }

sub gda_meta_store_create_modify_data_model (
  GdaMetaStore $store,
  Str          $table_name
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_meta_store_declare_foreign_key (
  GdaMetaStore            $store,
  GdaMetaStruct           $mstruct,
  Str                     $fk_name,
  Str                     $catalog,
  Str                     $schema,
  Str                     $table,
  Str                     $ref_catalog,
  Str                     $ref_schema,
  Str                     $ref_table,
  guint                   $nb_cols,
  CArray[Str]             $colnames,
  CArray[Str]             $ref_colnames,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_meta_store_extract (
  GdaMetaStore            $store,
  Str                     $select_sql,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_meta_store_extract_v (
  GdaMetaStore            $store,
  Str                     $select_sql,
  GHashTable              $vars,
  CArray[Pointer[GError]] $error
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_meta_store_get_attribute_value (
  GdaMetaStore            $store,
  Str                     $att_name,
  CArray[Str]             $att_value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_get_internal_connection (GdaMetaStore $store)
  returns GdaConnection
  is native(gda)
  is export
{ * }

sub gda_meta_store_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_meta_store_get_version (GdaMetaStore $store)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_meta_store_modify (
  GdaMetaStore            $store,
  Str                     $table_name,
  GdaDataModel            $new_data,
  Str                     $condition,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_modify_v (
  GdaMetaStore            $store,
  Str                     $table_name,
  GdaDataModel            $new_data,
  Str                     $condition,
  gint                    $nvalues,
  CArray[Str]             $value_names,
  CArray[GValue]          $values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_modify_with_context (
  GdaMetaStore            $store,
  GdaMetaContext          $context,
  GdaDataModel            $new_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_new (Str $cnc_string)
  returns GdaMetaStore
  is native(gda)
  is export
{ * }

sub gda_meta_store_new_with_file (Str $file_name)
  returns GdaMetaStore
  is native(gda)
  is export
{ * }

sub gda_meta_store_schema_add_custom_object (
  GdaMetaStore            $store,
  Str                     $xml_description,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_schema_get_all_tables (GdaMetaStore $store)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_meta_store_schema_get_depend_tables (
  GdaMetaStore $store,
  Str          $table_name
)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_meta_store_schema_get_structure (
  GdaMetaStore            $store,
  CArray[Pointer[GError]] $error
)
  returns GdaMetaStruct
  is native(gda)
  is export
{ * }

sub gda_meta_store_schema_remove_custom_object (
  GdaMetaStore            $store,
  Str                     $obj_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_set_attribute_value (
  GdaMetaStore            $store,
  Str                     $att_name,
  Str                     $att_value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_meta_store_set_identifiers_style (
  GdaMetaStore $store,
  GdaSqlIdentifierStyle $style
)
  is native(gda)
  is export
{ * }

sub gda_meta_store_set_reserved_keywords_func (
  GdaMetaStore $store,
               &func   #= GdaSqlReservedKeywordsFunc
)
  is native(gda)
  is export
{ * }

sub gda_meta_store_sql_identifier_quote (Str $id, GdaConnection $cnc)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_meta_store_undeclare_foreign_key (
  GdaMetaStore            $store,
  GdaMetaStruct           $mstruct,
  Str                     $fk_name,
  Str                     $catalog,
  Str                     $schema,
  Str                     $table,
  Str                     $ref_catalog,
  Str                     $ref_schema,
  Str                     $ref_table,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
