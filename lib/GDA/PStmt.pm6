use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;

use GLib::Roles::Object;

our subset GdaPStmtAncestry is export of Mu
  where GdaPStmt | GObject;

class GDA::PStmt {
  also does GLib::Roles::Object;

  has GdaPStmt $!gp;

  submethod BUILD ( :$gda-pstmt ) {
    self.setGdaPStmt($gda-pstmt) if $gda-pstmt;
  }

  method setGdaPStmt (GdaPStmtAncestry $_) {
    my $to-parent;
    $!gp = do {
      when GdaPStmt {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaPStmt, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definition::GdaPStmt
    is also<GdaPStmt>
  { $!gp }

  multi method new (GdaPStmtAncestry $gda-pstmt, :$ref = True) {
    return Nil unless $gda-pstmt;

    my $o = self.bless( :$gda-pstmt );
    $o.ref if $ref;
    $o;
  }

  method copy_contents (GdaPStmt() $dest) is also<copy-contents> {
    gda_pstmt_copy_contents($!gp, $dest);
  }

  method copy_from (GdaPStmt() $src) is also<copy-from> {
    gda_pstmt_copy_contents($src, $!gp);
  }

  method get_gda_statement ( :$raw = False ) is also<get-gda-statement> {
    propReturnObject(
      gda_pstmt_get_gda_statement($!gp),
      $raw,
      |GDA::Statement.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_pstmt_get_type, $n, $t );
  }

  method set_gda_statement (GdaStatement() $stmt) is also<set-gda-statement> {
    gda_pstmt_set_gda_statement($!gp, $stmt);
  }

}

### /usr/include/libgda-5.0/libgda/providers-support/gda-pstmt.h

sub gda_pstmt_copy_contents (GdaPStmt $src, GdaPStmt $dest)
  is native(gda)
  is export
{ * }

sub gda_pstmt_get_gda_statement (GdaPStmt $pstmt)
  returns GdaStatement
  is native(gda)
  is export
{ * }

sub gda_pstmt_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_pstmt_set_gda_statement (GdaPStmt $pstmt, GdaStatement $stmt)
  is native(gda)
  is export
{ * }
