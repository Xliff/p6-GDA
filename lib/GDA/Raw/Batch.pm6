use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;


### /usr/include/libgda-5.0/libgda/gda-batch.h

sub gda_batch_add_statement (GdaBatch $batch, GdaStatement $stmt)
  is native(gda)
  is export
{ * }

sub gda_batch_copy (GdaBatch $orig)
  returns GdaBatch
  is native(gda)
  is export
{ * }

sub gda_batch_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_batch_get_parameters (
  GdaBatch                $batch,
  CArray[Pointer[GdaSet]] $out_params,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_batch_get_statements (GdaBatch $batch)
  returns GSList
  is native(gda)
  is export
{ * }

sub gda_batch_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_batch_new ()
  returns GdaBatch
  is native(gda)
  is export
{ * }

sub gda_batch_remove_statement (GdaBatch $batch, GdaStatement $stmt)
  is native(gda)
  is export
{ * }

sub gda_batch_serialize (GdaBatch $batch)
  returns Str
  is native(gda)
  is export
{ * }
