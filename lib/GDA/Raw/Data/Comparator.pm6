use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Structs;

unit package GDA::Raw::Data::Comparator;

### /usr/include/libgda-5.0/libgda/gda-data-comparator.h

sub gda_data_comparator_compute_diff (
  GdaDataComparator       $comp,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(gda)
  is export
{ * }

sub gda_data_comparator_error_quark ()
  returns GQuark
  is native(gda)
  is export
{ * }

sub gda_data_comparator_get_diff (GdaDataComparator $comp, gint $pos)
  returns GdaDiff
  is native(gda)
  is export
{ * }

sub gda_data_comparator_get_n_diffs (GdaDataComparator $comp)
  returns gint
  is native(gda)
  is export
{ * }

sub gda_data_comparator_get_type ()
  returns GType
  is native(gda)
  is export
{ * }

sub gda_data_comparator_new (
  GdaDataModel $old_model,
  GdaDataModel $new_model
)
  returns GObject
  is native(gda)
  is export
{ * }

sub gda_data_comparator_set_key_columns (
  GdaDataComparator $comp,
  gint              $col_numbers is rw,
  gint              $nb_cols
)
  is native(gda)
  is export
{ * }
