use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;

use GLib::Value;
use GDA::Report::Engine;

use GLib::Roles::Object;

our subset GdaReportDocumentAncestry is export of Mu
  where GdaReportDocument | GObject;

class GDA::Report::Document {
  also does GLib::Roles::Object;

  has GdaReportDocument $!grd is implementor;

  submethod BUILD ( :$gda-report-document ) {
    self.setGdaReportDocument( $gda-report-document ) if $gda-report-document
  }

  method setGdaReportDocument (GdaReportDocumentAncestry $_) {
    my $to-parent;

    $!grd = do {
      when GdaReportDocument {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaReportDocument, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Structs::GdaReportDocument
    is also<GdaReportDocument>
  { $!grd }

  method new (GdaReportDocumentAncestry $gda-report-document, :$ref = True) {
    return Nil unless $gda-report-document;

    my $o = self.bless( :$gda-report-document );
    $o.ref if $ref;
    $o;
  }

  # Type: gchar
  method template is rw  {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('template', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('template', $gv);
      }
    );
  }

  # Type: GdaReportEngine
  method engine ( :$raw = False ) is rw  {
    my $gv = GLib::Value.new( GDA::Report::Engine.get_type );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('engine', $gv)
        );
        propReturnObject(
          $gv.object,
          $raw,
          |GDA::Report::Engine.getTypePair
        );
      },
      STORE => -> $, GdaReportEngine() $val is copy {
        $gv.object = $val;
        self.prop_set('engine', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_report_document_get_type, $n, $t );
  }

  method run_as_html (
    Str()                   $filename,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<run-as-html>
  {
    clear_error;
    my $rv = so gda_report_document_run_as_html($!grd, $filename, $error);
    set_error($error);
    $rv;
  }

  method run_as_pdf (
    Str()                   $filename,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<run-as-pdf>
  {
    clear_error;
    my $rv = so gda_report_document_run_as_pdf($!grd, $filename, $error);
    set_error($error)
  }

  method set_template (Str() $file) is also<set-template> {
    gda_report_document_set_template($!grd, $file);
  }

}


### /usr/include/libgda-5.0/libgda-report/gda-report-document.h

sub gda_report_document_get_type ()
  returns GType
  is native(gda-report)
  is export
{ * }

sub gda_report_document_run_as_html (
  GdaReportDocument       $doc,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-report)
  is export
{ * }

sub gda_report_document_run_as_pdf (
  GdaReportDocument       $doc,
  Str                     $filename,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda-report)
  is export
{ * }

sub gda_report_document_set_template (GdaReportDocument $doc, Str $file)
  is native(gda-report)
  is export
{ * }
