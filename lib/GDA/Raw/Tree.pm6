use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Tree;

### /usr/include/libgda-5.0/libgda/gda-tree.h

sub gda_tree_add_manager (GdaTree $tree, GdaTreeManager $manager)
  is native(gda)
  is export
{ * }

sub gda_tree_clean (GdaTree $tree)
  is native(gda)
  is export
{ * }

sub gda_tree_dump (GdaTree $tree, GdaTreeNode $node, Pointer $stream)
  is native(gda)
  is export
{ * }

sub gda_tree_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_tree_get_node (GdaTree $tree, Str $tree_path, gboolean $use_names)
  returns GdaTreeNode
  is native(gda)
  is export
{ * }

sub gda_tree_get_node_manager (GdaTree $tree, GdaTreeNode $node)
  returns GdaTreeManager
  is native(gda)
  is export
{ * }

sub gda_tree_get_node_path (GdaTree $tree, GdaTreeNode $node)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_tree_get_nodes_in_path (
  GdaTree  $tree,
  Str      $tree_path,
  gboolean $use_names
)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_tree_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_new ()
  returns GdaTree
  is native(gda)
  is export
{ * }

sub gda_tree_set_attribute (
  GdaTree  $tree,
  Str      $attribute,
  GValue   $value,
  Pointer  $destroy
)
  is native(gda)
  is export
{ * }

sub gda_tree_update_all (GdaTree $tree, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_tree_update_children (
  GdaTree                 $tree,
  GdaTreeNode             $node,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_tree_update_part (
  GdaTree                 $tree, 
  GdaTreeNode             $node, 
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }
