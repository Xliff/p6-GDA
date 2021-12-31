use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;

use GDA::Tree::Manager;

our subset GdaTreeMgrSelectAncestry is export of Mu
  where GdaTreeMgrSelect | GdaTreeManagerAncestry;

class GDA::Tree::Manager::Select is GDA::Tree::Manager {
  has GdaTreeMgrSelect $!gtms is implementor;

  submethod BUILD ( :$gda-tree-manager ) {
    self.setGdaTreeMgrSelect($gda-tree-manager) if $gda-tree-manager;
  }

  method setGdaTreeMgrSelect (GdaTreeMgrSelectAncestry $_) {
    my $to-parent;
    $!gtms = do {
      when GdaTreeMgrSelect {
        $to-parent = cast(GdaTreeManager, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTreeMgrSelect, $_);
      }
    }
    self.setGdaTreeManager($to-parent);
  }

  method GDA::Raw::Definition::GdaTreeMgrSelect
    is also<GdaTreeMgrSelect>
  { $!gtms }

  multi method new (
    GdaTreeMgrSelectAncestry $gda-tree-mgr-select,
                             :$ref                 = True
  ) {
    return Nil unless $gda-tree-mgr-select;

    my $o = self.bless( :$gda-tree-mgr-select );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaStatement() $stmt, GdaSet() $params) {
    my $gda-tree-mgr-select = gda_tree_mgr_select_new($stmt, $params);

    $gda-tree-mgr-select ?? self.bless( :$gda-tree-mgr-select ) !! Nil;
  }

  # Type: GdaConnection
  method connection ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Connection.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('connection', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Connection.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'connection is a construct-only attribute'
      }
    );
  }

  # Type: GdaSet
  method params ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Set.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('params', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Set.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'params is a construct-only attribute'
      }
    );
  }

  # Type: GdaStatement
  method statement ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Statement.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('statement', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Statement.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'statement is a construct-only attribute'
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_mgr_select_get_type, $n, $t );
  }

}

### /usr/include/libgda-5.0/libgda/gda-tree-mgr-select.h

sub gda_tree_mgr_select_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_mgr_select_new (
  GdaConnection $cnc,
  GdaStatement  $stmt,
  GdaSet        $params
)
  returns GdaTreeMgrSelect
  is native(gda)
  is export
{ * }
