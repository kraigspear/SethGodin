// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:

Parse.Cloud.job("checkForNew", function(request, response)
{
    Parse.Cloud.httpRequest({
      url: 'http://profile.typepad.com/sethgodin/activity.json'
    }).then(function(httpResponse) 
    {
       var json = JSON.parse(httpResponse.text);
       var published = json["items"][0]["published"]


       var LatestEntry = Parse.Object.extend("LatestEntry");
       var query = new Parse.Query(LatestEntry);

       return query.first();

    }).then(function(latestEntry)
    {
    	latestEntry.set("lastPublished", published);
    	return latestEntry.save(null);
    }).then(function(savedLatest)
    {
    	sendOutPushes();
    },
    function(error)
    {

    });
});




function sendOutPushes()
{

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
 
