use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDA::Raw::Types;
use GDA::Raw::Connection::Event;

use GLib::Roles::Object;

our subset GdaConnectionEventAncestry is export of Mu
  where GdaConnectionEvent | GObject;

class GDA::Connection::Event {
  also does GLib::Roles::Object;

  has GdaConnectionEvent $!gce;

  submethod BUILD ( :$gda-connection-event ) {
    self.setGdaConnectionEvent( $gda-connection-event )
      if $gda-connection-event
  }

  method setGdaConnectionEvent (GdaConnectionEventAncestry $_) {
    my $to-parent;

    $!gce = do {
      when GdaConnectionEvent {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaConnectionEvent, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Structs::GdaConnectionEvent
    is also<GdaConnectionEvent>
  { $!gce }

  multi method new (GdaConnectionEventAncestry  $gda-connection-event,
                                               :$ref = True
  ) {
    return Nil unless $gda-connection-event;

    my $o = self.bless( :$gda-connection-event );
    $o.ref if $ref;
    $o;
  }

  method code is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_code    },
      STORE => -> $, \v { self.set_code(v) }
  }

  method description is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_description    },
      STORE => -> $, \v { self.set_description(v) }
  }

  method event_type is rw is g-property is also<event-type> {
    Proxy.new:
      FETCH => -> $     { self.get_event_type    },
      STORE => -> $, \v { self.set_event_type(v) }
  }

  method gda_code is rw is g-property is also<gda-code> {
    Proxy.new:
      FETCH => -> $     { self.get_gda_code    },
      STORE => -> $, \v { self.set_gda_code(v) }
  }

  method source is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_source    },
      STORE => -> $, \v { self.set_source(v) }
  }

  method sqlstate is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_sqlstate    },
      STORE => -> $, \v { self.set_sqlstate(v) }
  }

  method get_code is also<get-code> {
    gda_connection_event_get_code($!gce);
  }

  method get_description is also<get-description> {
    gda_connection_event_get_description($!gce);
  }

  method get_event_type is also<get-event-type> {
    GdaConnectionEventTypeEnum( gda_connection_event_get_event_type($!gce) );
  }

  method get_gda_code is also<get-gda-code> {
    GdaConnectionEventCodeEnum( gda_connection_event_get_gda_code($!gce) );
  }

  method get_source is also<get-source> {
    gda_connection_event_get_source($!gce);
  }

  method get_sqlstate is also<get-sqlstate> {
    gda_connection_event_get_sqlstate($!gce);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_connection_event_get_type, $n, $t );
  }

  method set_code (Int() $code) is also<set-code> {
    my glong $c = $code;

    gda_connection_event_set_code($!gce, $c);
  }

  method set_description (Str() $description) is also<set-description> {
    gda_connection_event_set_description($!gce, $description);
  }

  method set_event_type (Int() $type) is also<set-event-type> {
    my GdaConnectionEventType $t = $type;

    gda_connection_event_set_event_type($!gce, $type);
  }

  method set_gda_code (Int() $code) is also<set-gda-code> {
    my GdaConnectionEventCode $c = $code;

    gda_connection_event_set_gda_code($!gce, $code);
  }

  method set_source (Str() $source) is also<set-source> {
    gda_connection_event_set_source($!gce, $source);
  }

  method set_sqlstate (Str() $sqlstate) is also<set-sqlstate> {
    gda_connection_event_set_sqlstate($!gce, $sqlstate);
  }
}
