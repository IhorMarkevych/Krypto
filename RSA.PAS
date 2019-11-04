unit rsa;
interface
procedure chiferrsa (var t,r:text; e,n:integer);
procedure dechiferrsa (var t,r:text; d,n:integer);

implementation
uses alphabet;

function eiler (p,q:longint):longint;
begin
 eiler:=(p-1)*(q-1);
end;

function stepmod (x,e,n:longint):integer;
var z,q:integer;
begin
z:=1;
q:=0;
while q<e do
begin
 q:=q+1;
 z:=(x*z) mod n;
end;
stepmod:=z;
end;

procedure chiferrsa;
var ts:char;
begin
reset (t);
rewrite (r);
while not eof (t) do
 begin
  read (t, ts);
  if not (ts in [#10, #13, #26]) then
  begin
   write (r,stepmod (numch(ts)+1,e,n)-1);
   write (r, '.');
  end
  else
   write (r, ts);
 end;
close (r);
close (t);
end;

procedure dechiferrsa;
var   ts:char;
       s:string;
     x,z:integer;
begin
reset (t);
rewrite (r);
while not eof (t) do
 begin
  s:='';
  ts:='q';
  while ts<>'.' do
   begin
   read (t, ts);
   if ts<>'.' then
    s:=s+ts;
   end;
  if not (ts in [#10, #13, #26]) then
  begin
   val (s,x,z);
   z:=stepmod (x+1,d,n);
    write (r,alph[z-1]);
  end
  else
   write (r, ts);
 end;
close (r);
close (t);
end;

end.