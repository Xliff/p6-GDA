use v6.c;

use Method::Also;
use NativeCall;

use GDA::Raw::Types;
use GDA::Raw::SqlBuilder;

use GDA::Statement;

use GLib::Roles::Object;
use GLib::Roles::Implementor;

our subset GdaSqlBuilderAncestry is export of Mu
  where GdaSqlBuilder | GObject;

class GDA::SqlBuilder {
  also does GLib::Roles::Object;

  has GdaSqlBuilder $!gsb is implementor;

  submethod BUILD ( :$gda-sql-bldr ) {
    self.setGdaSqlBuilder($gda-sql-bldr) if $gda-sql-bldr
  }

  method setGdaSqlBuilder (GdaSqlBuilderAncestry $_) {
    my $to-parent;

    $!gsb = do {
      when GdaSqlBuilder {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdaSqlBuilder, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDA::Raw::Definitions::GdaSqlBuilder
    is also<GdaSqlBuilder>
  { $!gsb }

  multi method new (
     $gda-sql-bldr where * ~~ GdaSqlBuilderAncestry,

    :$ref = True
  ) {
    return unless $gda-sql-bldr;

    my $o = self.bless( :$gda-sql-bldr );
    $o.ref if $ref;
    $o;
  }

  multi method new ( :c(:$create)  is required ) {
    samewith(GDA_SQL_STATEMENT_INSERT);
  }
  multi method new ( :r(:s(:$select))  is required ) {
    samewith(GDA_SQL_STATEMENT_SELECT);
  }
  multi method new ( :u(:$update)  is required ) {
    samewith(GDA_SQL_STATEMENT_UPDATE);
  }
  multi method new ( :d(:$deleted) is required ) {
    samewith(GDA_SQL_STATEMENT_DELETE);
  }
  multi method new (Int() $stmt_type) {
    my GdaSqlStatementType $s = $stmt_type;

    my $gda-sql-bldr = gda_sql_builder_new($s);

    $gda-sql-bldr ?? self.bless( :$gda-sql-bldr ) !! Nil;
  }

  # Type: int
  method stmt-type is rw
    is also<
      stmt_type
      statement-type
      statement_type
    >
  {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = self.prop_get('stmt-type', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('stmt-type', $gv);
      }
    );
  }

  method add_case (Int() $test_expr, Int() $else_expr) is also<add-case> {
    my GdaSqlBuilderId ($t, $e) = ($test_expr, $else_expr);

    gda_sql_builder_add_case($!gsb, $t, $e);
  }

  proto method add_case_v (|)
    is also<add-case-v>
  { * }

  multi method add_case_v (
    Int() $test_expr,
          @when_array,
          @then_array,
    Int() $else_expr
  ) {
    samewith(
      $test_expr,
      $else_expr,
      ArrayToCArray(GdaSqlBuilderId, @when_array),
      ArrayToCArray(GdaSqlBuilderId, @then_array),
      min(@when_array.elems, @then_array.elems)
    );
  }
  multi method add_case_v (
    Int()                   $test_expr,
    Int()                   $else_expr,
    CArray[GdaSqlBuilderId] $when_array,
    CArray[GdaSqlBuilderId] $then_array,
    Int()                   $args_size
  ) {
    my guint $a = $args_size;

    my GdaSqlBuilderId ($t, $e) = ($test_expr, $else_expr);

    gda_sql_builder_add_case_v(
      $!gsb,
      $test_expr,
      $else_expr,
      $when_array,
      $then_array,
      $a
    );
  }

  method add_cond (Int() $op, Int() $op1, Int() $op2, Int() $op3) is also<add-cond> {
    my GdaSqlOperatorType $o = $op;

    my GdaSqlBuilderId ($o1, $o2, $o3) = ($op1, $op2, $op3);

    gda_sql_builder_add_cond($!gsb, $o, $o1, $o2, $o3);
  }

  proto method add_cond_v (|)
    is also<add-cond-v>
  { * }

  multi method add_cond_v (Int() $op, @ops) {
    samewith($op, CArrayToArray(GdaSqlBuilderId, @ops), @ops.elems);
  }
  multi method add_cond_v (
    Int()                   $op,
    CArray[GdaSqlBuilderId] $op_ids,
    Int()                   $op_ids_size
  ) {
    my GdaSqlOperatorType $o = $op;
    my gint               $s = $op_ids_size;

    gda_sql_builder_add_cond_v($!gsb, $o, $op_ids, $s);
  }

  method add_expr (GdaDataHandler() $dh, Int() $type) is also<add-expr> {
    my GType $t = $type;

    gda_sql_builder_add_expr($!gsb, $dh, $t);
  }

  method add_expr_value (GdaDataHandler() $dh, GValue() $value)
    is also<add-expr-value>
  {
    gda_sql_builder_add_expr_value($!gsb, $dh, $value);
  }

  method add_field_id (Str() $field_name, Str() $table_name = Str)
    is also<add-field-id>
  {
    gda_sql_builder_add_field_id($!gsb, $field_name, $table_name);
  }

  method add_field_value (Str() $field_name, Int() $type)
    is also<add-field-value>
  {
    my GType $t = $type;

    gda_sql_builder_add_field_value($!gsb, $field_name, $t);
  }

  method add_field_value_as_gvalue (Str() $field_name, GValue() $value)
    is also<add-field-value-as-gvalue>
  {
    gda_sql_builder_add_field_value_as_gvalue($!gsb, $field_name, $value);
  }

  method add_field_value_id (Int() $field_id, Int() $value_id)
    is also<add-field-value-id>
  {
    my GdaSqlBuilderId ($f, $v) = ($field_id, $value_id);

    gda_sql_builder_add_field_value_id($!gsb, $f, $v);
  }

  method add_function (Str() $func_name) is also<add-function> {
    gda_sql_builder_add_function($!gsb, $func_name);
  }

  proto method add_function_v (|)
    is also<add-function-v>
  { * }

  multi method add_function_v (Str() $func_name, @args) {
    samewith(
      $func_name,
      CArrayToArray(GdaSqlBuilderId, @args),
      @args.elems
    );
  }
  multi method add_function_v (
    Str()                   $func_name,
    CArray[GdaSqlBuilderId] $args,
    Int()                   $args_size
  ) {
    my gint $s = $args_size;

    gda_sql_builder_add_function_v($!gsb, $func_name, $args, $s);
  }

  method add_id (Str() $str) is also<add-id> {
    gda_sql_builder_add_id($!gsb, $str);
  }

  method add_param (Str() $param_name, Int() $type, Int() $nullok)
    is also<add-param>
  {
    my GType    $t = $type;
    my gboolean $n = $nullok.so.Int;

    gda_sql_builder_add_param($!gsb, $param_name, $t, $n);
  }

  method add_sub_select (GdaSqlStatement() $sqlst) is also<add-sub-select> {
    gda_sql_builder_add_sub_select($!gsb, $sqlst);
  }

  method compound_add_sub_select (GdaSqlStatement() $sqlst)
    is also<compound-add-sub-select>
  {
    gda_sql_builder_compound_add_sub_select($!gsb, $sqlst);
  }

  method compound_add_sub_select_from_builder (GdaSqlBuilder() $subselect)
    is also<compound-add-sub-select-from-builder>
  {
    gda_sql_builder_compound_add_sub_select_from_builder($!gsb, $subselect);
  }

  method compound_set_type (Int() $compound_type)
    is also<compound-set-type>
  {
    my GdaSqlStatementCompoundType $c = $compound_type;

    gda_sql_builder_compound_set_type($!gsb, $c);
  }

  method error_quark is static is also<error-quark> {
    gda_sql_builder_error_quark();
  }

  method export_expression (Int() $id) is also<export-expression> {
    my GdaSqlBuilderId $i = $id;

    gda_sql_builder_export_expression($!gsb, $i);
  }

  method get_sql_statement is also<get-sql-statement> {
    gda_sql_builder_get_sql_statement($!gsb);
  }

  method get_statement (CArray[Pointer[GError]] $error = gerror)
    is also<get-statement>
  {
    say "Get Statement: { $!gsb }";

    gda_sql_builder_get_statement($!gsb, $error);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gda_sql_builder_get_type, $n, $t );
  }

  method import_expression (GdaSqlExpr() $expr) is also<import-expression> {
    gda_sql_builder_import_expression($!gsb, $expr);
  }

  method import_expression_from_builder (
    GdaSqlBuilder() $query,
    Int()           $expr_id
  )
    is also<import-expression-from-builder>
  {
    my GdaSqlBuilderId $e = $expr_id;

    gda_sql_builder_import_expression_from_builder($!gsb, $query, $e);
  }

  method join_add_field (Int() $join_id, Str() $field_name)
    is also<join-add-field>
  {
    my GdaSqlBuilderId $j = $join_id;

    gda_sql_builder_join_add_field($!gsb, $j, $field_name);
  }

  method set_table (Str() $table_name) is also<set-table> {
    gda_sql_builder_set_table($!gsb, $table_name);
  }


  method set_where (Int() $cond_id) is also<set-where> {
    my GdaSqlBuilderId $c = $cond_id;

    gda_sql_builder_set_where($!gsb, $c);
  }

}

class GDA::SqlBuilder::Select is GDA::SqlBuilder {
  has $!o handles(*) is built;

  method new {
    my $o = callwith( :select );
    return Nil unless $o;
    self.bless( :$o );
  }

  method build (
    :$distinct,
    :@fields,
    :table(:$target),
    :$where,
    :$limit,
    :order_by(:$order-by),
    :group_by(:$group-by),
    :$having
  ) {
    self.set_distinct($distinct)   if   $distinct;
    self.add_target($target)       if   $target;
    self.set_limit($_)             with $limit;
    self.order_by($order-by)       if   $order-by;
    self.group_by($group-by)       if   $group-by;
    self.set-having($having)       if   $having;

    if +@fields {
      self.add_field($_) for @fields
    }
  }

  method add_field (
    Str() $field_name,

    Str() $table_name  = Str,
    Str() $alias       = Str
  )
    is also<add-field>
  {
    my $id = gda_sql_builder_select_add_field(
      $!o.GdaSqlBuilder,
      $field_name,
      $table_name,
      $alias
    );
    say "Field: { $id }";
    $id;
  }

  method add_target (Str() $table_name, Str() $alias = Str)
    is also<add-target>
  {
    my $id = gda_sql_builder_select_add_target(
      $!o.GdaSqlBuilder,
      $table_name,
      $alias
    );
    say "Target: { $id }";
    $id;
  }

  method add_target_id (Int() $table_id, Str() $alias = Str)
    is also<add-target-id>
  {
    my  GdaSqlBuilderId $t = $table_id;

    gda_sql_builder_select_add_target_id($!o.GdaSqlBuilder, $t, $alias);
  }

  method get_sql_statement is also<get-sql-statement> {
    say "O: { $!o.GdaSqlBuilder }";

    $!o.get_sql_statement;
  }

  method get_statement ( :$raw = False ) is also<get-statement> {
    propReturnObject($!o.get_statement, $raw, |GDA::Statement.getTypePair);
  }

  method group_by (Int() $expr_id) is also<group-by> {
    my GdaSqlBuilderId $e = $expr_id;

    gda_sql_builder_select_group_by($!o.GdaSqlBuilder, $e);
  }

  method join_targets (
    Int() $left_target_id,
    Int() $right_target_id,
    Int() $join_type,
    Int() $join_expr
  )
    is also<join-targets>
  {
    my GdaSqlBuilderId ($l, $r, $e) =
      ($left_target_id, $right_target_id, $join_expr);

    my GdaSqlSelectJoinType  $j = $join_type;

    gda_sql_builder_select_join_targets($!o.GdaSqlBuilder, $l, $r, $j, $e);
  }

  method order_by (Int() $expr_id, Int() $asc, Str() $collation_name)
    is also<order-by>
  {
    my GdaSqlBuilderId $e = $expr_id;
    my gboolean        $a = $asc.so.Int;

    gda_sql_builder_select_order_by(
      $!o.GdaSqlBuilder,
      $e,
      $a,
      $collation_name
    );
  }

  method set_distinct (Int() $distinct, Int() $expr_id) is also<set-distinct> {
    my GdaSqlBuilderId $e = $expr_id;
    my gboolean        $d = $distinct.so.Int;

    gda_sql_builder_select_set_distinct($!o.GdaSqlBuilder, $d, $e);
  }

  method set_having (Int() $cond_id) is also<set-having> {
    my GdaSqlBuilderId $c = $cond_id;

    gda_sql_builder_select_set_having($!o.GdaSqlBuilder, $c);
  }

  method set_limit (
    Int() $limit_count_expr_id,
    Int() $limit_offset_expr_id
  )
    is also<set-limit>
  {
    my GdaSqlBuilderId ($l1, $l2) =
      ($limit_count_expr_id, $limit_offset_expr_id);

    gda_sql_builder_select_set_limit(
      $!o.GdaSqlBuilder,
      $limit_count_expr_id,
      $limit_offset_expr_id
    );
  }

}

constant SQLS is export := GDA::SqlBuilder::Select
