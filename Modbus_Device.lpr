program Modbus_Device;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, untDeviceMain, untDeviceSettings,
  untVisibilityDialog
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMainDevice, frmMainDevice);
  Application.CreateForm(TfrmSettings, frmSettings);
  Application.CreateForm(TdlgVisibility, dlgVisibility);
  Application.Run;
end.

