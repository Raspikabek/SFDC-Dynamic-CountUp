public with sharing class CountUp_ApexController {
    @AuraEnabled
    public static Decimal getMaxValue(Id recordId, String field, String SObjectName, String childRelation, String operation, String customConditions) {
        try {
            String myQuery;
            if (!String.isBlank(customConditions)) {
                myQuery = 'SELECT (SELECT ' + field + ' FROM ' + childRelation + ' WHERE '+ customConditions + ' ) FROM ' + SObjectName + ' WHERE Id =:recordId LIMIT 1';
            } else {
                myQuery = 'SELECT (SELECT ' + field + ' FROM ' + childRelation + ' ) FROM ' + SObjectName + ' WHERE Id =:recordId LIMIT 1';
            }
            SObject myObject = Database.query(myQuery);
            Decimal d = 0;
            if (myObject.getSObjects(childRelation) != null) {
                List<SObject> lSobj = myObject.getSObjects(childRelation);
                for (SObject o : lSobj) {
                    Decimal od = Decimal.valueOf(String.valueOf(o.get(field)));
                    if (operation == 'MIN') {
                        if (d == 0) d = od;
                        if (d > od) d = od;
                    } else if (operation == 'MAX') {
                        if (d < od) d = od;
                    } else {
                        d = d + od;
                    }
                }
                if (operation == 'AVG') d = d / lSobj.size();
            }
            return d;
        }
        catch (Exception e) {
            System.debug('COUNTUP_ERROR: '+ e);
            throw new AuraHandledException(e.getMessage());
        }
    }
}