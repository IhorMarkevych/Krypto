unit rsakey;
interface
function prostoe (x:integer):boolean;
function evklid (e,n:integer; var multobr:integer):integer;

implementation

function prostoe;
var i:integer;
    b:boolean;
begin
b:=true;
i:=2;
while (b) and (i<x) do
 begin
  if x mod i = 0 then
   b:=false;
  i:=i+1;
 end;
prostoe:=b;
end;

function evklid;
var x1,x2,y1,y2,q,r,x,y,d,b:integer;
begin
x1:=0;
x2:=1;
y1:=1;
y2:=0;
b:=n;
while b>0 do
begin
 q:=e div b;
 r:=e-q*b;
 x:=x2-q*x1;
 y:=y2-q*y1;
 e:=b;
 b:=r;
 x2:=x1;
 x1:=x;
 y2:=y1;
 y1:=y;
end;
x:=x2;
y:=y2;
multobr:=(x+n) mod n;
evklid:=e;
end;

end.