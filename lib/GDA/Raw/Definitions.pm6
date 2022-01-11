use v6.c;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;

use GLib::Roles::Pointers;

unit package GDA::Raw::Definitions;

constant gda         is export = 'gda-5.0',v4;
constant gda-ldap    is export = 'gda-ldap-5.0',v4;
constant gda-report  is export = 'gda-report-5.0',v4;
constant gda-virtual is export = 'gda-virtual-5.0',v4;
constant gda-xslt    is export = 'gda-xslt-5.0',v4;

class GdaDataModel            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaDataHandler          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaLdapConnection       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaLockable             is repr<CPointer> does GLib::Roles::Pointers is export { }

# Expand this in ::Raw::Structs and add gda_value_free
constant GdaValue is export := GValue;
