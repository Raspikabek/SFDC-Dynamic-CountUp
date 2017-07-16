({
	doInit : function(component, event, helper){
		console.log("Do init!");
		var myRecordId = component.get("v.recordId");
		var mySObjectName = component.get("v.sObjectName");
		var myChildRelationship = component.get("v.childRelation");
		// JUST FOR TEST
		if(myRecordId == null) myRecordId = '0010Y00000Wf6XRQAZ';
		if(mySObjectName == null) mySObjectName = 'Account';
		if(myChildRelationship == null) myChildRelationship = 'Opportunities';
		var action = component.get("c.getMaxValue");
		
		action.setParams({
			recordId : myRecordId,
			field : component.get("v.field"),
			SObjectName : mySObjectName,
			childRelation : myChildRelationship,
			operation : component.get("v.operation"),
			customConditions : component.get("v.customCondition")
		});
		
		action.setCallback(this, function(response){
			var state = response.getState();
			if(component.isValid && state === "SUCCESS"){
				component.set("v.maxValue", response.getReturnValue());
				component.set("v.success", true);
				component.set("v.errorMessage",null);
				console.log("Value returned");
			}
			else if(component.isValid && state === "ERROR"){
				console.log("Something wrong!");
				component.set("v.maxValue", 0);
				component.set("v.success", true);
				var errors = response.getError();
				if(errors){
					if(errors[0] && errors[0].message){
						console.log("Error message: " + errors[0].message);
						component.set("v.errorMessage","[ERROR] " + errors[0].message)
					}
				}
				else {
					console.log("Unknown error");
				}
			}
		});
		$A.enqueueAction(action);
	}
})