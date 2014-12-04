#include "catalog.h"
#include "query.h"
#include "sort.h"
#include "index.h"
#include "stdlib.h"
#include "string.h"

/* Consider using Operators::matchRec() defined in join.cpp
 * to compare records when joining the relations */
  
Status Operators::SMJ(const string& result,           // Output relation name
                      const int projCnt,              // Number of attributes in the projection
                      const AttrDesc attrDescArray[], // Projection list (as AttrDesc)
                      const AttrDesc& attrDesc1,      // The left attribute in the join predicate
                      const Operator op,              // Predicate operator
                      const AttrDesc& attrDesc2,      // The left attribute in the join predicate
                      const int reclen)               // The length of a tuple in the result relation

{
  cout << "Algorithm: SM Join" << endl;
  Status smjStatus;
  int numUnpinnedPages = bufMgr->numUnpinnedPages();
  double availablePages = 0.8 * numUnpinnedPages;
  int size = 0;
  for (int i = 0; i < projCnt; i++){
      size += attrDescArray[i].attrLen;
  }
  HeapFile attr1Heap = HeapFile(attrDesc1.relName,smjStatus);
  HeapFile attr2Heap = HeapFile(attrDesc2.relName, smjStatus);
//  int numTuples1 = attr1Heap.getRecCnt();
//  int numTuples2 = attr2Heap.getRecCnt();
  
  
  AttrDesc *outputDesc, *attr1Desc, *attr2Desc;
  int outputCnt, attr1Cnt, attr2Cnt;
  int attr1Size = 0, attr2Size = 0;
  smjStatus = attrCat->getRelInfo(result, outputCnt, outputDesc);
  if (smjStatus != OK)
      return smjStatus;
  string compileErrorBuster1(attrDesc1.relName);
  smjStatus = attrCat->getRelInfo(compileErrorBuster1, attr1Cnt, attr1Desc);
  if (smjStatus != OK)
      return smjStatus;
  for (int i = 0; i < attr1Cnt; i++)
      attr1Size += attr1Desc->attrLen;
  string compileErrorBuster2(attrDesc2.relName);
  smjStatus = attrCat->getRelInfo(compileErrorBuster2, attr2Cnt, attr2Desc);
  if (smjStatus != OK)
      return smjStatus;
  for (int i = 0; i < attr2Cnt; i++)
      attr2Size += attr2Desc->attrLen;
  
  int capacity1 = ((availablePages)*PAGESIZE) / attr1Size;
  int capacity2 = ((availablePages)*PAGESIZE / attr2Size);
  
  SortedFile attr1SortedFile = SortedFile(attrDesc1.relName,attrDesc1.attrOffset, attrDesc1.attrLen, (Datatype)attrDesc1.attrType, capacity1, smjStatus);
  if(smjStatus != OK)
      return smjStatus;
  
  //int numUnpinnedPages2 = bufMgr->numUnpinnedPages();
  //double availablePages2 = 0.8 * numUnpinnedPages2;
  //int capacity2 = (availablePages2)*PAGESIZE / attr2Size;
  SortedFile attr2SortedFile = SortedFile(attrDesc2.relName,attrDesc2.attrOffset, attrDesc2.attrLen, (Datatype)attrDesc2.attrType, capacity2, smjStatus);
  if(smjStatus != OK)
      return smjStatus;
  
  HeapFile joinResult = HeapFile(result, smjStatus);
  if (smjStatus != OK)
      return smjStatus;
  RID rid;
  
  Record rec1, rec2;
  smjStatus = attr1SortedFile.next(rec1);
  if (smjStatus != OK)
      return smjStatus;
  smjStatus = attr2SortedFile.next(rec2);
  if (smjStatus != OK)
      return smjStatus;
  Record ptrRecord;
  Status smjStatus2 = OK;
  while (true){
      //rec1 < rec2 => advance rec1
      if(matchRec(rec1, rec2, attrDesc1, attrDesc2) < 0){
          //while(matchRec(rec1, rec2, attrDesc1, attrDesc2) < 0){
              smjStatus = attr1SortedFile.next(rec1);
              if (smjStatus != OK)
                  break;//it's just an EOF, which is good (in theory)
         // } 
      }
      //rec2 < rec1 => advance rec2
      else if (matchRec(rec1, rec2, attrDesc1, attrDesc2) > 0){
         // while(matchRec(rec1, rec2, attrDesc1, attrDesc2) < 0){
              smjStatus = attr2SortedFile.next(rec2);
              if (smjStatus != OK)
                  break;//it's just an EOF, which is good (in theory)
          //} 
      }
      //rec2 = rec1 => boomtown
      else{
          //Mark starting point --->>>piazza @1129 for explanation of this merge part
          smjStatus = attr1SortedFile.setMark();
          if (smjStatus != OK)
              return smjStatus; //Because this is bad
          ptrRecord = rec1;
          //Get everything out of A that we need and combine it with this one thing from B
          while (matchRec(ptrRecord, rec2, attrDesc1, attrDesc2) == 0 && smjStatus2 == OK){
             Record newRecord;
             newRecord.length = reclen;
             newRecord.data = malloc (reclen);
             int offset = 0;
             for(int i = 0; i < projCnt; i++){
                     if (strcmp(attrDesc1.relName, attrDescArray[i].relName) == 0){
                             memcpy(((char *)newRecord.data) + offset, (char*)(ptrRecord.data) + attrDescArray[i].attrOffset, attrDescArray[i].attrLen);
                             offset += attrDescArray[i].attrLen;
                     }
                     else{
                             memcpy(((char*) newRecord.data) + offset, (char*)(rec2.data) + attrDescArray[i].attrOffset, attrDescArray[i].attrLen);
                             offset += attrDescArray[i].attrLen;
                     }
             }
             smjStatus = joinResult.insertRecord(newRecord, rid);
             if (smjStatus != OK)
                 return smjStatus;
             smjStatus2 = attr1SortedFile.next(ptrRecord);
             free(newRecord.data);        
          }
          //Now, increment B ptr...
          smjStatus = attr2SortedFile.next(rec2);
          if (smjStatus != OK)
              break;
          //and GO BACK to look at the things still in A that might match
          smjStatus = attr1SortedFile.gotoMark();
          if (smjStatus != OK)
              return smjStatus;
      }
  }

    /* Your solution goes here */

  return OK;   
  }
