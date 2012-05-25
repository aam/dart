#import('dart:html');

class webapp 
{
  webapp() {}
  void run() { write("Hello, world!"); }
  void write(String message) { document.query('#status').innerHTML = message; }
}

void main()
{
  new webapp().run();
  
  addUiElements();
}

addUiElements() {
  // build the elements and add them to the UI
  var elements = new Element.html("""
<div id="example">
  Enter some text:<input id="myTextbox" value="helloWorld"></input>
  <button id="myButton">Send request to server</button></br/>
  <span id="requestSpan">Request=</span><br />
  <span id="responseSpan">Response=</span></br />
</div>
""");
  document.body.nodes.add(elements);

  ButtonElement button = document.body.query("#myButton"); // get a handle on the button

  // add an event handler to the button
  button.on.click.add(EventListener (data) {
    // perform an XHR request to the server
    // for the url entered into the textbox

    // build the url
    InputElement textbox = document.body.query("#myTextbox"); // get a handle on the textbox
    String url = "http://127.0.0.1:8180/${textbox.value}"; // IMPORTANT: url must be the same as in the browser
                                                           // if you navigate to this page using http://localhost
                                                           // then this url also needs to use http://localhost
                                                           // otherwise you will get Access-Control-Origin errors

    // add the url to the UI
    SpanElement requestSpan = document.body.query("#requestSpan"); // get the request span
    requestSpan.innerHTML += "GET: $url <br />"; // add the request to the UI

    // add a callback which will be executed on the server
    XMLHttpRequest request = new XMLHttpRequest.get(url, (XMLHttpRequest request) {
      SpanElement responseSpan = document.body.query("#responseSpan"); // get the response span

      responseSpan.innerHTML += "${request.responseText} <br />"; // add the output to the UI
    });
  });

}