unit untDeviceSettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Spin, BCButton, untSnapMB, untCOMPortList;

const
  ParityChar: array [0..2] of char = ('N', 'E', 'O');


type

  TMBDeviceSetting = record
    DeviceID: byte;
    DataLink: TMBDataLink;
    NetProto: TMBNetProto;
    SerFormat: TMBSerialFormat;
    SerIframe: integer;
    EthParams: TMBEthParams;
    SerParams: TMBSerParams;
    ClrOnCreate: boolean;
    SerialOnEth: boolean;
  end;

  { TfrmSettings }

  TfrmSettings = class(TForm)
    btnCancel: TBCButton;
    btnAccept: TBCButton;
    btnBack: TBCButton;
    cbBaudRate: TComboBox;
    cbDataBits: TComboBox;
    cbDataLink: TComboBox;
    cbProtocol: TComboBox;
    cbFlow: TComboBox;
    cbParity: TComboBox;
    cbPort: TComboBox;
    cbFormat: TComboBox;
    cbStopBits: TComboBox;
    chkClrResources: TCheckBox;
    chkSerialOnEth: TCheckBox;
    edAddress: TEdit;
    edIFrame: TEdit;
    edPort: TEdit;
    edDisTimeout: TEdit;
    gbSerial: TGroupBox;
    gbEthernet: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    lblError: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PC: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    pnlDrop: TPanel;
    seDeviceID: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnAcceptClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbDataLinkCloseUp(Sender: TObject);
    procedure cbProtocolCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure InitComboBoxes;
    procedure UpdateGroupBoxes;
  public
    function EditSettings(var Settings: TMBDeviceSetting): boolean;
    function CheckSettings: boolean;
    procedure SettingsToForm(var Settings: TMBDeviceSetting);
    procedure FormToSettings(var Settings: TMBDeviceSetting);
  end;

var
  frmSettings: TfrmSettings;

procedure SetDefaults(var Settings: TMBDeviceSetting);

implementation

{$R *.lfm}

procedure SetDefaults(var Settings: TMBDeviceSetting);
begin
  Settings.DataLink := dlEthernet;
  Settings.DeviceID := 1;
  Settings.EthParams.Address := '127.0.0.1';
  Settings.EthParams.Port := 502;
  Settings.EthParams.DisTimeout := 0;
  Settings.NetProto := mbTCP;
  Settings.SerParams.Port := 'COM1';
  Settings.SerParams.BaudRate := 19200;
  Settings.SerParams.Parity := 'E';
  Settings.SerParams.DataBits := 8;
  Settings.SerParams.StopBits := 1;
  Settings.SerParams.Flow := flowNone;
  Settings.SerFormat := sfRTU;
  Settings.SerIframe := 50;
  Settings.ClrOnCreate := False;
  Settings.SerialOnEth := True;
end;

{ TfrmSettings }

procedure TfrmSettings.btnAcceptClick(Sender: TObject);
begin
  if CheckSettings then
    ModalResult := mrOk;
end;

procedure TfrmSettings.btnBackClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmSettings.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmSettings.cbDataLinkCloseUp(Sender: TObject);
begin
  UpdateGroupBoxes;
end;

procedure TfrmSettings.cbProtocolCloseUp(Sender: TObject);
begin
  pnlDrop.Visible := cbProtocol.ItemIndex in [0, 2];
end;

procedure TfrmSettings.FormCreate(Sender: TObject);
begin
  InitComboBoxes;
end;

procedure TfrmSettings.FormShow(Sender: TObject);
begin
  lblError.Caption := '';
  Position := poScreenCenter;
  PC.ActivePageIndex := 0;
end;

procedure TfrmSettings.InitComboBoxes;
var
  sl: TStringList;
begin
  seDeviceID.MinValue := 1;
  seDeviceID.MaxValue := 255;
  seDeviceID.Value := 1;
  sl := TStringList.Create;
  cbPort.Items.Clear;
  GetCOMPorts(sl);
  cbPort.Items.AddStrings(sl);
  cbPort.ItemIndex:=0;
  sl.Free;
end;

procedure TfrmSettings.UpdateGroupBoxes;
begin
  if cbDataLink.ItemIndex = 0 then
  begin
    gbSerial.Visible := False;
    gbEthernet.Visible := True;
  end
  else
  begin
    gbEthernet.Visible := False;
    gbSerial.Visible := True;
  end;
end;

function TfrmSettings.EditSettings(var Settings: TMBDeviceSetting): boolean;
begin
  SettingsToForm(Settings);
  if ShowModal = mrOk then
  begin
    FormToSettings(Settings);
    Result := True;
  end
  else
    Result := False;
end;

function TfrmSettings.CheckSettings: boolean;
var
  port: integer;
begin
  //ToDo better check for IP etc.
  Result := False;
  if cbDataLink.ItemIndex = 0 then
  begin
    if trim(edAddress.Text) = '' then
    begin
      lblError.Caption := 'Invalid IP Address';
      exit;
    end;
    port := StrToIntDef(edPort.Text, -1);
    if (port < 1) or (port > $FFFF) then
    begin
      lblError.Caption := 'Invalid IP Port (see Ethernet settings)';
      exit;
    end;
    if cbProtocol.ItemIndex = -1 then
    begin
      lblError.Caption := 'Invalid Protocol (see Ethernet settings)';
      exit;
    end;
  end;
  if cbDataLink.ItemIndex = 1 then
  begin
    if (cbPort.ItemIndex = -1) or (cbBaudRate.ItemIndex = -1) or
      (cbParity.ItemIndex = -1) or (cbDataBits.ItemIndex = -1) or
      (cbStopBits.ItemIndex = -1) or (cbFlow.ItemIndex = -1) or
      (cbFormat.ItemIndex = -1) then
    begin
      lblError.Caption := 'Invalid Serial settings';
      exit;
    end;
  end;
  Result := True;
end;

procedure TfrmSettings.SettingsToForm(var Settings: TMBDeviceSetting);
var
  ch: char;
begin
  seDeviceID.Value := Settings.DeviceID;
  cbDataLink.ItemIndex := Ord(Settings.DataLink);
  // Ethernet
  edAddress.Text := Settings.EthParams.Address;
  edPort.Text := IntToStr(Settings.EthParams.Port);
  cbProtocol.ItemIndex := Ord(Settings.NetProto);
  edDisTimeout.Text := IntToStr(Settings.EthParams.DisTimeout);
  // Serial
  cbPort.ItemIndex := cbPort.Items.IndexOf(Settings.SerParams.Port);
  cbBaudRate.ItemIndex := cbBaudRate.Items.IndexOf(
    IntToStr(Settings.SerParams.BaudRate));
  edIFrame.Text := IntToStr(Settings.SerIframe);

  ch := UpCase(Settings.SerParams.Parity);
  if ch = 'N' then cbParity.ItemIndex := 0
  else
  if ch = 'E' then cbParity.ItemIndex := 1
  else
  if ch = 'O' then cbParity.ItemIndex := 2
  else
    cbParity.ItemIndex := 0;

  cbDataBits.ItemIndex := cbDataBits.Items.IndexOf(
    IntToStr(Settings.SerParams.DataBits));
  cbStopBits.ItemIndex := cbStopBits.Items.IndexOf(
    IntToStr(Settings.SerParams.StopBits));
  cbFlow.ItemIndex := Ord(Settings.SerParams.Flow);
  cbFormat.ItemIndex := Ord(Settings.SerFormat);
  pnlDrop.Visible := Settings.NetProto in [mbTCP, mbRTUOverTCP];

  chkClrResources.Checked := Settings.ClrOnCreate;
  chkSerialOnEth.Checked := Settings.SerialOnEth;

  UpdateGroupBoxes;
end;

procedure TfrmSettings.FormToSettings(var Settings: TMBDeviceSetting);
begin
  Settings.DeviceID := seDeviceID.Value;
  Settings.DataLink := TMBDataLink(cbDataLink.ItemIndex);
  // Ethernet
  Settings.EthParams.Address := edAddress.Text;
  Settings.EthParams.Port := StrToIntDef(edPort.Text, 502);
  Settings.EthParams.DisTimeout := StrToIntDef(edDisTimeout.Text, 0);
  Settings.NetProto := TMBNetProto(cbProtocol.ItemIndex);
  // Serial
  Settings.SerParams.Port := cbPort.Text;
  Settings.SerParams.BaudRate := StrToIntDef(cbBaudRate.Text, 19200);
  Settings.SerParams.Parity := ParityChar[cbParity.ItemIndex];
  Settings.SerParams.DataBits := StrToIntDef(cbDataBits.Text, 8);
  Settings.SerParams.StopBits := StrToIntDef(cbStopBits.Text, 1);
  Settings.SerParams.Flow := TMBSerialFlow(cbFlow.ItemIndex);
  Settings.SerFormat := TMBSerialFormat(cbFormat.ItemIndex);
  Settings.SerIframe := StrToIntDef(edIFrame.Text, 20);
  Settings.ClrOnCreate := chkClrResources.Checked;
  Settings.SerialOnEth := chkSerialOnEth.Checked;
end;

end.
