program Prepare;
{$apptype console}

uses
  SysUtils,Math,Unit2 in 'Unit2.pas';

{$R *.RES}
var i,j,k,l,s: integer;
begin
  InitArrays;
  repeat
      {repeat
        i:=random(max2+1);
        j:=random(max2+1);
      until c5(i,j);}
      i:=3;j:=3;
      s:=0;
      for k:=0 to i do if c5(k,i) then
        //writeln(j,' ',k,' ',NFL5[FFF5[FL4[D5[j,0],D5[k,0]],FL4[D5[j,1],D5[k,1]]]]);
        s:=s+NFL5[FFF5[FL4[D5[j,0],D5[k,0]],FL4[D5[j,1],D5[k,1]]]];
      writeln(s);
      s:=0;
      for k:=0 to i do if c5(k,i) then
        for l:=k to j do if c5(k,l) and c5(l,j) then inc(s);
      writeln(s);
      writeln(i,' ',j);
      readln(i);
  until i=-1;
end.
