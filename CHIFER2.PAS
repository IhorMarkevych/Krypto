unit chifer2;

interface

procedure chifertext (var t,r,k:text);
procedure dechifertext (var t,r,k:text);
function checktext (var t:text):boolean;
procedure keygen (var k:text);

implementation
uses alphabet;

function chiferchar (t,k:char):char;
begin
chiferchar:=alph[(numch(t)+numch(k)) mod (alnum+1)];
end;

function dechiferchar (t,k:char):char;
begin
dechiferchar:=alph[(numch(t)-numch(k)+alnum+1) mod (alnum+1)];
end;

function checktext;
var c:char;
    i:byte;
    b:boolean;
begin
reset (t);
b:=true;
while (not eof (t)) and (b) do
begin
 repeat
  read (t,c);
 until not (c in [#10,#13,#26]);
 b:=false;
 for i:=0 to alnum do
  if c=alph[i] then
   b:=true;
end;
checktext:=b;
close (t);
end;

procedure keygen;
var j,n:byte;
begin
rewrite (k);
n:=random (50)+20;
for j:=1 to n do
 write (k, alph [random(alnum+1)]);
close (k);
end;

procedure chifertext;
var ts,ks:char;
begin
reset (t);
reset (k);
rewrite (r);
while not eof (t) do
 begin
  read (t, ts);
  repeat
   read (k, ks);
   if ks=#26 then
   begin
    close (k);
    reset (k);
   end;
  until not (ks in [#10, #13, #26]);
  if not (ts in [#10, #13, #26]) then
     write (r, chiferchar (ts, ks))
  else
   write (r, ts);
 end;
close (k);
close (r);
close (t);
end;

procedure dechifertext;
var ts,ks:char;
begin
reset (t);
reset (k);
rewrite (r);
while not eof (t) do
 begin
  read (t, ts);
  repeat
   read (k, ks);
   if ks=#26 then
   begin
    close (k);
    reset (k);
   end;
  until not (ks in [#10, #13, #26]);
  if not (ts in [#10, #13, #26]) then
   write (r, dechiferchar (ts, ks))
  else
   write (r, ts);
 end;
close (t);
close (r);
close (k);
end;

end.