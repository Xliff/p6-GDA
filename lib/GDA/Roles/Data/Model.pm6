use v6.c;

use NativeCall;
use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Data::Model;
use LibXML::Raw;

use GLib::HashTable;

use GLib::Roles::Object;
use GLib::Roles::TypedBuffer;
use GDA::Roles::Signals::Data::Model;

role GDA::Roles::Data::Model {
  also does GDA::Roles::Signals::Data::Model;

  has GdaDataModel $!gdm is implementor;

  method roleInit-GdaDataModel is also<roleInit_GdaDataModel> {
    my \i = findProperImplementor( self.^attributes );

    $!gdm = cast( GdaDataModel, i.get_value(self) );
  }

  method GDA::Raw::Definition::GdaDataModel
    is also<GdaDataModel>
  { $!gdm }

  method column_name is rw is also<column-name> {
    Proxy.new:
      FETCH => -> $     { self.get_column_name    },
      STORE => -> $, \v { self.set_column_name(v) }
  }

  method column_title is rw is also<column-title> {
    Proxy.new:
      FETCH => -> $     { self.get_column_title    },
      STORE => -> $, \v { self.set_column_title(v) }
  }

  # method notify is rw {
  #   Proxy.new:
  #     FETCH => -> $     { self.get_notify    },
  #     STORE => -> $, \v { self.set_notify(v) }
  # }

  method value_at is rw is also<value-at> {
    Proxy.new:
      FETCH => -> $     { self.get_value_at    },
      STORE => -> $, \v { self.set_value_at(v) }
  }

  # Is originally:
  # GdaDataModel *model --> void
  method changed {
    self.connect-model($!gdm, 'changed');
  }

  # Is originally:
  # GdaDataModel *model,  gint row --> void
  method row-inserted is also<row_inserted> {
    self.connect-model-row($!gdm, 'row-inserted');
  }

  # Is originally:
  # GdaDataModel *model --> void
  method reset {
    self.connect-model($!gdm, 'reset');
  }

  # Is originally:
  # GdaDataModel *model --> void
  method access-changed is also<access_changed> {
    self.connect-model($!gdm, 'access-changed');
  }

  # Is originally:
  # GdaDataModel *model,  gint row --> void
  method row-removed is also<row_removed> {
    self.connect-model-row($!gdm, 'row-removed');
  }

  # Is originally:
  # GdaDataModel *model,  gint row --> void
  method row-updated is also<row_updated> {
    self.connect-model-row($!gdm, 'row-updated');
  }

  method add_data_from_xml_node (
    GdaDataModel()          $model,
    anyNode()               $node,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<add-data-from-xml-node>
  {
    clear_error;
    my $rv = so gda_data_model_add_data_from_xml_node ($model, $node, $error);
    set_error($error);
    $rv;
  }

  method append_row (CArray[Pointer[GError]] $error = gerror)
    is also<append-row>
  {
    clear_error;
    my $i = gda_data_model_append_row($!gdm, $error);
    set_error($error);
    $i;
  }

  method append_values (
    GList()                 $values,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<append-values>
  {
    clear_error;
    my $i = gda_data_model_append_values($!gdm, $values, $error);
    set_error($error);
    $i;
  }

  method create_iter ( $raw = False ) is also<create-iter> {
    propReturnObject(
      gda_data_model_create_iter($!gdm),
      $raw,
      |GDA::Data::Model::Iter.getTypePair
    );
  }

  method describe_column (Int() $col) is also<describe-column> {
    my gint $c = $col;

    gda_data_model_describe_column($!gdm, $c);
  }

  method dump (
    Pointer $to_stream #= FILE *
  ) {
    gda_data_model_dump($!gdm, $to_stream);
  }

  method dump_as_string is also<dump-as-string> {
    gda_data_model_dump_as_string($!gdm);
  }

  method error_quark (::?CLASS:U: ) is also<error-quark> {
    gda_data_model_error_quark();
  }

  proto method export_to_file (|)
  { * }

  multi method export_to_file (
    Int()                   $format,
    Str()                   $file,
    GdaSet()                $options,
    CArray[Pointer[GError]] $error            = gerror,
                            :$cols    is copy = CArray[gint],
                            :$rows    is copy = CArray[gint],

    Int()                   :$nb_cols = $cols ~~ Array ?? $cols.elems !! 0,
    Int()                   :$nb_rows = $rows ~~ Array ?? $rows.elems !! 0
  )
    is also<export-to-file>
  {
    $cols = ArrayToCArray(gint, $cols) if $cols ~~ Array;
    $rows = ArrayToCArray(gint, $rows) if $rows ~~ Array;

    die '$cols must be a CArray[gint]' unless $cols ~~ CArray[gint];
    die '$rows must be a CArray[gint]' unless $rows ~~ CArray[gint];

    die '$nb_rows cannot be 0!' unless $nb_rows > 0;
    die '$nb_cols cannot be 0!' unless $nb_cols > 0;

    samewith(
      $format,
      $file,
      $cols,
      $nb_cols,
      $rows,
      $nb_rows,
      $options,
      $error
    );
  }
  multi method export_to_file (
    Int()                   $format,
    Str()                   $file,
    CArray[gint]            $cols,
    Int()                   $nb_cols,
    CArray[gint]            $rows,
    Int()                   $nb_rows,
    GdaSet()                $options,
    CArray[Pointer[GError]] $error     =  gerror
  )
    is also<export-to-file>
  {
    my GdaDataModelIOFormat $f         = $format;
    my gint                 ($nc, $nr) = ($nb_cols, $nb_rows);

    gda_data_model_export_to_file(
      $!gdm,
      $format,
      $file,
      $cols,
      $nc,
      $rows,
      $nr,
      $options,
      $error
    );
  }

  proto method export_to_string (|)
    is also<export-to-string>
  { * }

  multi method export_to_string (
    Int()         $format,
    GdaSet()      $options,
    CArray[gint] :$cols     = CArray[gint],
    CArray[gint] :$rows     = CArray[gint],

    Int()        :$nb_cols = $cols ~~ Array ?? $cols.elems !! 0,
    Int()        :$nb_rows = $rows ~~ Array ?? $rows.elems !! 0
  ) {
    $cols = ArrayToCArray(gint, $cols) if $cols ~~ Array;
    $rows = ArrayToCArray(gint, $rows) if $rows ~~ Array;

    die '$cols must be a CArray[gint]' unless $cols ~~ CArray[gint];
    die '$rows must be a CArray[gint]' unless $rows ~~ CArray[gint];

    die '$nb_rows cannot be 0!' unless $nb_rows > 0;
    die '$nb_cols cannot be 0!' unless $nb_cols > 0;

    samewith(
      $format,
      $cols,
      $nb_cols,
      $rows,
      $nb_rows,
      $options
    )
  }
  multi method export_to_string (
    Int()        $format,
    CArray[gint] $cols,
    Int()        $nb_cols,
    CArray[gint] $rows,
    Int()        $nb_rows,
    GdaSet()     $options
  ) {
    my GdaDataModelIOFormat $f         = $format;
    my gint                 ($nc, $nr) = ($nb_cols, $nb_rows);

    gda_data_model_export_to_string(
      $!gdm,
      $format,
      $cols,
      $nb_cols,
      $rows,
      $nb_rows,
      $options
    );
  }

  method freeze ( :$flags = True ) {
    gda_data_model_freeze($!gdm)
  }

  method get_access_flags is also<get-access-flags> {
    getFlags(
      GdaDataModelAccessFlagsEnum,
      gda_data_model_get_access_flags($!gdm)
    );
  }

  method get_attributes_at (Int() $col, Int() $row, :$flags)
    is also<get-attributes-at>
  {
    my gint ($c, $r) = ($col, $row);

    getFlags(
      GdaValueAttributeEnum,
      gda_data_model_get_attributes_at($!gdm, $c, $r)
    )
  }

  method get_column_index (Str() $name) is also<get-column-index> {
    gda_data_model_get_column_index($!gdm, $name);
  }

  method get_column_name (Int() $col) is also<get-column-name> {
    my gint $c = $col;

    gda_data_model_get_column_name($!gdm, $c);
  }

  method get_column_title (Int() $col) is also<get-column-title> {
    my gint $c = $col;

    gda_data_model_get_column_title($!gdm, $c);
  }

  method get_exceptions ( :$buffer = False ) is also<get-exceptions> {
    my $tb = GLib::Roles::TypedBuffer[GError].new(
      gda_data_model_get_exceptions($!gdm),
      :null-terminated
    );

    return $tb if $buffer;

    $tb.Array;
  }

  method get_n_columns is also<get-n-columns> {
    gda_data_model_get_n_columns($!gdm);
  }

  method get_n_rows is also<get-n-rows> {
    gda_data_model_get_n_rows($!gdm);
  }

  method getDims {
    (self.get_n_rows, self.get_n_columns);
  }

  method get_notify is also<get-notify> {
    so gda_data_model_get_notify($!gdm);
  }

  proto method get_row_from_values (|)
    is also<get-row-from-values>
  { * }

  multi method get_row_from_values (@values, @cols_index) {
    samewith(
      GLib::GSList.new(@values, typed => GValue),
      ArrayToCArray(gint, @cols_index)
    );
  }
  multi method get_row_from_values (
    GSList()     $values,
    CArray[gint] $cols_index
  ) {
    gda_data_model_get_row_from_values($!gdm, $values, $cols_index);
  }

  method gdadatamodel_get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_model_get_type, $n, $t );
  }

  method get_typed_value_at (
    Int()                    $col,
    Int()                    $row,
    Int()                    $expected_type,
    Int()                    $nullok,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$raw            = False
  )
    is also<get-typed-value-at>
  {
    my gint     ($c, $r) = ($col, $row);
    my GType    $e       = $expected_type;
    my gboolean $n       = $nullok.so.Int;

    clear_error;
    my $v = gda_data_model_get_typed_value_at($!gdm, $c, $r, $e, $n, $error);
    set_error($error);
    propReturnObject($v, $raw, |GLib::Value.getTypePair)
  }

  method get_value_at (
    Int()                    $col,
    Int()                    $row,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<get-value-at>
  {
    my gint     ($c, $r) = ($col, $row);

    clear_error;
    my $v = gda_data_model_get_value_at($!gdm, $c, $r, $error);
    set_error($error);
    propReturnObject($v, $raw, |GLib::Value.getTypePair)
  }

  proto method import_from_file (|)
    is also<import-from-file>
  { * }

  multi method import_from_file (
    Str()                    $file,
    GHashTable()             %cols_trans,
    CArray[Pointer[GError]]  $error       = gerror,
    GdaSet()                :@options,
  ) {
    samewith(
      $file,
      GLib::HashTable.new(%cols_trans),
      ::('GDA::Set').new(@options),
      $error
    );
  }
  multi method import_from_file (
    Str()                   $file,
    GHashTable()            $cols_trans,
    GdaSet()                $options,
    CArray[Pointer[GError]] $error       = gerror
  ) {
    clear_error
    my $rv = so gda_data_model_import_from_file(
      $!gdm,
      $file,
      $cols_trans,
      $options,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method import_from_model (|)
    is also<import-from-model>
  { * }

  multi method import_from_model (
    GdaDataModel()          $from,
    Int()                   $overwrite,
                            %col_trans,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<import-from-model>
  {
    samewith($from, $overwrite, GLib::HashTable.new(%col_trans), $error);
  }
  multi method import_from_model (
    GdaDataModel()          $from,
    Int()                   $overwrite,
    GHashTable()            $cols_trans,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<import-from-model>
  {
    my gboolean $o = $overwrite.so.Int;

    clear_error;
    my $rv = gda_data_model_import_from_model(
      $!gdm,
      $from,
      $o,
      $cols_trans,
      $error
    );
    set_error($error);
    $rv;
  }

  proto method import_from_string (|)
    is also<import-from-string>
  { * }
  multi method import_from_string (
    Str()                    $string,
                             %cols_trans,
    CArray[Pointer[GError]]  $error        = gerror,
                            :@options
  ) {
    samewith(
      $string,
      GLib::HashTable.new(%cols_trans),
      GDA::Set.new(@options),
      $error
    );
  }
  multi method import_from_string (
    Str()                   $string,
    GHashTable()            $cols_trans,
    GdaSet()                $options,
    CArray[Pointer[GError]] $error
  ) {
    clear_error;
    my $rv = so gda_data_model_import_from_string(
      $!gdm,
      $string,
      $cols_trans,
      $options,
      $error
    );
    set_error($error);
    $rv;
  }

  method remove_row (Int() $row, CArray[Pointer[GError]] $error = gerror)
    is also<remove-row>
  {
    my gint $r = $row;

    clear_error;
    my $rv = so gda_data_model_remove_row($!gdm, $r, $error);
    set_error($error);
    $rv;
  }

  method send_hint (Int() $hint, GValue() $hint_value) is also<send-hint> {
    my GdaDataModelHint $h = $hint;

    gda_data_model_send_hint($!gdm, $h, $hint_value);
  }

  method set_column_name (Int() $col, Str() $name) is also<set-column-name> {
    my gint $c = $col;

    gda_data_model_set_column_name($!gdm, $c, $name);
  }

  method set_column_title (Int() $col, Str() $title)
    is also<set-column-title>
  {
    my gint $c = $col;

    gda_data_model_set_column_title($!gdm, $c, $title);
  }

  method set_notify (Int() $do_notify_changes) is also<set-notify> {
    my gboolean $d = $do_notify_changes.so.Int;

    gda_data_model_set_notify($!gdm, $d);
  }

  method set_value_at (
    Int()                   $col,
    Int()                   $row,
    GValue()                $value,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-value-at>
  {
    my gint ($c, $r) = ($col, $row);

    gda_data_model_set_value_at($!gdm, $c, $r, $value, $error);
  }

  proto method set_values (|)
    is also<set-values>
  { * }

  multi method set_values (
    Int()                   $row,
                            @values,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    samewith($row, GLib::GList.new(@values, typed => GValue), $error);
  }
  multi method set_values (
    Int()                   $row,
    GList()                 $values,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    my gint $r = $row;

    gda_data_model_set_values($!gdm, $r, $values, $error);
  }

  method thaw {
    gda_data_model_thaw($!gdm);
  }

  # cw: These appear to be convenience methods on DataModel that allow
  #     operations to be performed on an arbitrary GdaDataModelIter.

  method iter_at_row (GdaDataModelIter() $iter, Int() $row)
    is also<iter-at-row>
  {
    my gint $r = $row;

    so gda_data_model_iter_at_row($!gdm, $iter, $r);
  }

  method iter_next (GdaDataModelIter() $iter) is also<iter-next> {
    so gda_data_model_iter_next($!gdm, $iter);
  }

  method iter_prev (GdaDataModelIter() $iter) is also<iter-prev> {
    so gda_data_model_iter_prev($!gdm, $iter);
  }

  method iter_set_value (
    GdaDataModelIter()      $iter,
    Int()                   $col,
    GValue()                $value,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<iter-set-value>
  {
    my gint $c = $col;

    clear_error;
    my $rv = so gda_data_model_iter_set_value(
      $!gdm,
      $iter,
      $c,
      $value,
      $error
    );
    set_error($error);
    $rv;
  }

}

our subset GdaDataModelAncestry is export of Mu
  where GdaDataModel | GObject;

class GDA::Data::Model {
  also does GLib::Roles::Object;
  also does GDA::Roles::Data::Model;

  submethod BUILD ( :$gda-data-model ) {
    self.setGdaDataModel($gda-data-model) if $gda-data-model
  }

  method setGdaDataModel (GdaDataModelAncestry $_) {
    my $to-parent;
    $!gdm = do {
      when GdaDataModel {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataModel, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GdaDataModelAncestry $gda-data-model, :$ref = True) {
    return Nil unless $gda-data-model;

    my $o = self.bless( :$gda-data-model );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gdadatamodel_get_type
  }

}
