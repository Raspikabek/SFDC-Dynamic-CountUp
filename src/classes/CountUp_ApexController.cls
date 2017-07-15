public with sharing class CountUp_ApexController {
	@AuraEnabled
	public static Decimal getMaxValue(Id recordId, String field, String SObjectName, String childRelation, String operation){
		try{
			String myQuery = 'SELECT (SELECT ' + field + ' FROM ' + childRelation + ' ) FROM ' + SObjectName + ' WHERE Id =:recordId LIMIT 1';
			//String myQuery = 'SELECT ' + field + ' FROM ' + SObjectName + ' WHERE ' + parentField + ' =:recordId';
			SObject myObject = Database.query(myQuery);
			List<SObject> lSobj = myObject.getSObjects(childRelation);			
			
			Decimal d = 0;
			for(SObject o : lSobj){
				Decimal od = Decimal.valueOf(String.valueOf(o.get(field)));
				if(operation == 'MIN'){
					if(d == 0) d = od;
					if(d > od) d = od;
				}
				else if(operation == 'MAX'){
					if(d < od) d = od;
				}
				else{
					d = d + od;
				}
			}
			if(operation == 'AVG') d = d / lSobj.size();
			return d;
		}
		catch (Exception e){
			System.debug('COUNTUP_ERROR: '+ e);
			throw new AuraHandledException('ERROR DETECTED: ' + e);
			//return 0;
		}
	}
}