#include "catalog.h"
#include "query.h"
#include "index.h"
/*
 * Selects records from the specified relation.
 *
 * Returns:
 * 	OK on success
 * 	an error code otherwise
 */
Status Operators::Select(const string & result,      // name of the output relation
	                 const int projCnt,          // number of attributes in the projection
		         const attrInfo projNames[], // the list of projection attributes
		         const attrInfo *attr,       // attribute used inthe selection predicate 
		         const Operator op,         // predicate operation
		         const void *attrValue)     // literal value in the predicate
{
AttrDesc* projAttrList = new AttrDesc[projCnt];
int relAttrCnt = 0;
Status projStatus;
int recordSize = 0;

AttrDesc predicate;

//Fill in attribute list from projection names
for (int i = 0; i < projCnt; i++){
    projStatus = attrCat->getInfo(projNames[i].relName, projNames[i].attrName, projAttrList[i]);
    if (projStatus != OK)
        return projStatus;
}
//Get the length of all the attributes
for (int i = 0; i < projCnt; i++)
    recordSize += projNames[i].attrLen;

//Check if there's a selection predicate
//Yes? get predicate
//No? Do Scan Select

//Check if there's an index & the operator is EQ
//Yes?  Index Scan
//No? Select Scan


delete[] projAttrList;
return OK;
}

