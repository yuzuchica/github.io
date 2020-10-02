myButton = 0; // [Start]/[Stop]のフラグ
function myCheck() {
  if (myButton == 0) { // Startボタンを押した
    myStart = new Date(); // スタート時間を退避
    myButton = 1;
    document.myForm.myFormButton.value = "Stop!";
    myInterval = setInterval("myDisp()", 1);
  } else { // Stopボタンを押した
    myDisp();
    myButton = 0;
    document.myForm.myFormButton.value = "Start";
    clearInterval(myInterval);

    var xhr = new XMLHttpRequest();
    xhr.open('POST', '/time');
    xhr.setRequestHeader('content-type', 'application/x-www-form-urlencoded;charset=UTF-8');
    xhr.send(myM = Math.floor(myTime / (60 * 1000)));
  }
}

function myDisp() {
  myStop = new Date(); // 経過時間を退避
  myTime = myStop.getTime() - myStart.getTime(); // 通算ミリ秒計算
  myH = Math.floor(myTime / (60 * 60 * 1000));
  // '時間'取得
  myTime = myTime - (myH * 60 * 60 * 1000);
  myM = Math.floor(myTime / (60 * 1000)); // '分'取得
  myTime = myTime - (myM * 60 * 1000);
  myS = Math.floor(myTime / 1000); // '秒'取得
  //myMS = myTime % 1000;  'ミリ秒'取得
  strTime = myM + ":" + myS; //+ ":" + myMS;

  document.getElementById("time").innerHTML = strTime;
}