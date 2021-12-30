use v6.c;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Tree;

use GLib::Roles::Object;

use GDA::Roles::Signals::Tree;

class GDA::Tree {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Tree;

  has GdaTree $!gt is implementor;

  method new {
    my $gda-tree = gda_tree_new();

    $gda-tree ?? self.bless( :$gda-tree ) !! Nil;
  }

  # Type: gboolean
  method is-list is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('is-list', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'is-list does not allow writing'
      }
    );
  }

  # Is originally:
  # GdaTree, GdaTreeNode, gpointer --> void
  method node-changed {
    self.connect-tree-node($!gt, 'node-changed');
  }

  # Is originally:
  # GdaTree, GdaTreeNode, gpointer --> void
  method node-has-child-toggled {
    self.connect-tree-node($!gt, 'node-has-child-toggle');
  }

  # Is originally:
  # GdaTree, gchar, gpointer --> void
  method node-deleted {
    self.connect-string($!gt, 'node-deleted');
  }

  # Is originally:
  # GdaTree, GdaTreeNode, gpointer --> void
  method node-inserted {
    self.connect-tree-node($!gt, 'node-inserted');
  }

  method add_manager (GdaTreeManager() $manager) {
    gda_tree_add_manager($!gt, $manager);
  }

  method clean {
    gda_tree_clean($!gt);
  }

  method dump (GdaTreeNode() $node, gpointer $stream) {
    gda_tree_dump($!gt, $node, $stream);
  }

  method error_quark ( GDA::Tree:U: ) {
    gda_tree_error_quark();
  }

  method get_node (Str() $tree_path, Int() $use_names, :$raw = False) {
    my gboolean $u = $use_names.so.Int;

    propReturnObject(
      gda_tree_get_node($!gt, $tree_path, $use_names),
      $raw,
      |GDA::Tree::Node
    );
  }

  method get_node_manager (GdaTreeNode() $node, :$raw = False) {
    propReturnObject(
      gda_tree_get_node_manager($!gt, $node),
      $raw,
      |GDA::Tree::Manager
    );
  }

  method get_node_path (GdaTreeNode() $node) {
    gda_tree_get_node_path($!gt, $node);
  }

  method get_nodes_in_path (Str() $tree_path, Int() $use_names) {
    my gboolean $u = $use_names.so.Int;

    gda_tree_get_nodes_in_path($!gt, $tree_path, $u);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_get_type, $n, $t );
  }

  method set_attribute (
    Str()          $attribute,
    GValue()       $value,
    GDestroyNotify $destroy    = gpointer
  ) {
    gda_tree_set_attribute($!gt, $attribute, $value, $destroy);
  }

  method update_all (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = gda_tree_update_all($!gt, $error);
    set_error($error);
    $rv;
  }

  method update_children (
    GdaTreeNode()           $node,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so gda_tree_update_children($!gt, $node, $error);
    set_error($error);
    $rv;
  }

  method update_part (
    GdaTreeNode()           $node,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so gda_tree_update_part($!gt, $node, $error);
    set_error($error);
    $rv;
  }

}
