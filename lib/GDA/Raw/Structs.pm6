use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDA::Raw::Definitions;

unit package GDA::Raw::Structs;

class GdaBatch is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaBlobOp is repr<CStruct> is export {
	has GObject  $!object        ;
	has gpointer $!_gda_reserved1;
}

class GdaColumn is repr<CStruct> is export {
	has GObject          $!object;
	has gpointer         $!priv  ;
}

class GdaConfig is repr<CStruct> is export {
	has GObject          $!object;
	has gpointer         $!priv  ;
}

class GdaConnection is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaConnectionEvent is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaDataAccessWrapper is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaDataComparator is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaDataModelArray is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaDataModelDir is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaDataModelImport is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaDataModelIter is repr<CStruct> is export {
	has GdaSet              $!object;
	has gpointer            $!priv  ;
}

class GdaDataPivot is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaDataProxy is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer            $!priv  ;
}

class GdaPStmt is repr<CStruct> is export {
	has GObject         $!object        ;
	has gpointer        $!priv          ;
	has Str             $!sql           ;
	has GSList          $!param_ids     ;
	has gint            $!ncols         ;
	has GType           $!types         ;
	has GSList          $!tmpl_columns  ;
	has gpointer        $!_gda_reserved1;
	has gpointer        $!_gda_reserved2;
}

class GdaDataSelect is repr<CStruct> is export {
	has GObject              $!object          ;
	has gpointer             $!priv            ;
	has GdaPStmt             $!prep_stmt       ;
	has gint                 $!nb_stored_rows  ;
	has gint                 $!advertized_nrows;
	has gpointer             $!_gda_reserved1  ;
	has gpointer             $!_gda_reserved2  ;
	has gpointer             $!_gda_reserved3  ;
	has gpointer             $!_gda_reserved4  ;
}

class GdaDsnInfo is repr<CStruct> is export {
	has Str      $!name          ;
	has Str      $!provider      ;
	has Str      $!description   ;
	has Str      $!cnc_string    ;
	has Str      $!auth_string   ;
	has gboolean $!is_system     ;
	has gpointer $!_gda_reserved1;
	has gpointer $!_gda_reserved2;
	has gpointer $!_gda_reserved3;
	has gpointer $!_gda_reserved4;
}

class GdaHandlerBin is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaHandlerBoolean is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaHandlerNumerical is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaHandlerString is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaHandlerTime is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaHandlerType is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaHolder is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaMetaStore is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaMetaStruct is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaSet is repr<CStruct> is export {
	has GObject       $!object      ;
	has gpointer      $!priv        ;
	has GSList        $!holders     ;
	has GSList        $!nodes_list  ;
	has GSList        $!sources_list;
	has GSList        $!groups_list ;
}

class GdaProviderInfo is repr<CStruct> is export {
	has Str      $!id            ;
	has Str      $!location      ;
	has Str      $!description   ;
	has GdaSet   $!dsn_params    ;
	has GdaSet   $!auth_params   ;
	has gpointer $!_gda_reserved1;
	has gpointer $!_gda_reserved2;
	has gpointer $!_gda_reserved3;
	has gpointer $!_gda_reserved4;
}

class GdaRepetitiveStatement is repr<CStruct> is export {
	has GObject $!parent_instance;
}

class GdaRepetitiveStatementClass is repr<CStruct> is export {
	has GObjectClass $!parent_class;
}

class GdaReportDocbookDocument is repr<CStruct> is export {
	has GdaReportDocument $!base;
	has gpointer          $!priv;
}

class GdaReportDocument is repr<CStruct> is export {
	has GObject   $!base;
	has gpointer  $!priv;
}

class GdaReportEngine is repr<CStruct> is export {
	has GObject   $!base;
	has gpointer  $!priv;
}

class GdaReportRmlDocument is repr<CStruct> is export {
	has GdaReportDocument  $!base;
	has gpointer           $!priv;
}

class GdaRow is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaServerOperation is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaServerOperationNode is repr<CStruct> is export {
	has GdaServerOperationNodeType   $!type  ;
	has GdaServerOperationNodeStatus $!status;
	has GdaSet                       $!plist ;
	has GdaDataModel                 $!model ;
	has GdaColumn                    $!column;
	has GdaHolder                    $!param ;
	has gpointer                     $!priv  ;
}

class GdaServerProvider is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class gpointer  is repr<CStruct> is export {
	has GHashTable   $!data_handlers;
	has GdaSqlParser $!parser       ;
}

class GdaSqlAnyPart is repr<CStruct> is export {
	has GdaSqlAnyPartType $!type  ;
	has GdaSqlAnyPart     $!parent;
}

class GdaSqlBuilder is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaSqlFunction is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has Str           $!function_name ;
	has GSList        $!args_list     ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlOperation is repr<CStruct> is export {
	has GdaSqlAnyPart      $!any           ;
	has GdaSqlOperatorType $!operator_type ;
	has GSList             $!operands      ;
	has gpointer           $!_gda_reserved1;
	has gpointer           $!_gda_reserved2;
}

class GdaSqlParamSpec is repr<CStruct> is export {
	has Str      $!name              ;
	has Str      $!descr             ;
	has gboolean $!is_param          ;
	has gboolean $!nullok            ;
	has GType    $!g_type            ;
	has gpointer $!validity_meta_dict;
	has gpointer $!_gda_reserved1    ;
	has gpointer $!_gda_reserved2    ;
}

class GdaSqlExpr is repr<CStruct> is export {
	has GdaSqlAnyPart   $!any           ;
	has GValue          $!value         ;
	has GdaSqlParamSpec $!param_spec    ;
	has GdaSqlFunction  $!func          ;
	has GdaSqlOperation $!cond          ;
	has GdaSqlAnyPart   $!select        ;
	has GdaSqlCase      $!case_s        ;
	has Str             $!cast_as       ;
	has gboolean        $!value_is_ident;
	has gpointer        $!_gda_reserved1;
	has gpointer        $!_gda_reserved2;
	has gpointer        $!_gda_reserved3;
	has gpointer        $!_gda_reserved4;
}

class GdaSqlCase is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has GdaSqlExpr    $!base_expr     ;
	has GSList        $!when_expr_list;
	has GSList        $!then_expr_list;
	has GdaSqlExpr    $!else_expr     ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlField is repr<CStruct> is export {
	has GdaSqlAnyPart      $!any                       ;
	has Str                $!field_name                ;
	has GdaMetaTableColumn $!validity_meta_table_column;
	has gpointer           $!_gda_reserved1            ;
	has gpointer           $!_gda_reserved2            ;
}

class GdaSqlParser is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaSqlStatement is repr<CStruct> is export {
	has Str                 $!sql                 ;
	has GdaSqlStatementType $!stmt_type           ;
	has gpointer            $!contents            ;
	has GdaMetaStruct       $!validity_meta_struct;
	has gpointer            $!_gda_reserved1      ;
	has gpointer            $!_gda_reserved2      ;
}

class GdaSqlParserIface is repr<CStruct> is export {
	has GdaSqlParser    $!parser          ;
	has GdaSqlStatement $!parsed_statement;
	has gpointer        $!_gda_reserved1  ;
	has gpointer        $!_gda_reserved2  ;
}

class GdaSqlSelectField is repr<CStruct> is export {
	has GdaSqlAnyPart      $!any                       ;
	has GdaSqlExpr         $!expr                      ;
	has Str                $!field_name                ;
	has Str                $!table_name                ;
	has Str                $!as                        ;
	has GdaMetaDbObject    $!validity_meta_object      ;
	has GdaMetaTableColumn $!validity_meta_table_column;
	has gpointer           $!_gda_reserved1            ;
	has gpointer           $!_gda_reserved2            ;
}

class GdaSqlSelectFrom is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has GSList        $!targets       ;
	has GSList        $!joins         ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlSelectJoin is repr<CStruct> is export {
	has GdaSqlAnyPart        $!any           ;
	has GdaSqlSelectJoinType $!type          ;
	has gint                 $!position      ;
	has GdaSqlExpr           $!expr          ;
	has GSList               $!use           ;
	has gpointer             $!_gda_reserved1;
	has gpointer             $!_gda_reserved2;
}

class GdaSqlSelectOrder is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has GdaSqlExpr    $!expr          ;
	has gboolean      $!asc           ;
	has Str           $!collation_name;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlSelectTarget is repr<CStruct> is export {
	has GdaSqlAnyPart   $!any                 ;
	has GdaSqlExpr      $!expr                ;
	has Str             $!table_name          ;
	has Str             $!as                  ;
	has GdaMetaDbObject $!validity_meta_object;
	has gpointer        $!_gda_reserved1      ;
	has gpointer        $!_gda_reserved2      ;
}

class GdaSqlStatementCompound is repr<CStruct> is export {
	has GdaSqlAnyPart               $!any           ;
	has GdaSqlStatementCompoundType $!compound_type ;
	has GSList                      $!stmt_list     ;
	has gpointer                    $!_gda_reserved1;
	has gpointer                    $!_gda_reserved2;
}

class GdaSqlStatementDelete is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has GdaSqlTable   $!table         ;
	has GdaSqlExpr    $!cond          ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlStatementInsert is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has Str           $!on_conflict   ;
	has GdaSqlTable   $!table         ;
	has GSList        $!fields_list   ;
	has GSList        $!values_list   ;
	has GdaSqlAnyPart $!select        ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlStatementSelect is repr<CStruct> is export {
	has GdaSqlAnyPart    $!any           ;
	has gboolean         $!distinct      ;
	has GdaSqlExpr       $!distinct_expr ;
	has GSList           $!expr_list     ;
	has GdaSqlSelectFrom $!from          ;
	has GdaSqlExpr       $!where_cond    ;
	has GSList           $!group_by      ;
	has GdaSqlExpr       $!having_cond   ;
	has GSList           $!order_by      ;
	has GdaSqlExpr       $!limit_count   ;
	has GdaSqlExpr       $!limit_offset  ;
	has gpointer         $!_gda_reserved1;
	has gpointer         $!_gda_reserved2;
}

class GdaSqlStatementTransaction is repr<CStruct> is export {
	has GdaSqlAnyPart           $!any            ;
	has GdaTransactionIsolation $!isolation_level;
	has Str                     $!trans_mode     ;
	has Str                     $!trans_name     ;
	has gpointer                $!_gda_reserved1 ;
	has gpointer                $!_gda_reserved2 ;
}

class GdaSqlStatementUnknown is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has GSList        $!expressions   ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlStatementUpdate is repr<CStruct> is export {
	has GdaSqlAnyPart $!any           ;
	has Str           $!on_conflict   ;
	has GdaSqlTable   $!table         ;
	has GSList        $!fields_list   ;
	has GSList        $!expr_list     ;
	has GdaSqlExpr    $!cond          ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaSqlTable is repr<CStruct> is export {
	has GdaSqlAnyPart   $!any                 ;
	has Str             $!table_name          ;
	has GdaMetaDbObject $!validity_meta_object;
	has gpointer        $!_gda_reserved1      ;
	has gpointer        $!_gda_reserved2      ;
}

class GdaSqliteProvider is repr<CStruct> is export {
	has GdaServerProvider $!provider;
}

class GdaStatement is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaThreadWrapper is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaTransactionStatus is repr<CStruct> is export {
	has GObject                   $!object         ;
	has Str                       $!name           ;
	has GdaTransactionIsolation   $!isolation_level;
	has GdaTransactionStatusState $!state          ;
	has GList                     $!events         ;
	has gpointer                  $!_gda_reserved1 ;
	has gpointer                  $!_gda_reserved2 ;
}

class GdaTree is repr<CStruct> is export {
	has GObject        $!object;
	has gpointer  $!priv  ;
}

class GdaTreeManager is repr<CStruct> is export {
	has GObject               $!object;
	has gpointer              $!priv  ;
}

class GdaTreeMgrColumns is repr<CStruct> is export {
	has GdaTreeManager        $!object;
	has gpointer              $!priv  ;
}

class GdaTreeMgrColumnsClass is repr<CStruct> is export {
	has GdaTreeManagerClass $!object_class;
}

class GdaTreeMgrLabel is repr<CStruct> is export {
	has GdaTreeManager      $!object;
	has gpointer            $!priv  ;
}

class GdaTreeMgrLabelClass is repr<CStruct> is export {
	has GdaTreeManagerClass $!object_class;
}

class GdaTreeMgrSchemas is repr<CStruct> is export {
	has GdaTreeManager  $!object;
	has gpointer        $!priv  ;
}

class GdaTreeMgrSchemasClass is repr<CStruct> is export {
	has GdaTreeManagerClass $!object_class;
}

class GdaTreeMgrSelect is repr<CStruct> is export {
	has GdaTreeManager $!object;
	has gpointer       $!priv  ;
}

class GdaTreeMgrSelectClass is repr<CStruct> is export {
	has GdaTreeManagerClass $!object_class;
}

class GdaTreeMgrTables is repr<CStruct> is export {
	has GdaTreeManager $!object;
	has gpointer       $!priv  ;
}

class GdaTreeMgrTablesClass is repr<CStruct> is export {
	has GdaTreeManagerClass $!object_class;
}

class GdaTreeNode is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}


class GdaVirtualConnection is repr<CStruct> is export {
	has GdaConnection $!connection;
	has gpointer      $!priv      ;
}

class GdaVconnectionDataModel is repr<CStruct> is export {
	has GdaVirtualConnection $!connection;
	has gpointer             $!priv      ;
}

class GdaVconnectionDataModelSpec is repr<CStruct> is export {
	has GdaDataModel                             $!data_model                ;
	has GdaVconnectionDataModelCreateColumnsFunc $!create_columns_func       ;
	has GdaVconnectionDataModelCreateModelFunc   $!create_model_func         ;
	has GdaVconnectionDataModelParseFilterFunc   $!create_filter_func        ;
	has GdaVconnectionDataModelCreateFModelFunc  $!create_filtered_model_func;
}

class GdaVconnectionHub is repr<CStruct> is export {
	has GdaVconnectionDataModel  $!parent;
	has gpointer                 $!priv  ;
}

class GdaVirtualConstraint is repr<CStruct> is export {
	has int                $!iColumn;
	has GdaSqlOperatorType $!op     ;
}

class GdaVirtualConstraintUsage is repr<CStruct> is export {
	has int      $!argvIndex;
	has gboolean $!omit     ;
}

class GdaVirtualOrderby is repr<CStruct> is export {
	has int      $!iColumn;
	has gboolean $!desc   ;
}

class GdaVproviderDataModel is repr<CStruct> is export {
	has GdaVirtualProvider     $!vprovider;
	has gpointer               $!priv     ;
}

class GdaVproviderHub is repr<CStruct> is export {
	has GdaVproviderDataModel  $!parent;
	has gpointer               $!priv  ;
}

class GdaXaTransaction is repr<CStruct> is export {
	has GObject                $!object;
	has gpointer               $!priv  ;
}

class GdaXsltExCont is repr<CStruct> is export {
	has int           $!init          ;
	has GdaConnection $!cnc           ;
	has GHashTable    $!query_hash    ;
	has GError        $!error         ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
	has gpointer      $!_gda_reserved3;
	has gpointer      $!_gda_reserved4;
}
