use v6.c;

use Method::Also;

use GDA::Raw::Types;

use GDA::Connection;
#use GDA::Meta::Store;

use GDA::Tree::Manager;

our subset GdaTreeMgrColumnsAncestry is export of Mu
  where GdaTreeMgrColumns | GdaTreeManagerAncestry;

class GDA::Tree::Manager::Columns is GDA::Tree::Manager {
  has GdaTreeMgrColumns $!gtmt is implementor;

  submethod BUILD ( :$gda-tree-mgr-column ) {
    self.setGdaTreeMgrColumns($gda-tree-mgr-column) if $gda-tree-mgr-column;
  }

  method setGdaTreeMgrColumns (GdaTreeMgrColumnsAncestry $_) {
    my $to-parent;
    $!gtmt = do {
      when GdaTreeMgrColumns {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTreeMgrColumns, $_);
      }
    }
    self.setGdaTreeManager($to-parent);
  }

  method GDA::Raw::Definition::GdaTreeMgrColumns
    is also<GdaTreeMgrColumns>
  { $!gtmt }

  multi method new (
    GdaTreeMgrColumnsAncestry  $gda-tree-mgr-column,
                              :$ref                   = True
  ) {
    return Nil unless $gda-tree-mgr-column;

    my $o = self.bless( :$gda-tree-mgr-column );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GdaConnection() $cnc,
    Str()           $schema,
    Str()           $table-name
  ) {
    my $gda-tree-mgr-column = gda_tree_mgr_columns_new(
      $cnc,
      $schema,
      $table-name
    );

    $gda-tree-mgr-column ?? self.bless( :$gda-tree-mgr-column ) !! Nil;
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

  # Type: string
  # method table-name is rw { ... }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_mgr_columns_get_type, $n, $t );
  }

}

### /usr/include/libgda-5.0/libgda/gda-tree-mgr-column.h

sub gda_tree_mgr_columns_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_mgr_columns_new (GdaConnection $cnc, Str $schema, Str $table-name)
  returns GdaTreeMgrColumns
  is native(gda)
  is export
{ * }
