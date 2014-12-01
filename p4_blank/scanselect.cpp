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
  
  /*
  HeapFileScan *myHeapScan = NULL;
          
  if(op == NOTSET)
      myHeapScan = new HeapFileScan(result, scanSelectStatus);
  else
      myHeapScan = new HeapFileScan(result, attrDesc->attrOffset, attrDesc->attrLen, (Datatype)attrDesc->attrType, (char*)(attrValue), op, scanSelectStatus);
  
  */
  HeapFileScan myHeapScan(projNames[0].relName, scanSelectStatus);
  if(op != NOTSET)
      HeapFileScan myHeapScan(projNames[0].relName, attrDesc->attrOffset, attrDesc->attrLen, (Datatype)attrDesc->attrType, (char*)(attrValue), op, scanSelectStatus);
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
//  scanSelectStatus = myHeapScan->startScan(attrDesc->attrOffset, attrDesc->attrLen, (Datatype)attrDesc->attrType, (char*)(attrValue), op);
//  
//  if(scanSelectStatus != OK)
//      return scanSelectStatus;
//  
  RID outRid, outRid2;
  
  HeapFile myHeap(result, scanSelectStatus);
  
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
  Record newRecord;
  newRecord.length = reclen;
  newRecord.data = malloc (reclen);
  Record oldRecord;
  while(myHeapScan.scanNext(outRid, oldRecord) == OK)
  {
      int offset = 0;      
      
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
      
      scanSelectStatus = myHeap.insertRecord(newRecord, outRid2);
      
      if(scanSelectStatus != OK)
      {
        free(newRecord.data);
        return scanSelectStatus;
      }
  }
  myHeapScan.endScan();
  free(newRecord.data);
  /* Your solution goes here */
  return OK;
}
