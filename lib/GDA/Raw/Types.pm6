use v6;

use CompUnit::Util :re-export;

use GLib::Raw::Exports;
use GDA::Raw::Exports;

my constant forced = 0;

unit package GDA::Raw::Types;

need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Struct_Subs;
need GLib::Raw::Subs;
need GLib::Roles::Pointers;
need GDA::Raw::Definitions;
need GDA::Raw::Enums;
need GDA::Raw::Structs;

BEGIN {
  glib-re-export($_) for |@glib-exports, |@gda-exports;
}
