use v6.c;

use Method::Also;

use GDA::Raw::Types;

use GDA::Connection;

use GDA::Tree::Manager;

our subset GdaTreeMgrLdapAncestry is export of Mu
  where GdaTreeMgrLdap | GdaTreeManagerAncestry;

class GDA::Tree::Manager::Ldap is GDA::Tree::Manager {
  has GdaTreeMgrLdap $!gtml is implementor;

  submethod BUILD ( :$gda-tree-mgr-ldap ) {
    self.setGdaTreeMgrLdap($gda-tree-mgr-ldap) if $gda-tree-mgr-ldap;
  }

  method setGdaTreeMgrLdap (GdaTreeMgrLdapAncestry $_) {
    my $to-parent;
    $!gtml = do {
      when GdaTreeMgrLdap {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaTreeMgrLdap, $_);
      }
    }
    self.setGdaTreeManager($to-parent);
  }

  method GDA::Raw::Definition::GdaTreeMgrLdap
    is also<GdaTreeMgrLdap>
  { $!gtml }

  multi method new (
    GdaTreeMgrLdapAncestry  $gda-tree-mgr-ldap,
                           :$ref                   = True
  ) {
    return Nil unless $gda-tree-mgr-ldap;

    my $o = self.bless( :$gda-tree-mgr-ldap );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaConnection() $cnc, Str() $dn) {
    my $gda-tree-mgr-ldap = gda_tree_mgr_ldap_new($cnc, $dn);

    $gda-tree-mgr-ldap ?? self.bless( :$gda-tree-mgr-ldap ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_tree_mgr_ldap_get_type, $n, $t );
  }

}

### /usr/include/libgda-5.0/libgda/gda-tree-mgr-ldap.h

sub gda_tree_mgr_ldap_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_tree_mgr_ldap_new (GdaConnection $cnc, Str $dn)
  returns GdaTreeMgrLdap
  is native(gda)
  is export
{ * }
