use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::LDAP::Connection;

### /usr/src/libgda/providers/ldap/gda-ldap-connection.h

sub gda_ldap_connection_declare_table (
  GdaLdapConnection       $cnc,
  Str                     $table_name,
  Str                     $base_dn,
  Str                     $filter,
  Str                     $attributes,
  GdaLdapSearchScope      $scope,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_connection_describe_table (
  GdaLdapConnection       $cnc,
  Str                     $table_name,
  CArray[Str]             $out_base_dn,
  CArray[Str]             $out_filter,
  CArray[Str]             $out_attributes,
  GdaLdapSearchScope      $out_scope,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_connection_get_base_dn (GdaLdapConnection $cnc)
  returns Str
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_connection_undeclare_table (
  GdaLdapConnection       $cnc,
  Str                     $table_name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_add_entry (
  GdaLdapConnection       $cnc,
  GdaLdapEntry            $entry,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_attributes_list_free (GSList $list)
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_describe_entry (
  GdaLdapConnection       $cnc,
  Str                     $dn,
  CArray[Pointer[GError]] $error = gerror
)
  returns GdaLdapEntry
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_dn_split (Str $dn, gboolean $all)
  returns Str
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_entry_add_attribute (
  GdaLdapEntry   $entry,
  gboolean       $merge,
  Str            $attr_name,
  guint          $nb_values,
  CArray[GValue] $values
)
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_entry_free (GdaLdapEntry $entry)
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_entry_get_attributes_list (
  GdaLdapConnection $cnc,
  GdaLdapEntry      $entry
)
  returns GSList
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_entry_new (Str $dn)
  returns GdaLdapEntry
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_get_class_info (GdaLdapConnection $cnc, Str $classname)
  returns GdaLdapClass
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_get_entry_children (
  GdaLdapConnection       $cnc,
  Str                     $dn,
  CArray[Str]             $attributes,
  CArray[Pointer[GError]] $error
)
  returns CArray[CArray[GdaLdapEntry]]
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_get_top_classes (GdaLdapConnection $cnc)
  returns GSList
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_is_dn (Str $dn)
  returns uint32
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_modify_entry (
  GdaLdapConnection       $cnc,
  GdaLdapModificationType $modtype,
  GdaLdapEntry            $entry,
  GdaLdapEntry            $ref_entry,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_remove_entry (
  GdaLdapConnection       $cnc,
  Str                     $dn,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-ldap)
  is export
{ * }

sub gda_ldap_rename_entry (
  GdaLdapConnection       $cnc,
  Str                     $current_dn,
  Str                     $new_dn,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-ldap)
  is export
{ * }
