use v6.c;

use NativeCall;

use LibXML::Raw;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Report::Engine;

### /usr/src/libgda5-5.2.10/libgda-report/engine/gda-report-engine.h

sub gda_report_engine_declare_object (
  GdaReportEngine $engine,
  GObject         $object,
  Str             $obj_name
)
  is native(gda-report)
  is export
{ * }

sub gda_report_engine_find_declared_object (
  GdaReportEngine $engine,
  GType           $obj_type,
  Str             $obj_name
)
  returns GObject
  is native(gda-report)
  is export
{ * }

sub gda_report_engine_get_type ()
  returns GType
  is native(gda-report)
  is export
{ * }

sub gda_report_engine_new (anyNode $spec_node)
  returns GdaReportEngine
  is native(gda-report)
  is export
{ * }

sub gda_report_engine_new_from_file (Str $spec_file_name)
  returns GdaReportEngine
  is native(gda-report)
  is export
{ * }

sub gda_report_engine_new_from_string (Str $spec_string)
  returns GdaReportEngine
  is native(gda-report)
  is export
{ * }

sub gda_report_engine_run_as_doc (
  GdaReportEngine         $engine,
  CArray[Pointer[GError]] $error
)
  returns xmlDoc
  is native(gda-report)
  is export
{ * }

sub gda_report_engine_run_as_node (
  GdaReportEngine         $engine,
  CArray[Pointer[GError]] $error
)
  returns anyNode
  is native(gda-report)
  is export
{ * }
