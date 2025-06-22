unit untVisibilityDialog;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, BCPanel,
  BCButton, BCTrackbarUpdown, Grids;

type

  { TdlgVisibility }

  TdlgVisibility = class(TForm)
    BCTrackbarUpdown1: TBCTrackbarUpdown;
    BCTrackbarUpdown2: TBCTrackbarUpdown;
    btnUnhide: TBCButton;
    btnHide: TBCButton;
    btnClose: TBCButton;
    Panel: TBCPanel;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure btnHideClick(Sender: TObject);
    procedure btnUnhideClick(Sender: TObject);
    procedure SetCaller(ACaller: TStringGrid);
    function GetCaller: TStringGrid;
    procedure SetColumns(AColumns: integer);
  private
    fColumns: integer;
    fCaller: TStringGrid;
  public
    property Caller: TStringGrid read GetCaller write SetCaller;
    property Columns: integer write SetColumns;
  end;

var
  fMinVisible: integer;
  fMaxVisible: integer;
  dlgVisibility: TdlgVisibility;

implementation

{$R *.lfm}

{ TdlgVisibility }

procedure TdlgVisibility.SetColumns(AColumns: integer);
begin
  fColumns := AColumns;
end;

procedure TdlgVisibility.SetCaller(ACaller: TStringGrid);
begin
  fCaller := ACaller;
end;

function TdlgVisibility.GetCaller: TStringGrid;
begin
  Result := fCaller;
end;

procedure TdlgVisibility.btnUnhideClick(Sender: TObject);
var
  i: integer;
  min, max: integer;
begin
  min := (BCTrackbarUpdown1.Value div fColumns) + 1;
  max := (BCTrackbarUpdown2.Value div fColumns) + 1;
  if min = 0 then min := 1;
  if max >= fCaller.RowCount then max := fCaller.RowCount - 1;

  for i := min to max do
  begin
    fCaller.RowHeights[i] := fCaller.DefaultRowHeight;
  end;
end;

procedure TdlgVisibility.btnHideClick(Sender: TObject);
var
  i: integer;
  min, max: integer;
begin
  min := (BCTrackbarUpdown1.Value div fColumns) + 2;
  max := (BCTrackbarUpdown2.Value div fColumns);
  if min = 0 then min := 1;
  if max >= fCaller.RowCount then max := fCaller.RowCount - 1;

  for i := min to max do
  begin
    fCaller.RowHeights[i] := 0;
  end;
end;

procedure TdlgVisibility.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.
