use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;
use GDA::Raw::Structs;

unit package GDA::Raw::SqlBuilder;

### /usr/src/libgda/libgda/gda-sql-builder.h

sub gda_sql_builder_add_case (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $test_expr,
  GdaSqlBuilderId $else_expr
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_case_v (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $test_expr,
  GdaSqlBuilderId $else_expr,
  GdaSqlBuilderId $when_array,
  GdaSqlBuilderId $then_array,
  gint            $args_size
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_cond (
  GdaSqlBuilder      $builder,
  GdaSqlOperatorType $op,
  GdaSqlBuilderId    $op1,
  GdaSqlBuilderId    $op2,
  GdaSqlBuilderId    $op3
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_cond_v (
  GdaSqlBuilder      $builder,
  GdaSqlOperatorType $op,
  GdaSqlBuilderId    $op_ids,
  gint               $op_ids_size
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_expr (
  GdaSqlBuilder  $builder,
  GdaDataHandler $dh,
  GType          $type
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_expr_value (
  GdaSqlBuilder  $builder,
  GdaDataHandler $dh,
  GValue         $value
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_field_id (
  GdaSqlBuilder $builder,
  Str           $field_name,
  Str           $table_name
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_field_value (
  GdaSqlBuilder $builder,
  Str           $field_name,
  GType         $type
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_field_value_as_gvalue (
  GdaSqlBuilder $builder,
  Str           $field_name,
  GValue        $value
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_field_value_id (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $field_id,
  GdaSqlBuilderId $value_id
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_function (
  GdaSqlBuilder $builder,
  Str           $func_name
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_function_v (
  GdaSqlBuilder   $builder,
  Str             $func_name,
  GdaSqlBuilderId $args,
  gint            $args_size
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_id (
  GdaSqlBuilder $builder,
  Str           $str
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_param (
  GdaSqlBuilder $builder,
  Str           $param_name,
  GType         $type,
  gboolean      $nullok
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_add_sub_select (
  GdaSqlBuilder   $builder,
  GdaSqlStatement $sqlst
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_compound_add_sub_select (
  GdaSqlBuilder   $builder,
  GdaSqlStatement $sqlst
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_compound_add_sub_select_from_builder (
  GdaSqlBuilder $builder,
  GdaSqlBuilder $subselect
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_compound_set_type (
  GdaSqlBuilder               $builder,
  GdaSqlStatementCompoundType $compound_type
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_error_quark
  returns GQuark
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_export_expression (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $id
)
  returns GdaSqlExpr
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_get_sql_statement (GdaSqlBuilder $builder)
  returns GdaSqlStatement
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_get_statement (
  GdaSqlBuilder           $builder,
  CArray[Pointer[GError]] $error
)
  returns GdaStatement
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_get_type
  returns GType
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_import_expression (
  GdaSqlBuilder $builder,
  GdaSqlExpr    $expr
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_import_expression_from_builder (
  GdaSqlBuilder   $builder,
  GdaSqlBuilder   $query,
  GdaSqlBuilderId $expr_id
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_join_add_field (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $join_id,
  Str             $field_name
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_new (GdaSqlStatementType $stmt_type)
  returns GdaSqlBuilder
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_add_field (
  GdaSqlBuilder $builder,
  Str           $field_name,
  Str           $table_name,
  Str           $alias
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_add_target (
  GdaSqlBuilder $builder,
  Str           $table_name,
  Str           $alias
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_add_target_id (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $table_id,
  Str             $alias
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_group_by (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $expr_id
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_join_targets (
  GdaSqlBuilder        $builder,
  GdaSqlBuilderId      $left_target_id,
  GdaSqlBuilderId      $right_target_id,
  GdaSqlSelectJoinType $join_type,
  GdaSqlBuilderId      $join_expr
)
  returns GdaSqlBuilderId
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_order_by (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $expr_id,
  gboolean        $asc,
  Str             $collation_name
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_set_distinct (
  GdaSqlBuilder   $builder,
  gboolean        $distinct,
  GdaSqlBuilderId $expr_id
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_set_having (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $cond_id
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_select_set_limit (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $limit_count_expr_id,
  GdaSqlBuilderId $limit_offset_expr_id
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_set_table (
  GdaSqlBuilder $builder,
  Str           $table_name
)
  is      native(gda)
  is      export
{ * }

sub gda_sql_builder_set_where (
  GdaSqlBuilder   $builder,
  GdaSqlBuilderId $cond_id
)
  is      native(gda)
  is      export
{ * }
