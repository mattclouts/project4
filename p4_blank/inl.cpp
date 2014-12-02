#include "catalog.h"
#include "query.h"
#include "sort.h"
#include "index.h"
#include "stdlib.h"
#include <iostream>
#include "string.h"
/* 
 * Indexed nested loop evaluates joins with an index on the 
 * inner/right relation (attrDesc2)
 */

Status Operators::INL(const string& result,           // Name of the output relation
                      const int projCnt,              // Number of attributes in the projection
                      const AttrDesc attrDescArray[], // The projection list (as AttrDesc)
                      const AttrDesc& attrDesc1,      // The left attribute in the join predicate
                      const Operator op,              // Predicate operator
                      const AttrDesc& attrDesc2,      // The left attribute in the join predicate
                      const int reclen)               // Length of a tuple in the output relation
{
  cout << "Algorithm: Indexed NL Join" << endl;
  
  //BASIC ALGORITHM PSEUDOCODE:
  //foreach tuple r in R do
  //    foreach tuple s in S do
  //        if r1 == s1 then add <r,s> to result 
  
  //Declare and initialize 2 scans (one for the left attribute, and the other for the right)
  
  Status scanSelectStatus;
    
  HeapFileScan myHeapScan = HeapFileScan(attrDesc1.relName, scanSelectStatus);
  
  if(scanSelectStatus != OK)
      return scanSelectStatus;
          
  HeapFileScan myHeapScan2 = HeapFileScan(attrDesc2.relName, attrDesc2.attrOffset, attrDesc2.attrLen, (Datatype)attrDesc2.attrType, (char*)(attrDesc1.attrName), op, scanSelectStatus);
  //ABOVE: (char*)(attrDesc1.attrName) is probably wrong.  Maybe not tho...
  
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
  HeapFile myHeap(result, scanSelectStatus);
  
  RID myRid;
  RID myRid2;
  
  Record newRecord;
  newRecord.length = reclen;
  newRecord.data = malloc (reclen);
  Record oldRecord;
  Record oldRecord2;
  
  while(myHeapScan.scanNext(myRid, oldRecord) == OK)
  {
      int offset = 0;
      
      if(scanSelectStatus != OK)
      {
        free(newRecord.data);
        return scanSelectStatus;
      }
      
      while(myHeapScan2.scanNext(myRid2, oldRecord2) == OK)
      {
            //int offset2 = 0;      

            if(scanSelectStatus != OK)
            {
              free(newRecord.data);
              return scanSelectStatus;
            }

            for(int i = 0; i < projCnt; i++)
            {
              memcpy(((char *)newRecord.data) + offset, (char*)(oldRecord2.data) + attrDescArray[i].attrOffset, attrDescArray[i].attrLen);
              offset += attrDescArray[i].attrLen;
            }

            scanSelectStatus = myHeap.insertRecord(newRecord, myRid);

            if(scanSelectStatus != OK)
            {
                free(newRecord.data);
                return scanSelectStatus;
            }
      }
      
      for(int i = 0; i < projCnt; i++)
      {
          memcpy(((char *)newRecord.data) + offset, (char*)(oldRecord.data) + attrDescArray[i].attrOffset, attrDescArray[i].attrLen);
          offset += attrDescArray[i].attrLen;
      }
      
      scanSelectStatus = myHeap.insertRecord(newRecord, myRid);
      
      if(scanSelectStatus != OK)
      {
        free(newRecord.data);
        return scanSelectStatus;
      }
      
      return OK;
  }
  
  myHeapScan.endScan();
  free(newRecord.data);
  
  /* Your solution goes here */
  return OK;
}
