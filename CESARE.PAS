unit cesare;

interface

procedure chifertextcesare (var t, r:text; k:byte);
procedure dechifertextcesare (var t, r:text; k:byte);

implementation

uses alphabet;

function chiferchar (t:char; k:byte):char;
begin
chiferchar:=alph[(numch(t)+k) mod alnum];
end;

function dechiferchar (t:char; k:byte):char;
begin
dechiferchar:=alph[(numch(t)-k+alnum) mod alnum];
end;

procedure chifertextcesare;
var c:char;
begin
reset (t);
rewrite (r);
while not eof (t) do
begin
 read (t, c);
 if not (c in [#10,#13,#26]) then
  write (r, chiferchar (c,k))
 else
  write (r,c);
end;
close (t);
close (r);
end;

procedure dechifertextcesare;
var c:char;
begin
reset (t);
rewrite (r);
while not eof (t) do
begin
 read (t,c);
 if not (c in [#10,#13,#26]) then
  write (r, dechiferchar (c,k))
 else
  write (r,c);
end;
close (t);
close (r);
end;

end.