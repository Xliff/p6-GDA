use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GDA::Raw::Definitions;

constant gda        is export = 'gda-5.0',v4;
constant gda-report is export = 'gda-report-5.0',v4;
constant gda-xslt   is export = 'gda-xslt-5.0',v4;

class GdaDataModel       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdaDataHandler     is repr<CPointer> does GLib::Roles::Pointers is export { }
