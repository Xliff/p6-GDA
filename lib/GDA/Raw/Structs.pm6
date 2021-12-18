use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GLib::Raw::Structs;
use GDA::Raw::Definitions;
use GDA::Raw::Enums;

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

class GdaSet is repr<CStruct> is export {
	has GObject       $!object      ;
	has gpointer      $!priv        ;
	has GSList        $!holders     ;
	has GSList        $!nodes_list  ;
	has GSList        $!sources_list;
	has GSList        $!groups_list ;
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

# cw: Move to ::Raw::Class compunit... possibly in another distro
# class GdaRepetitiveStatementClass is repr<CStruct> is export {
# 	has GObjectClass $!parent_class;
# }

class GdaReportDocument is repr<CStruct> is export {
	has GObject   $!base;
	has gpointer  $!priv;
}

class GdaReportDocbookDocument is repr<CStruct> is export {
	has GdaReportDocument $!base;
	has gpointer          $!priv;
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

class GdaSqlParser is repr<CStruct> is export {
	has GObject   $!object;
	has gpointer  $!priv  ;
}

class GdaServerProviderPrivates is repr<CStruct> is export {
	has GHashTable   $!data_handlers;
	has GdaSqlParser $!parser       ;
}

class GdaSetSource is repr<CStruct> is export {
  has GdaDataModel   $!data_model;      #= Can't be NULL
  has GSList         $!nodes;           #= list of #GdaSetNode for which source_model == @data_mode
  has gpointer       $!gda_reserved1;
  has gpointer       $!gda_reserved2;
  has gpointer       $!gda_reserved3;
  has gpointer       $!gda_reserved4;

  method data_model is rw {
    Proxy.new:
      FETCH => -> $                    { $!data_model      },
      STORE => -> $, GdaDataModel() \v { $!data_model := v };
  }

  method nodes is rw {
    Proxy.new:
      FETCH => -> $                    { $!nodes      },
      STORE => -> $, GdaDataModel() \v { $!nodes := v };
  }
}

class GdaSetGroup is repr<CStruct> is export {
	has GSList       $!nodes;        #= list of GdaSetNode, at least one entry
	has GdaSetSource $!nodes_source; #= if NULL, then @nodes contains exactly one entry

	has gpointer $!gda_reserved1;
	has gpointer $!gda_reserved2;

  method nodes is rw {
    Proxy.new:
      FETCH => -> $              { $!nodes      },
      STORE => -> $, GSList() \v { $!nodes := v };
  }

  method nodes_source is rw {
    Proxy.new:
      FETCH => -> $                    { $!nodes_source      },
      STORE => -> $, GdaSetSource() \v { $!nodes_source := v };
  }
}

class GdaSetNode is repr<CStruct> is export {
	has GdaHolder    $!holder;        #= Can't be NULL
	has GdaDataModel $!source_model;  #= may be NULL
	has gint         $.source_column; #= unused if @source_model is NULL

	has gpointer     $!gda_reserved1;
	has gpointer     $!gda_reserved2;

  method holder is rw {
    Proxy.new:
      FETCH => -> $                 { $!holder      },
      STORE => -> $, GdaHolder() \v { $!holder := v };
  }

  method source_model is rw {
    Proxy.new:
      FETCH => -> $                    { $!source_model      },
      STORE => -> $, GdaDataModel() \v { $!source_model := v };
  }
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

class GdaSqlCase is repr<CStruct> is export { ... }

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

class GdaSqlCase {
	HAS GdaSqlAnyPart $!any           ;
	has GdaSqlExpr    $!base_expr     ;
	has GSList        $!when_expr_list;
	has GSList        $!then_expr_list;
	has GdaSqlExpr    $!else_expr     ;
	has gpointer      $!_gda_reserved1;
	has gpointer      $!_gda_reserved2;
}

class GdaMetaContext is repr<CStruct> is export {
  has Str                     $!table_name;
  has gint                    $.size;
  has CArray[Str]             $!column_names;
  has CArray[Pointer[GValue]] $!column_values;
  has GHashTable              $!columns;

  method table_name is rw {
    Proxy.new:
      FETCH => -> $           { $!table_name      },
      STORE => -> $, Str() \v { $!table_name := v };
  }

  method column_name is rw {
    Proxy.new:
      FETCH => -> $                 { $!column_names      },
      STORE => -> $, CArray[Str] \v { $!column_names := v };
  }

  method column_values is rw {
    Proxy.new:
      FETCH => -> $                             { $!column_values      },
      STORE => -> $, CArray[Pointer[GValue]] \v { $!column_values := v };
  }

  method columns is rw {
    Proxy.new:
      FETCH => -> $                  { $!columns      },
      STORE => -> $, GHashTable() \v { $!columns := v };
  }

}

class GdaMetaTable is repr<CStruct> is export {
	has GSList       $.columns;
	has CArray[gint] $!pk_cols_array;
	has gint         $.pk_cols_nb;
	has GSList       $.reverse_fk_list; #=  list of GdaMetaTableForeignKey where @depend_on == this GdaMetaDbObject */
	has GSList       $.fk_list;         #=  list of GdaMetaTableForeignKey where @meta_table == this GdaMetaDbObject */

  method columns is rw {
    Proxy.new:
      FETCH => -> $                  { $!columns      },
      STORE => -> $, CArray[gint] \v { $!columns := v };
  }

  method pk_cols_array is rw {
    Proxy.new:
      FETCH => -> $                  { $!pk_cols_array      },
      STORE => -> $, CArray[gint] \v { $!pk_cols_array := v };
  }

	has gpointer $!gda_reserved1;
	has gpointer $!gda_reserved2;
	has gpointer $!gda_reserved3;
	has gpointer $!gda_reserved4;
}

class GdaMetaView is repr<CStruct> is export {
	HAS GdaMetaTable $.table;
	has Str          $!view_def;
	has gboolean     $.is_updatable;

  method view_def is rw {
    Proxy.new:
      FETCH => -> $                  { $!view_def      },
      STORE => -> $, CArray[gint] \v { $!view_def := v };
  }

	has gpointer $!gda_reserved1;
	has gpointer $!gda_reserved2;
	has gpointer $!gda_reserved3;
	has gpointer $!gda_reserved4;
}

class GdaMetaTableColumn is repr<CStruct> is export {
  has Str       $!column_type;
  has Str       $!column_name;
	has GType     $.gtype;
	has gboolean  $.pkey;
	has gboolean  $.nullok;
  has Str       $!default_value;
	has gboolean  $.auto_incement;
  has Str       $!desc;

  method column_type is rw {
    Proxy.new:
      FETCH => -> $           { $!column_type      },
      STORE => -> $, Str() \v { $!column_type := v }
  }

  method column_name is rw {
    Proxy.new:
      FETCH => -> $           { $!column_name      },
      STORE => -> $, Str() \v { $!column_name := v }
  }

  method default_value is rw {
    Proxy.new:
      FETCH => -> $           { $!default_value      },
      STORE => -> $, Str() \v { $!default_value := v }
  }

  method desc is rw {
    Proxy.new:
      FETCH => -> $           { $!desc      },
      STORE => -> $, Str() \v { $!desc := v }
  }

	has gpointer $!gda_reserved1;
	has gpointer $!gda_reserved2;
	has gpointer $!gda_reserved3;
	has gpointer $!gda_reserved4;
}

class GdaSqlField is repr<CStruct> is export {
	has GdaSqlAnyPart      $!any                       ;
	has Str                $!field_name                ;
	has GdaMetaTableColumn $!validity_meta_table_column;
	has gpointer           $!_gda_reserved1            ;
	has gpointer           $!_gda_reserved2            ;
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

class GdaMetaTableView is repr<CUnion> is export {
  HAS GdaMetaTable $.meta_table;
  HAS GdaMetaView  $.meta_view;
}

class GdaMetaDbObject is repr<CStruct>is export {
	HAS GdaMetaTableView    $.extra;
	has GdaMetaDbObjectType $.obj_type;
	has gboolean            $.outdated;
	has Str                 $!obj_catalog;
	has Str                 $!obj_schema;
	has Str                 $!obj_name;
	has Str                 $!obj_short_name;
	has Str                 $!obj_full_name;
	has Str                 $!obj_owner;
	has GSList              $!depend_list;

	has gpointer $!gda_reserved1;
	has gpointer $!gda_reserved2;
	has gpointer $!gda_reserved3;
	has gpointer $!gda_reserved4;

  method obj_catalog is rw {
    Proxy.new:
      FETCH => -> $           { $!obj_catalog      },
      STORE => -> $, Str() \v { $!obj_catalog := v }
  }

  method obj_schema is rw {
    Proxy.new:
      FETCH => -> $           { $!obj_schema      },
      STORE => -> $, Str() \v { $!obj_schema := v }
  }

  method obj_name is rw {
    Proxy.new:
      FETCH => -> $           { $!obj_name      },
      STORE => -> $, Str() \v { $!obj_name := v }
  }

  method obj_short_name is rw {
    Proxy.new:
      FETCH => -> $           { $!obj_short_name      },
      STORE => -> $, Str() \v { $!obj_short_name := v }
  }

  method obj_full_name is rw {
    Proxy.new:
      FETCH => -> $           { $!obj_full_name      },
      STORE => -> $, Str() \v { $!obj_full_name := v }
  }

  method obj_owner is rw {
    Proxy.new:
      FETCH => -> $           { $!obj_owner      },
      STORE => -> $, Str() \v { $!obj_owner := v }
  }

  method depend_list is rw {
    Proxy.new:
      FETCH => -> $           { $!depend_list      },
      STORE => -> $, Str() \v { $!depend_list := v }
  }

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

class GdaSqlTable is repr<CStruct> is export {
	has GdaSqlAnyPart   $!any                 ;
	has Str             $!table_name          ;
	has GdaMetaDbObject $!validity_meta_object;
	has gpointer        $!_gda_reserved1      ;
	has gpointer        $!_gda_reserved2      ;
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

# class GdaTreeMgrColumnsClass is repr<CStruct> is export {
# 	has GdaTreeManagerClass $!object_class;
# }

class GdaTreeMgrLabel is repr<CStruct> is export {
	has GdaTreeManager      $!object;
	has gpointer            $!priv  ;
}

# class GdaTreeMgrLabelClass is repr<CStruct> is export {
# 	has GdaTreeManagerClass $!object_class;
# }

class GdaTreeMgrSchemas is repr<CStruct> is export {
	has GdaTreeManager  $!object;
	has gpointer        $!priv  ;
}

# class GdaTreeMgrSchemasClass is repr<CStruct> is export {
# 	has GdaTreeManagerClass $!object_class;
# }

class GdaTreeMgrSelect is repr<CStruct> is export {
	has GdaTreeManager $!object;
	has gpointer       $!priv  ;
}

# class GdaTreeMgrSelectClass is repr<CStruct> is export {
# 	has GdaTreeManagerClass $!object_class;
# }

class GdaTreeMgrTables is repr<CStruct> is export {
	has GdaTreeManager $!object;
	has gpointer       $!priv  ;
}

# class GdaTreeMgrTablesClass is repr<CStruct> is export {
# 	has GdaTreeManagerClass $!object_class;
# }

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
	has GdaDataModel $!data_model                ;
	has gpointer     $!create_columns_func       ; #= GdaVconnectionDataModelCreateColumnsFunc
  has gpointer     $!create_filter_func        ; #= GdaVconnectionDataModelParseFilterFunc
	has gpointer     $!create_model_func         ; #= GdaVconnectionDataModelCreateModelFunc
	has gpointer     $!create_filtered_model_func; #= GdaVconnectionDataModelCreateFModelFunc
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

class GdaVirtualProvider is repr<CStruct> is export {
  HAS GdaSqliteProvider  $.provider;
  has gpointer           $!gda_reserved1; #= & (void)
};

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
