unit untBrokerMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, ComCtrls, Grids, SynEdit, SynHighlighterIni, LMessages, LCLIntf,
  Menus, SynHighlighterHTML, SynHighlighterAny, untSnapMBCommon,
  BCButton, BGRAImageList, BCPanel, BCComboBox, BCListBox, untSnapMB, Types,
  untBrokerSettings, IniFiles, LazFileUtils, untVisibilityDialog;

const
  WM_EXECUTE_FUN = LM_USER + $101;

type

  TFunDescriptor = record
    Name: string;
    Info: string;
    EdLabels: array[1..5] of string;
    EdEnable: array[1..5] of boolean;
  end;


  { TfrmMain }

  TfrmMain = class(TForm)
    BCPanel18: TBCPanel;
    btnClients: TBCButton;
    btnFunction: TBCButton;
    BCPanel1: TBCPanel;
    btnClearHistory: TBCButton;
    btnOpen: TBCButton;
    btnSave: TBCButton;
    FunExecuted: TSynEdit;
    edUsrFunction: TEdit;
    gridPDUOut: TStringGrid;
    gridPDUIn: TStringGrid;
    mniSetVisibleAddresses: TMenuItem;
    OpenDialog1: TOpenDialog;
    PDUOutItemIndex: TBCPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel5: TPanel;
    PopupMenu1: TPopupMenu;
    SaveDialog1: TSaveDialog;
    SpecialFunDump: TSynEdit;
    FunPanel_1: TBCPanel;
    FunPanel_3: TBCPanel;
    FunPanel_4: TBCPanel;
    FunPanel_2: TBCPanel;
    FunPanel_5: TBCPanel;
    BCPanel15: TBCPanel;
    BCPanel16: TBCPanel;
    BCPanel17: TBCPanel;
    BCPanel2: TBCPanel;
    BGRAImageList1: TBGRAImageList;
    btnClearDump: TBCButton;
    btnConnection: TBCButton;
    btnIncreaseFill: TBCButton;
    btnProperties: TBCButton;
    btnRandomFillAll: TBCButton;
    btnRandomFillArea: TBCButton;
    btnZeroAll: TBCButton;
    btnClrPDUs: TBCButton;
    btnZeroArea: TBCButton;
    cbFormat: TBCComboBox;
    cbFormatPDU: TBCComboBox;
    cbDeviceID: TBCComboBox;
    cbFunction: TBCComboBox;
    Dump: TSynEdit;
    edRDAddress: TEdit;
    edRDAmount: TEdit;
    edValue: TEdit;
    edWRAddress: TEdit;
    edWRAmount: TEdit;
    gridCoils: TStringGrid;
    gridDiscrete: TStringGrid;
    gridHoldingRegs: TStringGrid;
    gridInputRegs: TStringGrid;
    ImageList1: TImageList;
    ItemIndex: TBCPanel;
    ItemIndex1: TBCPanel;
    Label1: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblFunInfo: TLabel;
    lblConnection: TLabel;
    lblDataLink: TLabel;
    lblDataLink1: TLabel;
    lblBrokerType: TLabel;
    Bus: TLabel;
    lblDeviceIDLabel: TLabel;
    lblFlavour: TLabel;
    lblFlavourLabel: TLabel;
    lblLinkName: TLabel;
    lblLinkNameLabel: TLabel;
    lblLinkNameLabel1: TLabel;
    lblParams: TLabel;
    lblParamsLabel: TLabel;
    Panel10: TPanel;
    PC: TPageControl;
    Panel1: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    PCGrids: TPageControl;
    pnlChannel: TBCPanel;
    pnlNetController: TBCPanel;
    pnlConnection: TBCPanel;
    pnlDataLink: TBCPanel;
    SB: TStatusBar;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    SynIniSyn1: TSynIniSyn;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    timLog: TTimer;
    procedure btnClearDumpClick(Sender: TObject);
    procedure btnClearHistoryClick(Sender: TObject);
    procedure btnClrPDUsClick(Sender: TObject);
    procedure btnConnectionClick(Sender: TObject);
    procedure btnFunctionClick(Sender: TObject);
    procedure btnIncreaseFillClick(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure btnPropertiesClick(Sender: TObject);
    procedure btnRandomFillAllClick(Sender: TObject);
    procedure btnRandomFillAreaClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnZeroAllClick(Sender: TObject);
    procedure btnZeroAreaClick(Sender: TObject);
    procedure cbDeviceIDChange(Sender: TObject);
    procedure cbFormatChange(Sender: TObject);
    procedure cbFunctionChange(Sender: TObject);
    procedure FillAreaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure gridCoilsDblClick(Sender: TObject);
    procedure gridCoilsDrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure gridCoilsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure gridBitsSelectCell(Sender: TObject; aCol, aRow: integer;
      var CanSelect: boolean);
    procedure gridDiscreteDblClick(Sender: TObject);
    procedure gridDiscreteDrawCell(Sender: TObject; aCol, aRow: integer;
      aRect: TRect; aState: TGridDrawState);
    procedure gridDiscreteKeyDown(Sender: TObject; var Key: word;
      Shift: TShiftState);
    procedure gridHoldingRegsValidateEntry(Sender: TObject;
      aCol, aRow: integer; const OldValue: string; var NewValue: string);
    procedure gridInputRegsValidateEntry(Sender: TObject; aCol, aRow: integer;
      const OldValue: string; var NewValue: string);
    procedure gridPDUOutSelectCell(Sender: TObject; aCol, aRow: integer;
      var CanSelect: boolean);
    procedure GridRegsSelectCell(Sender: TObject; aCol, aRow: integer;
      var CanSelect: boolean);
    procedure mniSetVisibleAddressesClick(Sender: TObject);
    procedure PCGridsChange(Sender: TObject);
  private
    Fun: array[0..19] of TFunDescriptor;
    FunPanels: array[1..5] of TBCPanel;
    FunEdits: array[1..5] of TEdit;
    FConnected: boolean;
    doClearDump: boolean;
    WasConnected: boolean;
    Settings: TMBBrokerSetting;
    Broker: TSnapMBBroker;
    procedure ActionInfo(funidx: integer);
    procedure InitControls;
    procedure InitFunctions;
    procedure SetFConnected(AValue: boolean);
    procedure UpdateSettingsPanels;
    procedure UpdateEdits;
    procedure BrokerChangeTo;
    procedure BrokerDestroy;
    function WordOf(Edit: TEdit): word;
    procedure DumpIOData(var IOBuffer: TIOBuffer);
    procedure ClrPDUOut;
    procedure ClrPDUIn;
    function funReadCoils(DeviceID: byte): integer;
    function funReadDiscreteInputs(DeviceID: byte): integer;
    function funReadInputRegisters(DeviceID: byte): integer;
    function funReadHoldingRegisters(DeviceID: byte): integer;
    function funWriteSingleCoil(DeviceID: byte): integer;
    function funWriteSingleRegister(DeviceID: byte): integer;
    function funWriteMultipleCoils(DeviceID: byte): integer;
    function funWriteMultipleRegisters(DeviceID: byte): integer;
    function funMaskWriteRegisters(DeviceID: byte): integer;
    function funReadWriteMultipleRegisters(DeviceID: byte): integer;
    function funReadFileRecord(DeviceID: byte): integer;
    function funWriteFileRecord(DeviceID: byte): integer;
    function funReadExceptionStatus(DeviceID: byte): integer;
    function funDiagnostics(DeviceID: byte): integer;
    function funGetCommEventCounter(DeviceID: byte): integer;
    function funGetCommEventLog(DeviceID: byte): integer;
    function funReportServerID(DeviceID: byte): integer;
    function funReadFIFOQueue(DeviceID: byte): integer;
    function funEncapsulatedInterfaceTransport(DeviceID: byte): integer;
    function funUserFunction(DeviceID: byte): integer;
  public
    procedure WmExecuteFun(var Msg: TLMessage) message WM_EXECUTE_FUN;
    property Connected: boolean read FConnected write SetFConnected;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }


procedure TfrmMain.btnZeroAllClick(Sender: TObject);
begin
  case PCGrids.ActivePageIndex of
    0: begin
      fillchar(Coils, SizeOf(Coils), #0);
      gridCoils.Invalidate;
    end;
    1: begin
      fillchar(DiscreteInputs, SizeOf(DiscreteInputs), #0);
      gridDiscrete.Invalidate;
    end;
    2: begin
      fillchar(InputRegisters, SizeOf(InputRegisters), #0);
      InvalidateRegGrid(gridInputRegs, InputRegisters);
    end;
    3: begin
      fillchar(HoldingRegisters, SizeOf(HoldingRegisters), #0);
      InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
    end;
  end;
end;

procedure TfrmMain.btnRandomFillAreaClick(Sender: TObject);
var
  c: integer;
begin
  case PCGrids.ActivePageIndex of
    0: begin
      for c := 0 to bits_amount - 1 do
        Coils[c] := boolean(random(4) div 2);
      gridCoils.Invalidate;
    end;
    1: begin
      for c := 0 to bits_amount - 1 do
        DiscreteInputs[c] := boolean(random(4) div 2);
      gridDiscrete.Invalidate;
    end;
    2: begin
      for c := 0 to regs_amount - 1 do
        InputRegisters[c] := random(65535);
      InvalidateRegGrid(gridInputRegs, InputRegisters);
    end;
    3: begin
      for c := 0 to regs_amount - 1 do
        HoldingRegisters[c] := random(65535);
      InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
    end;
  end;
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
var
  Ini: TIniFile;
  projName: string;
  ms: TMemoryStream;
  i: integer;
begin
  gridCoils.SaveOptions := [soDesign];
  gridDiscrete.SaveOptions := [soDesign];
  gridInputRegs.SaveOptions := [soDesign];
  gridHoldingRegs.SaveOptions := [soDesign];

  if SaveDialog1.Execute then
  begin
    projName := ExtractFileNameWithoutExt(SaveDialog1.FileName);

    Ini := TIniFile.Create(ProjName + '.mbset');
    Ini.WriteInteger('Settings', 'DataLink', Ord(Settings.BrokerType));
    Ini.WriteBool('Settings', 'ClearOnCreate', Settings.ClrOnCreate);
    Ini.WriteBool('Settings', 'BaseAddressZero', Settings.BaseAddressZero);
    Ini.WriteInteger('Settings', 'MaxRetries', Settings.MaxRetries);

    Ini.WriteString('Ethernet', 'Address', Settings.CliEthParams.Address);
    Ini.WriteInteger('Ethernet', 'Port', Settings.CliEthParams.Port);
    Ini.WriteInteger('Ethernet', 'Protocol', Ord(Settings.CliNetProto));
    Ini.WriteInteger('Ethernet', 'Timeout', Settings.CliEthParams.DisTimeout);
    Ini.WriteBool('Ethernet', 'DisconnectOnError', Settings.CliEthParams.DisOnError);

    Ini.WriteString('Serial', 'Port', Settings.SerParams.Port);
    Ini.WriteInteger('Serial', 'Baudrate', Settings.SerParams.BaudRate);
    Ini.WriteString('Serial', 'Parity', Settings.SerParams.Parity);
    Ini.WriteInteger('Serial', 'Databits', Settings.SerParams.DataBits);
    Ini.WriteInteger('Serial', 'Stopbits', Settings.SerParams.StopBits);
    Ini.WriteInteger('Serial', 'Flow', Ord(Settings.SerParams.Flow));
    Ini.WriteInteger('Serial', 'Format', Ord(Settings.SerParams.Format));

    Ini.Free;

    gridCoils.SaveToFile(projName + '.coils.xml');
    gridDiscrete.SaveToFile(projName + '.discrete.xml');
    gridInputRegs.SaveToFile(projName + '.input.xml');
    gridHoldingRegs.SaveToFile(projName + '.holding.xml');

    ms := TMemoryStream.Create;
    for i := Low(Coils) to High(Coils) do
    begin
      if Coils[i] = True then ms.WriteByte(1)
      else
        ms.WriteByte(0);
    end;
    for i := Low(DiscreteInputs) to High(DiscreteInputs) do
    begin
      if DiscreteInputs[i] = True then ms.WriteByte(1)
      else
        ms.WriteByte(0);
    end;
    for i := Low(InputRegisters) to High(InputRegisters) do
    begin
      ms.WriteWord(InputRegisters[i]);
    end;
    for i := Low(HoldingRegisters) to High(HoldingRegisters) do
    begin
      ms.WriteWord(HoldingRegisters[i]);
    end;
    ms.SaveToFile(projName + '.bin');
    ms.Free;
  end;
end;

procedure TfrmMain.btnRandomFillAllClick(Sender: TObject);
var
  c: integer;
begin
  case PCGrids.ActivePageIndex of
    0: begin
      for c := 0 to bits_amount - 1 do
        Coils[c] := boolean(random(4) div 2);
      gridCoils.Invalidate;
    end;
    1: begin
      for c := 0 to bits_amount - 1 do
        DiscreteInputs[c] := boolean(random(4) div 2);
      gridDiscrete.Invalidate;
    end;
    2: begin
      for c := 0 to regs_amount - 1 do
        InputRegisters[c] := random(65535);
      InvalidateRegGrid(gridInputRegs, InputRegisters);
    end;
    3: begin
      for c := 0 to regs_amount - 1 do
        HoldingRegisters[c] := random(65535);
      InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
    end;
  end;
end;

procedure TfrmMain.btnIncreaseFillClick(Sender: TObject);
var
  c: integer;
begin
  case PCGrids.ActivePageIndex of
    0: ;
    1: ;
    2: begin
      for c := 0 to regs_amount - 1 do
        InputRegisters[c] := c;
      InvalidateRegGrid(gridInputRegs, InputRegisters);
    end;
    3: begin
      for c := 0 to regs_amount - 1 do
        HoldingRegisters[c] := c;
      InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
    end;
  end;
end;

procedure TfrmMain.btnOpenClick(Sender: TObject);
var
  Ini: TIniFile;
  projName: string;
  ms: TMemoryStream;
  i: integer;
begin
  gridCoils.SaveOptions := [soDesign];
  gridDiscrete.SaveOptions := [soDesign];
  gridInputRegs.SaveOptions := [soDesign];
  gridHoldingRegs.SaveOptions := [soDesign];

  if OpenDialog1.Execute then
  begin
    projName := ExtractFileNameWithoutExt(OpenDialog1.FileName);

    Ini := TIniFile.Create(ProjName + '.mbset');

    Settings.BrokerType := TMBBrokerType(Ini.ReadInteger('Settings', 'DataLink', 0));
    Settings.ClrOnCreate := Ini.ReadBool('Settings', 'ClearOnCreate', False);
    Settings.BaseAddressZero := Ini.ReadBool('Settings', 'BaseAddressZero', False);
    Settings.MaxRetries := Ini.ReadInteger('Settings', 'MaxRetries', 2);

    Settings.CliEthParams.Address := Ini.ReadString('Ethernet', 'Address', '127.0.0.1');
    Settings.CliEthParams.Port := Ini.ReadInteger('Ethernet', 'Port', 502);
    Settings.CliNetProto := TMBNetProto(Ini.ReadInteger('Ethernet', 'Protocol', 0));
    Settings.CliEthParams.DisTimeout := Ini.ReadInteger('Ethernet', 'Timeout', 0);
    Settings.CliEthParams.DisOnError :=
      Ini.ReadBool('Ethernet', 'DisconnectOnError', False);

    Settings.SerParams.Port := Ini.ReadString('Serial', 'Port', 'COM1');
    Settings.SerParams.BaudRate := Ini.ReadInteger('Serial', 'Baudrate', 19200);
    Settings.SerParams.Parity := Ini.ReadString('Serial', 'Parity', 'E')[1];
    Settings.SerParams.DataBits := Ini.ReadInteger('Serial', 'Databits', 8);
    Settings.SerParams.StopBits := Ini.ReadInteger('Serial', 'Stopbits', 1);
    Settings.SerParams.Flow := TMBSerialFlow(Ini.ReadInteger('Serial', 'Flow', 0));
    Settings.SerParams.Format := TMBSerialFormat(Ini.ReadInteger('Serial', 'Format', 0));

    Ini.Free;

    if FileExists(projName + '.coils.xml') then
      gridCoils.LoadFromFile(projName + '.coils.xml');
    if FileExists(projName + '.discrete.xml') then
      gridDiscrete.LoadFromFile(projName + '.discrete.xml');
    if FileExists(projName + '.input.xml') then
      gridInputRegs.LoadFromFile(projName + '.input.xml');
    if FileExists(projName + '.holding.xml') then
      gridHoldingRegs.LoadFromFile(projName + '.holding.xml');

    InitControls; // fill fixed row numbers

    if FileExists(projName + '.bin') then
    begin
      ms := TMemoryStream.Create;
      ms.LoadFromFile(projName + '.bin');
      for i := Low(Coils) to High(Coils) do
      begin
        if ms.ReadByte = 1 then Coils[i] := True
        else
          Coils[i] := False;
      end;
      for i := Low(DiscreteInputs) to High(DiscreteInputs) do
      begin
        if ms.ReadByte = 1 then DiscreteInputs[i] := True
        else
          DiscreteInputs[i] := False;
      end;
      for i := Low(InputRegisters) to High(InputRegisters) do
      begin
        InputRegisters[i] := ms.ReadWord;
      end;
      for i := Low(HoldingRegisters) to High(HoldingRegisters) do
      begin
        HoldingRegisters[i] := ms.ReadWord;
      end;
      ms.Free;
    end;
    gridCoils.Invalidate;
    gridDiscrete.Invalidate;
    InvalidateRegGrid(gridInputRegs, InputRegisters);
    InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
  end;
end;

procedure TfrmMain.btnConnectionClick(Sender: TObject);
begin
  SB.Panels[1].Text := '';
  if Connected then
  begin
    Broker.Disconnect;
    Connected := False;
  end
  else
    Connected := Broker.Connect = mbNoError;
  ActionInfo(-1);
end;

procedure TfrmMain.btnClrPDUsClick(Sender: TObject);
begin
  ClrPDUOut;
  ClrPDUIn;
end;

procedure TfrmMain.btnClearDumpClick(Sender: TObject);
begin
  Dump.Clear;
  SpecialFunDump.Clear;
end;

procedure TfrmMain.btnClearHistoryClick(Sender: TObject);
begin
  FunExecuted.Clear;
end;

procedure TfrmMain.btnFunctionClick(Sender: TObject);
begin
  PostMessage(Self.Handle, WM_EXECUTE_FUN, cbFunction.ItemIndex, cbDeviceID.ItemIndex);
end;

procedure TfrmMain.btnPropertiesClick(Sender: TObject);
begin
  WasConnected := Connected;
  if frmBrokerSettings.EditSettings(Settings) then
  begin
    BrokerChangeTo;
    if Settings.ClrOnCreate then
    begin
      InitData;
      InvalidateRegGrid(GridInputRegs, InputRegisters);
      InvalidateRegGrid(GridHoldingRegs, HoldingRegisters);
      gridCoils.Invalidate;
      gridDiscrete.Invalidate;
    end;
    UpdateSettingsPanels;
    if WasConnected then
      Connected := Broker.Connect = mbNoError;
  end;
end;

procedure TfrmMain.btnZeroAreaClick(Sender: TObject);
var
  doRandom: boolean;
begin
  doRandom := (Sender as TBCButton).Tag <> 0;
  case PCGrids.ActivePageIndex of
    0: FillBitGrid(GridCoils, Coils, doRandom);
    1: FillBitGrid(GridDiscrete, DiscreteInputs, doRandom);
    2: FillRegGrid(gridInputRegs, InputRegisters, doRandom);
    3: FillRegGrid(gridHoldingRegs, HoldingRegisters, doRandom);
  end;
end;

procedure TfrmMain.cbDeviceIDChange(Sender: TObject);
begin
  UpdateEdits;
end;

procedure TfrmMain.cbFormatChange(Sender: TObject);
begin
  if PCGrids.ActivePageIndex = 2 then
  begin
    if gridInputRegs.Tag <> cbFormat.ItemIndex then
    begin
      gridInputRegs.Tag := cbFormat.ItemIndex;
      InvalidateRegGrid(gridInputRegs, InputRegisters);
    end;
  end
  else
  begin
    if gridHoldingRegs.Tag <> cbFormat.ItemIndex then
    begin
      gridHoldingRegs.Tag := cbFormat.ItemIndex;
      InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
    end;
  end;
end;

procedure TfrmMain.cbFunctionChange(Sender: TObject);
begin
  UpdateEdits;
end;

procedure TfrmMain.FillAreaClick(Sender: TObject);
var
  doRandom: boolean;
begin
  doRandom := (Sender as TBCButton).Tag <> 0;
  case PCGrids.ActivePageIndex of
    0: FillBitGrid(GridCoils, Coils, doRandom);
    1: FillBitGrid(GridDiscrete, DiscreteInputs, doRandom);
    2: FillRegGrid(gridInputRegs, InputRegisters, doRandom);
    3: FillRegGrid(gridHoldingRegs, HoldingRegisters, doRandom);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  SetDefaults(Settings);
  InitFunctions;
  InitControls;
  InitData;
  Connected := False;
  UpdateSettingsPanels;
  with Settings do
    Broker := TSnapMBBroker.Create(settings.CliNetProto,
      Settings.CliEthParams.Address, Settings.CliEthParams.Port);
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  BrokerDestroy;
end;

procedure TfrmMain.gridCoilsDblClick(Sender: TObject);
var
  Index: integer;
begin
  Index := (gridCoils.Row - 1) * 32 + gridCoils.Col - 1;
  Coils[Index] := not Coils[Index];
  gridCoils.Invalidate;
end;

procedure TfrmMain.gridCoilsDrawCell(Sender: TObject; aCol, aRow: integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if (aCol > 0) and (aRow > 0) then
  begin
    if Coils[(aRow - 1) * 32 + (aCol - 1)] then
      gridCoils.Canvas.Brush.Color := $002F8AFF
    else
      gridCoils.Canvas.Brush.Color := gridCoils.Color;
    inflateRect(aRect, -2, -2);
    gridCoils.Canvas.FillRect(aRect);
  end;
end;

procedure TfrmMain.gridCoilsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  Index: integer;
begin
  if Key in [13, 32, 48, 49] then
  begin
    Index := (gridCoils.Row - 1) * 32 + gridCoils.Col - 1;
    if (Key = 13) or (key = 32) then
      Coils[Index] := not Coils[Index]
    else
    if Key = 48 then
      Coils[Index] := False
    else
      Coils[Index] := True;
    gridCoils.Invalidate;
  end;
end;

procedure TfrmMain.gridBitsSelectCell(Sender: TObject; aCol, aRow: integer;
  var CanSelect: boolean);
begin
  ItemIndex.Caption := IntToStr((aRow - 1) * 32 + (aCol - 1));
end;

procedure TfrmMain.gridDiscreteDblClick(Sender: TObject);
var
  Index: integer;
begin
  Index := (gridDiscrete.Row - 1) * 32 + gridDiscrete.Col - 1;
  DiscreteInputs[Index] := not DiscreteInputs[Index];
  gridDiscrete.Invalidate;
end;

procedure TfrmMain.gridDiscreteDrawCell(Sender: TObject; aCol, aRow: integer;
  aRect: TRect; aState: TGridDrawState);
begin
  if (aCol > 0) and (aRow > 0) then
  begin
    if DiscreteInputs[(aRow - 1) * 32 + (aCol - 1)] then
      gridDiscrete.Canvas.Brush.Color := $002F8AFF
    else
      gridDiscrete.Canvas.Brush.Color := gridCoils.Color;
    inflateRect(aRect, -2, -2);
    gridDiscrete.Canvas.FillRect(aRect);
  end;
end;

procedure TfrmMain.gridDiscreteKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  Index: integer;
begin
  if Key in [13, 32, 48, 49] then
  begin
    Index := (gridDiscrete.Row - 1) * 32 + gridDiscrete.Col - 1;
    if (Key = 13) or (key = 32) then
      DiscreteInputs[Index] := not DiscreteInputs[Index]
    else
    if Key = 48 then
      DiscreteInputs[Index] := False
    else
      DiscreteInputs[Index] := True;
    gridDiscrete.Invalidate;
  end;
end;

procedure TfrmMain.gridHoldingRegsValidateEntry(Sender: TObject;
  aCol, aRow: integer; const OldValue: string; var NewValue: string);
var
  Value: word;
begin
  if not IsValidInt16(NewValue, gridHoldingRegs.tag = 1, Value) then
  begin
    messageDlg(format('%s is not a valid value', [NewValue]), mtError, [mbOK], 0);
    NewValue := OldValue;
  end
  else
  begin
    if gridHoldingRegs.tag = 1 then
      NewValue := IntToHex(Value, 4);
    HoldingRegisters[(aRow - 1) * 16 + (aCol - 1)] := Value;
  end;
end;

procedure TfrmMain.gridInputRegsValidateEntry(Sender: TObject;
  aCol, aRow: integer; const OldValue: string; var NewValue: string);
var
  Value: word;
begin
  if not IsValidInt16(NewValue, gridInputRegs.tag = 1, Value) then
  begin
    messageDlg(format('%s is not a valid value', [NewValue]), mtError, [mbOK], 0);
    NewValue := OldValue;
  end
  else
  begin
    if gridInputRegs.tag = 1 then
      NewValue := IntToHex(Value, 4);
    InputRegisters[(aRow - 1) * 16 + (aCol - 1)] := Value;
  end;
end;

procedure TfrmMain.gridPDUOutSelectCell(Sender: TObject; aCol, aRow: integer;
  var CanSelect: boolean);
begin
  PDUOutItemIndex.Caption := IntToStr((aRow - 1) * 32 + (aCol - 1));
end;

procedure TfrmMain.GridRegsSelectCell(Sender: TObject; aCol, aRow: integer;
  var CanSelect: boolean);
begin
  ItemIndex.Caption := IntToStr((aRow - 1) * 16 + (aCol - 1));
end;

procedure TfrmMain.mniSetVisibleAddressesClick(Sender: TObject);
begin
  if (PopupMenu1.PopupComponent = gridCoils) or
    (PopupMenu1.PopupComponent = gridDiscrete) then dlgVisibility.SetColumns(32);
  if (PopupMenu1.PopupComponent = gridHoldingRegs) or
    (PopupMenu1.PopupComponent = gridInputRegs) then dlgVisibility.SetColumns(16);
  dlgVisibility.Caller := PopupMenu1.PopupComponent as TStringGrid;
  dlgVisibility.ShowModal;
end;

procedure TfrmMain.PCGridsChange(Sender: TObject);
begin
  cbFormat.Visible := PCGrids.ActivePageIndex > 1;
  btnIncreaseFill.Visible := PCGrids.ActivePageIndex > 1;
  case PCGrids.ActivePageIndex of
    0: begin
      with gridCoils.Selection.TopLeft do
        ItemIndex.Caption := IntToStr((Y - 1) * 32 + (X - 1));
    end;
    1: begin
      with gridDiscrete.Selection.TopLeft do
        ItemIndex.Caption := IntToStr((Y - 1) * 32 + (X - 1));
    end;
    2: begin
      cbFormat.ItemIndex := gridInputRegs.Tag;
      with gridInputRegs.Selection.TopLeft do
        ItemIndex.Caption := IntToStr((Y - 1) * 16 + (X - 1));
    end;
    3: begin
      cbFormat.ItemIndex := GridHoldingRegs.Tag;
      with gridHoldingRegs.Selection.TopLeft do
        ItemIndex.Caption := IntToStr((Y - 1) * 16 + (X - 1));
    end;
  end;
end;

procedure TfrmMain.ActionInfo(funidx: integer);
var
  Status: TDeviceStatus;
begin
  Status := Broker.GetDeviceStatus;
  SB.Panels[0].Text := format('Job time : %d ms', [Status.Time]);
  SB.Panels[1].Text := ErrorText(Status.LastError);
  Connected := Status.Connected;
  if funidx > -1 then
    FunExecuted.Append(format('%s : [%s]', [Fun[funidx].Name,
      ErrorText(Status.LastError)]));
end;

procedure TfrmMain.InitControls;
var
  c: integer;
begin
  PCGrids.ActivePageIndex := 0;
  cbFormat.Visible := False;
  btnIncreaseFill.Visible := False;
  for c := 1 to gridDiscrete.RowCount - 1 do
    gridDiscrete.Cells[0, c] := IntToStr((c - 1) * 32);
  for c := 1 to gridCoils.RowCount - 1 do
    gridCoils.Cells[0, c] := IntToStr((c - 1) * 32);
  for c := 1 to gridInputRegs.RowCount - 1 do
    gridInputRegs.Cells[0, c] := IntToStr((c - 1) * 16);
  for c := 1 to gridHoldingRegs.RowCount - 1 do
    gridHoldingRegs.Cells[0, c] := IntToStr((c - 1) * 16);
  InvalidateRegGrid(GridInputRegs, InputRegisters);
  InvalidateRegGrid(GridHoldingRegs, HoldingRegisters);
  ClrPDUOut;
  ClrPDUIn;
end;

procedure TfrmMain.InitFunctions;
var
  c: integer;
begin
  FunPanels[1] := FunPanel_1;
  FunPanels[2] := FunPanel_2;
  FunPanels[3] := FunPanel_3;
  FunPanels[4] := FunPanel_4;
  FunPanels[5] := FunPanel_5;
  FunEdits[1] := edRDAddress;
  FunEdits[2] := edRDAmount;
  FunEdits[3] := edWRAddress;
  FunEdits[4] := edWRAmount;
  FunEdits[5] := edValue;

  for c := 0 to 18 do
    with fun[c] do
    begin
      Info := '';
      EdLabels[1] := 'Read Address';
      EdLabels[2] := 'Read Amount';
      EdLabels[3] := 'Write Address';
      EdLabels[4] := 'Write Amount';
      EdLabels[5] := 'Value';
      EdEnable[1] := True;
      EdEnable[2] := True;
      EdEnable[3] := True;
      EdEnable[4] := True;
      EdEnable[5] := False;
    end;

  fun[0].Name := 'Read Coils';
  with fun[0] do
  begin
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := False;
    EdEnable[4] := False;
  end;
  fun[1].Name := 'Read Discrete Inputs';
  with fun[1] do
  begin
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := False;
    EdEnable[4] := False;
  end;
  fun[2].Name := 'Read Holding Registers';
  with fun[2] do
  begin
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := False;
    EdEnable[4] := False;
  end;
  fun[3].Name := 'Read Input Registers';
  with fun[3] do
  begin
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := False;
    EdEnable[4] := False;
  end;
  fun[4].Name := 'Write Single Coil';
  with fun[4] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := True;
    EdEnable[4] := False;
    EdEnable[5] := True;
  end;
  fun[5].Name := 'Write Single Register';
  with fun[5] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := True;
    EdEnable[4] := False;
    EdEnable[5] := True;
  end;
  fun[6].Name := 'Write Multiple Coils';
  with fun[6] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := True;
    EdEnable[4] := True;
  end;
  fun[7].Name := 'Write Multiple Registers';
  with fun[7] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := True;
    EdEnable[4] := True;
  end;
  fun[8].Name := 'Mask Write Register';
  with fun[8] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := True;
    EdEnable[4] := True;
    EdEnable[5] := True;
    EdLabels[4] := 'AND Mask';
    EdLabels[5] := 'OR Mask';
  end;
  fun[9].Name := 'Read/Write Multiple Registers';
  with fun[9] do
  begin
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := True;
    EdEnable[4] := True;
  end;
  fun[10].Name := 'Read File Record';
  with fun[10] do
  begin
    Info :=
      'The registers received by the "Read File Record" function will be stored into the Holding Registers starting from offset 0 ';
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := True;
    EdEnable[4] := True;
    EdLabels[1] := 'Ref. Type';
    EdLabels[2] := 'File Number';
    EdLabels[3] := 'Rec. Number';
    EdLabels[4] := 'Regs Amount';
  end;
  fun[11].Name := 'Write File Record';
  with fun[11] do
  begin
    Info :=
      'The registers sent by the "Write File Record" function will be taken from the Holding Registers starting from offset 0 ';
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := True;
    EdEnable[4] := True;
    EdLabels[1] := 'Ref. Type';
    EdLabels[2] := 'File Number';
    EdLabels[3] := 'Rec. Number';
    EdLabels[4] := 'Regs Amount';
  end;

  fun[12].Name := 'Read Exception Status';
  with fun[12] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := '';
    EdLabels[2] := '';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  fun[13].Name := 'Diagnostics';
  with fun[13] do
  begin
    Info :=
      'The data received by the "Diagnostic" function will be stored into the Holding Registers starting from offset 0 ';
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := 'Sub Fun';
    EdLabels[2] := 'Data Out';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  fun[14].Name := 'Get Comm Event Counter';
  with fun[14] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := '';
    EdLabels[2] := '';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  fun[15].Name := 'Get Comm Event Log';
  with fun[15] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := '';
    EdLabels[2] := '';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  fun[16].Name := 'Report Server ID';
  with fun[16] do
  begin
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := '';
    EdLabels[2] := '';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  fun[17].Name := 'Read FIFO Queue';
  with fun[17] do
  begin
    Info :=
      'The data received by the "Read FIFO Queue" function will be stored into the Holding Registers starting from offset 0 ';
    EdEnable[1] := True;
    EdEnable[2] := False;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := 'Address';
    EdLabels[2] := '';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  fun[18].Name := 'Encapsulated Interface Transport';
  with fun[18] do
  begin
    Info :=
      'For more flexibility, consider using the "User Function" by passing 0x2B as the function number ';
    EdEnable[1] := True;
    EdEnable[2] := True;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := 'MEI Type';
    EdLabels[2] := 'Data';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  fun[19].Name := 'User Function';
  with fun[19] do
  begin
    Info := 'Setup your own PDU into "User Function" Tab ';
    EdEnable[1] := False;
    EdEnable[2] := False;
    EdEnable[3] := False;
    EdEnable[4] := False;
    EdEnable[5] := False;
    EdLabels[1] := '';
    EdLabels[2] := '';
    EdLabels[3] := '';
    EdLabels[4] := '';
    EdLabels[5] := '';
  end;

  cbFunction.Items.Clear;
  for c := 0 to 19 do
    cbFunction.Items.Add(fun[c].Name);
  cbFunction.ItemIndex := 0;

  cbDeviceID.Items.Clear;
  for c := 0 to 255 do
    cbDeviceID.Items.Add(IntToStr(c));
  cbDeviceID.ItemIndex := 1;

  UpdateEdits;
end;

procedure TfrmMain.SetFConnected(AValue: boolean);
begin
  FConnected := AValue;
  if FConnected then
  begin
    pnlConnection.BackGround.Color := color_Connected;
    lblConnection.Caption := 'Connected';
    pnlDataLink.BackGround.Color := color_DataLinkActive;
    pnlChannel.BackGround.Color := color_ChannelActive;
    btnConnection.ImageIndex := 1;
    btnConnection.Hint := 'Disconnect';
  end
  else
  begin
    pnlConnection.BackGround.Color := color_Disconnected;
    lblConnection.Caption := 'Not Connected';
    pnlDataLink.BackGround.Color := color_DataLinkOff;
    pnlChannel.BackGround.Color := color_ChannelOff;
    btnConnection.ImageIndex := 0;
    btnConnection.Hint := 'Connect';
  end;
end;

procedure TfrmMain.UpdateSettingsPanels;
begin
  lblBrokerType.Caption := Brokers[Settings.BrokerType];
  case Settings.BrokerType of
    btNetClient: begin
      pnlNetController.Visible := False;
      pnlChannel.Visible := True;
      lblDataLink.Caption := 'Ethernet';
      lblFlavourLabel.Caption := 'Protocol';
      lblFlavour.Caption := NetProtocols[Settings.CliNetProto];
      lblLinkNameLabel.Caption := 'Address';
      lblLinkName.Caption := Settings.CliEthParams.Address;
      lblParamsLabel.Caption := 'Port';
      lblParams.Caption := IntToStr(Settings.CliEthParams.Port);
    end;
    btSerController: begin
      pnlNetController.Visible := False;
      pnlChannel.Visible := True;
      lblDataLink.Caption := 'Serial';
      lblFlavourLabel.Caption := 'Format';
      lblFlavour.Caption := 'RTU/ASCII';
      lblLinkNameLabel.Caption := 'Port';
      lblLinkName.Caption := Settings.SerParams.Port;
      lblParamsLabel.Caption := 'Params';
      with Settings.SerParams do
        lblParams.Caption := SysUtils.Format('%d, %s, %d, %d',
          [BaudRate, Parity, DataBits, StopBits]);
    end;
  end;
end;

procedure TfrmMain.UpdateEdits;
var
  idx, c: integer;
begin
  idx := cbFunction.ItemIndex;
  for c := 1 to 5 do
  begin
    FunPanels[c].Caption := fun[idx].EdLabels[c];
    if fun[idx].EdEnable[c] then
    begin
      FunEdits[c].Font.Color := clBlack;
      FunEdits[c].Color := clWhite;
    end
    else
    begin
      FunEdits[c].Font.Color := clSilver;
      FunEdits[c].Color := clSilver;
    end;
    FunEdits[c].Enabled := fun[idx].EdEnable[c];
  end;
  lblFunInfo.Caption := fun[idx].Info;

  if idx = 19 then
    PC.ActivePageIndex := 2;

  if cbDeviceID.ItemIndex = 0 then
    btnFunction.Enabled := (Settings.BrokerType = btNetClient) or
      (idx in [4, 5, 6, 7, 11])
  else
    btnFunction.Enabled := True;
end;

procedure TfrmMain.BrokerChangeTo;
begin
  case Settings.BrokerType of
    btNetClient: begin
      Broker.ChangeTo(Settings.CliNetProto, Settings.CliEthParams.Address,
        Settings.CliEthParams.Port);
      Broker.SetLocalParam(par_DisconnectOnError,
        integer(Settings.CliEthParams.DisOnError));
      Broker.SetLocalParam(par_BaseAddressZero, integer(Settings.BaseAddressZero));
      Broker.SetLocalParam(par_MaxRetries, Settings.MaxRetries);
    end;
    btSerController: begin
      with Settings do
        Broker.ChangeTo(sfRTU, SerParams.Port, SerParams.BaudRate,
          SerParams.Parity, SerParams.DataBits, SerParams.StopBits, SerParams.Flow);
      Broker.SetLocalParam(par_BaseAddressZero, integer(Settings.BaseAddressZero));
      Broker.SetLocalParam(par_MaxRetries, Settings.MaxRetries);
    end;
  end;
  PC.ActivePageIndex := 0;
  UpdateEdits;
end;

procedure TfrmMain.BrokerDestroy;
begin
  Broker.Disconnect;
  Broker.Free;
end;

function TfrmMain.WordOf(Edit: TEdit): word;
var
  MinVal, Value: longint;
begin
  if Settings.BaseAddressZero then
    MinVal := 0
  else
    MinVal := 1;

  Value := StrToIntDef(Edit.Text, -1);
  if (Value >= MinVal) and (Value < $FFFF) then
    exit(Value);
  if Value < MinVal then Value := MinVal;
  if Value > $FFFF then Value := $FFFF;
  Edit.Text := IntToStr(Value);
  Result := Value;
end;

procedure TfrmMain.DumpIOData(var IOBuffer: TIOBuffer);
var
  sHeader: string;
  SHex, SChr: string;
  Ch: ansichar;
  c, cnt: integer;
begin
  if IOBuffer.Direction = PacketLog_IN then // Indication
    sHeader := format('[Confirmation from Device %d]', [IOBuffer.Peer])
  else // Response
    sHeader := format('[Request to Device %d]', [IOBuffer.Peer]);

  if IOBuffer.Size > 0 then
  begin
    SHex := '';
    SChr := '';
    cnt := 0;
    Dump.Lines.BeginUpdate;
    try
      Dump.Lines.Add(sHeader);
      for c := 0 to IOBuffer.Size - 1 do
      begin
        SHex := SHex + IntToHex(IOBuffer.Data[c], 2) + ' ';
        Ch := ansichar(IOBuffer.Data[c]);
        if not (Ch in ['a'..'z', 'A'..'Z', '0'..'9', '_', '$', '-', #32]) then
          Ch := '.';
        SChr := SChr + string(Ch);
        Inc(cnt);
        if cnt = 16 then
        begin
          Dump.Lines.Add(SHex + '  ' + SChr);
          SHex := '';
          SChr := '';
          cnt := 0;
        end;
      end;
      // Dump remainder
      if cnt > 0 then
      begin
        while Length(SHex) < 48 do
          SHex := SHex + ' ';
        Dump.Lines.Add(SHex + '  ' + SChr);
      end;
    finally
      Dump.Lines.EndUpdate;
    end;
    Dump.CaretY := MaxInt;
  end;
end;

procedure TfrmMain.ClrPDUOut;
var
  x, y: integer;
begin
  for y := 1 to gridPDUOut.RowCount - 1 do
  begin
    gridPDUOut.Cells[0, y] := IntToStr((y - 1) * 32);
    for x := 1 to gridPDUOut.ColCount - 1 do
      gridPDUOut.Cells[x, y] := '';
  end;
end;

procedure TfrmMain.ClrPDUIn;
var
  x, y: integer;
begin
  for y := 1 to gridPDUIn.RowCount - 1 do
  begin
    gridPDUIn.Cells[0, y] := IntToStr((y - 1) * 32);
    for x := 1 to gridPDUIn.ColCount - 1 do
      gridPDUIn.Cells[x, y] := '';
  end;
end;

function TfrmMain.funReadCoils(DeviceID: byte): integer;
var
  Address, AddrIn, Amount: word;
begin
  Address := WordOf(edRDAddress);
  Amount := WordOf(edRDAmount);

  if Settings.BaseAddressZero then
    AddrIn := Address
  else
    AddrIn := Address - 1;

  Result := Broker.ReadCoils(DeviceID, Address, Amount, @Coils[AddrIn]);
  if Result = 0 then
    gridCoils.Invalidate;
end;

function TfrmMain.funReadDiscreteInputs(DeviceID: byte): integer;
var
  Address, AddrIn, Amount: word;
begin
  Address := WordOf(edRDAddress);
  Amount := WordOf(edRDAmount);

  if Settings.BaseAddressZero then
    AddrIn := Address
  else
    AddrIn := Address - 1;

  Result := Broker.ReadDiscreteInputs(DeviceID, Address, Amount,
    @DiscreteInputs[AddrIn]);
  if Result = 0 then
    gridDiscrete.Invalidate;
end;

function TfrmMain.funReadInputRegisters(DeviceID: byte): integer;
var
  Address, AddrIn, Amount: word;
begin
  Address := WordOf(edRDAddress);
  Amount := WordOf(edRDAmount);

  if Settings.BaseAddressZero then
    AddrIn := Address
  else
    AddrIn := Address - 1;

  Result := Broker.ReadInputRegisters(DeviceID, Address, Amount,
    @InputRegisters[AddrIn]);
  if Result = 0 then
    InvalidateRegGrid(gridInputRegs, InputRegisters);
end;

function TfrmMain.funReadHoldingRegisters(DeviceID: byte): integer;
var
  Address, AddrIn, Amount: word;
begin
  Address := WordOf(edRDAddress);
  Amount := WordOf(edRDAmount);

  if Settings.BaseAddressZero then
    AddrIn := Address
  else
    AddrIn := Address - 1;

  Result := Broker.ReadHoldingRegisters(DeviceID, Address, Amount,
    @HoldingRegisters[AddrIn]);
  if Result = 0 then
    InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
end;

function TfrmMain.funWriteSingleCoil(DeviceID: byte): integer;
var
  Address, Value: word;
begin
  Address := wordOf(edWRAddress);
  Value := StrToIntDef(edValue.Text, 0);
  Result := Broker.WriteSingleCoil(DeviceID, Address, Value);
end;

function TfrmMain.funWriteSingleRegister(DeviceID: byte): integer;
var
  Address, Value: word;
begin
  Address := wordOf(edWRAddress);
  Value := StrToIntDef(edValue.Text, 0);
  Result := Broker.WriteSingleRegister(DeviceID, Address, Value);
end;

function TfrmMain.funWriteMultipleCoils(DeviceID: byte): integer;
var
  Address, AddrOut, Amount: word;
begin
  Address := wordOf(edWRAddress);
  Amount := wordOf(edWRAmount);

  if Settings.BaseAddressZero then
    AddrOut := Address
  else
    AddrOut := Address - 1;

  Result := Broker.WriteMultipleCoils(DeviceID, Address, Amount, @Coils[AddrOut]);
end;

function TfrmMain.funWriteMultipleRegisters(DeviceID: byte): integer;
var
  Address, AddrOut, Amount: word;
begin
  Address := wordOf(edWRAddress);
  Amount := wordOf(edWRAmount);

  if Settings.BaseAddressZero then
    AddrOut := Address
  else
    AddrOut := Address - 1;

  Result := Broker.WriteMultipleRegisters(DeviceID, Address, Amount,
    @HoldingRegisters[AddrOut]);
end;

function TfrmMain.funMaskWriteRegisters(DeviceID: byte): integer;
var
  Address, AND_Mask, OR_Mask: word;
begin
  Address := wordOf(edWRAddress);
  AND_Mask := StrToIntDef(FunEdits[4].Text, 0);
  OR_Mask := StrToIntDef(FunEdits[5].Text, 0);
  Result := Broker.MaskWriteRegister(DeviceID, Address, AND_Mask, OR_Mask);
end;

function TfrmMain.funReadWriteMultipleRegisters(DeviceID: byte): integer;
var
  RDAddress, WRAddress, RDAmount, WRAmount: word;
  AddrIn, AddrOut: word;
begin
  RDAddress := wordOf(edRDAddress);
  RDAmount := wordOf(edRDAmount);
  WRAddress := wordOf(edWRAddress);
  WRAmount := wordOf(edWRAmount);

  if Settings.BaseAddressZero then
  begin
    AddrIn := RDAddress;
    AddrOut := WRAddress;
  end
  else
  begin
    AddrIn := RDAddress - 1;
    AddrOut := WRAddress - 1;
  end;

  Result := Broker.ReadWriteMultipleRegisters(DeviceID, RDAddress,
    RDAmount, WRAddress, WRAmount, @HoldingRegisters[AddrIn],
    @HoldingRegisters[AddrOut]);
  if Result = 0 then
    InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
end;

function TfrmMain.funReadFileRecord(DeviceID: byte): integer;
var
  RefType: byte;
  FileNumber, RecNumber, RegsAmount: word;
begin
  RefType := StrToIntDef(FunEdits[1].Text, 0);
  FileNumber := StrToIntDef(FunEdits[2].Text, 0);
  RecNumber := StrToIntDef(FunEdits[3].Text, 0);
  RegsAmount := StrToIntDef(FunEdits[4].Text, 0);

  Result := Broker.ReadFileRecord(DeviceID, RefType, FileNumber,
    RecNumber, RegsAmount, @HoldingRegisters[0]);
  if Result = 0 then
    InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
end;

function TfrmMain.funWriteFileRecord(DeviceID: byte): integer;
var
  RefType: byte;
  FileNumber, RecNumber, RegsAmount: word;
begin
  RefType := StrToIntDef(FunEdits[1].Text, 0);
  FileNumber := StrToIntDef(FunEdits[2].Text, 0);
  RecNumber := StrToIntDef(FunEdits[3].Text, 0);
  RegsAmount := StrToIntDef(FunEdits[4].Text, 0);

  Result := Broker.WriteFileRecord(DeviceID, RefType, FileNumber,
    RecNumber, RegsAmount, @HoldingRegisters[0]);
end;

function TfrmMain.funReadExceptionStatus(DeviceID: byte): integer;
var
  Data: byte;
begin
  Result := Broker.ReadExceptionStatus(DeviceID, Data);
  if Result = 0 then
  begin
    SpecialFunDump.Lines.Add('[Function Read Exception Status]');
    SpecialFunDump.Lines.Add(format('Return Value : 0x%s', [IntToHex(Data, 2)]));
    PC.ActivePageIndex := 1;
  end;
end;

function TfrmMain.funDiagnostics(DeviceID: byte): integer;
var
  SubFun, Data: word;
  Received: word;
begin
  SubFun := StrToIntDef(FunEdits[1].Text, 0);
  Data := StrToIntDef(FunEdits[2].Text, 0);

  Result := Broker.Diagnostics(DeviceID, SubFun, @Data, @HoldingRegisters[0],
    1, Received);
  if Result = 0 then
  begin
    InvalidateRegGrid(gridHoldingRegs, HoldingRegisters);
    SpecialFunDump.Lines.Add('[Function Diagnostics]');
    SpecialFunDump.Lines.Add(format('SubFun : 0x%s, Data : 0x%s',
      [IntToHex(SubFun, 2), IntToHex(Data, 4)]));
    SpecialFunDump.Lines.Add(format(
      'Received %d items stored @HoldingRegisters[0]', [Received]));
    PC.ActivePageIndex := 1;
  end;
end;

function TfrmMain.funGetCommEventCounter(DeviceID: byte): integer;
var
  Status, EventCount: word;
begin
  Result := Broker.GetCommEventCounter(DeviceID, Status, EventCount);
  if Result = 0 then
  begin
    SpecialFunDump.Lines.Add('[Function Get Comm Event Counter]');
    SpecialFunDump.Lines.Add(format('Received - Status : 0x%s, Event Count : 0x%s',
      [IntToHex(Status, 4), IntToHex(EventCount, 4)]));
    PC.ActivePageIndex := 1;
  end;
end;

function TfrmMain.funGetCommEventLog(DeviceID: byte): integer;
var
  Status: word;
  EventCount: word;
  MessageCount: word;
  NumItems: word;
  Events: packed array[0..255] of byte;
  c: integer;
begin
  Result := Broker.GetCommEventLog(DeviceID, Status, EventCount,
    MessageCount, NumItems, @Events);
  if Result = 0 then
  begin
    SpecialFunDump.Lines.Add('[Function Get Comm Event Log]');
    SpecialFunDump.Lines.Add(format(
      'Received - Status : 0x%s, Evt Count : %d, Msg Count : %d, Num Items : %d',
      [IntToHex(Status, 4), EventCount, MessageCount, NumItems]));
    SpecialFunDump.Lines.Add('Items[]');
    if NumItems > 256 then NumItems := 256;
    for c := 0 to NumItems - 1 do
      SpecialFunDump.Lines.Add(' (%3d) : 0x%s', [c, IntToHex(Events[c])]);
    PC.ActivePageIndex := 1;
  end;
end;

function TfrmMain.funReportServerID(DeviceID: byte): integer;
var
  DataSize: integer;
  c: integer;
  ServerID: packed array[0..255] of ansichar;
  S: string;
begin
  Result := Broker.ReportServerID(DeviceID, @ServerID, DataSize);
  if Result = 0 then
  begin
    SpecialFunDump.Lines.Add('[Function Report Server ID]');
    SpecialFunDump.Lines.Add('%d byte received', [DataSize]);
    S := '';
    for c := 0 to DataSize - 1 do
      if ServerID[c] in ['0'..'9', 'a'..'z', 'A'..'Z', ' ', '_'] then
        S := S + ServerID[c]
      else
        S := S + Format('(0x%s)', [IntToHex(Ord(ServerID[c]), 2)]);
    SpecialFunDump.Lines.Add(S);
    PC.ActivePageIndex := 1;
  end;
end;

function TfrmMain.funReadFIFOQueue(DeviceID: byte): integer;
var
  Address: word;
  FifoCount: word;
begin
  Address := wordOf(edWRAddress);
  Result := Broker.ReadFIFOQueue(DeviceID, Address, FifoCount, @HoldingRegisters[0]);
  if Result = 0 then
  begin
    SpecialFunDump.Lines.Add('[Function Read FIFO Queue]');
    SpecialFunDump.Lines.Add(
      '%d Items received, stored starting from HoldingRegisters[0]', [FifoCount]);
    PC.ActivePageIndex := 1;
  end;
end;

function TfrmMain.funEncapsulatedInterfaceTransport(DeviceID: byte): integer;
var
  MEI_Type: byte;
  DataOut: word;
  RdSize: word;
  c: integer;
  S: string;
  DataIN: packed array[0..255] of ansichar;
begin
  MEI_Type := StrToIntDef(FunEdits[1].Text, 0);
  DataOut := StrToIntDef(FunEdits[2].Text, 0);
  Result := Broker.ExecuteMEIFunction(DeviceID, MEI_Type, @DataOut, 2, @DataIn, RDSize);
  if Result = 0 then
  begin
    SpecialFunDump.Lines.Add('[Function Encapsulated Interface Transport (MEI)]');
    SpecialFunDump.Lines.Add('%d byte received', [RDSize]);
    S := '';
    for c := 0 to RDSize - 1 do
      if DataIN[c] in ['0'..'9', 'a'..'z', 'A'..'Z', ' ', '_'] then
        S := S + DataIN[c]
      else
        S := S + Format('(0x%s)', [IntToHex(Ord(DataIN[c]), 2)]);
    SpecialFunDump.Lines.Add(S);
    PC.ActivePageIndex := 1;
  end;
end;

function TfrmMain.funUserFunction(DeviceID: byte): integer;
var
  UsrFunction: byte;
  SizePDUWrite: integer;
  SizePDURead: word;
  PDUOut, PDUIn: packed array[0..255] of byte;


  function GetValue(x, y: integer): integer;
  begin
    if cbFormatPDU.ItemIndex = 0 then
      Result := StrToIntDef(gridPDUOut.Cells[x, y], -1)
    else
      Result := StrToIntDef('$' + gridPDUOut.Cells[x, y], -1);

    if (Result < 0) or (Result > 255) then
      Result := -1;
  end;

  function FillPDUOut: integer;
  var
    c, x, y, val: integer;
  begin
    c := -1;
    for y := 1 to gridPDUOut.ColCount - 1 do
    begin
      for x := 1 to gridPDUOut.RowCount - 1 do
      begin
        if trim(gridPDUOut.Cells[x, y]) = '' then
          exit(c + 1);

        val := GetValue(x, y);
        if val = -1 then
        begin
          gridPDUOut.Col := x;
          gridPDUOut.Row := y;
          messageDlg('Invalid byte value', mtError, [mbOK], 0);
          exit(-1);
        end;

        Inc(c);
        PDUOut[c] := val;

      end;
    end;
    Result := c + 1;
  end;

  procedure PutValue(x, y, Value: integer);
  begin
    if cbFormatPDU.ItemIndex = 0 then
      gridPDUIn.Cells[x, y] := IntToStr(Value)
    else
      gridPDUIn.Cells[x, y] := IntToHex(Value, 2);
  end;

  procedure FillPDUIn(SizeRead: integer);
  var
    c, x, y: integer;
  begin
    for c := 0 to SizeRead - 1 do
    begin
      x := (c mod 32) + 1;
      y := (c div 32) + 1;
      PutValue(x, y, PDUIn[c]);
    end;
  end;

begin
  Result := 0;

  UsrFunction := byte(StrToIntDef(edUsrFunction.Text, 0));
  edUsrFunction.Text := IntToStr(UsrFunction);
  if (UsrFunction <= 0) then
  begin
    messageDlg('Invalid Function Number (Must be in [1..255])', mtError, [mbOK], 0);
    exit;
  end;

  SizePDUWrite := FillPDUOut;
  if SizePDUWrite = -1 then
    exit;
  if SizePDUWrite = 0 then
  begin
    messageDlg('PDU is Empty', mtError, [mbOK], 0);
    exit;
  end;
  if SizePDUWrite > MaxBinPDUSize then
  begin
    messageDlg('PDU Size exceeds 253 byte', mtError, [mbOK], 0);
    exit;
  end;
  ClrPDUIn;

  Result := Broker.CustomFunctionRequest(DeviceID, UsrFunction, @PDUOut,
    SizePDUWrite, @PDUIn, SizePDURead, 0);
  if Result = 0 then
  begin
    if SizePDURead > 256 then SizePDURead := 256;
    FillPDUIn(SizePDURead);
  end;

end;

procedure TfrmMain.WmExecuteFun(var Msg: TLMessage);
var
  IOBuffer: TIOBuffer;
  Size: integer;
  DeviceID: byte;
begin
  DeviceID := byte(Msg.lParam);

  SB.Panels[0].Text := '';
  SB.Panels[1].Text := '';
  case Msg.wParam of
    0: funReadCoils(DeviceID);
    1: funReadDiscreteInputs(DeviceID);
    2: funReadHoldingRegisters(DeviceID);
    3: funReadInputRegisters(DeviceID);
    4: funWriteSingleCoil(DeviceID);
    5: funWriteSingleRegister(DeviceID);
    6: funWriteMultipleCoils(DeviceID);
    7: funWriteMultipleRegisters(DeviceID);
    8: funMaskWriteRegisters(DeviceID);
    9: funReadWriteMultipleRegisters(DeviceID);
    10: funReadFileRecord(DeviceID);
    11: funWriteFileRecord(DeviceID);
    12: funReadExceptionStatus(DeviceID);
    13: funDiagnostics(DeviceID);
    14: funGetCommEventCounter(DeviceID);
    15: funGetCommEventLog(DeviceID);
    16: funReportServerID(DeviceID);
    17: funReadFIFOQueue(DeviceID);
    18: funEncapsulatedInterfaceTransport(DeviceID);
    19: funUserFunction(DeviceID);
  end;
  ActionInfo(Msg.wParam);
  if Broker.GetBufferSent(@IOBuffer.Data, Size) then
  begin
    IOBuffer.Size := Size;
    IOBuffer.Direction := PacketLog_OUT;
    IoBuffer.Peer := DeviceID;
    DumpIOData(IOBuffer);
  end;
  if (DeviceID > 0) and Broker.GetBufferRecv(@IOBuffer.Data, Size) then
  begin
    IOBuffer.Size := Size;
    IOBuffer.Direction := PacketLog_IN;
    IoBuffer.Peer := DeviceID;
    DumpIOData(IOBuffer);
  end;
end;

end.
