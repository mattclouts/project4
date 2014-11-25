#include "catalog.h"
#include "query.h"
#include "index.h"
#include "string.h"
#include "stdlib.h"
#include "utility.h"
/*
 * Inserts a record into the specified relation
 *
 * Returns:
 * 	OK on success
 * 	an error code otherwise
 */

Status Updates::Insert(const string& relation,      // Name of the relation
                       const int attrCnt,           // Number of attributes specified in INSERT statement
                       const attrInfo attrList[])   // Value of attributes specified in INSERT statement
{

    //1.Insert the record into the Heapfile corresponding to 'relation'
    //First map data from the arguments to insert into a Record Object
    //Look in System Catalog for attributes of relation, their offset, data type
    //Put the attributes in the correct order in the Record object:
    //  attrCat->getRelInfo(const string &rName, int &attrCnt, AttrDesc *&attrs)

    AttrDesc* relAttrList;
    int relAttrCnt = 0;
    Status relStatus;
    int recordSize = 0;
    
    relStatus = attrCat->getRelInfo(relation, relAttrCnt, relAttrList);
    if (relStatus != OK)
        return relStatus;
    
    for (int i = 0; i < attrCnt; i++){
        if (attrList[i].attrName == NULL)
            return ATTRTYPEMISMATCH;
    }
    for (int i = 0; i < relAttrCnt; i++){
        recordSize += relAttrList[i].attrLen;
    }
    
    Record newRecord;
    newRecord.length = recordSize;
    newRecord.data = malloc (recordSize);
    
    for (int i = 0; i < relAttrCnt; i++){
        for (int j = 0; j < attrCnt; j++){
            if (strcmp(relAttrList[i].attrName, attrList[j].attrName) == 0){
                memcpy(((char *)newRecord.data) + relAttrList[i].attrOffset, attrList[j].attrValue, relAttrList[i].attrLen);
            }
        }
    }
    Status heapStatus;
    RID heapRid;
    HeapFile relHeap = HeapFile(relation, heapStatus);
    heapStatus = relHeap.insertRecord(newRecord,heapRid);
    if (heapStatus != OK)
        return heapStatus;
    
    //2.Insert the record ID into each index that exists in 'relation'
    //Look in the catalogs to see if there are one or more indexes for the relation
    
    
    for (int i =0; i < attrCnt; i++){
        for (int j = 0; j < attrCnt; j++){
            if (strcmp(relAttrList[i].attrName, attrList[j].attrName) == 0){
                if (relAttrList[i].indexed){
                        Status tempStatus;
                        Index *tempIndex = new Index(relAttrList[i].relName, 
                            relAttrList[i].attrOffset, relAttrList[i].attrLen,
                            (Datatype)relAttrList[i].attrType, 0, tempStatus);
                        if (tempStatus != OK)
                                return tempStatus;
                tempIndex->insertEntry(attrList[j].attrValue,heapRid);
                delete tempIndex;
                continue;
                }
            } 
        }
    }
    Utilities lordHelpMe;
    lordHelpMe.Print(relation);
    free(newRecord.data);
    return OK;
}
