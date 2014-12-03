#include "catalog.h"
#include "query.h"
#include "sort.h"
#include "index.h"
#include "stdlib.h"
#include <iostream>
#include "string.h"

  static bool evalOp(int a, Operator op){
      int temp = -a;
      if (temp == 0){
          if(op == EQ || op == LTE || op == GTE)
              return true;
          else
              return false;
      }
      else if (temp > 0){
          if (op == GT || op == GTE || op == NE)
              return true;
          else
              return false;
      }
      else if (temp < 0){
          if (op == LT || op == LTE || op == NE)
              return true;
          else
              return false;
      }
      else
          return false;
}
Status Operators::SNL(const string& result,           // Output relation name
                      const int projCnt,              // Number of attributes in the projection
                      const AttrDesc attrDescArray[], // Projection list (as AttrDesc)
                      const AttrDesc& attrDesc1,      // The left attribute in the join predicate
                      const Operator op,              // Predicate operator
                      const AttrDesc& attrDesc2,      // The left attribute in the join predicate
                      const int reclen)               // The length of a tuple in the result relation
{
  cout << "Algorithm: Simple NL Join" << endl;
  
  //BASIC ALGORITHM PSEUDOCODE:
  //foreach tuple r in R do
  //    foreach tuple s in S do
  //        if r1 == s1 then add <r,s> to result 
  
  //Declare and initialize 2 scans (one for the left attribute, and the other for the right)
  
  Status scanSelectStatus;
  //attrDesc2 == outer!
  HeapFileScan myHeapScan = HeapFileScan(attrDesc2.relName, scanSelectStatus);
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  //attrDesc1 == inner!
  HeapFileScan myHeapScan2 = HeapFileScan(attrDesc1.relName, scanSelectStatus);
  if(scanSelectStatus != OK)
      return scanSelectStatus;      
  //HeapFileScan myHeapScan2 = HeapFileScan(attrDesc2.relName, scanSelectStatus);
  //ABOVE: (char*)(attrDesc1.attrName) is probably wrong.  Maybe not tho...

  HeapFile myHeap(result, scanSelectStatus);
  if(scanSelectStatus != OK)
      return scanSelectStatus;
  
  RID myRid, myRid2;
  
  Record oldRecord;
  Record oldRecord2;

  while(myHeapScan.scanNext(myRid, oldRecord) == OK)
  {
      
      myHeapScan2 = HeapFileScan(attrDesc1.relName, scanSelectStatus);
      if(scanSelectStatus != OK)
        return scanSelectStatus;
      while(myHeapScan2.scanNext(myRid2, oldRecord2) == OK)
      {
         //outer, inner => have to flip Op, see evalOp - it does just that!
         int temp = matchRec(oldRecord, oldRecord2, attrDesc2, attrDesc1);
         if(evalOp(temp, op)){
             Record newRecord;
             newRecord.length = reclen;
             newRecord.data = malloc (reclen);
             int offset = 0;
             for(int i = 0; i < projCnt; i++){
                     if (strcmp(attrDesc2.relName, attrDescArray[i].relName) == 0){
                             memcpy(((char *)newRecord.data) + offset, (char*)(oldRecord.data) + attrDescArray[i].attrOffset, attrDescArray[i].attrLen);
                             offset += attrDescArray[i].attrLen;
                     }
                     else{
                             memcpy(((char*) newRecord.data) + offset, (char*)(oldRecord2.data) + attrDescArray[i].attrOffset, attrDescArray[i].attrLen);
                             offset += attrDescArray[i].attrLen;
                     }
             }   
             scanSelectStatus = myHeap.insertRecord(newRecord, myRid);
             if(scanSelectStatus != OK)
                     return scanSelectStatus;
             free(newRecord.data);
         }
      }
      scanSelectStatus = myHeapScan2.endScan();
      if (scanSelectStatus != OK)
          return scanSelectStatus;
  }
  
  myHeapScan.endScan();  
  
  return OK;
}

