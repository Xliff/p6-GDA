use v6.c;

use NativeCall;
use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Statement;

use GLib::GList;
use GDA::Holder;
use GDA::Set;

use GLib::Roles::Object;
use GDA::Roles::Signals::Statement;

our subset GdaStatementAncestry is export of Mu
  where GdaStatement | GObject;

class GDA::Statement {
  also does GLib::Roles::Object;
  also does GDA::Roles::Signals::Statement;

  has GdaStatement $!gs;

  submethod BUILD ( :$gda-statement ) {
    self.setGdaStatement($gda-statement) if $gda-statement;
  }

  method setGdaStatement (GdaStatementAncestry $_) {
    my $to-parent;
    $!gs = do {
      when GdaStatement {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaStatement, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Structs::GdaStatement
    is also<GdaStatement>
  { $!gs }

  multi method new (GdaStatementAncestry $gda-statement, :$ref = True) {
    return Nil unless $gda-statement;

    my $o = self.bless( :$gda-statement );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gda-statement = gda_statement_new();

    $gda-statement ?? self.bless( :$gda-statement ) !! Nil
  }

  # Type: gpointer
  method structure is rw  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('structure', $gv)
        );
        $gv.pointer
      },
      STORE => -> $, $val is copy {
        $gv.pointer = $val;
        self.prop_set('structure', $gv);
      }
    );
  }

  # Is originally:
  # GdaStatement *stmt --> void
  method reset {
    self.connect-reset($!gs);
  }

  # Is originally:
  # GdaStatement *stmt,  GdaConnection *cnc,  gboolean checked --> void
  method checked {
    self.connect-checked($!gs);
  }

  method check_structure (CArray[Pointer[GError]] $error = gerror)
    is also<check-structure>
  {
    clear_error;
    my $rv = so gda_statement_check_structure($!gs, $error);
    set_error($error);
    $rv;
  }

  method check_validity (
    GdaConnection()         $cnc,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<check-validity>
  {
    clear_error;
    my $rv = so gda_statement_check_validity($!gs, $cnc, $error);
    set_error($error);
    $rv;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gda_statement_copy($!gs),
      $raw,
      |self.getTypePair
    )
  }

  method error_quark (GDA::Statement:U ) is also<error-quark> {
    gda_statement_error_quark();
  }

  proto method get_parameters (|)
    is also<get-parameters>
  { * }

  multi method get_parameters (
    CArray[Pointer[GError]] $error = gerror
  ) {
    return-with-all(
      samewith( newCArray(GdaSet), $error, :all )
    );
  }
  multi method get_parameters (
    CArray[Pointer[GdaSet]]  $out_params,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$all         = False,
                            :$raw         = False
  ) {
    clear_error;
    my $rv = so gda_statement_get_parameters($!gs, $out_params, $error);
    set_error($error);

    my $s = $all
      ?? propReturnObject( ppr($out_params), $raw |GDA::Set.getTypePair )
      !! Nil;

    $all.not ?? $rv !! ($rv, $s);
  }

  method get_statement_type is also<get-statement-type> {
    GdaSqlStatementTypeEnum( gda_statement_get_statement_type($!gs) )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_statement_get_type, $n, $t );
  }

  method is_useless is also<is-useless> {
    so gda_statement_is_useless($!gs);
  }

  method normalize (
    GdaConnection()         $cnc,
    CArray[Pointer[GError]] $error = gerror
  ) {
    clear_error;
    my $rv = so gda_statement_normalize($!gs, $cnc, $error);
    set_error($error);
    $rv;
  }

  method serialize {
    gda_statement_serialize($!gs);
  }

  proto method to_sql_extended (|)
    is also<to-sql-extended>
  { * }

  multi method to_sql_extended (
    GdaConnection()          $cnc,
    GdaSet()                 $params,
    CArray[Pointer[GError]]  $error   = gerror,
    Int()                   :$flags   = 0,
                            :$glist   = False,
                            :$raw     = False
  ) {
    samewith(
      $cnc,
      $params,
      $flags,
      newCArray(GSList),
      $error,
      :all,
      :$glist,
      :$raw
    );
  }
  multi method to_sql_extended (
    GdaConnection()          $cnc,
    GdaSet()                 $params,
    Int()                    $flags,
    CArray[Pointer[GSList]]  $params_used,
    CArray[Pointer[GError]]  $error        = gerror,
                            :$all          = False,
                            :$glist        = False,
                            :$raw          = False
  ) {
    my GdaStatementSqlFlag  $f = $flags;

    my $sql = gda_statement_to_sql_extended(
      $!gs,
      $cnc,
      $params,
      $f,
      $params_used,
      $error
    );

    my $pl = do if $all {
      returnGList(
        ppr($params_used),
        $raw,
        $glist,
        |GDA::Holder.getTypePair
      )
    }

    $all.not ?? $sql !! ($sql, $pl)
  }

}
