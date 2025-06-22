unit untBrokerSettings;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  StdCtrls, Spin, BCButton, untSnapMB, untCOMPortList;

const
  ParityChar : array [0..2] of char = ('N','E','O');

type

  TMBDeviceSetting = record
     DeviceID    : byte;
     DataLink    : TMBDataLink;
     NetProto    : TMBNetProto;
     SerFormat   : TMBSerialFormat;
     EthParams   : TMBEthParams;
     SerParams   : TMBSerParams;
     ClrOnCreate : boolean;
     SerialOnEth : boolean;
  end;

  TMBBrokerSetting = record
     BrokerType      : TMBBrokerType;
     CliEthParams    : TMBEthParams; // Only for BrokerType = btNetClient
     CliNetProto     : TMBNetProto;
     SerParams       : TMBSerParams;
     BaseAddressZero : boolean; // First Bit/Register Address is 0 (otherwise it is 1)
     MaxRetries      : integer;
     ClrOnCreate     : boolean;
  end;

  { TfrmBrokerSettings }

  TfrmBrokerSettings = class(TForm)
    btnCancel: TBCButton;
    btnAccept: TBCButton;
    btnBack: TBCButton;
    cbBaudRate: TComboBox;
    cbDataBits: TComboBox;
    cbBrokerType: TComboBox;
    cbFormat: TComboBox;
    cbProtocol: TComboBox;
    cbFlow: TComboBox;
    cbParity: TComboBox;
    cbPort: TComboBox;
    cbStopBits: TComboBox;
    ckBaseAddressZero: TCheckBox;
    ckDisconnectOnError: TCheckBox;
    chkClrResources: TCheckBox;
    edAddress: TEdit;
    edPort: TEdit;
    gbSerial: TGroupBox;
    gbEthernet: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    lblError: TLabel;
    Label12: TLabel;
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
    speRetries: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnAcceptClick(Sender: TObject);
    procedure btnBackClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure cbBrokerTypeCloseUp(Sender: TObject);
    procedure cbProtocolCloseUp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure InitComboBoxes;
    procedure UpdateGroupBoxes;
  public
    function EditSettings(var Settings : TMBBrokerSetting) : boolean;
    function CheckSettings : boolean;
    procedure SettingsToForm(var Settings : TMBBrokerSetting);
    procedure FormToSettings(var Settings : TMBBrokerSetting);
  end;

var
  frmBrokerSettings: TfrmBrokerSettings;

procedure SetDefaults(var Settings : TMBBrokerSetting);

implementation

{$R *.lfm}

procedure SetDefaults(var Settings : TMBBrokerSetting);
begin
  Settings.BrokerType:=btNetClient;
  Settings.CliEthParams.Address:='127.0.0.1';
  Settings.CliEthParams.Port:=502;
  Settings.CliEthParams.DisOnError:=true;
  Settings.CliNetProto:=mbTCP;
  Settings.SerParams.Port:='COM1';
  Settings.SerParams.BaudRate:=19200;
  Settings.SerParams.Parity:='E';
  Settings.SerParams.DataBits:=8;
  Settings.SerParams.StopBits:=1;
  Settings.SerParams.Flow:=flowNone;
  Settings.SerParams.Format:=sfRTU;
  Settings.MaxRetries:=2;
  Settings.BaseAddressZero:=false;
  Settings.ClrOnCreate:=false;
end;

{ TfrmBrokerSettings }

procedure TfrmBrokerSettings.btnAcceptClick(Sender: TObject);
begin
  if CheckSettings then
    ModalResult:=mrOK;
end;

procedure TfrmBrokerSettings.btnBackClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TfrmBrokerSettings.btnCancelClick(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TfrmBrokerSettings.cbBrokerTypeCloseUp(Sender: TObject);
begin
  UpdateGroupBoxes;
end;

procedure TfrmBrokerSettings.cbProtocolCloseUp(Sender: TObject);
begin
  ckDisconnectOnError.Visible:=cbProtocol.ItemIndex in [0,2];
end;

procedure TfrmBrokerSettings.FormCreate(Sender: TObject);
begin
  InitComboBoxes;
end;

procedure TfrmBrokerSettings.FormShow(Sender: TObject);
begin
  lblError.Caption:='';
  Position:=poScreenCenter;
  PC.ActivePageIndex:=0;
end;

procedure TfrmBrokerSettings.InitComboBoxes;
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  cbPort.Items.Clear;
  GetCOMPorts(sl);
  cbPort.Items.AddStrings(sl);
  cbPort.ItemIndex:=0;
  sl.Free;
end;

procedure TfrmBrokerSettings.UpdateGroupBoxes;
begin
  if cbBrokerType.ItemIndex = 0 then
  begin
    gbSerial.Visible:=false;
    gbEthernet.Visible:=true;
  end
  else begin
    gbEthernet.Visible:=false;
    gbSerial.Visible:=true;
  end;
end;

function TfrmBrokerSettings.EditSettings(var Settings: TMBBrokerSetting): boolean;
begin
  SettingsToForm(Settings);
  if ShowModal = mrOk then
  begin
    FormToSettings(Settings);
    Result:=true;
  end
  else
    Result:=false;
end;

function TfrmBrokerSettings.CheckSettings: boolean;
var
  port : integer;
  deviceid : integer;
begin
  Result:=false;
  if cbBrokerType.ItemIndex = -1 then
  begin
    lblError.Caption:='Invalid Broker Type';
    exit;
  end;
  if trim(edAddress.Text) = '' then
  begin
    lblError.Caption:='Invalid IP Address';
    exit;
  end;
  port := StrToIntDef(edPort.Text, -1);
  if (port < 1) or (port > $FFFF) then
  begin
    lblError.Caption:='Invalid IP Port (see Ethernet settings)';
    exit;
  end;
  if cbProtocol.ItemIndex = -1 then
  begin
    lblError.Caption:='Invalid Protocol (see Ethernet settings)';
    exit;
  end;
  if (cbPort.ItemIndex=-1) or
     (cbBaudRate.ItemIndex=-1) or
     (cbParity.ItemIndex=-1) or
     (cbDataBits.ItemIndex=-1) or
     (cbStopBits.ItemIndex=-1) or
     (cbFlow.ItemIndex=-1) then
  begin
    lblError.Caption:='Invalid Serial settings';
    exit;
  end;
  Result:=true;
end;

procedure TfrmBrokerSettings.SettingsToForm(var Settings: TMBBrokerSetting);
var
  ch : char;
begin
  cbBrokerType.ItemIndex:=ord(Settings.BrokerType);
  // Ethernet
  edAddress.Text:=Settings.CliEthParams.Address;
  edPort.Text:=IntToStr(Settings.CliEthParams.Port);
  cbProtocol.ItemIndex:=ord(Settings.CliNetProto);
  ckDisconnectOnError.Checked:=Settings.CliEthParams.DisOnError;
  ckDisconnectOnError.Visible:=cbProtocol.ItemIndex in [0,2];
  // Serial
  cbPort.ItemIndex:=cbPort.Items.IndexOf(Settings.SerParams.Port);
  cbBaudRate.ItemIndex:=cbBaudRate.Items.IndexOf(IntToStr(Settings.SerParams.BaudRate));

  ch:=UpCase(Settings.SerParams.Parity);
  if ch='N' then cbParity.ItemIndex:=0 else
  if ch='E' then cbParity.ItemIndex:=1 else
  if ch='O' then cbParity.ItemIndex:=2 else
    cbParity.ItemIndex:=0;

  cbDataBits.ItemIndex:=cbDataBits.Items.IndexOf(IntToStr(Settings.SerParams.DataBits));
  cbStopBits.ItemIndex:=cbStopBits.Items.IndexOf(IntToStr(Settings.SerParams.StopBits));
  cbFlow.ItemIndex:=ord(Settings.SerParams.Flow);
  cbFormat.ItemIndex:=ord(Settings.SerParams.Format);

  ckBaseAddressZero.Checked:=Settings.BaseAddressZero;

  speRetries.Value:=Settings.MaxRetries;

  chkClrResources.Checked:=Settings.ClrOnCreate;
  UpdateGroupBoxes;
end;

procedure TfrmBrokerSettings.FormToSettings(var Settings: TMBBrokerSetting);
begin
  Settings.BrokerType:=TMBBrokerType(cbBrokerType.ItemIndex);
  // Ethernet
  Settings.CliEthParams.Address:=edAddress.Text;
  Settings.CliEthParams.Port:=StrToIntDef(edPort.Text, 502);
  Settings.CliNetProto:=TMBNetProto(cbProtocol.ItemIndex);
  Settings.CliEthParams.DisOnError:=ckDisconnectOnError.Checked;
  // Serial
  Settings.SerParams.Port:=cbPort.Text;
  Settings.SerParams.BaudRate:=StrToIntDef(cbBaudRate.Text,19200);
  Settings.SerParams.Parity:=ParityChar[cbParity.ItemIndex];
  Settings.SerParams.DataBits:=StrToIntDef(cbDataBits.Text,8);
  Settings.SerParams.StopBits:=StrToIntDef(cbStopBits.Text,1);
  Settings.SerParams.Flow:=TMBSerialFlow(cbFlow.ItemIndex);
  Settings.SerParams.Format:=TMBSerialFormat(cbFormat.ItemIndex);

  Settings.BaseAddressZero:=ckBaseAddressZero.Checked;
  // Common
  Settings.MaxRetries:=speRetries.Value;
  Settings.ClrOnCreate:=chkClrResources.Checked;
end;

end.

