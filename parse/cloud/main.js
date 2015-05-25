// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:

Parse.Cloud.job("checkForNew", function(request, response)
{
    var blogTitle = "";
    var displayName = "";
    var published = "";
    var blogId = "";
    var needToPush = false;

    Parse.Cloud.httpRequest(
    {
      url: 'http://profile.typepad.com/sethgodin/activity.json'
    }).then(function(httpResponse) 
    {
       var json = JSON.parse(httpResponse.text);
       published = json["items"][0]["published"];

       blogTitle = json["items"][0]["object"]["displayName"];
       displayName = json["items"][0]["object"]["displayName"];
 	   blogId = json["items"][0]["object"]["id"];
 		
       var LatestEntry = Parse.Object.extend("LatestEntry");
       var query = new Parse.Query(LatestEntry);

       return query.first();

    }).then(function(latestEntry)
    {
      if(latestEntry.get("lastPublished") == published)
      {
        console.log("dates don't equal, need to push");
        return null;
      }
      else
      {
        latestEntry.set("lastPublished", published);
        return latestEntry.save(null);
      }
    	
    }).then(function(savedLatest)
    {
      if(savedLatest != null)
      {
        console.log("doing push");
        return Parse.Push.send({
          where: new Parse.Query(Parse.Installation),
          data: 
          {
            "alert": displayName,
            "badge": "Increment",
            "content-available": "1"
          }
        });
      }
      else
      {
        return null;
      }
    }).then(function(pushed)
    {
       response.success("pushed");
    },
    function(error)
    {
      response.error(error);
    });
});

 
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
 
