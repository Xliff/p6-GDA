use v6.c;

use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Tree::Node;

use GLib::Value;
use GLib::GList;

use GLib::Roles::Object;
use GDA::Roles::Signals::Tree::Node;

our subset GdaTreeNodeAncestry is export of Mu
  where GdaTreeNode | GObject;

class GDA::Tree::Node {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Tree::Node;

  has GdaTreeNode $!gtn;

  submethod BUILD ( :$gda-tree-node ) {
    self.setGdaTreeNode($gda-tree-node) if $gda-tree-node;
  }

  method setGdaTreeNode (GdaTreeNodeAncestry $_) {
    my $to-parent;
    $!gtn = do {
      when GdaTreeNode {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTreeNode, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaTreeNode
    is also<GdaTreeNode>
  { $!gtn }

  multi method new (GdaTreeNodeAncestry $gda-tree-node, :$ref = True) {
    return Nil unless $gda-tree-node;

    my $o = self.bless( :$gda-tree-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name) {
    my $gda-tree-node = gda_tree_node_new($name);

    $gda-tree-node ?? self.bless( :$gda-tree-node ) !! Nil;
  }

  # Type: gchar
  method name is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Is originally:
  # GdaTreeNode, GdaTreeNode, gpointer --> void
  method node-inserted is also<node_inserted> {
    self.connect-node-inserted($!gtn, 'node-inserted');
  }

  # Is originally:
  # GdaTreeNode, GdaTreeNode, gpointer --> void
  method node-has-child-toggled is also<node_has_child_toggled> {
    self.connect-node-has-child-toggled($!gtn, 'node-has-child-toggled');
  }

  # Is originally:
  # GdaTreeNode, gchar, gpointer --> void
  method node-deleted is also<node_deleted> {
    self.connect-node-deleted($!gtn, 'node-deleted');
  }

  # Is originally:
  # GdaTreeNode, GdaTreeNode, gpointer --> void
  method node-changed is also<node_changed> {
    self.connect-node-changed($!gtn, 'node-changed');
  }

  method error_quark ( GDA::Tree::Node:U: ) is also<error-quark> {
    gda_tree_node_error_quark();
  }

  method fetch_attribute (Str() $attribute, :$raw = False)
    is also<fetch-attribute>
  {
    propReturnObject(
      gda_tree_node_fetch_attribute($!gtn, $attribute),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_child_index (Int() $index, :$raw = False)
    is also<get-child-index>
  {
    my gint $i = $index;

    propReturnObject(
      gda_tree_node_get_child_index($!gtn, $i),
      $raw,
      |GDA::Tree::Node.getTypePair
    );
  }

  method get_child_name (Str() $name, :$raw = False) is also<get-child-name> {
    propReturnObject(
      gda_tree_node_get_child_name($!gtn, $name),
      $raw,
      |GDA::Tree::Node.getTypePair
    );
  }

  method get_children (:$glist = False, :$raw = False) is also<get-children> {
    returnGList(
      gda_tree_node_get_children($!gtn),
      $raw,
      $glist,
      |GDA::Tree::Node.getTypePair
    );
  }

  method get_node_attribute (Str() $attribute, :$raw = False)
    is also<get-node-attribute>
  {
    propReturnObject(
      gda_tree_node_get_node_attribute($!gtn, $attribute),
      $raw,
      |GLib::Value.getTypePair
    )
  }

  method get_parent ( :$raw = False ) is also<get-parent> {
    propReturnObject(
      gda_tree_node_get_parent($!gtn),
      $raw,
      |GDA::Tree::Node.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_node_get_type, $n, $t);
  }

  method set_node_attribute (
    Str()          $attribute,
    GValue()       $value,
    GDestroyNotify $destroy    = gpointer
  )
    is also<set-node-attribute>
  {
    gda_tree_node_set_node_attribute($!gtn, $attribute, $value, $destroy);
  }

}
