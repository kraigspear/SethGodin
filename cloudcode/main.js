// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:

Parse.Cloud.define("checkForNew", function(request, response)
{
    Parse.Cloud.httpRequest({
      url: 'http://www.parse.com/'
    }).then(function(httpResponse) 
    {
  
       console.log(httpResponse.text);
    },function(httpResponse) 
    {
       console.error('Request failed with response code ' + httpResponse.status);
    });
}
 
Parse.Cloud.beforeSave("Favorite", function(request, response) 
{
     console.log("beforeSave favorite");
    var favoriteID = request.object.get("favoriteID");
    var currentUser = Parse.User.current();
     var query = new Parse.Query("Favorite");
     query.equalTo("currentUser", currentUser);
    query.equalTo("favoriteID", favoriteID);
 
     query.count(
    {
       success: function(number)
       {
              console.log("Found favorite to delete " + number);
               
                if(number >= 1)
                    response.error("Duplicate favorite");
                else
                   response.success();
          },
       error: function(error) 
       {
           console.log("didn't find an existing favorite. return success");
                response.success();
          }
    });
});
 
