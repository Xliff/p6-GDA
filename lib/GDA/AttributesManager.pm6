use v6.c;

use GDA::Raw::Types;
use GDA::Raw::AttributesManager;

# STRUCT

class GDA::AttributesManager {
  has GdaAttributesManager $!gam is implementor;

  submethod BUILD ( :$gda-attribute-man ) {
    $!gam = $gda-attribute-man if $gda-attribute-man
  }

  method GDA::Raw::Definitions::GdaAttributesManager
  { $!gam }

  method new (
    Int()    $for_objects,
             &signal_func,
    gpointer $signal_data  = gpointer
  ) {
    my gboolean $f = $for_objects.so.Int;

    my $gda-attr-man = gda_attributes_manager_new(
      $f,
      &signal_func,
      $signal_data
    );

    $gda-attr-man ?? self.bless( :$gda-attr-man  ) !! Nil
  }

  method clear (gpointer $ptr) {
    gda_attributes_manager_clear($!gam, $ptr);
  }

  method copy (
    gpointer               $from,
    GdaAttributesManager() $to_mgr,
    gpointer               $to
  ) {
    gda_attributes_manager_copy($!gam, $from, $to_mgr, $to);
  }

  method foreach (gpointer $ptr, &func, gpointer $data) {
    gda_attributes_manager_foreach($!gam, $ptr, &func, $data);
  }

  method free {
    gda_attributes_manager_free($!gam);
  }

  proto method get (|)
  { * }

  multi method get (gpointer $ptr, Str $att_name, :$raw = False) {
    propReturnObject(
      gda_attributes_manager_get($!gam, $ptr, $att_name),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  proto method set (|)
  { * }

  multi method set (
    gpointer $ptr,
    Str()    $att_name,
    GValue() $value
  ) {
    gda_attributes_manager_set($!gam, $ptr, $att_name, $value);
  }

  method set_full (
    gpointer $ptr,
    Str()    $att_name,
    GValue() $value,
             &destroy   = %DEFAULT-CALLBACKS<GDestroyNotify>
  ) {
    gda_attributes_manager_set_full($!gam, $ptr, $att_name, $value, &destroy);
  }

}
