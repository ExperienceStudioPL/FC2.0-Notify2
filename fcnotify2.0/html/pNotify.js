function parseMessage(message) {
  const regexColor = /~([^h])~([^~]+)/g;	
  const regexBold = /~([h])~([^~]+)/g;	
  const regexStop = /~s~/g;	
  const regexLine = /\n/g;	

  message = message.replace(regexColor, "<span class='$1'>$2</span>").replace(regexBold, "<span class='$1'>$2</span>").replace(regexStop, "").replace(regexLine, "<br />");

  return message;
}

$(function(){
    window.addEventListener("message", function(event){
        if (event.data.event === 'changePosition') {
          if (event.data.type === 'top') {
            $('#noty_layout__topRight').css({'top':'4px'})
          } else if (event.data.type === 'down') {
            $('#noty_layout__topRight').css({'top':'180px'})
          }
        } else if(event.data.options){
          var options = event.data.options;
          options.text = parseMessage(options.text)
          new Noty(options).show();
        }else{
          var maxNotifications = event.data.maxNotifications;
          Noty.setMaxVisible(maxNotifications.max, maxNotifications.queue);
        };
    });
});