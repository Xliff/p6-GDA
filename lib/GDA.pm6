use v6.c;

use NativeCall;

use GDA::Raw::Types;

use GLib::Roles::StaticClass;

class GDA {
  also does GLib::Roles::StaticClass;

  method get_application_exec_path (Str() $app_name) {
    gda_get_application_exec_path($app_name);
  }

  method init {
    gda_init();
  }

  method locale_changed {
    gda_locale_changed();
  }

}

INIT { GDA.init }

### /usr/include/libgda-5.0/libgda/libgda.h

sub gda_get_application_exec_path (Str $app_name)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_init ()
  is native(gda)
  is export
{ * }

sub gda_locale_changed ()
  is native(gda)
  is export
{ * }
