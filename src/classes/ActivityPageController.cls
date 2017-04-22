public with sharing class ActivityPageController {

    public List<Task> Taskslst { get; set;} 
    
    private String soql {get;set;}
    
    
    
     public String sortDir {
    get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
    set;
  }

  // the current field to sort by. defaults to last name
  public String sortField {
    get  { if (sortField == null) {sortField = 'Subject'; } return sortField;  }
    set;
  }

  // format the soql for display on the visualforce page
  public String debugSoql {
    get { return soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20'; }
    set;
  }
    
     public ActivityPageController(ApexPages.StandardController controller) {
     
    soql= 'Select id,Type__c,Subject,Contact_Name__c,ActivityDate,Description,Contact_Phone__c,Contact_Email__c from Task';
     runQuery();
       }
       
       
       // toggles the sorting of query from asc<-->desc
  public void toggleSort() {
    // simply toggle the direction
    sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
    // run the query again
    runQuery();
  }

  // runs the actual query
  public void runQuery() {

    try {
      Taskslst = Database.query(soql + ' order by ' + sortField + ' ' + sortDir + ' limit 20');
    } catch (Exception e) {
      ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!'));
    }

  }

       
       // runs the search with parameters passed via Javascript
  public PageReference runSearch() {

    String Subject = Apexpages.currentPage().getParameters().get('Subject');
   

    soql = 'Select id,Type__c,Subject,Contact_Name__c,ActivityDate,Description,Contact_Phone__c,Contact_Email__c from Task';
    if (!Subject.equals(''))
          soql += ' and subject LIKE \''+String.escapeSingleQuotes(Subject)+'%\'';

   
    

    // run the query again
    runQuery();

    return null;
  }

       
}