
var util = require("util");
var fs = require("fs");
var current_char = null;
var read_char0 = function(){
    return fs.readSync(process.stdin.fd, 1)[0];
}
var read_char_ = function(){
    if (current_char == null) current_char = read_char0();
    var out = current_char;
    current_char = read_char0();
    return out;
}
var stdinsep = function(){
    if (current_char == null) current_char = read_char0();
    while (current_char == '\n' || current_char == ' ' || current_char == '\t')
        current_char = read_char0();
}
var read_int_ = function(){
    if (current_char == null) current_char = read_char0();
    var sign = 1;
    if (current_char == '-'){
        current_char = read_char0();
        sign = -1;
    }
    var out = 0;
    while (true){
        if (current_char.charCodeAt(0) >= '0'.charCodeAt(0) && current_char.charCodeAt(0) <= '9'.charCodeAt(0)){
            out = out * 10 + current_char.charCodeAt(0) - '0'.charCodeAt(0);
            current_char = read_char0();
        }else{
            return out * sign;
        }
    }
}


function read_int(){
  var out_ = 0;
  out_=read_int_();
  stdinsep();
  return out_;
}

function read_int_line(n){
  var tab = new Array(n);
  for (var i = 0 ; i <= n - 1; i++)
  {
    var t = 0;
    t=read_int_();
    stdinsep();
    tab[i] = t;
  }
  return tab;
}

function programme_candidat(tableau, taille){
  var out_ = 0;
  for (var i = 0 ; i <= taille - 1; i++)
    out_ += tableau[i];
  return out_;
}

var b = 0;
b=read_int_();
stdinsep();
var a = b;
var taille = a;
var d = taille;
var e = new Array(d);
for (var f = 0 ; f <= d - 1; f++)
{
  var g = 0;
  g=read_int_();
  stdinsep();
  e[f] = g;
}
var c = e;
var tableau = c;
util.print(programme_candidat(tableau, taille), "\n");


