# SFDC Dynamic CountUp
Lightning Component for Salesforce

![Animated Image](/img/countUp_animation.gif)

### Description
Summarize, Average, Min or Max any field from any Child relationship in any SObject, like Opportunities Amount from any Account. **Even you can customize what records do you need to filter!**

![Sample Image](/img/Sample1.PNG)

### Instalation
* Download from Github

* [Install as Managed Package in your Org](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t0Y000001KwsS)

### How to use

Once installed, go to an Account record and add the Lightning Component **Count Up** to the Lightning Layout.

![Lightning Component Icon](/img/LightningIcon.PNG)

Now you can fill and configure the following parameters:

- [x] Required
- [ ] Non required
##### Parameters
- [x] Card Title
- [x] Child Relationship -- RelationShip API Name Ex: *Opportunities* from Account
- [x] Field -- Field API Name Ex: *Amount* -- *MyCustomField__c*
- [x] Operation -- SUM, AVG, MIN, MAX
- [ ] Custom Conditions -- Like a SOQL WHERE Clause Ex: *IsWon = TRUE*
- [x] Decimals -- Integer value
- [x] Thousand Separator -- A comma (,) or a point (.)
- [x] Decimal Separator -- A comma (,) or a point (.)
- [ ] Prefix
- [ ] Suffix

![Config Image](/img/Sample2.PNG)
 
###### Using CountUp.js v1.8.5 from: https://github.com/inorganik/countUp.js
