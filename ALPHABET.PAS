unit alphabet;

interface

var     alph:array [0..74] of char;
const   alnum:byte=74;
function numch (c:char):byte;

implementation

function numch;
var i:byte;
begin
i:=0;
while c<>alph [i] do
 i:=i+1;
numch:=i;
end;

var i:byte;
begin
for i:=0 to 25 do
 alph [i]:=chr (65+i);
for i:=0 to 9 do
 alph [i+26]:=chr (48+i);
alph [36]:=' ';
alph [37]:='.';
alph [38]:=',';
alph [39]:='!';
alph [40]:='?';
alph [41]:='-';
alph [42]:='"';
alph [43]:=chr (39);
alph [44]:=':';
alph [45]:=';';
alph [46]:=')';
alph [47]:='(';
alph [48]:='`';
for i:=0 to 25 do
 alph [i+49]:=chr (97+i);
end.

