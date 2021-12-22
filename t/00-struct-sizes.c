/*

Ouput created via the following script:

use GDA::Raw::Structs;

say "s({ .^shortname });" for GDA::Raw::Structs::.keys
                                                 .sort
                                                 .map({ ::("$_") })
                                                 .grep({ .REPR eq "CStruct" });
*/

#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

#include <libgda/libgda.h>
#include <libgda-report/libgda-report.h>
#include <libgda-xslt/libgda-xslt.h>
#include <libgda/gda-blob-op.h>
#include <libgda/gda-repetitive-statement.h>
#include <libgda/sqlite/gda-sqlite-provider.h>
#include <libgda/thread-wrapper/gda-thread-wrapper.h>
#include <libgda/virtual/libgda-virtual.h>
#include <libgda/virtual/gda-vconnection-data-model.h>

#define s(name)     DLLEXPORT int sizeof_ ## name () { return sizeof(name); }

s(GdaBatch);
s(GdaBinary);
s(GdaBlob);
s(GdaBlobOp);
s(GdaColumn);
s(GdaConfig);
s(GdaConnection);
s(GdaConnectionEvent);
s(GdaDataAccessWrapper);
s(GdaDataComparator);
s(GdaDataModelArray);
s(GdaDataModelDir);
s(GdaDataModelImport);
s(GdaDataModelIter);
s(GdaDataPivot);
s(GdaDataProxy);
s(GdaDataSelect);
s(GdaDiff);
s(GdaDsnInfo);
s(GdaGeometricPoint);
s(GdaHandlerBin);
s(GdaHandlerBoolean);
s(GdaHandlerNumerical);
s(GdaHandlerString);
s(GdaHandlerTime);
s(GdaHandlerType);
s(GdaHolder);
s(GdaMetaContext);
s(GdaMetaDbObject);
s(GdaMetaStore);
s(GdaMetaStruct);
s(GdaMetaTable);
s(GdaMetaTableColumn);
s(GdaMetaView);
s(GdaNumeric);
s(GdaPStmt);
s(GdaProviderInfo);
s(GdaRepetitiveStatement);
s(GdaReportDocbookDocument);
s(GdaReportDocument);
s(GdaReportEngine);
s(GdaReportRmlDocument);
s(GdaRow);
s(GdaServerOperation);
s(GdaServerOperationNode);
s(GdaServerProvider);
s(GdaSet);
s(GdaSetGroup);
s(GdaSetNode);
s(GdaSetSource);
s(GdaSqlAnyPart);
s(GdaSqlBuilder);
s(GdaSqlCase);
s(GdaSqlExpr);
s(GdaSqlField);
s(GdaSqlFunction);
s(GdaSqlOperation);
s(GdaSqlParamSpec);
s(GdaSqlParser);
s(GdaSqlParserIface);
s(GdaSqlSelectField);
s(GdaSqlSelectFrom);
s(GdaSqlSelectJoin);
s(GdaSqlSelectOrder);
s(GdaSqlSelectTarget);
s(GdaSqlStatement);
s(GdaSqlStatementCompound);
s(GdaSqlStatementDelete);
s(GdaSqlStatementInsert);
s(GdaSqlStatementSelect);
s(GdaSqlStatementTransaction);
s(GdaSqlStatementUnknown);
s(GdaSqlStatementUpdate);
s(GdaSqlTable);
s(GdaSqliteProvider);
s(GdaStatement);
s(GdaThreadWrapper);
s(GdaTime);
s(GdaTimestamp);
s(GdaTransactionStatus);
s(GdaTree);
s(GdaTreeManager);
s(GdaTreeMgrColumns);
s(GdaTreeMgrLabel);
s(GdaTreeMgrSchemas);
s(GdaTreeMgrSelect);
s(GdaTreeMgrTables);
s(GdaTreeNode);
s(GdaVconnectionDataModel);
s(GdaVconnectionDataModelSpec);
s(GdaVconnectionHub);
s(GdaVirtualConnection);
//s(GdaVirtualConstraint); -- Internal struct
//s(GdaVirtualOrderby);    -- Internal struct
s(GdaVirtualProvider);
s(GdaVproviderDataModel);
s(GdaVproviderHub);
s(GdaXaTransaction);
s(GdaXsltExCont);
