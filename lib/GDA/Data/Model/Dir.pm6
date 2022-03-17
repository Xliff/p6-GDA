use v6.c;

use NativeCall;

use GDA::Raw::Types;

use GLib::GSList;

use GLib::Roles::Object;
use GDA::Roles::Data::Model;

our subset GdaDataModelDirAncestry is export of Mu
  where GdaDataModelDir | GdaDataModelAncestry;

class GDA::Data::Model::Dir {
  also does GLib::Roles::Object;
  also does GDA::Roles::Data::Model;

  has GdaDataModelDir $!gdmd;

  submethod BUILD ( :$gda-data-model-dir ) {
    self.setGdaDataModelDir($gda-data-model-dir) if $gda-data-model-dir;
  }

  method setGdaDataModelDir (GdaDataModelDirAncestry $_) {
    my $to-parent;

    $!gdmd = do {
      when GdaDataModelDir {
        $to-parent = cast(GObject, $_);
        $_
      }

      when GdaDataModel {
        $to-parent = cast(GObject, $_);
        $!gdm      = $_;
        cast(GdaDataModelDir, $_);
      }

      default {
        $to-parent = $_;
        cast(GdaDataModelDir, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GdaDataModel;
  }

  multi method new (Str() $basedir) {
    my $gda-data-model-dir = gda_data_model_dir_new($basedir);

    $gda-data-model-dir ?? self.bless( :$gda-data-model-dir ) !! Nil;
  }

  method clean_errors {
    gda_data_model_dir_clean_errors($!gdmd);
  }

  method get_errors (:$glist = False, :$raw = False) {
    returnGSList(
      gda_data_model_dir_get_errors($!gdmd),
      $glist,
      $raw,
      |GLib::Error.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_data_model_dir_get_type, $n, $t );
  }

}

### /usr/include/libgda-5.0/libgda/gda-data-model-dir.h

sub gda_data_model_dir_clean_errors (GdaDataModelDir $model)
  is native(gda)
  is export
{ * }

sub gda_data_model_dir_get_errors (GdaDataModelDir $model)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_data_model_dir_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_model_dir_new (Str $basedir)
  returns GdaDataModelDir
  is native(gda)
  is export
{ * }
