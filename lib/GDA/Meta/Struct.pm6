use v6.c;

use GDA::Raw::Types;
use GDA::Raw::Meta::Struct;

use GLib::Roles::Object;

class GDA::Meta::Struct {
  also does GLib:L:Roles::Object;

  has GdaMetaStruct $!gms is implementor;

  method new (GdaMetaStructFeature() $features) {
    my $gda-meta-struct = gda_meta_struct_new($!gms, $features);

    $gda-meta-struct ?? self.bless( :$gda-meta-struct ) !! Nil;
  }

  method complement (
    Int()                   $type,
    GValue()                $catalog,
    GValue()                $schema,
    GValue()                $name,
    CArray[Pointer[GError]] $error     = gerror
  ) {
    my GdaMetaDbObjectType $t = $type;

    clear_error;
    my $ms = propReturnObject(
      gda_meta_struct_complement($!gms, $t, $catalog, $schema, $name, $error),
      True,
      GdaMetaStruct
    );
    set_error($error);
    $ms;
  }

  method complement_all (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so gda_meta_struct_complement_all($!gms, $error);
    set_error($error);
    $rv;
  }

  method complement_default (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so gda_meta_struct_complement_default($!gms, $error);
    set_error($error);
    $rv;
  }

  method complement_depend (
    GdaMetaDbObject()       $dbo,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so gda_meta_struct_complement_depend($!gms, $dbo, $error);
    set_error($error);
    $rv;
  }

  method complement_schema (
    GValue()                $catalog,
    GValue()                $schema,
    CArray[Pointer[GError]] $error    = gerror
  ) {
    clear_error;
    my $rv = so gda_meta_struct_complement_schema(
      $!gms,
      $catalog,
      $schema,
      $error
    );
    set_error($error);
    $rv;
  }

  method dump_as_graph (
    GdaMetaGraphInfo()      $info,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so gda_meta_struct_dump_as_graph($!gms, $info, $error);
    set_error($error);
    $rv;
  }

  method error_quark {
    gda_meta_struct_error_quark();
  }

  method get_all_db_objects ( :$raw = False, :$glist = False ) {
    returnGList(
      gda_meta_struct_get_all_db_objects($!gms);
      $raw,
      $glist,
      GdaMetaDbObject
    );
  }

  method get_db_object (
    GValue()  $catalog,
    GValue()  $schema,
    GValue()  $name
  ) {
    propReturnObject(
      gda_meta_struct_get_db_object($!gms, $catalog, $schema, $name),
      True,
      GdaMetaStruct
    );
  }

  method get_table_column (GdaMetaTable() $table, GValue() $col_name) {
    propReturnObject(
      gda_meta_struct_get_table_column($!gms, $table, $col_name),
      True,
      GdaMetaColumn
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_meta_struct_get_type, $n, $t );
  }

  method load_from_xml_file (
    Str()                   $catalog,
    Str()                   $schema,
    Str()                   $xml_spec_file,
    CArray[Pointer[GError]] $error          = gerror
  ) {
    clear_error;
    my $rv = so gda_meta_struct_load_from_xml_file(
      $!gms,
      $catalog,
      $schema,
      $xml_spec_file,
      $error
    );
    set_error($error);
    $rv;
  }

  method sort_db_objects (GdaMetaSortType $sort_type, CArray[Pointer[GError]] $error) {
    gda_meta_struct_sort_db_objects($!gms, $sort_type, $error);
  }
}
