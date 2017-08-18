#Powershell Snippit to send data to HipChat Room
#Variables for the json post
$APIKey = 'YOUR API KEY HERE'
#The key is tied to user who requests it and will post as that person (may want to build an admin user)
$Room = 'ROOM NAME' #Case sensitive if using name!! Use ID from the room it's easier
#Hipchat post url variable
$apiuri = http://api.hipchat.com/v2/room/$Room/notification?auth_token=$APIKey”
#Notify defaults to false, change to true for notifications 
$body = @{
color =  “purple”;
message=  “Hello World Post”;
notify=  “false”;
message_format= “text”
}
#Post to room
Invoke-RestMethod -Method Post -Uri $apiuri -body (ConvertTo-Json $body) -ContentType “application/json”
#End of Hipchat Post
