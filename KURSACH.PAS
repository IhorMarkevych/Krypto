program main; 
uses crt,h_menu,chifer2,rsa,cesare, rsakey, alphabet;

const menu1:men=('About','Help','Path to text file','Path to result file','Cipher/decipher', 'Exit');
      menutypes:men=('Help','Viginere','RSA','Caesar','Back','');
      menucipher:men=('Help','Key','Cipher','Decipher', 'Back','');
      menuchoose:men=('Yes','No','Back','','','');
      menugenerate:men=('Help', 'Generate key', 'Input key', 'Back', '','');
var x,y,maxX,maxY,j,h,f,a,g:byte;
          s,patht,pathr,pathk:string;
                            c:char;
                        t,r,k:text;
                            b:boolean;
                p,q,err,d,e,n:integer;
begin
{$I-}
randomize;
e:=0;
d:=0;
n:=0;
patht:='';
pathr:=' ';
pathk:='  ';
maxX:=lo(windmax)+1;
maxY:=hi(windmax)+1;
 textbackground(black);
 window(1,1,maxX,maxY);
 clrscr;
 s:='"Krypto"';
 x:=(maxX-length(s)-2) div 2;
 y:=(maxY-3) div 2;
 ramka(x,y,length(s)+2,2,white,red);
 gotoxy(2,2);
 write(s);
 gotoxy (2,2);
 repeat until keypressed;
 c:=readkey;
repeat
 textbackground(black);
 window (1,1,maxX,maxY);
 clrscr;
 x:=((maxX-sizeof(menu1[4])-2)div 2);
 y:=(maxY-6-2)div 2;
 g:=mov_men(menu1,x,y,6,white,black);
 window(1,1,maxX,maxY);
 clrscr;
 case g of
  1: begin
   s:='This program was created by Igor Markevych, student of KA-51, IASA.';
   x:=(maxX-length(s)-2) div 2;
   y:=(maxY-3) div 2;
   ramka(x,y,length(s)+2,2,white,black);
   gotoxy(2,2);
   write(s);
   repeat until keypressed;
   c:=readkey;
  end;
 2: begin
   s:='"Krypto" allows user to cipher and dechifer text files,';
   x:=(maxX-length(s)-2) div 2;
   y:=(maxY-3) div 2;
   ramka(x,y,length(s)+2,8,white,black);
   gotoxy(2,2);
   write(s);
   gotoxy(maxX,maxY);
   s:='using Vigenere cipher, RSA and Caesar cipher.';
   gotoxy(2,3);
   write(s);
   gotoxy(2,4);
   write ('ATTENTION!');
   gotoxy(2,5);
   write ('You need to input ciphered file');
   gotoxy (2,6);
   write ('in "Path to text file" to decipher it right!');
   gotoxy (2,7);
   write ('You can`t cipher file and just after that choose');
   gotoxy (2,8);
   write ('decipher. "Krypto" won`t decipher it right.');
   repeat until keypressed;
   c:=readkey;
  end;
 3:begin
   repeat
    {textbackground (blue);}
    clrscr;
    {textcolor (white);}
    gotoxy (x,y);
    writeln ('Input path to text file');
    gotoxy (x,y+1);
    writeln ('Example: C:\cipher\text.txt');
    gotoxy (x,y+2);
     write (patht);
    gotoxy (x,y+3);
     readln (s);
    { if (s<>'') and (s<>pathk) and (s<>pathr) then
     patht:=s;}
     b:=true;
    if s<>'' then
    begin
     if (s=pathr) or (s=pathk) then
     begin
      window (1,1,maxX,maxY);
      clrscr;
      gotoxy (x-7,y+3);
      write ('Input different pathes for text, result and key!');
      b:=false;
      repeat until keypressed;
      c:=readkey;
     end
     else
     begin
     {$I-}
     assign (t,s);
     reset (t);
     close (t);
     if ioresult<>0 then
      b:=false;
     if not b then
      begin
       gotoxy (x-5,y+3);
       write ('Seems like a wrong path to file. Try again!');
       readln;
      end
     else
     begin
     if (s<>'') and (b) and (not checktext (t)) then
      begin
       b:=false;
       gotoxy (x-5,y+4);
       s:='Wrong symbols in text file!';
       x:=(maxX-length(s)-2) div 2;
       y:=(maxY-3) div 2;
       window (1,1,maxX,maxY);
       clrscr;
       ramka(x,y,length(s)+2,2,white,red);
       gotoxy (2,2);
       write (s);
       textbackground (black);
       repeat until keypressed;
       c:=readkey;
      end
      else
      patht:=s;
     end;
     end;
    end;
   until b;
   assign (t,patht);
   if patht<>'' then
    txtwrite (t,maxX,maxY);
   end;
 4:begin
   repeat
    {textbackground (blue);}
    clrscr;
    {textcolor (white);}
    gotoxy (x-10,y);
    writeln ('Input path to text file, where result will be writed.');
    gotoxy (x,y+1);
    writeln ('Example: C:\cipher\text.txt');
    gotoxy (x-5,y+2);
    writeln ('File will be overwrited, if it exists,');
    gotoxy (x+2,y+3);
    write ('else it will be created.');
    gotoxy (x-5,y+4);
    write (pathr);
    gotoxy (x-5,y+5);
     readln (s);
   {  if (s<>' ') and (s<>patht) and (s<>pathk) then
      pathr:=s;}
     b:=true;
    if s<>'' then
    begin
     if (patht=s) or (s=pathk) then
     begin
      window (1,1,maxX,maxY);
      clrscr;
      gotoxy (x-7,y+3);
      write ('Input different pathes for text, result and key!');
      b:=false;
      repeat until keypressed;
      c:=readkey;
     end
     else
     begin
     {$I-}
     assign (r,s);
     rewrite (r);
     close (r);
     if ioresult<>0 then
      b:=false;
     if not b then
      begin
       clrscr;
       gotoxy (x-5,y+4);
       write ('Seems like a wrong path to file. Try again!');
       repeat until keypressed;
       c:=readkey;
      end
     else
      pathr:=s;
      end;
    end;
   until b;
   assign (r,pathr);
   end;
 5:begin
   repeat
    window (1,1,maxX,maxY);
    {textbackground (black);}
    clrscr;  
    x:=((maxX-sizeof(menu1[4])-2)div 2);
    y:=(maxY-6-2)div 2;
    f:=mov_men(menutypes,x,y,6,white,black);
     case f of
     1:begin
         window (1,1,maxX,maxY);
         {textbackground (blue);}
         clrscr;
         s:='Choose one of the following types of cipher.';
         x:=(maxX-length(s)-2) div 2;
         y:=(maxY-3) div 2;
         ramka(x,y,length(s)+2,2,white,black);
         gotoxy(2,2);
         write(s);
         repeat until keypressed;
         c:=readkey;
         window (1,1,maxX,maxY);
        { textbackground (blue);}
         clrscr;
       end;                                         
     2: begin    {Viginere}
       repeat
        window (1,1,maxX,maxY);
        clrscr;
        x:=((maxX-sizeof(menu1[4])-2)div 2);
        y:=(maxY-6-2)div 2;
        j:=mov_men(menucipher,x,y,6,white,black);
        window(1,1,maxX,maxY);
        {textbackground(blue);}
        clrscr;
        case j of
         1: begin
          s:='Secret key must be a text file, it is needed to cipher and decipher text.';
          x:=(maxX-length(s)-2) div 2;
          y:=(maxY-3) div 2;
          ramka(x,y,length(s)+2,2,white,black);
          gotoxy(2,2);
          write(s);
          repeat until keypressed;
          c:=readkey;
          window (1,1,maxX,maxY);
          {textbackground (blue);}
          clrscr;
          end;
         2:begin
          repeat
           {textbackground (blue);}
           clrscr;
           {textcolor (white);}
           gotoxy (x+1,y);
           writeln ('Input path to key file.');
           gotoxy (x,y+1);
           writeln ('Example: C:\cipher\text.txt');
           gotoxy (x-7,y+2);
           writeln ('In case of key generation, file will be overwrited,');
           gotoxy (x-3,y+3);
           write ('if it exist, else it will be created.');
           gotoxy (x-5,y+4);
           write (pathk);
           gotoxy (x-5,y+5);
           readln (s);
          { if (s<>'  ') and (s<>pathr) and (s<>patht) then
            pathk:=s;}
           b:=true;
          if s<>'' then
          begin
          if (s=patht) or (pathr=s) then
           begin
            window (1,1,maxX,maxY);
            clrscr;
            gotoxy (x-7,y+3);
            write ('Input different pathes for text, result and key!');
            b:=false;
            repeat until keypressed;
            c:=readkey;
           end
          else
           begin
           {$I-}
           assign (k,s);
           clrscr;
           x:=(maxX-length(s)-2) div 2;
           y:=(maxY-3) div 2;
           ramka(x,1,20+2,2,white,red);
           gotoxy(2,2);
           write('Generate random key?');
	   textbackground (black);
           window (1,1,maxX,maxY);
           h:=mov_men(menuchoose,x,y,2,white,black);
           case h of
            1:begin
               {$I-}
               keygen (k);
               if ioresult <> 0 then
                begin
                 gotoxy (x-5,y+4);
                 write ('Seems like a wrong path to file. Try again!');
                 repeat until keypressed;
                 c:=readkey;
                 clrscr;
                end
               else
                pathk:=s;
              end;
            2:begin
             {$I-}
             reset (k);
             close (k);
             window (1,1,maxX,maxY);
             clrscr;
             if ioresult <> 0 then
              begin
               b:=false;
               gotoxy (x-5,y+4);
               write ('Seems like a wrong path to file. Try again!');
              end;
              reset (k);
              if eof (k) then b:=false;
              close (k);
              if (b) and (checktext (k)) then
              begin
               txtwrite (k,maxX,maxY);
               pathk:=s;
              end;
              assign (k,pathk);
             if (s<>'') and (b) and (not checktext (k)) then
              begin
               b:=false;
               gotoxy (x-5,y+4);
               s:='Wrong symbols in key file!';
               x:=(maxX-length(s)-2) div 2;
               y:=(maxY-3) div 2;
               window (1,1,maxX,maxY);
               clrscr;
               ramka(x,y,length(s)+2,2,white,red);
               gotoxy (2,2);
               write (s);
               textbackground (black);
               repeat until keypressed;
               c:=readkey;
              end;
             end;
            end;
            window (1,1,maxX,maxY);
            clrscr;
           end;
           end;
           until b;
           assign (k,pathk);
           end;
          3:begin
            b:=true;
            reset (t);
            close (t);
            if ioresult<>0 then b:=false;
            if b then
             begin
              reset (k);
              close (k);
              if ioresult <>0 then b:=false;
             end;
             if b then
              begin
               rewrite (r);
               close (r);
               if ioresult <>0 then b:=false;
              end;
           if not b then
            begin
             s:='ERROR! Try to check pathes to files.';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
             gotoxy(2,2);
             write(s);
       	     textbackground (black);
             repeat until keypressed;
             c:=readkey;
             clrscr;
            end
           else
            begin
             chifertext (t,r,k);
             s:='Procedure complete!';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
             gotoxy(2,2);
             write(s);
             textbackground (black);
             repeat until keypressed;
             c:=readkey;
             txtwrite (r,maxX,maxY);
            end;
           end;
         4:begin
            b:=true;
            reset (t);
            close (t);
            if ioresult<>0 then b:=false;
            if b then
             begin
              reset (k);
              close (k);
              if ioresult <>0 then b:=false;
             end;
             if b then
              begin
               rewrite (r);
               close (r);
               if ioresult <>0 then b:=false;
              end;
           if not b then
           begin
            s:='ERROR! Try to check pathes to files.';
            x:=(maxX-length(s)-2) div 2;
            y:=(maxY-3) div 2;
            ramka(x,y,length(s)+2,2,white,red);
            gotoxy(2,2);
            write(s);
	    textbackground (black);
            repeat until keypressed;
            c:=readkey;
           end
           else
            begin
             dechifertext (t,r,k);
             s:='Procedure complete!';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
             gotoxy(2,2);
             write(s);
	     textbackground (black);
             repeat until keypressed;
             c:=readkey;
             txtwrite (r,maxX,maxY);
            end;
          end;
         end;
        until (j=5) or (j=0);
         end;                                                        
    3:begin
        repeat
        window (1,1,maxX,maxY);
        clrscr;
        x:=((maxX-sizeof(menu1[4])-2)div 2);
        y:=(maxY-6-2)div 2;
        j:=mov_men(menucipher,x,y,5,white,black);
        window(1,1,maxX,maxY);
        {textbackground(blue);}
        clrscr;
        case j of
         1: begin
          s:='There are pair of keys. One, which is used to cipher, is not secret.';
          x:=(maxX-length(s)-2) div 2;
          y:=(maxY-3) div 2;
          ramka(x,y,length(s)+2,4,white,black);
          gotoxy(2,2);
          write(s);
          gotoxy(2,3);
          write('The second is needed to decipher text.');
          gotoxy (2,4);
          write ('It must be keeped in secret!');
          repeat until keypressed;
          c:=readkey;
          window (1,1,maxX,maxY);
          {textbackground (blue);}
          clrscr;
          end;
         2: begin
             x:=((maxX-sizeof(menu1[4])-2)div 2);
             y:=(maxY-6-2)div 2;
             a:=mov_men(menugenerate,x,y,3,white,black);
             window(1,1,maxX,maxY);
             {textbackground(blue);}
             clrscr;
             case a of
             1:begin
                s:='Choose "Generate key" to generate pair of keys,';
                x:=(maxX-length(s)-2) div 2;
                y:=(maxY-3) div 2;
                ramka(x,y,length(s)+2,3,white,black);
                gotoxy(2,2);
                write(s);
                gotoxy (2,3);
                write ('"Input key" to input key fully manually.');
                repeat until keypressed;
                c:=readkey;
               end;
             2:begin
               repeat
                repeat
                 repeat
                  {textbackground (blue);}
                  clrscr;
                  {textcolor (white);}
                  gotoxy (x,y);
                  write ('Input two prime positive numbers.');
                  gotoxy (x-5,y+1);
                  write ('Their product must be not less then ', alnum, '.');
                  gotoxy (x,y+2);
                  write ('First:');
                  gotoxy (x,y+3);
                  readln (s);
                  val (s,q,err);
                 until (err=0) and (q>0) and (prostoe(q));
                 gotoxy (x,y+4);
                 write ('Second:');
                 gotoxy (x,y+5);
                 readln (s);
                val (s,p,err);
                until (err=0) and (p>0) and (prostoe(p));
                if p*q<alnum then
                 begin
                  gotoxy (x,y+6);
                  write ('Choose bigger numbers!');
                  repeat until keypressed;
                  c:=readkey;
                 end;
               until p*q>=alnum;
               n:=p*q;
               clrscr;
               s:='Generate random key?';
               x:=(maxX-length(s)-2) div 2;
               y:=(maxY-3) div 2;
               ramka(x,1,length(s)+2,2,white,black);
               gotoxy(2,2);
               write(s);
               h:=mov_men(menuchoose,x,y,2,white,black);
               case h of
                1:begin
                  e:=1+random ((p-1)*(q-1)-1);
                  while evklid (e,(p-1)*(q-1),d)<>1 do
                   begin
                    e:=e+1;
                    if e>=p*q then
                     e:=1+random (p*q-1);
                   end;
                  end;
                2:begin
                  repeat
                   window (1,1,maxX,maxY);
                   clrscr;
                   gotoxy (x-10,y);
                   write ('Input open exponent. It must be less then');
                   gotoxy (x-10,y+1);
                   write ('  ', (p-1)*(q-1), ' and coprime with it.');
                   gotoxy (x-10, y+2);
                   readln (s);
                   val (s,e,err);
                  until (err=0) and (evklid (e,(p-1)*(q-1),d)=1) and (e<(p-1)*(q-1));
                  end;
                end;
            window (1,1,maxX,maxY);
            clrscr;
            if h<>3 then
            begin
            s:='Open key:     ';
            x:=(maxX-length(s)-2) div 2;
            y:=(maxY-3) div 2;
            ramka(x,y,length(s)+2,5,white,red);
            gotoxy(2,2);
            write(s);
            gotoxy (2,3);
            write ('(',e,',',n,')');
            gotoxy (2,4);
            write ('Secret key:   ');
            gotoxy (2,5);
            write ('(',d,',',n,')');
            repeat until keypressed;
            c:=readkey;
            textbackground (black);
            end;
            end;
           3:begin
            repeat
             clrscr;
             gotoxy (x,y);
             write ('Input module');
             gotoxy (x,y+1);
             readln (s);
             val (s,n,err);
            until (err=0) and (n>0);
            repeat
             clrscr;
             gotoxy (x,y+2);
             write ('Input open exponent (to decipher, write any number)');
             gotoxy (x,y+3);
             readln (s);
             val (s,e,err);
            until (err=0) and (e>0);
            repeat
             clrscr;
             gotoxy (x-5,y+2);
             write ('Input secret exponent (to cipher, write any number)');
             gotoxy (x-6,y+3);
             readln (s);
             val (s,d,err);
            until (err=0) and (d>0);
           end;
         end;
         end;
        3:begin
            b:=true;
            reset (t);
            close (t);
            if ioresult<>0 then b:=false;
           if b then
              begin
               rewrite (r);
               close (r);
               if ioresult <>0 then b:=false;
              end;
           if not b then
            begin
             s:='ERROR! Try to check pathes to files.';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
             gotoxy(2,2);
             write(s);
	     textbackground (black);
             repeat until keypressed;
             c:=readkey;
            end
           else
            begin
             if (d=0) or (e=0) or (n=0) then
              begin
               s:='ERROR! Input key!';
               x:=(maxX-length(s)-2) div 2;
               y:=(maxY-3) div 2;
               ramka(x,y,length(s)+2,2,white,red);
               gotoxy(2,2);
               write(s);
       	       textbackground (black);
               repeat until keypressed;
               c:=readkey;
              end
             else
              begin
              chiferrsa(t,r,e,n);
              s:='Procedure complete!';
              x:=(maxX-length(s)-2) div 2;
              y:=(maxY-3) div 2;
              ramka(x,y,length(s)+2,2,white,red);
              gotoxy(2,2);
              write(s);
	      textbackground (black);
              repeat until keypressed;
              c:=readkey;
              txtwrite (r,maxX,maxY);
              end;
            end;
            clrscr;
           end;
         4:begin
            b:=true;
            reset (t);
            close (t);
            if ioresult<>0 then b:=false;
             if b then
              begin
               rewrite (r);
               close (r);
               if ioresult <>0 then b:=false;
              end;
           if not b then
            begin
            s:='ERROR! Try to check pathes to files.';
            x:=(maxX-length(s)-2) div 2;
            y:=(maxY-3) div 2;
            ramka(x,y,length(s)+2,2,white,red);
            gotoxy(2,2);
            write(s);
	    textbackground (black);
            repeat until keypressed;
            c:=readkey;
           end
          else
            begin
             if (d=0) or (e=0) or (n=0) then
              begin
               s:='ERROR! Input key!';
               x:=(maxX-length(s)-2) div 2;
               y:=(maxY-3) div 2;
               ramka(x,y,length(s)+2,2,white,red);
               gotoxy(2,2);
               write(s);
       	       textbackground (black);
               repeat until keypressed;
               c:=readkey;
              end
             else
             begin
              reset (t);
              c:='q';
              while (not eof (t)) and (not (c in ['0'..'9','.'])) do
               begin
                read (t,c);
                if not (c in ['0'..'9', '.']) then
                  begin
                   s:='ERROR! Wrong text format! File must consist of dots and numbers!';
                   x:=(maxX-length(s)-2) div 2;
                   y:=(maxY-3) div 2;
                   ramka(x,y,length(s)+2,2,white,red);
                   gotoxy(2,2);
                   write(s);
                   repeat until keypressed;
                   c:=readkey;
                  end;
               end;
             end;
            end;
            if b then
            begin
             dechiferrsa (t,r,e,n);
             s:='Procedure complete!';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
             gotoxy(2,2);
             write(s);
             repeat until keypressed;
             c:=readkey;
             txtwrite (r,maxX,maxY);
            end;
             textbackground (black);
            clrscr;
          end;
         end;
        until (j=5) or (j=0);
      end;
    4:begin     {CAESER}
       repeat
        x:=((maxX-sizeof(menu1[4])-2)div 2);
        y:=(maxY-6-2)div 2;
        j:=mov_men(menucipher,x,y,6,white,black);
        window(1,1,maxX,maxY);
        {textbackground(blue);}
        clrscr;
        case j of
         1: begin
          s:='Secret key must be a number, it is needed to cipher and decipher text.';
          x:=(maxX-length(s)-2) div 2;
          y:=(maxY-3) div 2;
          ramka(x,y,length(s)+2,2,white,red);
          gotoxy(2,2);
          write(s);
	  textbackground (black);
          repeat until keypressed;
          c:=readkey;
          window (1,1,maxX,maxY);
          {textbackground (blue);}
          clrscr;
          end;
         2:begin
           {textbackground (blue);}
           window (1,1,maxX,maxY);
           clrscr;
           s:='Generate random key?';
           x:=(maxX-length(s)-2) div 2;
           y:=(maxY-3) div 2;
           ramka(x,1,length(s)+2,2,white,red);
           gotoxy(2,2);
           write(s);
	   textbackground (black);
           h:=mov_men(menuchoose,x,y,2,white,black);
           case h of
            1:begin
               e:=random (alnum);
               d:=0;
               n:=0;
              end;
            2:begin
             repeat
              window (1,1,maxX,maxY);
              clrscr;
              gotoxy (x-6,y);
              write ('Input number-key. It must be less then ', alnum, '.');
              gotoxy (x-6,y+1);
              readln (s);
              val (s,e,err);
            until (err=0) and (e<alnum) and (e>0);
              d:=0;
              n:=0;
              window (1,1,maxX,maxY);
              clrscr;
              end;
            end;
            window (1,1,maxX,maxY);
            clrscr;
            if h<>0 then
            begin
            s:='Key:';
            x:=(maxX-length(s)-2) div 2;
            y:=(maxY-3) div 2;
            ramka(x,y,length(s)+6,2,white,red);
            gotoxy(2,2);
            write(s, ' ',e,'.');
	    textbackground (black);
            repeat until keypressed;
            c:=readkey;
            end;
            end;
          3:begin
            window (1,1,maxX,maxY);
            clrscr;
            b:=true;
            reset (t);
            close (t);
            if ioresult<>0 then b:=false;
             if b then
              begin
               rewrite (r);
               close (r);
               if ioresult <>0 then b:=false;
              end;
           if not b then
            begin
             s:='ERROR! Try to check pathes to files.';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
             gotoxy(2,2);
             write(s);
	     textbackground (black);
             repeat until keypressed;
             c:=readkey;
            end
           else
            begin
             if ((e<>0) and ((d=0) or (n=0))) or (e=0) then
              begin
               s:='ERROR! Input key!';
               x:=(maxX-length(s)-2) div 2;
               y:=(maxY-3) div 2;
               ramka(x,y,length(s)+2,2,white,red);
               gotoxy(2,2);
               write(s);
       	       textbackground (black);
               repeat until keypressed;
               c:=readkey;
              end
             else
            begin
             chifertextcesare (t,r,e);
             s:='Procedure complete!';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
	     gotoxy(2,2);
             write(s);
	     textbackground (black);
             repeat until keypressed;
             c:=readkey;
             txtwrite (r,maxX,maxY);
            end;
            end;
            window (1,1,maxX,maxY);
            clrscr;
          end;
         4:begin
            window (1,1,maxX,maxY);
            clrscr;
            b:=true;
            reset (t);
            close (t);
            if ioresult<>0 then b:=false;
            if b then
             begin
              reset (r);
              close (r);
              if ioresult <>0 then b:=false;
             end;
           if not b then
           begin
            s:='ERROR! Try to check pathes to files.';
            x:=(maxX-length(s)-2) div 2;
            y:=(maxY-3) div 2;
            ramka(x,y,length(s)+2,2,white,red);
            gotoxy(2,2);
            write(s);
            repeat until keypressed;
            c:=readkey;
	    textbackground (black);
            window (1,1,maxX,maxY);
            clrscr;
           end
          else
            begin
             if ((e<>0) and ((d=0) or (n=0))) or (e=0) then
              begin
               s:='ERROR! Input key!';
               x:=(maxX-length(s)-2) div 2;
               y:=(maxY-3) div 2;
               ramka(x,y,length(s)+2,2,white,red);
               gotoxy(2,2);
               write(s);
       	       textbackground (black);
               repeat until keypressed;
               c:=readkey;
              end
             else
           begin
             dechifertextcesare (t,r,e);
             s:='Procedure complete!';
             x:=(maxX-length(s)-2) div 2;
             y:=(maxY-3) div 2;
             ramka(x,y,length(s)+2,2,white,red);
             gotoxy(2,2);
             write(s);
	     textbackground (black);
             repeat until keypressed;
             c:=readkey;
             txtwrite (r,maxX,maxY);
            end;
          clrscr;
          end;
         end;
         end;
        until (j=5) or (j=0);
         end;
      end;
   until (f=0) or (f=5);
 end;
 end;
until (g=0) or (g=6);
end.