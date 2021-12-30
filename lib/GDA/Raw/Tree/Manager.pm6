use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Tree::Manager;


### /usr/include/libgda-5.0/libgda/gda-tree-manager.h

sub _gda_tree_manager_update_children (
  GdaTreeManager          $manager,
  GdaTreeNode             $node,
  GSList                  $children_nodes,
  gboolean                $out_error,
  CArray[Pointer[GError]] $error
)
  is native(gda)
  is export
{ * }

sub gda_tree_manager_add_manager (GdaTreeManager $manager, GdaTreeManager $sub)
  is native(gda)
  is export
{ * }

sub gda_tree_manager_add_new_node_attribute (
  GdaTreeManager $manager,
  Str            $attribute,
  GValue         $value
 )
  is native(gda)
  is export
{ * }

sub gda_tree_manager_create_node (
  GdaTreeManager $manager,
  GdaTreeNode    $parent,
  Str            $name
)
  returns GdaTreeNode
  is native(gda)
  is export
{ * }

sub gda_tree_manager_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_tree_manager_get_managers (GdaTreeManager $manager)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_tree_manager_get_node_create_func (GdaTreeManager $manager)
  returns gpointer # GdaTreeManagerNodeFunc
  is native(gda)
  is export
{ * }

sub gda_tree_manager_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_manager_new_with_func (
  # GdaTreeManagerNodeFunc
  &update_func (
    GdaTreeManager,
    GdaTreeNode,
    GSList,
    gboolean,
    CArray[Pointer[GError]]
    --> GSList
  )
)
  returns GdaTreeManager
  is native(gda)
  is export
{ * }

sub gda_tree_manager_set_node_create_func (
  GdaTreeManager  $manager,
                  &update_func (
                    GdaTreeManager,
                    GdaTreeNode,
                    GSList,
                    gboolean,
                    CArray[Pointer[GError]]
                    --> GSList
                  )
)
  is native(gda)
  is export
{ * }
