use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;

unit package GDA::Raw::AttributesManagver;

### /usr/include/libgda-5.0/libgda/gda-attributes-manager.h

sub gda_attributes_manager_clear (
  GdaAttributesManager $mgr,
  gpointer             $ptr
)
  is      native(gda)
  is      export
{ * }

sub gda_attributes_manager_copy (
  GdaAttributesManager $from_mgr,
  gpointer             $from,
  GdaAttributesManager $to_mgr,
  gpointer             $to
)
  is      native(gda)
  is      export
{ * }

sub gda_attributes_manager_foreach (
  GdaAttributesManager $mgr,
  gpointer             $ptr,
                       &func (Str, GValue, gpointer),
  gpointer             $data
)
  is      native(gda)
  is      export
{ * }

sub gda_attributes_manager_free (GdaAttributesManager $mgr)
  is      native(gda)
  is      export
{ * }

sub gda_attributes_manager_get (
  GdaAttributesManager $mgr,
  gpointer             $ptr,
  Str                  $att_name
)
  returns GValue
  is      native(gda)
  is      export
{ * }

sub gda_attributes_manager_new (
  gboolean $for_objects,
           &signal_func (GObject, Str, GValue, gpointer),
  gpointer $signal_data
)
  returns GdaAttributesManager
  is      native(gda)
  is      export
{ * }

sub gda_attributes_manager_set (
  GdaAttributesManager $mgr,
  gpointer             $ptr,
  Str                  $att_name,
  GValue               $value
)
  is      native(gda)
  is      export
{ * }

sub gda_attributes_manager_set_full (
  GdaAttributesManager $mgr,
  gpointer             $ptr,
  Str                  $att_name,
  GValue               $value,
                       &destroy
)
  is      native(gda)
  is      export
{ * }
