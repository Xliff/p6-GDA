use v6.c;

use Method::Also;
use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::SQL::Parser;

use GDA::Batch;
use GDA::Statement;

use GLib::Roles::Object;
use GDA::Roles::Lockable;

our subset GdaSqlParserAncestry is export of Mu
  where GdaSqlParser | GdaLockable | GObject;

class GDA::Sql::Parser {
  also does GLib::Roles::Object;
  also does GDA::Roles::Lockable;

  has GdaSqlParser $!gsp;

  submethod BUILD ( :$gda-sql-parser ) {
    self.setGdaSqlParser($gda-sql-parser) if $gda-sql-parser;
  }

  method setGdaSqlParser (GdaSqlParserAncestry $_) {
    my $to-parent;
    $!gsp = do {
      when GdaSqlParser {
        $to-parent = cast(GObject, $_);
        $_;
      }

      when GdaLockable {
        $to-parent = cast(GObject, $_);
        $!gl       = $_;
        cast(GdaSqlParser, $_);
      }

      default {
        $to-parent = $_;
        cast(GdaSqlParser, $_);
      }
    }
    self!setObject($to-parent);
    self.roleInit-GdaLockable unless $!gl;
  }

  method GDA::Raw::Definition::GdaSqlParser
    is also<GdaSqlParser>
  { $!gsp }

  multi method new (GdaSqlParserAncestry $gda-sql-parser, :$ref = True) {
    return Nil unless $gda-sql-parser;

    my $o = self.bless( :$gda-sql-parser );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gda-sql-parser = gda_sql_parser_new();

    $gda-sql-parser ?? self.bless( :$gda-sql-parser ) !! Nil;
  }

  # Type: gint
  method column-error is rw  is also<column_error> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('column-error', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'column-error does not allow writing'
      }
    );
  }

  # Type: gint
  method line-error is rw  is also<line_error> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('line-error', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'line-error does not allow writing'
      }
    );
  }

  # Type: gint
  method mode is rw  {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('mode', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('mode', $gv);
      }
    );
  }

  # Type: gint
  method tokenizer-flavour is rw  is also<tokenizer_flavour> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('tokenizer-flavour', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('tokenizer-flavour', $gv);
      }
    );
  }

  method error_quark is also<error-quark> {
    gda_sql_parser_error_quark();
  }

  method parse_file_as_batch (
    Str()                     $filename,
    CArray[Pointer[GError]]   $error     = gerror,
                             :$raw       = False
  )
    is also<parse-file-as-batch>
  {
    clear_error;
    my $b = gda_sql_parser_parse_file_as_batch($!gsp, $filename, $error);
    set_error($error);
    propReturnObject($b, $raw, |GDA::Batch.getTypePair);
  }

  method parse_string (
    Str()                    $sql,
    CArray[Str]              $remain,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<parse-string>
  {
    propReturnObject(
      gda_sql_parser_parse_string($!gsp, $sql, $remain, $error),
      $raw,
      GDA::Statement.getTypePair
    );
  }

  method parse_string_as_batch (
    Str()                    $sql,
    CArray[Str]              $remain,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  )
    is also<parse-string-as-batch>
  {
    propReturnObject(
      gda_sql_parser_parse_string_as_batch($!gsp, $sql, $remain, $error),
      $raw,
      |GDA::Batch.getTypePair
    );
  }

  method set_overflow_error is also<set-overflow-error> {
    gda_sql_parser_set_overflow_error($!gsp);
  }

  method set_syntax_error is also<set-syntax-error> {
    gda_sql_parser_set_syntax_error($!gsp);
  }

}
