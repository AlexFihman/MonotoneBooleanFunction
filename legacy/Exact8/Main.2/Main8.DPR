program Main8;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Exact8';
  Application.CreateForm(TForm1, Form1);
  Application.ProcessMessages;
  Form1.Prepare;
  Application.Run;
end.
