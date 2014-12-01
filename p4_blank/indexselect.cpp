#include "catalog.h"
#include "query.h"
#include "index.h"
#include "stdlib.h"
#include "string.h"
Status Operators::IndexSelect(const string& result,       // Name of the output relation
                              const int projCnt,          // Number of attributes in the projection
                              const AttrDesc projNames[], // Projection list (as AttrDesc)
                              const AttrDesc* attrDesc,   // Attribute in the selection predicate
                              const Operator op,          // Predicate operator
                              const void* attrValue,      // Pointer to the literal value in the predicate
                              const int reclen)           // Length of a tuple in the output relation
{
  cout << "Algorithm: Index Select" << endl;
  
  /* Your solution goes here */
  Status indexStatus;
  Index scanIndex(attrDesc->relName, attrDesc->attrOffset, attrDesc->attrLen, (Datatype)attrDesc->attrType, 0, indexStatus);
  if (indexStatus != OK)
      return indexStatus;
  
  HeapFile indexHeapFile(result, indexStatus);
  if (indexStatus != OK)
      return indexStatus;
  HeapFileScan indexHeapScan (attrDesc->relName, indexStatus);
  if (indexStatus != OK)
      return indexStatus;
  Record newRecord, oldRecord;
  newRecord.length = reclen;
  newRecord.data = malloc (reclen);
  
  RID rid1, rid2;
  
  scanIndex.startScan(attrValue);
  while(scanIndex.scanNext(rid1)==OK){
      int offset = 0;
      indexStatus = indexHeapScan.getRandomRecord(rid1, oldRecord);
      if (indexStatus != OK){
          free(newRecord.data);
          return indexStatus;
      }
      for (int i = 0; i < projCnt; i++){
          memcpy((char*)(newRecord.data) + offset, (char*)(oldRecord.data) + projNames[i].attrOffset, projNames[i].attrLen);
          offset += projNames[i].attrLen;
      }
      indexStatus = indexHeapFile.insertRecord(newRecord, rid2);
      if (indexStatus != OK){
          free(newRecord.data);
          return indexStatus;
      }    
  }
  scanIndex.endScan();
  free(newRecord.data);
  return OK;
}

