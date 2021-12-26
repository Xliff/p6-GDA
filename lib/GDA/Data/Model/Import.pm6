use v6.c;

use NativeCall;

use LibXML::Raw;

use GDA::Raw::Types;
use GDA::Raw::Data::Model::Import;

use GLib::GList;

use GLib::Roles::Object;

our subset GdaDataModelImportAncestry is export of Mu
  where GdaDataModelImport | GObject;

class GDA::Data::Model::Import {
  also does GLib::Roles::Object;

  has GdaDataModelImport $!gdmi;

  submethod BUILD ( :$gda-data-model-import ) {
    self.setGdaDataModelImport($gda-data-model-import) if $gda-data-model-import;
  }

  method setGdaDataModelImport (GdaDataModelImportAncestry $_) {
    my $to-parent;
    $!gdmi = do {
      when GdaDataModelImport {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaDataModelImport, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaDataModelImport
    is also<GdaDataModelImport>
  { $!gdmi }

  multi method new (GdaDataModelImportAncestry  $gda-data-model-import,
                                               :$ref                    = True)
  {
    return Nil unless $gda-data-model-import;

    my $o = self.bless( :$gda-data-model-import );
    $o.ref if $ref;
    $o;
  }

  method new_file (
    Str()    $filename,
    Int()    $random_access,
    GdaSet() $options
  ) {
    my gboolean $r = $random_access.so.Int;

    my $gda-data-model-import = gda_data_model_import_new_file(
      $filename,
      $r,
      $options
    );

    $gda-data-model-import ?? self.bless( :$gda-data-model-import ) !! Nil;
  }

  proto method new_mem (|)
  { * }

  multi method new_mem (
    Str()     $data,
    Int()     $random_access,
    GdaSet()  $options,
             :$encoding = 'utf8'
  ) {
    samewith( $data.encode($encoding), $random_access, $options );
  }
  multi method new_mem (
    Buf      $data,
    Int()    $random_access,
    GdaSet() $options
  ) {
    samewith( cast(Pointer, $data), $random_access, $options );
  }
  multi method new_mem (
    CArray[uint8] $data,
    Int()         $random_access,
    GdaSet()      $options
  ) {
    my gboolean $r = $random_access.so.Int;

    my $gda-data-model-import = gda_data_model_import_new_mem(
      $!gdmi,
      $data,
      $r,
      $options
    );

    $gda-data-model-import ?? self.bless( :$gda-data-model-import ) !! Nil;
  }

  method new_xml_node (anyNode() $node) {
    my $gda-data-model-import = gda_data_model_import_new_xml_node($node);

    $gda-data-model-import ?? self.bless( :$gda-data-model-import ) !! Nil;
  }

  # Type: gchar
  method data-string is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('data-string', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'data-string is a construct-only attribute'
      }
    );
  }

  # Type: gchar
  method filename is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('filename', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'filename is a construct-only attribute'
      }
    );
  }

  # Type: GdaDataModelImport
  method options (:$raw = False) is rw  {
    my $gv = GLib::Value.new( GDA::Set.get_type );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('options', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Set.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'options is a construct-only attribute'
      }
    );
  }

  # Type: gboolean
  method random-access is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('random-access', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn 'random-access is a construct-only attribute'
      }
    );
  }

  # Type: gboolean
  method strict is rw  {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('strict', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn 'strict is a construct-only attribute'
      }
    );
  }

  # Type: gpointer
  method xml-node is rw  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('xml-node', $gv)
        );
        $gv.pointer
      },
      STORE => -> $, $val is copy {
        warn 'xml-node is a construct-only attribute'
      }
    );
  }

  method clean_errors  {
    gda_data_model_import_clean_errors($!gdmi),
  }

  method get_errors  ( :$raw = False, :$glist = False ) {
    returnGList(
      gda_data_model_import_get_errors($!gdmi),
      $raw,
      $glist
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_model_import_get_type, $n, $t );
  }

}
