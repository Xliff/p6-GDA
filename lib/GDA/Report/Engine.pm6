use v6.c;

use NativeCall;
use Method::Also;

use GDA::Raw::Types;
use GDA::Raw::Report::Engine;

use LibXML::Document;
use LibXML::Node;
use LibXML::Raw;

use GLib::Value;

use GLib::Roles::Object;

our subset GdaReportEngineAncestry is export of Mu
  where GdaReportEngine | GObject;

class GDA::Report::Engine {
  also does GLib::Roles::Object;

  has GdaReportEngine $!gre;

  submethod BUILD ( :$gda-report-engine ) {
    self.setGdaReportEngine( $gda-report-engine ) if $gda-report-engine
  }

  method setGdaReportEngine (GdaReportEngineAncestry $_) {
    my $to-parent;

    $!gre = do {
      when GdaReportEngine {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaReportEngine, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Structs::GdaReportEngine
    is also<GdaReportEngine>
  { $!gre }

  multi method new (GdaReportEngineAncestry $gda-report-engine, :$ref = True) {
    return Nil unless $gda-report-engine;

    my $o = self.bless( :$gda-report-engine );
    $o.ref if $ref;
    $o;
  }
  multi method new (anyNode $spec_node) {
    my $gda-report-engine = gda_report_engine_new($spec_node);

    $gda-report-engine ?? self.bless( :$gda-report-engine ) !! Nil;
  }

  method new_from_file (Str() $file) is also<new-from-file> {
    my $gda-report-engine = gda_report_engine_new_from_file($file);

    $gda-report-engine ?? self.bless( :$gda-report-engine ) !! Nil;
  }

  method new_from_string (Str() $spec) is also<new-from-string> {
    my $gda-report-engine = gda_report_engine_new_from_string($spec);

    $gda-report-engine ?? self.bless( :$gda-report-engine ) !! Nil;
  }

  # Type: gpointers
  method spec is rw  {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('template', $gv)
        );
        $gv.pointer;
      },
      STORE => -> $, $val is copy {
        $gv.pointer = $val;
        self.prop_set('template', $gv);
      }
    );
  }

  # Type: gchar
  method output-directory is rw  is also<output_directory> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('output-directory', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('output-directory', $gv);
      }
    );
  }

  # Type: gchar
  method spec-filename is rw  is also<spec_filename> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('spec-filename', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('spec-filename', $gv);
      }
    );
  }

  # Type: gchar
  method spec-string is rw  is also<spec_string> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('spec-string', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('spec-string', $gv);
      }
    );
  }

  method declare_object (GObject() $object, Str() $obj_name)
    is also<declare-object>
  {
    gda_report_engine_declare_object($!gre, $object, $obj_name);
  }

  method find_declared_object (
    Int()  $obj_type,
    Str()  $obj_name,
          :$raw       = False
  )
    is also<find-declared-object>
  {
    my GType $o = $obj_type;

    propReturnObject(
      gda_report_engine_find_declared_object($!gre, $o, $obj_name),
      $raw,
      |GLib::Object.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_report_engine_get_type, $n, $t );
  }

  # xmlDoc
  method run_as_doc (CArray[Pointer[GError]] $error = gerror, :$raw = False)
    is also<run-as-doc>
  {
    clear_error;
    my $xd = gda_report_engine_run_as_doc($!gre, $error);
    set_error($error);

    return Nil unless $xd;

    $raw ?? $xd !! LibXML::Document.new( raw => $xd );
  }

  # xmlNode
  method run_as_node (CArray[Pointer[GError]] $error = gerror, :$raw = False)
    is also<run-as-node>
  {
    clear_error;
    my $xn = gda_report_engine_run_as_node($!gre, $error);
    set_error($error);

    return Nil unless $xn;

    $raw ?? $xn !! LibXML::Node.box($xn);
  }

}
