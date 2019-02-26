# Rocket.Chat WebHook integration

Add the following script for formatting messages for Rocket.Chat

```javascript
class Script {
  process_incoming_request({ request }) {
    var staytus = request.content;
    var message = {};
    message.attachement = [];

    var attachement = {}
    attachement.title = staytus.data.title +
      " (" + staytus.data.class + ": " + staytus.data.state + ")";
    attachement.title_link = staytus.data.url;
    attachement.text = staytus.data.updates.text;
    attachement.text += "\n\nAffected Services:";
    message.attachement.push(attachement);


    // add attachements for each affected service
    if (staytus.data.services.length > 0) {
      for (i = 0; i < staytus.data.services.length; i++) {
        var status_attachement = {}
        status_attachement.text = " - " + staytus.data.services[i].name + " : " + staytus.data.services[i].status.name
        status_attachement.color = "#" + staytus.data.services[i].status.color
        message.attachement.push(status_attachement);
      }
    } else {
      var status_attachement = {}
      status_attachement.text = " - none";
      message.attachement.push(status_attachement);
    }

    return {
      content:{
        text: "",
         "attachments": message.attachement
       }
    };

  }
}
```
