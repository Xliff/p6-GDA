use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Virtual::Connection::Data::Model;

use GDA::Virtual::Connection;

use GDA::Roles::Data::Model;
use GDA::Roles::Signals::Virtual::Connection::Data::Model;

our subset GdaVconnectionDataModelAncestry is export of Mu
  where GdaVconnectionDataModel | GdaVirtualConnectionAncestry;

class GDA::Virtual::Connection::Data::Model is GDA::Virtual::Connection {
  also does GDA::Roles::Signals::Virtual::Connection::Data::Model;

  has GdaVconnectionDataModel $!gvdm is implementor;

  submethod BUILD ( :$gda-virtual-connection-data-model ) {
    self.setGdaVconnectionDataModel($gda-virtual-connection-data-model)
      if $gda-virtual-connection-data-model;
  }

  method setGdaVconnectionDataModel (GdaVconnectionDataModelAncestry $_) {
    my $to-parent;
    $!gvdm = do {
      when GdaVconnectionDataModel {
        $to-parent = cast(GdaVirtualConnection, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaVconnectionDataModel, $_);
      }
    }
    self.setGdaVirtualConnection($to-parent);
  }

  method GDA::Raw::Definition::GdaVconnectionDataModel
    is also<GdaVconnectionDataModel>
  { $!gvdm }

  multi method new (
    GdaVconnectionDataModelAncestry  $gda-virtual-connection-data-model,
                                    :$ref                                = True
  ) {
    return Nil unless $gda-virtual-connection-data-model;

    my $o = self.bless( :$gda-virtual-connection-data-model );
    $o.ref if $ref;
    $o;
  }

  # Is originally:
  # GdaVconnectionDataModel *cnc,  Str *table_name --> void
  method vtable-created is also<vtable_created> {
    self.connect-vtable($!gvdm, 'vtable-created');
  }

  # Is originally:
  # GdaVconnectionDataModel *cnc,  Str *table_name --> void
  method vtable-dropped is also<vtable_dropped> {
    self.connect-vtable($!gvdm, 'vtable-dropped');
  }

  method add (
    GdaVconnectionDataModelSpec() $spec,
    GDestroyNotify()              $spec_free_func,
    Str()                         $table_name,
    CArray[Pointer[GError]]       $error            = gerror
  ) {
    clear_error;
    my $rv = so gda_vconnection_data_model_add(
      $!gvdm,
      $spec,
      $spec_free_func,
      $table_name,
      $error
    );
    set_error($error);
  }

  method add_model (
    GdaDataModel()          $model,
    Str()                   $table_name,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<add-model>
  {
    clear_error;
    my $rv = so gda_vconnection_data_model_add_model(
      $!gvdm,
      $model,
      $table_name,
      $error
    );
    set_error($error);
    $rv;
  }

  method foreach (&func, gpointer $data) {
    gda_vconnection_data_model_foreach($!gvdm, &func, $data);
  }

  method get (Str() $table_name) {
    gda_vconnection_data_model_get($!gvdm, $table_name);
  }

  method get_model (Str() $table_name, :$raw = False) is also<get-model> {
    propReturnObject(
      gda_vconnection_data_model_get_model($!gvdm, $table_name),
      $raw,
      |GDA::Data::Model.getTypePair
    );
  }

  method get_table_name (GdaDataModel() $model) is also<get-table-name> {
    gda_vconnection_data_model_get_table_name($!gvdm, $model);
  }

  method remove (Str() $table_name, CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so gda_vconnection_data_model_remove($!gvdm, $table_name, $error);
    set_error($error);
    $rv;
  }

}
