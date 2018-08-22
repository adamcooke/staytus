class Script {
  /**
   * @params {object} request
   */
  process_incoming_request({ request }) {
    // request.url.hash
    // request.url.search
    // request.url.query
    // request.url.pathname
    // request.url.path
    // request.url_raw
    // request.url_params
    // request.headers
    // request.user._id
    // request.user.name
    // request.user.username
    // request.content_raw
    // request.content

    var staytus_url = "http://localhost:3000"


    var staytus = request.content;
    var message = {};
    message.attachement = [];

    var attachement = {}
    attachement.title = staytus.data.title + " (" + staytus.data.updates.state + ")";
    attachement.title_link = staytus_url + "/issue/" + staytus.data.identifier;
    attachement.text = staytus.data.updates.text;
    attachement.text += "\n\nAffected Services:";
    message.attachement.push(attachement);


    // Add more attachements for each affected Service
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
         "attachments":  message.attachement
       }
    };

  }
}
