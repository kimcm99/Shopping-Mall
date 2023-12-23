/*챗봇js*/

function chatOpen() {
   document.getElementById("chat-open").style.display = "none";
   document.getElementById("chat-close").style.display = "block";
   document.getElementById("chat-window1").style.display = "block";
}
function chatClose() {
   document.getElementById("chat-open").style.display = "block";
   document.getElementById("chat-close").style.display = "none";
   document.getElementById("chat-window1").style.display = "none";
}
function openConversation() {
   document.getElementById("chat-window1").style.display = "none";
}

//Gets the text from the input box(user)
function userResponse() {
   let userText = document.getElementById("textInput").value;

   if (userText == "") {
      alert("Please type something!");
   } else {
      document.getElementById("messageBox").innerHTML += `<div class="first-chat">
      <p>${userText}</p>
      <div class="arrow"></div>
    </div>`;
      document.getElementById("textInput").value = "";
      var objDiv = document.getElementById("messageBox");
      objDiv.scrollTop = objDiv.scrollHeight;

      setTimeout(() => {
         adminResponse(userText);
      }, 100);
   }
}

//admin Respononse to user's message   
function adminResponse(userText) {
   $.ajax({
      url: 'requestChatbot.do',
      type: 'post',
      data: { 'prompt': userText },
      success: function(data) {
         if (data.product != 'none') {
            answerHTML = `
            <div class="second-chat">
             <div class="circle" id="circle-mar"></div>
             <div class="ai-product" style="none; cursor: pointer;" onClick="location.href='productDetail.do?pid=${data.product.pid}'">
             <img id="product" src="images/${data.product.pimage}" height="100" width="100" />
             </div>
              <p>${data.product.pname}</p>
              <p>${data.answer}</p>
             <div class="arrow"></div>
           </div>
             `;
         } else {
            console.log(data.answer);

            answerHTML = `
            <div class="second-chat">
             <div class="circle" id="circle-mar"></div>
             <p>${data.answer}</p>
             <div class="arrow"></div>
           </div>
             `;
         }
         document.getElementById(
            "messageBox"
         ).innerHTML += answerHTML;

         var objDiv = document.getElementById("messageBox");
         objDiv.scrollTop = objDiv.scrollHeight;
      }
   });
}

//press enter on keyboard and send message
addEventListener("keypress", (e) => {
   if (e.keyCode === 13) {
      const e = document.getElementById("textInput");
      if (e === document.activeElement) {
         userResponse();
      }
   }
});