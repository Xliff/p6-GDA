use v6.c;

use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Tree::Manager;

use GLib::GList;
use GDA::Tree::Node;

use GLib::Roles::Object;

our subset GdaTreeManagerAncestry is export of Mu
  where GdaTreeManager | GObject;

class GDA::Tree::Manager {
  also does GLib::Roles::Object;

  has GdaTreeManager $!gtm;

  submethod BUILD ( :$gda-tree-manager ) {
    self.setGdaTreeManager($gda-tree-manager) if $gda-tree-manager;
  }

  method setGdaTreeManager (GdaTreeManagerAncestry $_) {
    my $to-parent;
    $!gtm = do {
      when GdaTreeManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTreeManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaTreeManager
    is also<GdaTreeManager>
  { $!gtm }

  method new_with_func ( &update_func )
    is also<
      new
      new-with-func
    >
  {
    my $gda-tree-manager = gda_tree_manager_new_with_func(
      $!gtm,
      &update_func
    );

    $gda-tree-manager ?? self.bless( :$gda-tree-manager ) !! Nil;
  }

  # Type: gpointer - Eventually to return a callable.
  method func is rw
    is also<gda_tree_manager>
  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('func', $gv)
        );
        $gv.pointer
      },
      STORE => -> $,  $val is copy {
        warn 'func is a construct-only attribute'
      }
    );
  }

  # Type: gboolean
  method recursive is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('recursive', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'recursive is a construct-only attribute'
      }
    );
  }


  method add_manager (GdaTreeManager() $sub) is also<add-manager> {
    gda_tree_manager_add_manager($!gtm, $sub);
  }

  method add_new_node_attribute (Str() $attribute, GValue() $value)
    is also<add-new-node-attribute>
  {
    gda_tree_manager_add_new_node_attribute($!gtm, $attribute, $value);
  }

  method create_node (GdaTreeNode() $parent, Str() $name, :$raw = False)
    is also<create-node>
  {
    propReturnObject(
      gda_tree_manager_create_node($!gtm, $parent, $name),
      $raw,
      |GDA::Tree::Node.getTypePair
    );
  }

  method error_quark ( GDA::Tree::Manager:U: ) is also<error-quark> {
    gda_tree_manager_error_quark();
  }

  method get_managers ( :$glist = False, :$raw = False )
    is also<get-managers>
  {
    returnGList(
      gda_tree_manager_get_managers($!gtm),
      $raw,
      $glist,
      |GDA::Tree::Manager.getTypePair
    );
  }

  method get_node_create_func is also<get-node-create-func> {
    gda_tree_manager_get_node_create_func($!gtm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_manager_get_type, $n, $t );
  }

  method set_node_create_func (&func)
    is also<set-node-create-func>
  {
    gda_tree_manager_set_node_create_func($!gtm, &func);
  }


}
