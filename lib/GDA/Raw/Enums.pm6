use v6.c;

use GLib::Raw::Definitions;

unit package GDA::Raw::Enums;

constant GdaBatchError is export := guint32;
our enum GdaBatchErrorEnum is export <
  GDA_BATCH_CONFLICTING_PARAMETER_ERROR
>;

constant GdaConfigError is export := guint32;
our enum GdaConfigErrorEnum is export <
  GDA_CONFIG_DSN_NOT_FOUND_ERROR
  GDA_CONFIG_PERMISSION_ERROR
  GDA_CONFIG_PROVIDER_NOT_FOUND_ERROR
  GDA_CONFIG_PROVIDER_CREATION_ERROR
>;

constant GdaConnectionError is export := guint32;
our enum GdaConnectionErrorEnum is export <
  GDA_CONNECTION_DSN_NOT_FOUND_ERROR
  GDA_CONNECTION_PROVIDER_NOT_FOUND_ERROR
  GDA_CONNECTION_PROVIDER_ERROR
  GDA_CONNECTION_NO_CNC_SPEC_ERROR
  GDA_CONNECTION_NO_PROVIDER_SPEC_ERROR
  GDA_CONNECTION_OPEN_ERROR
  GDA_CONNECTION_STATEMENT_TYPE_ERROR
  GDA_CONNECTION_CANT_LOCK_ERROR
  GDA_CONNECTION_TASK_NOT_FOUND_ERROR
  GDA_CONNECTION_UNSUPPORTED_THREADS_ERROR
  GDA_CONNECTION_CLOSED_ERROR
  GDA_CONNECTION_META_DATA_CONTEXT_ERROR
  GDA_CONNECTION_UNSUPPORTED_ASYNC_EXEC_ERROR
>;

constant GdaConnectionEventCode is export := guint32;
our enum GdaConnectionEventCodeEnum is export <
  GDA_CONNECTION_EVENT_CODE_CONSTRAINT_VIOLATION
  GDA_CONNECTION_EVENT_CODE_RESTRICT_VIOLATION
  GDA_CONNECTION_EVENT_CODE_NOT_NULL_VIOLATION
  GDA_CONNECTION_EVENT_CODE_FOREIGN_KEY_VIOLATION
  GDA_CONNECTION_EVENT_CODE_UNIQUE_VIOLATION
  GDA_CONNECTION_EVENT_CODE_CHECK_VIOLATION
  GDA_CONNECTION_EVENT_CODE_INSUFFICIENT_PRIVILEGES
  GDA_CONNECTION_EVENT_CODE_UNDEFINED_COLUMN
  GDA_CONNECTION_EVENT_CODE_UNDEFINED_FUNCTION
  GDA_CONNECTION_EVENT_CODE_UNDEFINED_TABLE
  GDA_CONNECTION_EVENT_CODE_DUPLICATE_COLUMN
  GDA_CONNECTION_EVENT_CODE_DUPLICATE_DATABASE
  GDA_CONNECTION_EVENT_CODE_DUPLICATE_FUNCTION
  GDA_CONNECTION_EVENT_CODE_DUPLICATE_SCHEMA
  GDA_CONNECTION_EVENT_CODE_DUPLICATE_TABLE
  GDA_CONNECTION_EVENT_CODE_DUPLICATE_ALIAS
  GDA_CONNECTION_EVENT_CODE_DUPLICATE_OBJECT
  GDA_CONNECTION_EVENT_CODE_SYNTAX_ERROR
  GDA_CONNECTION_EVENT_CODE_UNKNOWN
>;

constant GdaConnectionEventType is export := guint32;
our enum GdaConnectionEventTypeEnum is export <
  GDA_CONNECTION_EVENT_NOTICE
  GDA_CONNECTION_EVENT_WARNING
  GDA_CONNECTION_EVENT_ERROR
  GDA_CONNECTION_EVENT_COMMAND
>;

constant GdaConnectionFeature is export := guint32;
our enum GdaConnectionFeatureEnum is export <
  GDA_CONNECTION_FEATURE_AGGREGATES
  GDA_CONNECTION_FEATURE_BLOBS
  GDA_CONNECTION_FEATURE_INDEXES
  GDA_CONNECTION_FEATURE_INHERITANCE
  GDA_CONNECTION_FEATURE_NAMESPACES
  GDA_CONNECTION_FEATURE_PROCEDURES
  GDA_CONNECTION_FEATURE_SEQUENCES
  GDA_CONNECTION_FEATURE_SQL
  GDA_CONNECTION_FEATURE_TRANSACTIONS
  GDA_CONNECTION_FEATURE_SAVEPOINTS
  GDA_CONNECTION_FEATURE_SAVEPOINTS_REMOVE
  GDA_CONNECTION_FEATURE_TRIGGERS
  GDA_CONNECTION_FEATURE_UPDATABLE_CURSOR
  GDA_CONNECTION_FEATURE_USERS
  GDA_CONNECTION_FEATURE_VIEWS
  GDA_CONNECTION_FEATURE_XA_TRANSACTIONS
  GDA_CONNECTION_FEATURE_MULTI_THREADING
  GDA_CONNECTION_FEATURE_ASYNC_EXEC
  GDA_CONNECTION_FEATURE_LAST
>;

constant GdaConnectionMetaType is export := guint32;
our enum GdaConnectionMetaTypeEnum is export <
  GDA_CONNECTION_META_NAMESPACES
  GDA_CONNECTION_META_TYPES
  GDA_CONNECTION_META_TABLES
  GDA_CONNECTION_META_VIEWS
  GDA_CONNECTION_META_FIELDS
  GDA_CONNECTION_META_INDEXES
>;

constant GdaConnectionOptions is export := guint32;
our enum GdaConnectionOptionsEnum is export (
  GDA_CONNECTION_OPTIONS_NONE                           =>      0,
  GDA_CONNECTION_OPTIONS_READ_ONLY                      => 1 +< 0,
  GDA_CONNECTION_OPTIONS_SQL_IDENTIFIERS_CASE_SENSITIVE => 1 +< 1,
  GDA_CONNECTION_OPTIONS_THREAD_SAFE                    => 1 +< 2,
  GDA_CONNECTION_OPTIONS_THREAD_ISOLATED                => 1 +< 3,
  GDA_CONNECTION_OPTIONS_AUTO_META_DATA                 => 1 +< 4,
);

constant GdaDataComparatorError is export := guint32;
our enum GdaDataComparatorErrorEnum is export <
  GDA_DATA_COMPARATOR_MISSING_DATA_MODEL_ERROR
  GDA_DATA_COMPARATOR_COLUMN_TYPES_MISMATCH_ERROR
  GDA_DATA_COMPARATOR_MODEL_ACCESS_ERROR
  GDA_DATA_COMPARATOR_USER_CANCELLED_ERROR
>;

constant GdaDataModelAccessFlags is export := guint32;
our enum GdaDataModelAccessFlagsEnum is export (
  GDA_DATA_MODEL_ACCESS_RANDOM          => 1,
  GDA_DATA_MODEL_ACCESS_CURSOR_FORWARD  => 1 +< 1,
  GDA_DATA_MODEL_ACCESS_CURSOR_BACKWARD => 1 +< 2,
  GDA_DATA_MODEL_ACCESS_CURSOR          => (1 +< 1) +| (1 +< 2),            #= GDA_DATA_MODEL_ACCESS_CURSOR_FORWARD | GDA_DATA_MODEL_ACCESS_CURSOR_BACKWARD,
  GDA_DATA_MODEL_ACCESS_INSERT          => 1 +< 3,
  GDA_DATA_MODEL_ACCESS_UPDATE          => 1 +< 4,
  GDA_DATA_MODEL_ACCESS_DELETE          => 1 +< 5,
  GDA_DATA_MODEL_ACCESS_WRITE           => (1 +< 3) +| (1 +< 4) +| (1 +< 5), #= GDA_DATA_MODEL_ACCESS_INSERT | GDA_DATA_MODEL_ACCESS_UPDATE | GDA_DATA_MODEL_ACCESS_DELET
);

constant GdaDataModelError is export := guint32;
our enum GdaDataModelErrorEnum is export <
  GDA_DATA_MODEL_ROW_OUT_OF_RANGE_ERROR
  GDA_DATA_MODEL_COLUMN_OUT_OF_RANGE_ERROR
  GDA_DATA_MODEL_VALUES_LIST_ERROR
  GDA_DATA_MODEL_VALUE_TYPE_ERROR
  GDA_DATA_MODEL_ROW_NOT_FOUND_ERROR
  GDA_DATA_MODEL_ACCESS_ERROR
  GDA_DATA_MODEL_FEATURE_NON_SUPPORTED_ERROR
  GDA_DATA_MODEL_FILE_EXIST_ERROR
  GDA_DATA_MODEL_XML_FORMAT_ERROR
  GDA_DATA_MODEL_TRUNCATED_ERROR
  GDA_DATA_MODEL_OTHER_ERROR
>;

constant GdaDataModelHint is export := guint32;
our enum GdaDataModelHintEnum is export <
  GDA_DATA_MODEL_HINT_START_BATCH_UPDATE
  GDA_DATA_MODEL_HINT_END_BATCH_UPDATE
  GDA_DATA_MODEL_HINT_REFRESH
>;

constant GdaDataModelIOFormat is export := guint32;
our enum GdaDataModelIOFormatEnum is export <
  GDA_DATA_MODEL_IO_DATA_ARRAY_XML
  GDA_DATA_MODEL_IO_TEXT_SEPARATED
  GDA_DATA_MODEL_IO_TEXT_TABLE
>;

constant GdaDataModelIterError is export := guint32;
our enum GdaDataModelIterErrorEnum is export <
  GDA_DATA_MODEL_ITER_COLUMN_OUT_OF_RANGE_ERROR
>;

constant GdaDataPivotAggregate is export := guint32;
our enum GdaDataPivotAggregateEnum is export <
  GDA_DATA_PIVOT_AVG
  GDA_DATA_PIVOT_COUNT
  GDA_DATA_PIVOT_MAX
  GDA_DATA_PIVOT_MIN
  GDA_DATA_PIVOT_SUM
>;

constant GdaDataPivotError is export := guint32;
our enum GdaDataPivotErrorEnum is export <
  GDA_DATA_PIVOT_INTERNAL_ERROR
  GDA_DATA_PIVOT_SOURCE_MODEL_ERROR
  GDA_DATA_PIVOT_FIELD_FORMAT_ERROR
  GDA_DATA_PIVOT_USAGE_ERROR
  GDA_DATA_PIVOT_OVERFLOW_ERROR
>;

constant GdaDataPivotFieldType is export := guint32;
our enum GdaDataPivotFieldTypeEnum is export <
  GDA_DATA_PIVOT_FIELD_ROW
  GDA_DATA_PIVOT_FIELD_COLUMN
>;

constant GdaDataProxyError is export := guint32;
our enum GdaDataProxyErrorEnum is export <
  GDA_DATA_PROXY_COMMIT_ERROR
  GDA_DATA_PROXY_COMMIT_CANCELLED
  GDA_DATA_PROXY_READ_ONLY_VALUE
  GDA_DATA_PROXY_READ_ONLY_ROW
  GDA_DATA_PROXY_FILTER_ERROR
>;

constant GdaDataSelectConditionType is export := guint32;
our enum GdaDataSelectConditionTypeEnum is export <
  GDA_DATA_SELECT_COND_PK
  GDA_DATA_SELECT_COND_ALL_COLUMNS
>;

constant GdaDataSelectError is export := guint32;
our enum GdaDataSelectErrorEnum is export <
  GDA_DATA_SELECT_MODIFICATION_STATEMENT_ERROR
  GDA_DATA_SELECT_MISSING_MODIFICATION_STATEMENT_ERROR
  GDA_DATA_SELECT_CONNECTION_ERROR
  GDA_DATA_SELECT_ACCESS_ERROR
  GDA_DATA_SELECT_SQL_ERROR
  GDA_DATA_SELECT_SAFETY_LOCKED_ERROR
>;

constant GdaDiffType is export := guint32;
our enum GdaDiffTypeEnum is export <
  GDA_DIFF_ADD_ROW
  GDA_DIFF_REMOVE_ROW
  GDA_DIFF_MODIFY_ROW
>;

constant GdaHolderError is export := guint32;
our enum GdaHolderErrorEnum is export <
  GDA_HOLDER_STRING_CONVERSION_ERROR
  GDA_HOLDER_VALUE_TYPE_ERROR
  GDA_HOLDER_VALUE_NULL_ERROR
>;

our constant GdaLdapSearchScope is export := guint32;
our enum GdaLdapSearchScopeEnum is export (
  GDA_LDAP_SEARCH_BASE     => 1,
  GDA_LDAP_SEARCH_ONELEVEL => 2,
  GDA_LDAP_SEARCH_SUBTREE  => 3
);

constant GdaMetaDbObjectType is export := guint32;
our enum GdaMetaDbObjectTypeEnum is export <
  GDA_META_DB_UNKNOWN
  GDA_META_DB_TABLE
  GDA_META_DB_VIEW
>;

constant GdaMetaForeignKeyPolicy is export := guint32;
our enum GdaMetaForeignKeyPolicyEnum is export <
  GDA_META_FOREIGN_KEY_UNKNOWN
  GDA_META_FOREIGN_KEY_NONE
  GDA_META_FOREIGN_KEY_NO_ACTION
  GDA_META_FOREIGN_KEY_RESTRICT
  GDA_META_FOREIGN_KEY_CASCADE
  GDA_META_FOREIGN_KEY_SET_NULL
  GDA_META_FOREIGN_KEY_SET_DEFAULT
>;

constant GdaMetaGraphInfo is export := guint32;
our enum GdaMetaGraphInfoEnum is export (
  GDA_META_GRAPH_COLUMNS => 1 +< 0,
);

constant GdaMetaSortType is export := guint32;
our enum GdaMetaSortTypeEnum is export <
  GDA_META_SORT_ALHAPETICAL
  GDA_META_SORT_DEPENDENCIES
>;

constant GdaMetaStoreChangeType is export := guint32;
our enum GdaMetaStoreChangeTypeEnum is export <
  GDA_META_STORE_ADD
  GDA_META_STORE_REMOVE
  GDA_META_STORE_MODIFY
>;

constant GdaMetaStoreError is export := guint32;
our enum GdaMetaStoreErrorEnum is export <
  GDA_META_STORE_INCORRECT_SCHEMA_ERROR
  GDA_META_STORE_UNSUPPORTED_PROVIDER_ERROR
  GDA_META_STORE_INTERNAL_ERROR
  GDA_META_STORE_META_CONTEXT_ERROR
  GDA_META_STORE_MODIFY_CONTENTS_ERROR
  GDA_META_STORE_EXTRACT_SQL_ERROR
  GDA_META_STORE_ATTRIBUTE_NOT_FOUND_ERROR
  GDA_META_STORE_ATTRIBUTE_ERROR
  GDA_META_STORE_SCHEMA_OBJECT_NOT_FOUND_ERROR
  GDA_META_STORE_SCHEMA_OBJECT_CONFLICT_ERROR
  GDA_META_STORE_SCHEMA_OBJECT_DESCR_ERROR
  GDA_META_STORE_TRANSACTION_ALREADY_STARTED_ERROR
>;

constant GdaMetaStructError is export := guint32;
our enum GdaMetaStructErrorEnum is export <
  GDA_META_STRUCT_UNKNOWN_OBJECT_ERROR
  GDA_META_STRUCT_DUPLICATE_OBJECT_ERROR
  GDA_META_STRUCT_INCOHERENCE_ERROR
  GDA_META_STRUCT_XML_ERROR
>;

constant GdaPrefixDir is export := guint32;
our enum GdaPrefixDirEnum is export <
  GDA_NO_DIR
  GDA_BIN_DIR
  GDA_SBIN_DIR
  GDA_DATA_DIR
  GDA_LOCALE_DIR
  GDA_LIB_DIR
  GDA_LIBEXEC_DIR
  GDA_ETC_DIR
>;

constant GdaServerOperationError is export := guint32;
our enum GdaServerOperationErrorEnum is export <
  GDA_SERVER_OPERATION_OBJECT_NAME_ERROR
  GDA_SERVER_OPERATION_INCORRECT_VALUE_ERROR
  GDA_SERVER_OPERATION_XML_ERROR
>;

constant GdaServerOperationNodeStatus is export := guint32;
our enum GdaServerOperationNodeStatusEnum is export <
  GDA_SERVER_OPERATION_STATUS_OPTIONAL
  GDA_SERVER_OPERATION_STATUS_REQUIRED
  GDA_SERVER_OPERATION_STATUS_UNKNOWN
>;

constant GdaServerOperationNodeType is export := guint32;
our enum GdaServerOperationNodeTypeEnum is export <
  GDA_SERVER_OPERATION_NODE_PARAMLIST
  GDA_SERVER_OPERATION_NODE_DATA_MODEL
  GDA_SERVER_OPERATION_NODE_PARAM
  GDA_SERVER_OPERATION_NODE_SEQUENCE
  GDA_SERVER_OPERATION_NODE_SEQUENCE_ITEM
  GDA_SERVER_OPERATION_NODE_DATA_MODEL_COLUMN
  GDA_SERVER_OPERATION_NODE_UNKNOWN
>;

constant GdaServerOperationType is export := guint32;
our enum GdaServerOperationTypeEnum is export <
  GDA_SERVER_OPERATION_CREATE_DB
  GDA_SERVER_OPERATION_DROP_DB
  GDA_SERVER_OPERATION_CREATE_TABLE
  GDA_SERVER_OPERATION_DROP_TABLE
  GDA_SERVER_OPERATION_RENAME_TABLE
  GDA_SERVER_OPERATION_ADD_COLUMN
  GDA_SERVER_OPERATION_DROP_COLUMN
  GDA_SERVER_OPERATION_CREATE_INDEX
  GDA_SERVER_OPERATION_DROP_INDEX
  GDA_SERVER_OPERATION_CREATE_VIEW
  GDA_SERVER_OPERATION_DROP_VIEW
  GDA_SERVER_OPERATION_COMMENT_TABLE
  GDA_SERVER_OPERATION_COMMENT_COLUMN
  GDA_SERVER_OPERATION_CREATE_USER
  GDA_SERVER_OPERATION_ALTER_USER
  GDA_SERVER_OPERATION_DROP_USER
  GDA_SERVER_OPERATION_LAST
>;

constant GdaServerProviderError is export := guint32;
our enum GdaServerProviderErrorEnum is export <
  GDA_SERVER_PROVIDER_METHOD_NON_IMPLEMENTED_ERROR
  GDA_SERVER_PROVIDER_PREPARE_STMT_ERROR
  GDA_SERVER_PROVIDER_EMPTY_STMT_ERROR
  GDA_SERVER_PROVIDER_MISSING_PARAM_ERROR
  GDA_SERVER_PROVIDER_STATEMENT_EXEC_ERROR
  GDA_SERVER_PROVIDER_OPERATION_ERROR
  GDA_SERVER_PROVIDER_INTERNAL_ERROR
  GDA_SERVER_PROVIDER_BUSY_ERROR
  GDA_SERVER_PROVIDER_NON_SUPPORTED_ERROR
  GDA_SERVER_PROVIDER_SERVER_VERSION_ERROR
  GDA_SERVER_PROVIDER_DATA_ERROR
  GDA_SERVER_PROVIDER_DEFAULT_VALUE_HANDLING_ERROR
  GDA_SERVER_PROVIDER_MISUSE_ERROR
  GDA_SERVER_PROVIDER_FILE_NOT_FOUND_ERROR
>;

constant GdaSetError is export := guint32;
our enum GdaSetErrorEnum is export <
  GDA_SET_XML_SPEC_ERROR
  GDA_SET_HOLDER_NOT_FOUND_ERROR
  GDA_SET_INVALID_ERROR
  GDA_SET_READ_ONLY_ERROR
  GDA_SET_IMPLEMENTATION_ERROR
>;

constant GdaSqlStatementType is export := guint32;
our enum GdaSqlStatementTypeEnum is export <
  GDA_SQL_STATEMENT_SELECT
  GDA_SQL_STATEMENT_INSERT
  GDA_SQL_STATEMENT_UPDATE
  GDA_SQL_STATEMENT_DELETE
  GDA_SQL_STATEMENT_COMPOUND
  GDA_SQL_STATEMENT_BEGIN
  GDA_SQL_STATEMENT_ROLLBACK
  GDA_SQL_STATEMENT_COMMIT
  GDA_SQL_STATEMENT_SAVEPOINT
  GDA_SQL_STATEMENT_ROLLBACK_SAVEPOINT
  GDA_SQL_STATEMENT_DELETE_SAVEPOINT
  GDA_SQL_STATEMENT_UNKNOWN
  GDA_SQL_STATEMENT_NONE
>;

constant GdaSqlAnyPartType is export := guint32;
our enum GdaSqlAnyPartTypeEnum is export (
  GDA_SQL_ANY_STMT_SELECT             =>             GDA_SQL_STATEMENT_SELECT,
  GDA_SQL_ANY_STMT_INSERT             =>             GDA_SQL_STATEMENT_INSERT,
  GDA_SQL_ANY_STMT_UPDATE             =>             GDA_SQL_STATEMENT_UPDATE,
  GDA_SQL_ANY_STMT_DELETE             =>             GDA_SQL_STATEMENT_DELETE,
  GDA_SQL_ANY_STMT_COMPOUND           =>           GDA_SQL_STATEMENT_COMPOUND,
  GDA_SQL_ANY_STMT_BEGIN              =>              GDA_SQL_STATEMENT_BEGIN,
  GDA_SQL_ANY_STMT_ROLLBACK           =>           GDA_SQL_STATEMENT_ROLLBACK,
  GDA_SQL_ANY_STMT_COMMIT             =>             GDA_SQL_STATEMENT_COMMIT,
  GDA_SQL_ANY_STMT_SAVEPOINT          =>          GDA_SQL_STATEMENT_SAVEPOINT,
  GDA_SQL_ANY_STMT_ROLLBACK_SAVEPOINT => GDA_SQL_STATEMENT_ROLLBACK_SAVEPOINT,
  GDA_SQL_ANY_STMT_DELETE_SAVEPOINT   =>   GDA_SQL_STATEMENT_DELETE_SAVEPOINT,
  GDA_SQL_ANY_STMT_UNKNOWN            =>            GDA_SQL_STATEMENT_UNKNOWN,
  GDA_SQL_ANY_EXPR                    =>                                  500,
  'GDA_SQL_ANY_SQL_FIELD',
  'GDA_SQL_ANY_SQL_TABLE',
  'GDA_SQL_ANY_SQL_FUNCTION',
  'GDA_SQL_ANY_SQL_OPERATION',
  'GDA_SQL_ANY_SQL_CASE',
  'GDA_SQL_ANY_SQL_SELECT_FIELD',
  'GDA_SQL_ANY_SQL_SELECT_TARGET',
  'GDA_SQL_ANY_SQL_SELECT_JOIN',
  'GDA_SQL_ANY_SQL_SELECT_FROM',
  'GDA_SQL_ANY_SQL_SELECT_ORDER'
);

constant GdaSqlBuilderError is export := guint32;
our enum GdaSqlBuilderErrorEnum is export <
  GDA_SQL_BUILDER_WRONG_TYPE_ERROR
  GDA_SQL_BUILDER_MISUSE_ERROR
>;

constant GdaSqlError is export := guint32;
our enum GdaSqlErrorEnum is export <
  GDA_SQL_STRUCTURE_CONTENTS_ERROR
  GDA_SQL_MALFORMED_IDENTIFIER_ERROR
  GDA_SQL_MISSING_IDENTIFIER_ERROR
  GDA_SQL_VALIDATION_ERROR
>;

constant GdaSqlIdentifierStyle is export := guint32;
our enum GdaSqlIdentifierStyleEnum is export (
  GDA_SQL_IDENTIFIERS_LOWER_CASE => 1 +< 0,
  GDA_SQL_IDENTIFIERS_UPPER_CASE => 1 +< 1,
);

constant GdaSqlOperatorType is export := guint32;
our enum GdaSqlOperatorTypeEnum is export <
  GDA_SQL_OPERATOR_TYPE_AND
  GDA_SQL_OPERATOR_TYPE_OR
  GDA_SQL_OPERATOR_TYPE_EQ
  GDA_SQL_OPERATOR_TYPE_IS
  GDA_SQL_OPERATOR_TYPE_LIKE
  GDA_SQL_OPERATOR_TYPE_BETWEEN
  GDA_SQL_OPERATOR_TYPE_GT
  GDA_SQL_OPERATOR_TYPE_LT
  GDA_SQL_OPERATOR_TYPE_GEQ
  GDA_SQL_OPERATOR_TYPE_LEQ
  GDA_SQL_OPERATOR_TYPE_DIFF
  GDA_SQL_OPERATOR_TYPE_REGEXP
  GDA_SQL_OPERATOR_TYPE_REGEXP_CI
  GDA_SQL_OPERATOR_TYPE_NOT_REGEXP
  GDA_SQL_OPERATOR_TYPE_NOT_REGEXP_CI
  GDA_SQL_OPERATOR_TYPE_SIMILAR
  GDA_SQL_OPERATOR_TYPE_ISNULL
  GDA_SQL_OPERATOR_TYPE_ISNOTNULL
  GDA_SQL_OPERATOR_TYPE_NOT
  GDA_SQL_OPERATOR_TYPE_IN
  GDA_SQL_OPERATOR_TYPE_NOTIN
  GDA_SQL_OPERATOR_TYPE_CONCAT
  GDA_SQL_OPERATOR_TYPE_PLUS
  GDA_SQL_OPERATOR_TYPE_MINUS
  GDA_SQL_OPERATOR_TYPE_STAR
  GDA_SQL_OPERATOR_TYPE_DIV
  GDA_SQL_OPERATOR_TYPE_REM
  GDA_SQL_OPERATOR_TYPE_BITAND
  GDA_SQL_OPERATOR_TYPE_BITOR
  GDA_SQL_OPERATOR_TYPE_BITNOT
  GDA_SQL_OPERATOR_TYPE_ILIKE
  GDA_SQL_OPERATOR_TYPE_NOTLIKE
  GDA_SQL_OPERATOR_TYPE_NOTILIKE
  GDA_SQL_OPERATOR_TYPE_GLOB
>;

constant GdaSqlParserError is export := guint32;
our enum GdaSqlParserErrorEnum is export <
  GDA_SQL_PARSER_SYNTAX_ERROR
  GDA_SQL_PARSER_OVERFLOW_ERROR
  GDA_SQL_PARSER_EMPTY_SQL_ERROR
>;

constant GdaSqlParserFlavour is export := guint32;
our enum GdaSqlParserFlavourEnum is export (
  GDA_SQL_PARSER_FLAVOUR_STANDARD   => 0,
  GDA_SQL_PARSER_FLAVOUR_SQLITE     => 1,
  GDA_SQL_PARSER_FLAVOUR_MYSQL      => 2,
  GDA_SQL_PARSER_FLAVOUR_ORACLE     => 3,
  GDA_SQL_PARSER_FLAVOUR_POSTGRESQL => 4,
);

constant GdaSqlParserMode is export := guint32;
our enum GdaSqlParserModeEnum is export <
  GDA_SQL_PARSER_MODE_PARSE
  GDA_SQL_PARSER_MODE_DELIMIT
>;

constant GdaSqlSelectJoinType is export := guint32;
our enum GdaSqlSelectJoinTypeEnum is export <
  GDA_SQL_SELECT_JOIN_CROSS
  GDA_SQL_SELECT_JOIN_NATURAL
  GDA_SQL_SELECT_JOIN_INNER
  GDA_SQL_SELECT_JOIN_LEFT
  GDA_SQL_SELECT_JOIN_RIGHT
  GDA_SQL_SELECT_JOIN_FULL
>;

constant GdaSqlStatementCompoundType is export := guint32;
our enum GdaSqlStatementCompoundTypeEnum is export <
  GDA_SQL_STATEMENT_COMPOUND_UNION
  GDA_SQL_STATEMENT_COMPOUND_UNION_ALL
  GDA_SQL_STATEMENT_COMPOUND_INTERSECT
  GDA_SQL_STATEMENT_COMPOUND_INTERSECT_ALL
  GDA_SQL_STATEMENT_COMPOUND_EXCEPT
  GDA_SQL_STATEMENT_COMPOUND_EXCEPT_ALL
>;

constant GdaStatementError is export := guint32;
our enum GdaStatementErrorEnum is export <
  GDA_STATEMENT_PARSE_ERROR
  GDA_STATEMENT_SYNTAX_ERROR
  GDA_STATEMENT_NO_CNC_ERROR
  GDA_STATEMENT_CNC_CLOSED_ERROR
  GDA_STATEMENT_EXEC_ERROR
  GDA_STATEMENT_PARAM_TYPE_ERROR
  GDA_STATEMENT_PARAM_ERROR
>;

constant GdaStatementModelUsage is export := guint32;
our enum GdaStatementModelUsageEnum is export (
  GDA_STATEMENT_MODEL_RANDOM_ACCESS   => 1,
  GDA_STATEMENT_MODEL_CURSOR_FORWARD  => 1 +< 1,
  GDA_STATEMENT_MODEL_CURSOR_BACKWARD => 1 +< 2,
  GDA_STATEMENT_MODEL_CURSOR          => (1 +< 1) +| (1 +< 2), #= GDA_STATEMENT_MODEL_CURSOR_FORWARD | GDA_STATEMENT_MODEL_CURSOR_BACKWARD
  GDA_STATEMENT_MODEL_ALLOW_NOPARAM   => 1 +< 3,
  GDA_STATEMENT_MODEL_OFFLINE         => 1 +< 4
);

constant GdaStatementSqlFlag is export := guint32;
our enum GdaStatementSqlFlagEnum is export (
  GDA_STATEMENT_SQL_PARAMS_AS_VALUES =>      0,
  GDA_STATEMENT_SQL_PRETTY           => 1 +< 0,
  GDA_STATEMENT_SQL_PARAMS_LONG      => 1 +< 1,
  GDA_STATEMENT_SQL_PARAMS_SHORT     => 1 +< 2,
  GDA_STATEMENT_SQL_PARAMS_AS_COLON  => 1 +< 3,
  GDA_STATEMENT_SQL_PARAMS_AS_DOLLAR => 1 +< 4,
  GDA_STATEMENT_SQL_PARAMS_AS_QMARK  => 1 +< 5,
  GDA_STATEMENT_SQL_PARAMS_AS_UQMARK => 1 +< 6,
  GDA_STATEMENT_SQL_TIMEZONE_TO_GMT  => 1 +< 7,
);

constant GdaThreadNotificationType is export := guint32;
our enum GdaThreadNotificationTypeEnum is export (
  GDA_THREAD_NOTIFICATION_JOB    => 0x01,
  GDA_THREAD_NOTIFICATION_SIGNAL => 0x02,
);

constant GdaThreadWrapperError is export := guint32;
our enum GdaThreadWrapperErrorEnum is export <
  GDA_THREAD_WRAPPER_UNKNOWN_ERROR
>;

constant GdaTransactionIsolation is export := guint32;
our enum GdaTransactionIsolationEnum is export <
  GDA_TRANSACTION_ISOLATION_UNKNOWN
  GDA_TRANSACTION_ISOLATION_READ_COMMITTED
  GDA_TRANSACTION_ISOLATION_READ_UNCOMMITTED
  GDA_TRANSACTION_ISOLATION_REPEATABLE_READ
  GDA_TRANSACTION_ISOLATION_SERIALIZABLE
>;

constant GdaTransactionStatusEventType is export := guint32;
our enum GdaTransactionStatusEventTypeEnum is export <
  GDA_TRANSACTION_STATUS_EVENT_SAVEPOINT
  GDA_TRANSACTION_STATUS_EVENT_SQL
  GDA_TRANSACTION_STATUS_EVENT_SUB_TRANSACTION
>;

constant GdaTransactionStatusState is export := guint32;
our enum GdaTransactionStatusStateEnum is export <
  GDA_TRANSACTION_STATUS_STATE_OK
  GDA_TRANSACTION_STATUS_STATE_FAILED
>;

constant GdaTreeError is export := guint32;
our enum GdaTreeErrorEnum is export <
  GDA_TREE_UNKNOWN_ERROR
>;

constant GdaTreeManagerError is export := guint32;
our enum GdaTreeManagerErrorEnum is export <
  GDA_TREE_MANAGER_UNKNOWN_ERROR
>;

constant GdaTreeNodeError is export := guint32;
our enum GdaTreeNodeErrorEnum is export <
  GDA_TREE_NODE_UNKNOWN_ERROR
>;

constant GdaValueAttribute is export := guint32;
our enum GdaValueAttributeEnum is export (
  GDA_VALUE_ATTR_NONE           =>      0,
  GDA_VALUE_ATTR_IS_NULL        => 1 +< 0,
  GDA_VALUE_ATTR_CAN_BE_NULL    => 1 +< 1,
  GDA_VALUE_ATTR_IS_DEFAULT     => 1 +< 2,
  GDA_VALUE_ATTR_CAN_BE_DEFAULT => 1 +< 3,
  GDA_VALUE_ATTR_IS_UNCHANGED   => 1 +< 4,
  GDA_VALUE_ATTR_ACTIONS_SHOWN  => 1 +< 5,
  GDA_VALUE_ATTR_DATA_NON_VALID => 1 +< 6,
  GDA_VALUE_ATTR_HAS_VALUE_ORIG => 1 +< 7,
  GDA_VALUE_ATTR_NO_MODIF       => 1 +< 8,
  GDA_VALUE_ATTR_UNUSED         => 1 +< 9,
);

constant GdaXaTransactionError is export := guint32;
our enum GdaXaTransactionErrorEnum is export <
  GDA_XA_TRANSACTION_ALREADY_REGISTERED_ERROR
  GDA_XA_TRANSACTION_DTP_NOT_SUPPORTED_ERROR
  GDA_XA_TRANSACTION_CONNECTION_BRANCH_LENGTH_ERROR
>;
