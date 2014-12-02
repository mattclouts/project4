#include "catalog.h"
#include "query.h"
#include "sort.h"
#include "index.h"

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
  int numUnpinnedPages = BufMgr::numUnpinnedPages();
  int availablePages = 0.8 * numUnpinnedPages;
  int size = 0;
  for (int i = 0; i < projCnt; i++){
      size += attrDescArray[i].attrLen;
  }
  HeapFile attr1Heap = HeapFile(attrDesc1.relName,smjStatus);
  HeapFile attr2Heap = HeapFile(attrDesc2.relName, smjStatus);
  int numTuples1 = attr1Heap.getRecCnt();
  int numTuples2 = attr2Heap.getRecCnt();
  
  
  AttrDesc* outputDesc, attr1Desc, attr2Desc;
  int outputCnt, attr1Cnt, attr2Cnt;
  int attr1Size = 0, attr2Size = 0;
  smjStatus = attrCat->getRelInfo(result, outputCnt, outputDesc);
  if (smjStatus != OK)
      return smjStatus;
  smjStatus = attrCat->getRelInfo(attrDesc1.relName, attr1Cnt, attr1Desc);
  if (smjStatus != OK)
      return smjStatus;
  for (int i = 0; i < attr1Cnt; i++)
      attr1Size += attr1Desc.attrLen;
  smjStatus = attrCat->getRelInfo(attrDesc2.relName, attr2Cnt, attr2Desc);
  if (smjStatus != OK)
      return smjStatus;
  for (int i = 0; i < attr2Cnt; i++)
      attr2Size += attr1Desc.attrLen;
  
  int capacity1 = (availablePages/2)*PAGESIZE / attr1Size;
  int capacity2 = (availablePages/2)*PAGESIZE / attr2Size;
  
  SortedFile attr1SortedFile = SortedFile(attrDesc1.relName,attrDesc1.attrOffset, attrDesc1.attrLen, (Datatype)attrDesc1.attrType, capacity1, smjStatus);
  if(smjStatus != OK)
      return smjStatus;
  SortedFile attr2SortedFile = SortedFile(attrDesc2.relName,attrDesc2.attrOffset, attrDesc2.attrLen, (Datatype)attrDesc2.attrType, capacity2, smjStatus);
  if(smjStatus != OK)
      return smjStatus;
  
  HeapFile joinResult = HeapFile(result, smjStatus);
  if (smjStatus != OK)
      return smjStatus;
  
  
  /* Your solution goes here */

  return OK;
}

