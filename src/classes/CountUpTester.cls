@isTest
private class CountUpTester{
	@testSetup static void setup(){
		Schema.DescribeFieldResult fieldResult = Opportunity.StageName.getDescribe();    
    	List<Schema.PicklistEntry> vls = fieldResult.getPicklistValues();  
		
		Account a = new Account(
			Name = 'CountUp Account SA'
		);
		
		insert a; 
    
    	List<Opportunity> lOpps = new List<Opportunity>();
		Opportunity o = new Opportunity(
			AccountId = a.Id,
			CloseDate = Date.today() + 15,
			Name = 'CountUp Opportunity',
			StageName = vls.get(0).getValue(),
			Amount = 1000
		);
		
		Opportunity o2 = new Opportunity(
			AccountId = a.Id,
			CloseDate = Date.today() + 15,
			Name = 'Second CountUp Opportunity',
			StageName = vls.get(0).getValue(),
			Amount = 1000
		);
		lOpps.add(o);
		lOpps.add(o2);
		insert lOpps;
	}
	
	@isTest static void countUp_Controller(){
		Id recordId = [SELECT Id FROM Account LIMIT 1].Id;
		
		Decimal firstValue = CountUp_ApexController.getMaxValue(recordId, 'Amount', 'Account', 'Opportunities', 'SUM', '');
		Decimal secondValue = CountUp_ApexController.getMaxValue(recordId, 'Amount', 'Account', 'Opportunities', 'AVG', 'IsWon = false');
		Decimal thirdValue = CountUp_ApexController.getMaxValue(recordId, 'Amount', 'Account', 'Opportunities', 'MIN', '');
		Decimal fourthValue = CountUp_ApexController.getMaxValue(recordId, 'Amount', 'Account', 'Opportunities', 'MAX', null);
		System.assertEquals(firstValue,2000);
		System.assertEquals(secondValue,1000);
		System.assertEquals(thirdValue,1000);
		System.assertEquals(fourthValue,1000);
		// Manage Exception
		try{
			Decimal fifthValue = CountUp_ApexController.getMaxValue(recordId, 'ERROR_FIELD', 'Account', 'Opportunities', 'MIN',null);
		}
		catch(Exception e){
			System.debug(e);
		}	
	}
}