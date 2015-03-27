
with ada.text_io, ada.Integer_text_IO, Ada.Text_IO.Text_Streams, Ada.Strings.Fixed;
use ada.text_io, ada.Integer_text_IO, Ada.Strings, Ada.Strings.Fixed;

procedure aaa_09chars is
procedure PString(s : String) is
begin
  String'Write (Text_Streams.Stream (Current_Output), s);
end;
procedure PChar(c : in Character) is
begin
  Character'Write (Text_Streams.Stream (Current_Output), c);
end;
procedure PInt(i : in Integer) is
begin
  String'Write (Text_Streams.Stream (Current_Output), Trim(Integer'Image(i), Left));
end;

begin
  PInt(1);
  PString("=>");
  PChar(Character'Val(1));
  PString("" & Character'Val(10));
  PInt(2);
  PString("=>");
  PChar(Character'Val(2));
  PString("" & Character'Val(10));
  PInt(3);
  PString("=>");
  PChar(Character'Val(3));
  PString("" & Character'Val(10));
  PInt(4);
  PString("=>");
  PChar(Character'Val(4));
  PString("" & Character'Val(10));
  PInt(5);
  PString("=>");
  PChar(Character'Val(5));
  PString("" & Character'Val(10));
  PInt(6);
  PString("=>");
  PChar(Character'Val(6));
  PString("" & Character'Val(10));
  PInt(7);
  PString("=>");
  PChar(Character'Val(7));
  PString("" & Character'Val(10));
  PInt(8);
  PString("=>");
  PChar(Character'Val(8));
  PString("" & Character'Val(10));
  PInt(9);
  PString("=>");
  PChar(Character'Val(9));
  PString("" & Character'Val(10));
  PInt(10);
  PString("=>");
  PChar(Character'Val(10));
  PString("" & Character'Val(10));
  PInt(11);
  PString("=>");
  PChar(Character'Val(11));
  PString("" & Character'Val(10));
  PInt(12);
  PString("=>");
  PChar(Character'Val(12));
  PString("" & Character'Val(10));
  PInt(13);
  PString("=>");
  PChar(Character'Val(13));
  PString("" & Character'Val(10));
  PInt(14);
  PString("=>");
  PChar(Character'Val(14));
  PString("" & Character'Val(10));
  PInt(15);
  PString("=>");
  PChar(Character'Val(15));
  PString("" & Character'Val(10));
  PInt(16);
  PString("=>");
  PChar(Character'Val(16));
  PString("" & Character'Val(10));
  PInt(17);
  PString("=>");
  PChar(Character'Val(17));
  PString("" & Character'Val(10));
  PInt(18);
  PString("=>");
  PChar(Character'Val(18));
  PString("" & Character'Val(10));
  PInt(19);
  PString("=>");
  PChar(Character'Val(19));
  PString("" & Character'Val(10));
  PInt(20);
  PString("=>");
  PChar(Character'Val(20));
  PString("" & Character'Val(10));
  PInt(21);
  PString("=>");
  PChar(Character'Val(21));
  PString("" & Character'Val(10));
  PInt(22);
  PString("=>");
  PChar(Character'Val(22));
  PString("" & Character'Val(10));
  PInt(23);
  PString("=>");
  PChar(Character'Val(23));
  PString("" & Character'Val(10));
  PInt(24);
  PString("=>");
  PChar(Character'Val(24));
  PString("" & Character'Val(10));
  PInt(25);
  PString("=>");
  PChar(Character'Val(25));
  PString("" & Character'Val(10));
  PInt(26);
  PString("=>");
  PChar(Character'Val(26));
  PString("" & Character'Val(10));
  PInt(27);
  PString("=>");
  PChar(Character'Val(27));
  PString("" & Character'Val(10));
  PInt(28);
  PString("=>");
  PChar(Character'Val(28));
  PString("" & Character'Val(10));
  PInt(29);
  PString("=>");
  PChar(Character'Val(29));
  PString("" & Character'Val(10));
  PInt(30);
  PString("=>");
  PChar(Character'Val(30));
  PString("" & Character'Val(10));
  PInt(31);
  PString("=>");
  PChar(Character'Val(31));
  PString("" & Character'Val(10));
  PInt(32);
  PString("=>");
  PChar(' ');
  PString("" & Character'Val(10));
  PInt(33);
  PString("=>");
  PChar('!');
  PString("" & Character'Val(10));
  PInt(34);
  PString("=>");
  PChar('"');
  PString("" & Character'Val(10));
  PInt(35);
  PString("=>");
  PChar('#');
  PString("" & Character'Val(10));
  PInt(36);
  PString("=>");
  PChar('$');
  PString("" & Character'Val(10));
  PInt(37);
  PString("=>");
  PChar('%');
  PString("" & Character'Val(10));
  PInt(38);
  PString("=>");
  PChar('&');
  PString("" & Character'Val(10));
  PInt(39);
  PString("=>");
  PChar(Character'Val(39));
  PString("" & Character'Val(10));
  PInt(40);
  PString("=>");
  PChar('(');
  PString("" & Character'Val(10));
  PInt(41);
  PString("=>");
  PChar(')');
  PString("" & Character'Val(10));
  PInt(42);
  PString("=>");
  PChar('*');
  PString("" & Character'Val(10));
  PInt(43);
  PString("=>");
  PChar('+');
  PString("" & Character'Val(10));
  PInt(44);
  PString("=>");
  PChar(',');
  PString("" & Character'Val(10));
  PInt(45);
  PString("=>");
  PChar('-');
  PString("" & Character'Val(10));
  PInt(46);
  PString("=>");
  PChar('.');
  PString("" & Character'Val(10));
  PInt(47);
  PString("=>");
  PChar('/');
  PString("" & Character'Val(10));
  PInt(48);
  PString("=>");
  PChar('0');
  PString("" & Character'Val(10));
  PInt(49);
  PString("=>");
  PChar('1');
  PString("" & Character'Val(10));
  PInt(50);
  PString("=>");
  PChar('2');
  PString("" & Character'Val(10));
  PInt(51);
  PString("=>");
  PChar('3');
  PString("" & Character'Val(10));
  PInt(52);
  PString("=>");
  PChar('4');
  PString("" & Character'Val(10));
  PInt(53);
  PString("=>");
  PChar('5');
  PString("" & Character'Val(10));
  PInt(54);
  PString("=>");
  PChar('6');
  PString("" & Character'Val(10));
  PInt(55);
  PString("=>");
  PChar('7');
  PString("" & Character'Val(10));
  PInt(56);
  PString("=>");
  PChar('8');
  PString("" & Character'Val(10));
  PInt(57);
  PString("=>");
  PChar('9');
  PString("" & Character'Val(10));
  PInt(58);
  PString("=>");
  PChar(':');
  PString("" & Character'Val(10));
  PInt(59);
  PString("=>");
  PChar(';');
  PString("" & Character'Val(10));
  PInt(60);
  PString("=>");
  PChar('<');
  PString("" & Character'Val(10));
  PInt(61);
  PString("=>");
  PChar('=');
  PString("" & Character'Val(10));
  PInt(62);
  PString("=>");
  PChar('>');
  PString("" & Character'Val(10));
  PInt(63);
  PString("=>");
  PChar('?');
  PString("" & Character'Val(10));
  PInt(64);
  PString("=>");
  PChar('@');
  PString("" & Character'Val(10));
  PInt(65);
  PString("=>");
  PChar('A');
  PString("" & Character'Val(10));
  PInt(66);
  PString("=>");
  PChar('B');
  PString("" & Character'Val(10));
  PInt(67);
  PString("=>");
  PChar('C');
  PString("" & Character'Val(10));
  PInt(68);
  PString("=>");
  PChar('D');
  PString("" & Character'Val(10));
  PInt(69);
  PString("=>");
  PChar('E');
  PString("" & Character'Val(10));
  PInt(70);
  PString("=>");
  PChar('F');
  PString("" & Character'Val(10));
  PInt(71);
  PString("=>");
  PChar('G');
  PString("" & Character'Val(10));
  PInt(72);
  PString("=>");
  PChar('H');
  PString("" & Character'Val(10));
  PInt(73);
  PString("=>");
  PChar('I');
  PString("" & Character'Val(10));
  PInt(74);
  PString("=>");
  PChar('J');
  PString("" & Character'Val(10));
  PInt(75);
  PString("=>");
  PChar('K');
  PString("" & Character'Val(10));
  PInt(76);
  PString("=>");
  PChar('L');
  PString("" & Character'Val(10));
  PInt(77);
  PString("=>");
  PChar('M');
  PString("" & Character'Val(10));
  PInt(78);
  PString("=>");
  PChar('N');
  PString("" & Character'Val(10));
  PInt(79);
  PString("=>");
  PChar('O');
  PString("" & Character'Val(10));
  PInt(80);
  PString("=>");
  PChar('P');
  PString("" & Character'Val(10));
  PInt(81);
  PString("=>");
  PChar('Q');
  PString("" & Character'Val(10));
  PInt(82);
  PString("=>");
  PChar('R');
  PString("" & Character'Val(10));
  PInt(83);
  PString("=>");
  PChar('S');
  PString("" & Character'Val(10));
  PInt(84);
  PString("=>");
  PChar('T');
  PString("" & Character'Val(10));
  PInt(85);
  PString("=>");
  PChar('U');
  PString("" & Character'Val(10));
  PInt(86);
  PString("=>");
  PChar('V');
  PString("" & Character'Val(10));
  PInt(87);
  PString("=>");
  PChar('W');
  PString("" & Character'Val(10));
  PInt(88);
  PString("=>");
  PChar('X');
  PString("" & Character'Val(10));
  PInt(89);
  PString("=>");
  PChar('Y');
  PString("" & Character'Val(10));
  PInt(90);
  PString("=>");
  PChar('Z');
  PString("" & Character'Val(10));
  PInt(91);
  PString("=>");
  PChar('[');
  PString("" & Character'Val(10));
  PInt(92);
  PString("=>");
  PChar(Character'Val(92));
  PString("" & Character'Val(10));
  PInt(93);
  PString("=>");
  PChar(']');
  PString("" & Character'Val(10));
  PInt(94);
  PString("=>");
  PChar('^');
  PString("" & Character'Val(10));
  PInt(95);
  PString("=>");
  PChar('_');
  PString("" & Character'Val(10));
  PInt(96);
  PString("=>");
  PChar('`');
  PString("" & Character'Val(10));
  PInt(97);
  PString("=>");
  PChar('a');
  PString("" & Character'Val(10));
  PInt(98);
  PString("=>");
  PChar('b');
  PString("" & Character'Val(10));
  PInt(99);
  PString("=>");
  PChar('c');
  PString("" & Character'Val(10));
  PInt(100);
  PString("=>");
  PChar('d');
  PString("" & Character'Val(10));
  PInt(101);
  PString("=>");
  PChar('e');
  PString("" & Character'Val(10));
  PInt(102);
  PString("=>");
  PChar('f');
  PString("" & Character'Val(10));
  PInt(103);
  PString("=>");
  PChar('g');
  PString("" & Character'Val(10));
  PInt(104);
  PString("=>");
  PChar('h');
  PString("" & Character'Val(10));
  PInt(105);
  PString("=>");
  PChar('i');
  PString("" & Character'Val(10));
  PInt(106);
  PString("=>");
  PChar('j');
  PString("" & Character'Val(10));
  PInt(107);
  PString("=>");
  PChar('k');
  PString("" & Character'Val(10));
  PInt(108);
  PString("=>");
  PChar('l');
  PString("" & Character'Val(10));
  PInt(109);
  PString("=>");
  PChar('m');
  PString("" & Character'Val(10));
  PInt(110);
  PString("=>");
  PChar('n');
  PString("" & Character'Val(10));
  PInt(111);
  PString("=>");
  PChar('o');
  PString("" & Character'Val(10));
  PInt(112);
  PString("=>");
  PChar('p');
  PString("" & Character'Val(10));
  PInt(113);
  PString("=>");
  PChar('q');
  PString("" & Character'Val(10));
  PInt(114);
  PString("=>");
  PChar('r');
  PString("" & Character'Val(10));
  PInt(115);
  PString("=>");
  PChar('s');
  PString("" & Character'Val(10));
  PInt(116);
  PString("=>");
  PChar('t');
  PString("" & Character'Val(10));
  PInt(117);
  PString("=>");
  PChar('u');
  PString("" & Character'Val(10));
  PInt(118);
  PString("=>");
  PChar('v');
  PString("" & Character'Val(10));
  PInt(119);
  PString("=>");
  PChar('w');
  PString("" & Character'Val(10));
  PInt(120);
  PString("=>");
  PChar('x');
  PString("" & Character'Val(10));
  PInt(121);
  PString("=>");
  PChar('y');
  PString("" & Character'Val(10));
  PInt(122);
  PString("=>");
  PChar('z');
  PString("" & Character'Val(10));
  PInt(123);
  PString("=>");
  PChar('{');
  PString("" & Character'Val(10));
  PInt(124);
  PString("=>");
  PChar('|');
  PString("" & Character'Val(10));
  PInt(125);
  PString("=>");
  PChar('}');
  PString("" & Character'Val(10));
  PInt(126);
  PString("=>");
  PChar('~');
  PString("" & Character'Val(10));
  PInt(127);
  PString("=>");
  PChar(Character'Val(127));
  PString("" & Character'Val(10));
end;