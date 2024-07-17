use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;

use GLib::Roles::Pointers;

unit package GDA::Raw::Definitions;

constant gda         is export = 'gda-5.0',v4;
constant gda-ldap    is export = 'gda-ldap-5.0',v4;
constant gda-report  is export = 'gda-report-5.0',v4;
constant gda-virtual is export = 'gda-virtual-5.0',v4;
constant gda-xslt    is export = 'gda-xslt-5.0',v4;

constant GdaSqlBuilderId is export := guint;

class GdaAttributesManager    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaDataModel            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaDataHandler          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaLdapConnection       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaLockable             is repr<CPointer> does GLib::Roles::Pointers is export { }

constant GDA_ATTRIBUTE_DESCRIPTION                is export =
  '__gda_attr_descr';
constant GDA_ATTRIBUTE_NAME                       is export =
  '__gda_attr_name';
constant GDA_ATTRIBUTE_NUMERIC_PRECISION          is export =
  '__gda_attr_numeric_precision';
constant GDA_ATTRIBUTE_NUMERIC_SCALE              is export =
  '__gda_attr_numeric_scale';
constant GDA_ATTRIBUTE_AUTO_INCREMENT             is export =
  '__gda_attr_autoinc';
constant GDA_ATTRIBUTE_IS_DEFAULT                 is export =
  '__gda_attr_is_default';
constant GDA_ATTRIBUTE_TREE_NODE_UNKNOWN_CHILDREN is export =
  '__gda_attr_tnuchild';


sub rfc1738-encode ($e) is export {
  sub gda_rfc1738_encode (Str)
    returns Str
    is native(gda)
  { * }

  gda_rfc1738_encode($e);
}

multi sub rfc1738-decode (Str $a, :$encoding = 'utf8') {
  my $ca = CArray[uint8].new( |$a.encode($encoding), 0 );
  samewith($ca);
  Buf.new($ca).decode($encoding);
}

multi sub rfc1738-decode (CArray[uint8] $d) is export {
  sub gda_rfc1738_decode (CArray[uint8])
    returns gboolean
    is native(gda)
  { * }

  so gda_rfc1738_decode($d)
}

# Expand this in ::Raw::Structs and add gda_value_free
constant GdaValue is export := GValue;
