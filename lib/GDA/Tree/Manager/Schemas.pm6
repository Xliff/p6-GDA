use v6.c;

use Method::Also;

use GDA::Raw::Types;

use GDA::Connection;
#use GDA::Meta::Store;

use GDA::Tree::Manager;

our subset GdaTreeMgrSchemasAncestry is export of Mu
  where GdaTreeMgrSchemas | GdaTreeManagerAncestry;

class GDA::Tree::Manager::Schemas is GDA::Tree::Manager {
  has GdaTreeMgrSchemas $!gtms is implementor;

  submethod BUILD ( :$gda-tree-mgr-schemas ) {
    self.setGdaTreeMgrSchemas($gda-tree-mgr-schemas) if $gda-tree-mgr-schemas;
  }

  method setGdaTreeMgrSchemas (GdaTreeMgrSchemasAncestry $_) {
    my $to-parent;
    $!gtms = do {
      when GdaTreeMgrSchemas {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTreeMgrSchemas, $_);
      }
    }
    self.setGdaTreeManager($to-parent);
  }

  method GDA::Raw::Definition::GdaTreeMgrSchemaws
    is also<GdaTreeMgrSchemas>
  { $!gtms }

  multi method new (
    GdaTreeMgrSchemasAncestry  $gda-tree-mgr-schemas,
                              :$ref                   = True
  ) {
    return Nil unless $gda-tree-mgr-schemas;

    my $o = self.bless( :$gda-tree-mgr-schemas );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaConnection() $cnc) {
    my $gda-tree-mgr-schemas = gda_tree_mgr_schemas_new($cnc);

    $gda-tree-mgr-schemas ?? self.bless( :$gda-tree-mgr-schemas ) !! Nil;
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

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_mgr_schemas_get_type, $n, $t );
  }

}

### /usr/include/libgda-5.0/libgda/gda-tree-mgr-schemas.h

sub gda_tree_mgr_schemas_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_mgr_schemas_new (GdaConnection $cnc)
  returns GdaTreeMgrSchemas
  is native(gda)
  is export
{ * }
