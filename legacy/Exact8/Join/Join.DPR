program Join;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Join';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
