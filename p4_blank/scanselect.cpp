#include "catalog.h"
#include "query.h"
#include "index.h"
#include "stdlib.h"
#include "string.h"

/* 
 * A simple scan select using a heap file scan
 */

Status Operators::ScanSelect(const string& result,       // Name of the output relation
                             const int projCnt,          // Number of attributes in the projection
                             const AttrDesc projNames[], // Projection list (as AttrDesc)
                             const AttrDesc* attrDesc,   // Attribute in the selection predicate
                             const Operator op,          // Predicate operator
                             const void* attrValue,      // Pointer to the literal value in the predicate
                             const int reclen)           // Length of a tuple in the result relation
{
  cout << "Algorithm: File Scan" << endl;
  
  Status scanSelectStatus;
  
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
  HeapFileScan myHeapScan(result, scanSelectStatus);
  
  if(op != NULL)
  {
      HeapFileScan myHeapScan(result, attrDesc->attrOffset, attrDesc->attrLen, (Datatype)attrDesc->attrType, (char*)(attrValue), op, scanSelectStatus);
  }
  
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
  scanSelectStatus = myHeapScan.startScan(attrDesc->attrOffset, attrDesc->attrLen, (Datatype)attrDesc->attrType, (char*)(attrValue), op);
  
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
  RID outRid;
  
  HeapFile myHeap(result, scanSelectStatus);
  
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
  Record newRecord;
  newRecord.length = reclen;
  newRecord.data = malloc (reclen);
  
  while(myHeapScan.scanNext(outRid) == OK)
  {
      int offset = 0;      

      Record oldRecord;
      scanSelectStatus = myHeapScan.getRecord(outRid, oldRecord);
      
      if(scanSelectStatus != OK)
      {
        free(newRecord.data);
        return scanSelectStatus;
      }
      
      for(int i = 0; i < projCnt; i++)
      {
          memcpy(((char *)newRecord.data) + offset, (char*)(oldRecord.data) + projNames[i].attrOffset, projNames[i].attrLen);
          offset += projNames[i].attrLen;
      }
      
      scanSelectStatus = myHeap.insertRecord(newRecord, outRid);
      
      if(scanSelectStatus != OK)
      {
        free(newRecord.data);
        return scanSelectStatus;
      }
      
      myHeapScan.endScan();
      free(newRecord.data);
      return OK;
  };
  
  /* Your solution goes here */

  return OK;
}
