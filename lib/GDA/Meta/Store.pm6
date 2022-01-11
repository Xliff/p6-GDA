use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Meta::Store;

use GLib::GList;

use GLib::Roles::Object;
use GDA::Roles::Data::Model;
use GDA::Roles::Signals::Meta::Store;

our subset GdaMetaStoreAncestry is export of Mu
  where GdaMetaStore | GObject;

class GDA::Meta::Store {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Meta::Store;

  has GdaMetaStore $!gms is implementor;

  submethod BUILD ( :$gda-meta-store ) {
    self.setGdaMetaStore($gda-meta-store) if $gda-meta-store;
  }

  method setGdaMetaStore (GdaMetaStoreAncestry $_) {
    my $to-parent;
    $!gms = do {
      when GdaMetaStore {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaMetaStore, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Structs::GdaMetaStore
    is also<GdaMetaStore>
  { $!gms }

  multi method new (GdaMetaStoreAncestry $gda-meta-store, :$ref = True) {
    return Nil unless $gda-meta-store;

    my $o = self.bless( :$gda-meta-store );
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $cnc-string = Str) {
    my $gda-meta-store = gda_meta_store_new($cnc-string);

    $gda-meta-store ?? self.bless( :$gda-meta-store ) !! Nil;
  }

  method new_with_file (Str() $filename) is also<new-with-file> {
    my $gda-meta-store = gda_meta_store_new_with_file($filename);
    say "F: { $filename } / { $gda-meta-store // '»» UNSET ««' }";
    say $ERROR.gist if $ERROR;

    $gda-meta-store ?? self.bless( :$gda-meta-store ) !! Nil;
  }

  # Type: GdaConnection
  method cnc ( :$raw = False ) is rw  {
    my \gda_connection = ::('GDA::Connection');
    my $gv = GLib::Value.new( gda_connection.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('cnc', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          | gda_connection.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'cnc is a construct-only attribute'
      }
    );
  }

  # Is originally:
  # GdaMetaStore, gpointer --> void
  method meta-reset is also<meta_reset> {
    self.connect-meta-reset($!gms);
  }

  # Is originally:
  # GdaMetaStore, gpointer, gpointer --> void
  method meta-changed is also<meta_changed> {
    self.connect-pointer($!gms, 'meta-changed');
  }

  method create_modify_data_model (Str() $table_name, :$raw = False)
    is also<create-modify-data-model>
  {
    propReturnObject(
      gda_meta_store_create_modify_data_model($!gms, $table_name),
      $raw,
      |GDA::Data::Model.getTypePair
    );
  }

  proto method declare_foreign_key (|)
    is also<declare-foreign-key>
  { * }

  multi method declare_foreign_key (
  Str()                      $table,
  Str()                      $fk_name,
  GdaMetaStruct()            $mstruct,
  Str()                     :$catalog =     Str,
  Str()                     :$schema =      Str,
  Str()                     :$ref_catalog = Str,
  Str()                     :$ref_schema =  Str,
  Str()                     :$ref_table =   Str,
                            *%colrefs
  ) {
    samewith(
      $mstruct,
      $fk_name,
      $catalog,
      $schema,
      $table,
      $ref_catalog,
      $ref_schema,
      %colrefs
    )
  }
  multi method declare_foreign_key (
    Str()                      $table,
    Str()                      $fk_name,
    GdaMetaStruct()            $mstruct,
                               %colrefs,
    Str()                     :$catalog     = Str,
    Str()                     :$schema      = Str,
    Str()                     :$ref_catalog = Str,
    Str()                     :$ref_schema  = Str,
    Str()                     :$ref_table   = Str,
  ) {
    my @colnames = %colrefs.keys;

    samewith(
      $mstruct,
      $fk_name,
      $catalog,
      $schema,
      $table,
      $ref_catalog,
      $ref_schema,
      $ref_table,
      @colnames.elems,
      @colnames,
      %colrefs.values
    );
  }
  multi method declare_foreign_key (
    GdaMetaStruct()           $mstruct,
    Str()                     $fk_name,
    Str()                     $catalog,
    Str()                     $schema,
    Str()                     $table,
    Str()                     $ref_catalog,
    Str()                     $ref_schema,
    Str()                     $ref_table,
                              @colnames,
                              @ref_colnames,
    CArray[Pointer[GError]]   $error         = gerror
  ) {
    samewith(
      $mstruct,
      $fk_name,
      $catalog,
      $schema,
      $table,
      $ref_catalog,
      $ref_schema,
      $ref_table,
      @colnames.elems,
      ArrayToCArray(Str, @colnames),
      ArrayToCArray(Str, @ref_colnames),
      $error
    )
  }
  multi method declare_foreign_key (
    GdaMetaStruct()           $mstruct,
    Str()                     $fk_name,
    Str()                     $catalog,
    Str()                     $schema,
    Str()                     $table,
    Str()                     $ref_catalog,
    Str()                     $ref_schema,
    Str()                     $ref_table,
    Int()                     $nb_cols,
    CArray[Str]               $colnames,
    CArray[Str]               $ref_colnames,
    CArray[Pointer[GError]]   $error         = gerror
  ) {
    my guint $n = $nb_cols;

    clear_error;
    gda_meta_store_declare_foreign_key(
      $!gms,
      $mstruct,
      $fk_name,
      $catalog,
      $schema,
      $table,
      $ref_catalog,
      $ref_schema,
      $ref_table,
      $nb_cols,
      $colnames,
      $ref_colnames,
      $error
    );
    set_error($error);

  }

  method error_quark is also<error-quark> {
    gda_meta_store_error_quark();
  }

  # # cw: Varargs is out of scope!
  # method extract (Str() $select_sql, CArray[Pointer[GError]] $error = gerror) {
  #   clear_error;
  #   gda_meta_store_extract($!gms, $select_sql, $error);
  #   set_error($error);
  # }

  method extract_v (
    Str()                   $select_sql,
    GHashTable()            $vars,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<extract-v>
  {
    clear_error;
    gda_meta_store_extract_v($!gms, $select_sql, $vars, $error);
    set_error($error);
  }

  proto method get_attribute_value (|)
    is also<get-attribute-value>
  { * }

  multi method get_attribute_value (
    Str()                    $att_name,
    CArray[Pointer[GError]]  $error     = gerror,
                            :$raw       = False
  ) {
    return-with-all(
      samewith($att_name, $, $error, :all, :$raw)
    );
  }
  multi method get_attribute_value (
    Str()                    $att_name,
                             $att_value is rw,
    CArray[Pointer[GError]]  $error,
                            :$all       =  False,
                            :$raw       =  False
  ) {
    my $v  = newCArray(Str);

    clear_error;
    my $rv = so gda_meta_store_get_attribute_value(
      $!gms,
      $att_name,
      $v,
      $error
    );
    set_error($error);
    $att_value = $raw ?? $v !! ppr($v);

    $all.not ?? $rv !! ( $rv, $att_value )
  }

  method get_internal_connection ( :$raw = False )
    is also<get-internal-connection>
  {
    propReturnObject(
      gda_meta_store_get_internal_connection($!gms),
      $raw,
      |::('GDA::Connection').getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_meta_store_get_type, $n, $t );
  }

  method get_version is also<get-version> {
    gda_meta_store_get_version($!gms);
  }

  # cw - Varargs are out of scope!
  # method modify (
  #   Str()                   $table_name,
  #   GdaDataModel()          $new_data,
  #   Str()                   $condition,
  #   CArray[Pointer[GError]] $error       = gerror
  # ) {
  #   gda_meta_store_modify($!gms, $table_name, $new_data, $condition, $error);
  # }

  # ...


  proto method modify_v (|)
    is also<modify-v>
  { * }

  multi method modify (
    Str()                     $table_name,
    GdaDataModel()            $new_data,
    Str()                     $condition,
                              $error                      = gerror,
                             *%values       where *.elems > 0
  ) {
    samewith(
      $table_name,
      $new_data,
      $condition,
      %values,
      $error
    )
  }
  multi method modify (
    Str()                    $table_name,
    GdaDataModel()           $new_data,
    Str()                    $condition,
                             %values,
                             $error        = gerror
  ) {
    my @val_names = %values.keys;

    self.modify_v(
      $table_name,
      $new_data,
      $condition,
      @val_names.elems,
      @val_names,
      %values.values,
      $error
    );
  }

  multi method modify_v (
    Str()          $table_name,
    GdaDataModel() $new_data,
    Str()          $condition,
                   @value_names,
                   @values,
                   $error        = gerror
  ) {
    samewith(
      $table_name,
      $new_data,
      $condition,
      @value_names.elems,
      ArrayToCArray(Str,    @value_names),
      ArrayToCArray(GValue, @values),
      $error
    );
  }
  multi method modify_v (
    Str()                   $table_name,
    GdaDataModel()          $new_data,
    Str()                   $condition,
    Int()                   $nvalues,
    CArray[Str]             $value_names,
    CArray[GValue]          $values,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    my gint $n = $nvalues;

    gda_meta_store_modify_v(
      $!gms,
      $table_name,
      $new_data,
      $condition,
      $n,
      $value_names,
      $values,
      $error
    );
  }

  method store_modify_with_context (
    GdaMetaContext()        $context,
    GdaDataModel()          $new_data,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<store-modify-with-context>
  {
    clear_error;
    gda_meta_store_modify_with_context($!gms, $context, $new_data, $error);
    set_error($error);
  }

  method set_attribute_value (
    Str()                   $att_name,
    Str()                   $att_value,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<set-attribute-value>
  {
    gda_meta_store_set_attribute_value($!gms, $att_name, $att_value, $error);
  }

  method set_identifiers_style (Int() $style) is also<set-identifiers-style> {
    my GdaSqlIdentifierStyle $s = $style;

    gda_meta_store_set_identifiers_style($!gms, $s);
  }

  method set_reserved_keywords_func (&func)
    is also<set-reserved-keywords-func>
  {
    gda_meta_store_set_reserved_keywords_func($!gms, &func);
  }

  method sql_identifier_quote (GdaConnection() $cnc)
    is also<sql-identifier-quote>
  {
    gda_meta_store_sql_identifier_quote($!gms, $cnc);
  }

  proto method undeclare_foreign_key (|)
    is also<undeclare-foreign-key>
  { * }

  multi method undeclare_foreign_key (
    Str()                   $table,
    Str()                   $ref_table,
    Str()                   $fk_name,
    CArray[Pointer[GError]] $error        = gerror,
    GdaMetaStruct()         :$mstruct     = GdaMetaStruct,
    Str()                   :$catalog     = Str,
    Str()                   :$schema      = Str,
    Str()                   :$ref_catalog = Str,
    Str()                   :$ref_schema  = Str
  ) {
    samewith(
      $mstruct,
      $fk_name,
      $catalog,
      $schema,
      $table,
      $ref_catalog,
      $ref_schema,
      $ref_table,
      $error
    );
  }
  multi method undeclare_foreign_key (
    GdaMetaStruct()         $mstruct,
    Str()                   $fk_name,
    Str()                   $catalog,
    Str()                   $schema,
    Str()                   $table,
    Str()                   $ref_catalog,
    Str()                   $ref_schema,
    Str()                   $ref_table,
    CArray[Pointer[GError]] $error        = gerror
  ) {
    clear_error;
    gda_meta_store_undeclare_foreign_key(
      $!gms,
      $mstruct,
      $fk_name,
      $catalog,
      $schema,
      $table,
      $ref_catalog,
      $ref_schema,
      $ref_table,
      $error
    );
    set_error($error);
  }

  method getSchema {
    GDA::Meta::Store::Schema.new(self);
  }

}

# GDA::Meta::Store::Schema ?

class GDA::Meta::Store::Schema is GDA::Meta::Store {

  method new (GdaMetaStore() $gda-meta-store) {
    $gda-meta-store ?? self.bless( :$gda-meta-store ) !! Nil;
  }

  method add_custom_object (
    Str()                   $xml_description,
    CArray[Pointer[GError]] $error            = gerror
  )
    is also<add-custom-object>
  {
    clear_error;
    gda_meta_store_schema_add_custom_object(
      self.GdaMetaStore,
      $xml_description,
      $error
    );
    set_error($error);
  }

  method get_all_tables ( :$raw = False, :$glist = False )
    is also<get-all-tables>
  {
    returnGList(
      gda_meta_store_schema_get_all_tables(self.GdaMetaStore),
      $raw,
      $glist
    );
  }

  method get_depend_tables (Str() $table_name, :$glist = False, :$raw = False)
    is also<get-depend-tables>
  {
    returnGList(
      gda_meta_store_schema_get_depend_tables(
        self.GdaMetaStore,
        $table_name
      ),
      $raw,
      $glist
    );
  }

  method get_structure (CArray[Pointer[GError]] $error = gerror)
    is also<get-structure>
  {
    clear_error;
    gda_meta_store_schema_get_structure(
      self.GdaMetaStore,
      $error
    );
    set_error($error);
  }

  method remove_custom_object (
    Str()                   $obj_name,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<remove-custom-object>
  {
    clear_error;
    gda_meta_store_schema_remove_custom_object(
      self.GdaMetaStore,
      $obj_name,
      $error
    );
    set_error($error);
  }

}
