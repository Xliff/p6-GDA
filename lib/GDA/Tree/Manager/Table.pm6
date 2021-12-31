use v6.c;

use Method::Also;

use GDA::Raw::Types;

use GDA::Connection;
#use GDA::Meta::Store;

use GDA::Tree::Manager;

our subset GdaTreeMgrTableAncestry is export of Mu
  where GdaTreeMgrTables | GdaTreeManagerAncestry;

class GDA::Tree::Manager::Table is GDA::Tree::Manager {
  has GdaTreeMgrTables $!gtmt is implementor;

  submethod BUILD ( :$gda-tree-mgr-table ) {
    self.setGdaTreeMgrTable($gda-tree-mgr-table) if $gda-tree-mgr-table;
  }

  method setGdaTreeMgrTable (GdaTreeMgrTableAncestry $_) {
    my $to-parent;
    $!gtmt = do {
      when GdaTreeMgrTables {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTreeMgrTables, $_);
      }
    }
    self.setGdaTreeManager($to-parent);
  }

  method GDA::Raw::Definition::GdaTreeMgrTables
    is also<GdaTreeMgrTables>
  { $!gtmt }

  multi method new (
    GdaTreeMgrTableAncestry  $gda-tree-mgr-table,
                            :$ref                   = True
  ) {
    return Nil unless $gda-tree-mgr-table;

    my $o = self.bless( :$gda-tree-mgr-table );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaConnection() $cnc) {
    my $gda-tree-mgr-table = gda_tree_mgr_table_new($cnc);

    $gda-tree-mgr-table ?? self.bless( :$gda-tree-mgr-table ) !! Nil;
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

  # Type: GdaMetaStore
  method meta-store ( :$raw = False ) is rw  is also<meta_store> {
    my $gv = GLib::Value.new( GDA::Meta::Store.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('meta-store', $gv)
        );

        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Meta::Store.getTypePair
        );
      },
      STORE => -> $, $val is copy {
        warn 'meta-store is a construct-only attribute'
      }
    );
  }

  # Type: string
  # method schema is rw { ... }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_mgr_table_get_type, $n, $t );
  }

}

### /usr/include/libgda-5.0/libgda/gda-tree-mgr-table.h

sub gda_tree_mgr_table_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_mgr_table_new (GdaConnection $cnc, Str $schema)
  returns GdaTreeMgrTables
  is native(gda)
  is export
{ * }
