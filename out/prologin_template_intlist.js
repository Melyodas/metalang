var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    var buf = Buffer.alloc(1);
    fs.readSync(process.stdin.fd, buf, 0, 1)[0];
    return buf.toString();
}
function stdinsep(){
    if (current_char == null) current_char = read_char0();
    while (current_char.match(/[\n\t\s]/g))
        current_char = read_char0();
}
function read_int_(){
  if (current_char == null) current_char = read_char0();
  var sign = 1;
  if (current_char == '-'){
     current_char = read_char0();
     sign = -1;
  }
  var out = 0;
  while (true){
    if (current_char.match(/[0-9]/g)){
      out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
      current_char = read_char0();
    }else{
      return out * sign;
    }
  }
}

function programme_candidat(tableau, taille){
    var out0 = 0;
    for (var i = 0; i < taille; i++)
        out0 += tableau[i];
    return out0;
}
var taille = read_int_();
stdinsep();
var tableau = new Array(taille);
for (var a = 0; a < taille; a++)
{
    tableau[a] = read_int_();
    stdinsep();
}
util.print(programme_candidat(tableau, taille), "\n");

