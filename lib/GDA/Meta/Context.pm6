use v6.c;

use Method::Also;

use GDA::Raw::Types;

use GLib::Roles::Implementor;

# STRUCT!

class GDA::Meta::Context {
  also does GLib::Roles::Implementor;

  has GdaMetaContext $!gmc;

  submethod BUILD ( :$gda-meta-context ) {
    $!gmc = $gda-meta-context;
  }

  method GDA::Raw::Structs::GdaMetaContext
    is also<GdaMetaContext>
  { $!gmc }

  method new {
    my $gda-meta-context = gda_meta_context_new();

    $gda-meta-context ?? self.bless( :$gda-meta-context ) !! Nil;
  }

  method table is rw is an-attribute {
    Proxy.new:
      FETCH => -> $     { self.get_table    },
      STORE => -> $, \v { self.set_table(v) }
  }


  method copy ( :$raw = False ) {
    propReturnObject(
      gda_meta_context_copy($!gms),
      $raw,
      self.getTypePair
    );
  }

  method free {
    gda_meta_context_free($!gms);
  }

  method get_table is also<get-table> {
    gda_meta_context_get_table($!gms);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_meta_context_get_type, $n, $t );
  }

  method set_column (Str() $column, GValue() $value, GdaConnection() $cnc)
    is also<set-column>
  {
    gda_meta_context_set_column($!gms, $column, $value, $cnc);
  }

  method set_columns (GHashTable() $columns, GdaConnection() $cnc)
    is also<set-columns>
  {
    gda_meta_context_set_columns($!gms, $columns, $cnc);
  }

  method set_table (Str() $table) is also<set-table> {
    gda_meta_context_set_table($!gms, $table);
  }

}
