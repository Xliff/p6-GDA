use v6.c;

use Method::Also;

use NativeCall;

use GDA::Raw::Types;

use GDA::Report::Document;

our subset GdaReportDocbookDocumentAncestry is export of Mu
  where GdaReportDocbookDocument | GdaReportDocumentAncestry;

class GDA::Report::Document::Docbook is GDA::Report::Document {
  has GdaReportDocbookDocument $!grdd is implementor;

  submethod BUILD ( :$gda-docbook-document ) {
    self.setGdaReportDocbookDocument( $gda-docbook-document )
      if $gda-docbook-document;
  }

  method setGdaReportDocbookDocument (GdaReportDocbookDocumentAncestry $_) {
    my $to-parent;

    $!grdd = do {
      when GdaReportDocbookDocument {
        $to-parent = cast(GdaReportDocument, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaReportDocbookDocument, $_);
      }
    }
    self.setGdaReportDocument($to-parent);
  }

  method GDA::Raw::Structs::GdaReportDocbookDocument
    is also<GdaReportDocbookDocument>
  { $!grdd }

  multi method new (
    GdaReportDocbookDocumentAncestry  $gda-docbook-document,
                                     :$ref                   = True
  ) {
    return Nil unless $gda-docbook-document;

    my $o = self.bless( :$gda-docbook-document );
    $o.ref if $ref;
    $o;
  }
  multi method new (GdaReportEngine() $engine) {
    my $gda-dockbook-document = gda_report_docbook_document_new($engine);

    $gda-dockbook-document ?? self.bless( :$gda-dockbook-document ) !! Nil;
  }

  # Type: gchar
  method html-stylesheet is rw  is also<html_stylesheet> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('html-stylesheet', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('html-stylesheet', $gv);
      }
    );
  }

  # Type: gchar
  method fo-stylesheet is rw  is also<fo_stylesheet> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fo-stylesheet', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('fo-stylesheet', $gv);
      }
    );
  }

  # Type: gchar
  method java-home is rw  is also<java_home> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('java-home', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('java-home', $gv);
      }
    );
  }

  # Type: gchar
  method fop-path is rw  is also<fop_path> {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('fop-path', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('fop-path', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gda_report_docbook_document_get_type,
      $n,
      $t
    );
  }

}


### /usr/src/libgda5-5.2.10/libgda-report/DocBook/gda-report-docbook-document.h

sub gda_report_docbook_document_get_type ()
  returns GType
  is native(gda-report)
  is export
{ * }

sub gda_report_docbook_document_new (GdaReportEngine $engine)
  returns GdaReportDocbookDocument
  is native(gda-report)
  is export
{ * }
