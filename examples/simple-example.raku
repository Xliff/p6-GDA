use v6.c;

use GLib::Value;
use GDA::Raw::Types;
use GDA::Connection;

use GDA;

sub MAIN {
  GDA.init;

  my $*parser;

  given open-connection() {
    .&create-table;
    .&insert-data;
    .&display-products-contents;
    .&update-data;
    .&display-products-contents;
    .&delete-data;
    .&display-products-contents;
    .close;
    .unref;
  }
}

sub getError {
  $ERROR && $ERROR.message ?? $ERROR.message !! 'No detail';
}

sub open-connection {
  my $cnc = GDA::Connection.open-from-string(
    'SQLite',
    'DB_DIR=.;DB_NAME=example_db',
  );

  without $cnc {
    $*ERR.say: "Could not open connection to SQLite database in {
                '' }example_db.db file: { getError }";
    exit;
  }

  $*parser = $cnc.create-parser;
  $*parser = GDA::SQL::Parser.new unless $*parser;
  $cnc;
}

sub create-table ($cnc) {
  run-sql-non-select($cnc, 'DROP table IF EXISTS products');

  run-sql-non-select($cnc, q:to/SQL/);
    CREATE TABLE products (
      ref   string NOT NULL primary key,
      name  string NOT NULL,
      price real
    );
    SQL
}

sub insert-data ($cnc) {
  my @data = (
		['p1',   'chair', False, 2.0],
		['p2',   'table', False, 5.0],
		['p3',   'glass', False, 1.1],
		['p1000',  '???', True,    0],
		['p1001',  '???', True,    0]
  );

  for @data {
    # @dv = (
    #   gv_str( .[0] ),
    #   gv_str( .[1] ),
    #   .[2].not ?? gv_flt( .[3] ) !! GValue
    # );

    # my $res = $cnc.insert_row_into_table(
    #   $products,
    #   <ref name price>,
    #   @dv
    # );
    my $res = $cnc.insert-row-into-table(
      'products',
      ref   => gv_str( .[0] ),
      name  => gv_str( .[1] ),
      price => .[2].not ?? gv_flt( .[3] ) !! GValue
    );

    unless $res {
      $*ERR.say: "Could not INSERT data into the 'products' table: {
                  $ERROR.domain } / { $ERROR.code }";
    }
  }
}

sub delete-data ($cnc) {
  my $res = $cnc.delete-row-from-table( 'products', 'name', gv_str('table') );

  unless $res {
    $*ERR.say: "Could not DELETE data from the 'products' table: {
                getError }";
  }

  $res = $cnc.delete-row-from-table( 'products', 'price' );

  unless $res {
    $*ERR.say: "Could not DELETE data from the 'products' table: {
                getError }";
  }
}

sub update-data ($cnc) {
  my $res = $cnc.update-row-in-table(
    'products',
    'ref',
    gv_str('p1000'),
    gerror,
    name  => gv_str('flowers'),
    price => gv_flt(1.99)
  );
  say 'Done updating';

  unless $res {
    $*ERR.say: "Could not UPDATE data in the 'products' table: {
                getError }";
  }
}

sub display-products-contents ($cnc) {
  my $stmt = $*parser.parse-string(q:to/SQL/);
    SELECT ref, name, price FROM products
    SQL

  my $data-model = $cnc.statement_execute_select($stmt);
  unless $data-model {
    $*ERR.say: "Could not get the contents of the 'products' table: {
                getError }";
  }
  $data-model.dump_as_string.say;
}

sub run-sql-non-select ($cnc, $sql) {
  my ($stmt, $remain) = $*parser.parse-string($sql);
  say "REMAINS: { $remain }" if $remain;

  my $nrows = $cnc.statement-execute-non-select($stmt);
  $*ERR.say: "NON SELELECT error: { getError }" if $nrows == -1;
  $stmt.unref;
}
