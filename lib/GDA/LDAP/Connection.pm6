use v6.c;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::LDAP::Connection;

our subset GdaLdapConnectionAncestry is export of Mu
  where GdaLdapConnection | GdaVconnectionDataModelAncestry;

class GDA::LDAP::Connection is GDA::Virtual::Connection::Data::Model {
  has GdaLdapConnection $!glc;

  submethod BUILD ( :$gda-ldap-connection ) {
    self.setGdaLdapConnection($gda-ldap-connection) if $gda-ldap-connection;
  }

  method setGdaLdapConnection (GdaLdapConnectionAncestry $_) {
    my $to-parent;
    $!glc = do {
      when GdaLdapConnection {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaVconnectionDataModel, $_);
      }
    }
    self.setGdaVconnectionDataModel($to-parent);
  }

  method GDA::Raw::Definition::GdaLdapConnection
    is also<GdaLdapConnection>
  { $!glc }

  multi method new (
    GdaLdapConnectionAncestry  $gda-ldap-connection,
                              :$ref                  = True
  ) {
    return Nil unless $gda-ldap-connection;

    my $o = self.bless( :$gda-ldap-connection );
    $o.ref if $ref;
    $o;
  }

  #| Property-type: GdaConnection
  method connection ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Connection.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('connection', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Connection.getTypePair
        );
      },
      STORE => -> $, GdaConnection() $val is copy {
        $gv.object = $val;
        self.prop_set('connection', $gv);
      }
    );
  }

  #| Property-type: Str
  method dn is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('dn', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('dn', $gv);
      }
    );
  }

  method declare_table (
    Str()                   $table_name,
    Str()                   $base_dn,
    Str()                   $filter,
    Str()                   $attributes,
    Int()                   $scope,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    my GdaLdapSearchScope $s = $scope;

    clear_error;
    my $rv = so gda_ldap_connection_declare_table(
      $!glc,
      $table_name,
      $base_dn,
      $filter,
      $attributes,
      $s,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method describe_table (|)
  { * }

  multi method describe_table (
    Str()                  $table_name,
    Array[Pointer[GError]] $error       = gerror
  ) {
    return-with-all(
      samewith($table_name, $, $, $, $, $error, :all)
    )
  }
  multi method describe_table (
    Str()                   $table_name,
                            $out_base_dn    is rw,
                            $out_filter     is rw,
                            $out_attributes is rw,
                            $out_scope      is rw,
    Array[Pointer[GError]]  $error,
                           :$all            =  False
  ) {
    my GdaLdapSearchScope $oss = 0;
    my ($obd, $of, $oa) = newCArray(Str) xx 3;

    clear_error;
    my $rv = so gda_ldap_connection_describe_table(
      $!glc,
      $table_name,
      $obd,
      $of,
      $oa,
      $oss,
      $error
    );
    set_error($error);
    ($out-base_dn, $out_filter, $out_attributes, $out_scope) =
      ( |ppr($obd, $of, $oa), GdaLdapSearchScope($oss) )
    $rv;
  }

  method add_entry (
    GdaLdapEntry()          $entry,
    CArray[Pointer[GError]] $error  = gerror
  ) {
    clear_error;
    my $rv = so gda_ldap_add_entry($!glc, $entry, $error);
    set_error($error);
    $rv;
  }

  method attributes_list_free {
    gda_ldap_attributes_list_free($!glc);
  }

  method describe_entry (
    Str()                    $dn,
    CArray[Pointer[GError]]  $error = gerror
                            :$raw   = False
  ) {
    my $o = propReturnObject(
      gda_ldap_describe_entry($!glc, $dn, $error),
      $raw
      |GDA::LDAP::Entry.getTypePair
    );

    $o.setConnection($!glc) unless $raw;
    $o;
  }

  method dn_split (GDA::LDAP::Connection:U: Str() $many, Int() $all) {
    my gboolean $a = $all.so.Int;

    CArrayToArray( gda_ldap_dn_split($many, $all) );
  }

  method get_class_info (Str() $classname) {
    gda_ldap_get_class_info($!glc, $classname);
  }

  proto method get_entry_children (|)
  { * }

  multi method get_entry_children (
    Str()                    $dn,
                             @attributes,
    CArray[Pointer[GError]]  $error       = gerror
  ) {
    samewith( $dn, ArrayToCArray(Str, @attributes), $error )
  }
  multi method get_entry_children (
    Str()                    $dn,
    CArray[Str]              $attributes,
    CArray[Pointer[GError]]  $error       = gerror
                            :$raw         = False,
                            :$glist       = False
  ) {
    returnGList(
      gda_ldap_get_entry_children($!glc, $dn, $attributes, $error),
      $raw,
      $glist,
      |GDA::LDAP::Entry.getTypePair
    );
  }

  # - Hold this for the ::Class version of this package.
  #   Add via `augment class`
  # - However GdaLdapClass is NOT GObject base, so maybe reconsider?
  # method gda_ldap_get_top_classes {
  #   gda_ldap_get_top_classes($!glc);
  # }

  method gda_ldap_is_dn {
    so gda_ldap_is_dn($!glc);
  }

  method modify_entry (
    Int()                   $modtype,
    GdaLdapEntry()          $entry,
    GdaLdapEntry()          $ref_entry,
    CArray[Pointer[GError]] $error      = gerror
  ) {
    my GdaLdapModificationType $m = $modtype;

    gda_ldap_modify_entry($!glc, $m, $entry, $ref_entry, $error);
  }

  method remove_entry (Str() $dn, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so gda_ldap_remove_entry($!glc, $dn, $error);
    set_error($error);
    $rv;
  }

  method rename_entry (
    Str()                   $current_dn,
    Str()                   $new_dn,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so gda_ldap_rename_entry($!glc, $current_dn, $new_dn, $error);
    set_error($error);
    $rv;
  }

  method get_base_dn {
    gda_ldap_connection_get_base_dn($!glc);
  }

  method undeclare_table (
    Str()                   $table_name,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error;
    my $rv = so gda_ldap_connection_undeclare_table($!glc, $table_name, $error);
    set_error($error);
    $rv;
  }

}


class GDA::LDAP::Entry {
  has GdaLdapEntry  $!gle is implementor;
  has GdaConnection $!glc;

  method new {
    my $gda-ldap-entry = gda_ldap_entry_new();

    $gda-ldap-entry ?? self.bless( :$gda-ldap-entry ) !! Nil;
  }

  proto method add_attribute (|)
  { * }

  multi method add_attribute (
    Int()          $merge,
    Str()          $attr_name,
                   @values
  ) {
    samewith(
      $merge,
      $attr_name,
      @values.elems,
      ArrayToCArray(GValue, @values)
    )
  }
  multi method add_attribute (
    Int()          $merge,
    Str()          $attr_name,
    Int()          $nb_values,
    CArray[GValue] $values
  ) {
    my gboolean $m = $merge;
    my guint    $n = $nb_values;

    gda_ldap_entry_add_attribute($!gle, $m, $attr_name, $n, $values);
  }

  method free {
    gda_ldap_entry_free($!gle);
  }

  method get_attributes_list (:$glist = False) {
    returnGList(
      gda_ldap_entry_get_attributes_list($!glc, $!gle),
      True,
      GdaLdapAttributeDefinition
    );
  }
}
