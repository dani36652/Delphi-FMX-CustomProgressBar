program CustomProgressBar;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain in 'UMain.pas' {MainForm},
  UCustomProgressBar in 'UCustomProgressBar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
