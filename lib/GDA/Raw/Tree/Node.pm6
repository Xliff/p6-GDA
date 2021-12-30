use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Tree::Node;

### /usr/include/libgda-5.0/libgda/gda-tree-node.h

# "Private"
sub _gda_tree_node_add_children (
  GdaTreeNode    $node,
  GdaTreeManager $mgr,
  GSList         $children
)
  is native(gda)
  is export
{ * }

sub _gda_tree_node_get_children_for_manager (
  GdaTreeNode    $node, 
  GdaTreeManager $mgr
)
  returns GSList
  is native(gda)
  is export
{ * }

sub _gda_tree_node_get_manager_for_child (
  GdaTreeNode $node,
  GdaTreeNode $child
)
  returns GdaTreeManager
  is native(gda)
  is export
{ * }

sub _gda_tree_node_get_managers_for_children (GdaTreeNode $node)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_tree_node_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_tree_node_fetch_attribute (GdaTreeNode $node, Str $attribute)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_tree_node_get_child_index (GdaTreeNode $node, gint $index)
  returns GdaTreeNode
  is native(gda)
  is export
{ * }

sub gda_tree_node_get_child_name (GdaTreeNode $node, Str $name)
  returns GdaTreeNode
  is native(gda)
  is export
{ * }

sub gda_tree_node_get_children (GdaTreeNode $node)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_tree_node_get_node_attribute (GdaTreeNode $node, Str $attribute)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_tree_node_get_parent (GdaTreeNode $node)
  returns GdaTreeNode
  is native(gda)
  is export
{ * }

sub gda_tree_node_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_node_new (Str $name)
  returns GdaTreeNode
  is native(gda)
  is export
{ * }

sub gda_tree_node_set_node_attribute (
  GdaTreeNode    $node,
  Str            $attribute,
  GValue         $value,
  GDestroyNotify $destroy
)
  is native(gda)
  is export
{ * }
