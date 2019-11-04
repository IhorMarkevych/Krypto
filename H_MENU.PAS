unit h_menu;{h_menu.pas} 
{Vertikal'noe menu dlya obrobku textovogo rejimu} 

interface 
uses crt; 
type men=array[1..6] of string[22];
procedure ramka(x,y,m,n,colt,colf:byte); 
procedure form_men(menu:men;x,y,n,colt,colf:byte);
function mov_men(menu:men; x,y,n,colt,colf:byte):byte;
procedure txtwrite (var t:text; maxX,maxY:byte);

implementation

procedure txtwrite;
var j,k,n:integer;
      i:byte;
      s:string;
      c:char;
    tmp:text;
begin
window (1,1,maxX,maxY);
textbackground (black);
clrscr;
assign (tmp, 'C:\tmp.txt');
reset (t);
rewrite (tmp);
i:=1;
while not eof (t) do
   begin
    if eoln (t) then
     begin
      i:=1;
      writeln (tmp);
      readln (t);
     end
    else
     begin
      read (t,c);
      write (tmp,c);
     end;
    if (i mod maxX)=0 then
     writeln (tmp);
    i:=i+1;
   end;

k:=1;
n:=0;
close (tmp);
reset (tmp);
while not eof (tmp) do
 begin
  readln (tmp,s);
  n:=n+1;
 end;
repeat
 clrscr;
 close (tmp);
 reset (tmp);
 j:=0;
 while (j<>k-1) and (j<=n) do
  begin
   readln (tmp,s);
   j:=j+1;
  end;

 for i:=1 to maxY do
  if j+i<>n+1 then
   begin
    readln (tmp,s);
    write (s);
    if wherey<>maxY then writeln;
   end;

 repeat
  c:=readkey;
 until c in [#72,#80,#27,#13];
if n>maxY then
 case c of
  #72:begin
       k:=k-1;
       if k=0 then k:=1;
      end;
  #80:begin
       k:=k+1;
       if (k>n) or (n-k+2=maxY) then k:=1;
      end;
 end;

until c in [#27, #13];
close (tmp);
erase (tmp);
close (t);
clrscr;
end;

procedure ramka;
var i:byte; 
begin
window (x,y,x+m-1,y+n);
textattr:=16*colf+colt; 
clrscr;
{Delaem ramku} 
gotoxy(1,n);
write(#200);{ugolok};
for i:=1 to m-2 do
write(#205);{=}
write(#188);{drugoi ugolok}
gotoxy(1,1);
insline;{Vstavili ryadok}
write(#201); {drugoi ugolok}
for i:=1 to m-2 do
write(#205);
write(#187); {ugolok}
for i:=2 to n do begin
gotoxy(1,i);
write(#186);{II}
gotoxy(m,i);
write(#186);{II} 
end; 
end; 

procedure form_men; 
var i:byte; 
begin
ramka(x,y,sizeof(menu[4])+2,n+2,colt,colf);
window (x+1,y+1,x+sizeof(menu[4])+1,y+n);
highvideo;
write(menu[1]);
lowvideo;
for i:=2 to n do
begin
gotoxy(1,i);
write(menu[i]);
end;
end;

function mov_men; 
var i:byte; 
c:char; 
begin 
form_men(menu,x,y,n,colt,colf); 
gotoxy(1,1);
i:=1;
repeat
c:=readkey;
case c of
#72:{Strelka vverh} begin
lowvideo;
write(menu[i]);
if i=1 then i:=n
else i:=i-1;
highvideo;
gotoxy(1,i);
write(menu[i]);
gotoxy(1,i);
end;
#80:{strelka vniz} begin
lowvideo;
write(menu[i]);
if i=n then i:=1
else i:=i+1;
highvideo;
gotoxy(1,i);
write(menu[i]);
gotoxy(1,i);
end;
end;
until (c=#27) or (c=#13);
if c=#13 then mov_men:=i
else mov_men:=0;
end;
end.
