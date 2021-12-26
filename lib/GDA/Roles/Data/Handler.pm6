use v6.c;

use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Data::Handler;

use GLib::Value;

role GDA::Roles::Data::Handler {
  has GdaDataHandler $!gdh;

  method GDA::Raw::Definition::GdaDataHandler
    is also<GdaDataHandler>
  { $!gdh }

  method accepts_g_type (Int() $type) is also<accepts-g-type> {
    my GType $t = $type;

    gda_data_handler_accepts_g_type($!gdh, $type);
  }

  method get_default ( :$raw = False ) is also<get-default> {
    propReturnObject(
      gda_data_handler_get_default($!gdh),
      $raw,
      |::('GDA::Data::Holder').getTypePair
    );
  }

  method get_descr is also<get-descr> {
    gda_data_handler_get_descr($!gdh);
  }

  method get_sane_init_value (Int() $type, :$raw = False) is also<get-sane-init-value> {
    my GType $t = $type;

    propReturnObject(
      gda_data_handler_get_sane_init_value($!gdh, $type),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method get_sql_from_value (GValue() $value) is also<get-sql-from-value> {
    gda_data_handler_get_sql_from_value($!gdh, $value);
  }

  method get_str_from_value (GValue() $value) is also<get-str-from-value> {
    gda_data_handler_get_str_from_value($!gdh, $value);
  }

  method gdadatahandler_get_type is also<gdadatahandler-get-type> {
    state ($n, $t);

    unstable_get_type( ::?CLASS.^name, &gda_data_handler_get_type, $n, $t );
  }

  method get_value_from_sql (Str() $sql, Int() $type) is also<get-value-from-sql> {
    my GType $t = $type;

    gda_data_handler_get_value_from_sql($!gdh, $sql, $t);
  }

  method get_value_from_str (Str $str, Int() $type) is also<get-value-from-str> {
    my GType $t = $type;

    gda_data_handler_get_value_from_str($!gdh, $str, $t);
  }
}

use GLib::Roles::Object;

our subset GdaDataHandlerAncestry is export of Mu
  where GdaDataHandler | GObject;

class GDA::Data::Handler {
  also does GLib::Roles::Object;
  also does GDA::Roles::Data::Handler;

  submethod BUILD ( :$gda-data-handler ) {
    self.setGdaDataHandler($gda-data-handler) if $gda-data-handler;
  }

  method setGdaDataHandler (GdaDataHandlerAncestry $_) {
    my $to-parent;
    $!gdh = do {
      when GdaDataHandler {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataHandler, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GdaDataHandlerAncestry $gda-data-handler, :$ref = True) {
    return Nil unless $gda-data-handler;

    my $o = self.bless( :$gda-data-handler );
    $o.ref if $ref;
    $o;
  }

}
