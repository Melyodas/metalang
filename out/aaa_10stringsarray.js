var util = require("util");
function idstring(s){
    return s;
}
function printstring(s){
    util.print(idstring(s), "\n");
}
function print_toto(t){
    util.print(t["s"], " = ", t["v"], "\n");
}
var tab = new Array(2);
for (var i = 0; i < 2; i++)
    tab[i] = idstring("chaine de test");
for (var j = 0; j < 2; j++)
    printstring(idstring(tab[j]));
var a = {
    "s":"one",
    "v":1};
print_toto(a);

