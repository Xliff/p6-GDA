use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Holder;

### /usr/include/libgda-5.0/libgda/gda-holder.h

sub gda_holder_copy (GdaHolder $orig)
  returns GdaHolder
  is native(gda)
  is export
{ * }

sub gda_holder_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_holder_force_invalid (GdaHolder $holder)
  is native(gda)
  is export
{ * }

sub gda_holder_force_invalid_e (GdaHolder $holder, Pointer[GError] $error)
  is native(gda)
  is export
{ * }

sub gda_holder_get_alphanum_id (GdaHolder $holder)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_holder_get_attribute (GdaHolder $holder, Str $attribute)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_holder_get_bind (GdaHolder $holder)
  returns GdaHolder
  is native(gda)
  is export
{ * }

sub gda_holder_get_default_value (GdaHolder $holder)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_holder_get_g_type (GdaHolder $holder)
  returns GType
  is native(gda)
  is export
{ * }

sub gda_holder_get_id (GdaHolder $holder)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_holder_get_not_null (GdaHolder $holder)
  returns uint32
  is native(gda)
  is export
{ * }

multi sub gda_holder_get_source_model (
  GdaHolder $holder,
  Pointer
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }
multi sub gda_holder_get_source_model (
  GdaHolder $holder,
  gint      $col     is rw
)
  returns GdaDataModel
  is native(gda)
  is export
{ * }

sub gda_holder_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_holder_get_value (GdaHolder $holder)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_holder_get_value_str (GdaHolder $holder, GdaDataHandler $dh)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_holder_is_valid (GdaHolder $holder)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_is_valid_e (GdaHolder $holder, CArray[Pointer[GError]] $error)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_new (GType $type)
  returns GdaHolder
  is native(gda)
  is export
{ * }

# cw: Varargs is out of scope!
# sub gda_holder_new_inline (GType $type, Str $id, ...)
#   returns GdaHolder
#   is native(gda)
#   is export
# { * }

multi sub gda_holder_new_inline_string (GType $type, Str $id, Str $val, Str)
  returns GdaHolder
  is native(gda)
  is export
  is symbol('gda_holder_new_inline')
{ * }

multi sub gda_holder_new_inline_bool (
  GType    $type,
  Str      $id,
  gboolean $val,
  Str
)
  returns GdaHolder
  is native(gda)
  is export
  is symbol('gda_holder_new_inline')
{ * }

multi sub gda_holder_new_inline_int (GType $type, Str $id, gint $val, Str)
  returns GdaHolder
  is native(gda)
  is export
  is symbol('gda_holder_new_inline')
{ * }


sub gda_holder_set_attribute (
  GdaHolder      $holder,
  Str            $attribute,
  GValue         $value,
  GDestroyNotify $destroy
)
  is native(gda)
  is export
{ * }

sub gda_holder_set_bind (
  GdaHolder               $holder,
  GdaHolder               $bind_to,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_set_default_value (GdaHolder $holder, GValue $value)
  is native(gda)
  is export
{ * }

sub gda_holder_set_not_null (GdaHolder $holder, gboolean $not_null)
  is native(gda)
  is export
{ * }

sub gda_holder_set_source_model (
  GdaHolder               $holder,
  GdaDataModel            $model,
  gint                    $col,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_set_value (
  GdaHolder               $holder,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_set_value_str (
  GdaHolder               $holder,
  GdaDataHandler          $dh,
  Str                     $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_set_value_to_default (GdaHolder $holder)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_take_static_value (
  GdaHolder               $holder,
  GValue                  $value,
  gboolean                $value_changed,
  CArray[Pointer[GError]] $error
)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_holder_take_value (
  GdaHolder               $holder,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_holder_value_is_default (GdaHolder $holder)
  returns uint32
  is native(gda)
  is export
{ * }
