use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Data::Handler;

### /usr/include/libgda-5.0/libgda/gda-data-handler.h

sub gda_data_handler_accepts_g_type (GdaDataHandler $dh, GType $type)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_default (GType $for_type)
  returns GdaDataHandler
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_descr (GdaDataHandler $dh)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_sane_init_value (GdaDataHandler $dh, GType $type)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_sql_from_value (GdaDataHandler $dh, GValue $value)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_str_from_value (GdaDataHandler $dh, GValue $value)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_value_from_sql (
  GdaDataHandler $dh,
  Str            $sql,
  GType          $type
)
  returns GValue
  is native(gda)
  is export
{ * }

sub gda_data_handler_get_value_from_str (
  GdaDataHandler $dh,
  Str            $str,
  GType          $type
)
  returns GValue
  is native(gda)
  is export
{ * }
