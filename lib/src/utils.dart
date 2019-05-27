import 'dart:html';

class ScrollPosDetect {
  static bool isAtTop() {
    if(window.scrollY<1){
      //window.console.log("at top");
      return true;
    }else{
      return false;
    }
  }

  static bool isAtBottom() {
    //window.console.log("1:"+document.body.scrollHeight.toString());
    //window.console.log("2:"+window.scrollY.toString());
    //window.console.log("3:"+document.body.clientHeight.toString());
    if (document.body.scrollHeight - (window.scrollY + document.body.clientHeight)<1) {
      //window.console.log("at bottom");
      return true;
    }else{
      return false;
    }
  }
}
