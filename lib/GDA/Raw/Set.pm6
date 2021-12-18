use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use LibXML::Raw;                  # for anyNode
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Set;

### /usr/include/libgda-5.0/libgda/gda-set.h

sub _gda_set_validate (GdaSet $set, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_set_add_holder (GdaSet $set, GdaHolder $holder)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_set_copy (GdaSet $set)
  returns GdaSet
  is native(gda)
  is export
{ * }

sub gda_set_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_set_get_group (GdaSet $set, GdaHolder $holder)
  returns GdaSetGroup
  is native(gda)
  is export
{ * }

sub gda_set_get_holder (GdaSet $set, Str $holder_id)
  returns GdaHolder
  is native(gda)
  is export
{ * }

sub gda_set_get_holder_value (GdaSet $set, Str $holder_id)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_set_get_node (GdaSet $set, GdaHolder $holder)
  returns GdaSetNode
  is native(gda)
  is export
{ * }

sub gda_set_get_nth_holder (GdaSet $set, gint $pos)
  returns GdaHolder
  is native(gda)
  is export
{ * }

sub gda_set_get_source (GdaSet $set, GdaHolder $holder)
  returns GdaSetSource
  is native(gda)
  is export
{ * }

sub gda_set_get_source_for_model (GdaSet $set, GdaDataModel $model)
  returns GdaSetSource
  is native(gda)
  is export
{ * }

sub gda_set_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_set_group_add_node (GdaSetGroup $sg, GdaSetNode $node)
  is native(gda)
  is export
{ * }

sub gda_set_group_copy (GdaSetGroup $sg)
  returns GdaSetGroup
  is native(gda)
  is export
{ * }

sub gda_set_group_free (GdaSetGroup $sg)
  is native(gda)
  is export
{ * }

sub gda_set_group_get_n_nodes (GdaSetGroup $sg)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_set_group_get_node (GdaSetGroup $sg)
  returns GdaSetNode
  is native(gda)
  is export
{ * }

sub gda_set_group_get_nodes (GdaSetGroup $sg)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_set_group_get_source (GdaSetGroup $sg)
  returns GdaSetSource
  is native(gda)
  is export
{ * }

sub gda_set_group_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_set_group_new (GdaSetNode $node)
  returns GdaSetGroup
  is native(gda)
  is export
{ * }

sub gda_set_group_set_source (GdaSetGroup $sg, GdaSetSource $source)
  is native(gda)
  is export
{ * }

sub gda_set_is_valid (GdaSet $set, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_set_merge_with_set (GdaSet $set, GdaSet $set_to_merge)
  is native(gda)
  is export
{ * }

sub gda_set_new (GSList $holders)
  returns GdaSet
  is native(gda)
  is export
{ * }

sub gda_set_new_from_spec_node (
  anyNode                 $xml_spec, # xmlNodePtr
  CArray[Pointer[GError]] $error
)
  returns GdaSet
  is native(gda)
  is export
{ * }

sub gda_set_new_from_spec_string (
  Str                     $xml_spec,
  CArray[Pointer[GError]] $error
)
  returns GdaSet
  is native(gda)
  is export
{ * }

sub gda_set_new_inline (gint $nb)
  returns GdaSet
  is native(gda)
  is export
{ * }

sub gda_set_new_read_only (GSList $holders)
  returns GdaSet
  is native(gda)
  is export
{ * }

sub gda_set_node_copy (GdaSetNode $node)
  returns GdaSetNode
  is native(gda)
  is export
{ * }

sub gda_set_node_free (GdaSetNode $node)
  is native(gda)
  is export
{ * }

sub gda_set_node_get_data_model (GdaSetNode $node)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_set_node_get_holder (GdaSetNode $node)
  returns GdaHolder
  is native(gda)
  is export
{ * }

sub gda_set_node_get_source_column (GdaSetNode $node)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_set_node_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_set_node_new (GdaHolder $holder)
  returns GdaSetNode
  is native(gda)
  is export
{ * }

sub gda_set_node_set_data_model (GdaSetNode $node, GdaDataModel $model)
  is native(gda)
  is export
{ * }

sub gda_set_node_set_holder (GdaSetNode $node, GdaHolder $holder)
  is native(gda)
  is export
{ * }

sub gda_set_node_set_source_column (GdaSetNode $node, gint $column)
  is native(gda)
  is export
{ * }

sub gda_set_remove_holder (GdaSet $set, GdaHolder $holder)
  is native(gda)
  is export
{ * }

sub gda_set_replace_source_model (
  GdaSet       $set,
  GdaSetSource $source,
  GdaDataModel $model
)
  is native(gda)
  is export
{ * }

sub gda_set_set_holder_value (
  GdaSet                  $set,
  CArray[Pointer[GError]] $error,
  Str                     $holder_id
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_set_source_add_node (GdaSetSource $s, GdaSetNode $node)
  is native(gda)
  is export
{ * }

sub gda_set_source_copy (GdaSetSource $s)
  returns GdaSetSource
  is native(gda)
  is export
{ * }

sub gda_set_source_free (GdaSetSource $s)
  is native(gda)
  is export
{ * }

sub gda_set_source_get_data_model (GdaSetSource $s)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_set_source_get_n_nodes (GdaSetSource $s)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_set_source_get_nodes (GdaSetSource $s)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_set_source_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_set_source_new (GdaDataModel $model)
  returns GdaSetSource
  is native(gda)
  is export
{ * }

sub gda_set_source_set_data_model (GdaSetSource $s, GdaDataModel $model)
  is native(gda)
  is export
{ * }
