var util = require("util");
var fs = require("fs");
var current_char = null;
function read_char0(){
    var buf = Buffer.alloc(1);
    fs.readSync(process.stdin.fd, buf, 0, 1)[0];
    return buf.toString();
}
function read_char_(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
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
/*
Ce test permet de vérifier si les différents backends pour les langages implémentent bien
read int, read char et skip
*/
var len = read_int_();
stdinsep();
util.print(len, "=len\n");
len *= 2;
util.print("len*2=", len, "\n");
len = ~~(len / 2);
var tab = new Array(len);
for (var i = 0; i < len; i++)
{
    var tmpi1 = read_int_();
    stdinsep();
    util.print(i, "=>", tmpi1, " ");
    tab[i] = tmpi1;
}
util.print("\n");
var tab2 = new Array(len);
for (var i_ = 0; i_ < len; i_++)
{
    var tmpi2 = read_int_();
    stdinsep();
    util.print(i_, "==>", tmpi2, " ");
    tab2[i_] = tmpi2;
}
var strlen = read_int_();
stdinsep();
util.print(strlen, "=strlen\n");
var tab4 = new Array(strlen);
for (var toto = 0; toto < strlen; toto++)
{
    var tmpc = read_char_();
    var c = tmpc.charCodeAt(0);
    util.print(tmpc, ":", c, " ");
    if (tmpc != ' ')
        c = ~~((c - 'a'.charCodeAt(0) + 13) % 26) + 'a'.charCodeAt(0);
    tab4[toto] = String.fromCharCode(c);
}
for (var j = 0; j < strlen; j++)
    util.print(tab4[j]);

