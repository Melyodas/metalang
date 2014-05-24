
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



function score(){
  stdinsep();
  var len = 0;
  len=read_int_();
  stdinsep();
  var sum = 0;
  for (var i = 1 ; i <= len; i++)
  {
    var c = '_';
    c=read_char_();
    sum += (c.charCodeAt(0) - 'A'.charCodeAt(0)) + 1;
    /*		print c print " " print sum print " " */
  }
  return sum;
}

var sum = 0;
var n = 0;
n=read_int_();
for (var i = 1 ; i <= n; i++)
  sum += i * score();
util.print(sum, "\n");

