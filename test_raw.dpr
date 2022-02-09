program test_raw;

uses
  System.StartUpCopy,
  FMX.Forms,
  Unit3 in 'Unit3.pas' {Form3},
  libraw_types in 'libraw_types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
