use v6.c;

use Method::Also;
use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::Batch;

use GLib::GList;

use GLib::Roles::Object;
use GDA::Roles::Signals::Batch;

our subset GdaBatchAncestry is export of Mu
  where GdaBatch | GObject;

class GDA::Batch {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Batch;

  has GdaBatch $!gb;

  submethod BUILD ( :$gda-batch ) {
    self.setGdaBatch($gda-batch) if $gda-batch;
  }

  method setGdaBatch (GdaBatchAncestry $_) {
    my $to-parent;
    $!gb = do {
      when GdaBatch {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaBatch, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaBatch
    is also<GdaBatch>
  { $!gb }

  multi method new (GdaBatchAncestry $gda-batch, :$ref = True) {
    return Nil unless $gda-batch;

    my $o = self.bless( :$gda-batch );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gda-batch = gda_batch_new();

    $gda-batch ?? self.bless( :$gda-batch ) !! Nil;
  }

  # Is originally:
  # GdaBatch *batch,  GdaStatement *changed_stmt --> void
  method changed {
    self.connect-changed($!gb);
  }

  method add_statement (GdaStatement() $stmt) is also<add-statement> {
    gda_batch_add_statement($!gb, $stmt);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_batch_copy($!gb),
      $raw,
      |self.getTypePair
    )
  }

  method error_quark is also<error-quark> {
    gda_batch_error_quark();
  }

  proto method get_parameters (|)
    is also<get-parameters>
  { * }

  multi method get_parameters (
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False,
                            :$raw         = False
  ) {
    samewith( newCArray(GdaSet), $error, :all, :$raw );
  }
  multi method get_parameters (
    CArray[Pointer[GdaSet]]  $out_params,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False,
                            :$raw         = False
  ) {
    clear_error;
    my $rv = gda_batch_get_parameters($!gb, $out_params, $error);
    set_error($error);

    my $p = propReturnObject(ppr($out_params), $raw, |GDA::Set.getTypePair);

    $all.not ?? $rv !! ($rv, $p);
  }

  method get_statements (:$glist = False, :$raw = False)
    is also<get-statements>
  {
    returnGList(
      gda_batch_get_statements($!gb),
      $raw,
      $glist,
      |GDA::Statement.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_batch_get_type, $n, $t )
  }

  method remove_statement (GdaStatement() $stmt) is also<remove-statement> {
    gda_batch_remove_statement($!gb, $stmt);
  }

  method serialize {
    gda_batch_serialize($!gb);
  }

}
