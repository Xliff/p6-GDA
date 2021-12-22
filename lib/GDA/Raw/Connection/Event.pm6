use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::Connection::Event;


### /usr/include/libgda-5.0/libgda/gda-connection-event.h

sub gda_connection_event_get_code (GdaConnectionEvent $event)
  returns glong
  is native(gda)
  is export
{ * }

sub gda_connection_event_get_description (GdaConnectionEvent $event)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_event_get_event_type (GdaConnectionEvent $event)
  returns GdaConnectionEventType
  is native(gda)
  is export
{ * }

sub gda_connection_event_get_gda_code (GdaConnectionEvent $event)
  returns GdaConnectionEventCode
  is native(gda)
  is export
{ * }

sub gda_connection_event_get_source (GdaConnectionEvent $event)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_event_get_sqlstate (GdaConnectionEvent $event)
  returns Str
  is native(gda)
  is export
{ * }

sub gda_connection_event_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_connection_event_set_code (GdaConnectionEvent $event, glong $code)
  is native(gda)
  is export
{ * }

sub gda_connection_event_set_description (
  GdaConnectionEvent $event,
  Str                $description
)
  is native(gda)
  is export
{ * }

sub gda_connection_event_set_event_type (
  GdaConnectionEvent     $event,
  GdaConnectionEventType $type
)
  is native(gda)
  is export
{ * }

sub gda_connection_event_set_gda_code (
  GdaConnectionEvent     $event,
  GdaConnectionEventCode $code
)
  is native(gda)
  is export
{ * }

sub gda_connection_event_set_source (GdaConnectionEvent $event, Str $source)
  is native(gda)
  is export
{ * }

sub gda_connection_event_set_sqlstate (
  GdaConnectionEvent $event,
  Str                $sqlstate
)
  is native(gda)
  is export
{ * }
