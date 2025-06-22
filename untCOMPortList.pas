{Windows part of the code is based on Ararat Synapse
Linux part of the code is based on code from forum topic 
https://forum.lazarus.freepascal.org/index.php/topic,63256.0.html}

// suppress note: call to subroutine "function" marked as inline is not inlined
{$warn 6058 off}

unit untCOMPortList;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,
  {$IFDEF MSWINDOWS}
  Registry
  {$ELSE}
  BaseUnix, termio
  {$ENDIF}
  ;

{$IFNDEF MSWINDOWS}
type
  cstruct_serial =   // from serial.h
    record
    &type: cint;
    line: cint;
    port: cuint;
    irq: cint;
    flags: cint;
    xmit_fifo_size: cint;
    custom_divisor: cint;
    baud_base: cint;
    close_delay: cushort;
    io_type: cchar;
    reserved_char: cchar;
    hub6: cint;
    closing_wait: cushort; // time to wait before closing
    closing_wait2: cushort; // no longer used...
    iomem_base: pcuchar;
    iomem_reg_shift: cushort;
    port_high: cuint;
    iomap_base: culong;  // cookie passed into ioremap
  end;
{$ENDIF}

procedure GetCOMPorts(var sl: TStringList; WithPath: boolean = True);

implementation

{$IFDEF MSWINDOWS}
procedure GetWindowsCOMPorts(var sl: TStringList);
var
  I: integer;
  reg: tregistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKeyReadOnly('HARDWARE\DEVICEMAP\SERIALCOMM') then
    begin
      Reg.GetValueNames(sl);
      for I := 0 to sl.Count - 1 do
        sl[i] := Reg.ReadString(sl[i]);
    end;
  finally
    Reg.Free;
  end;
end;

{$ELSE}

procedure GetLinuxCOMPorts(var sl: TStringList; WithPath: boolean = True);
var
  flags: Longint= faAnyFile and (not faDirectory);
  rec: TSearchRec;

  procedure ScanForPorts(const ThisRootStr:string; ValidateIO:boolean=false);
  var
    devnam: string;
    FD    : cInt;
    ser   : cstruct_serial;
    usedev: boolean;
  begin
    if FindFirst(ThisRootStr, flags, rec)= 0 then
    begin
      repeat
        if (rec.Attr and flags)= rec.Attr then
        begin
          devnam:= '/dev/'+ rec.Name;
          FD:= fpopen(devnam, O_RdWr or O_NonBlock or O_NoCtty);
          if FD > 0 then
          begin
            if not ValidateIO then usedev:=true else
            begin
              usedev:= false;
              if fpioctl(FD, TIOCGSERIAL, @ser)<> -1 then
                if ser.&type<> 0 then usedev:= true;
            end;
            if usedev then
              if WithPath then
                sl.Add(devnam)
              else sl.Add(rec.Name);
            fpclose(FD);
          end;
        end;
      until FindNext(rec)<> 0;
      FindClose(rec);
    end;
  end;
begin
  ScanForPorts('/dev/ttyS*',true);
  ScanForPorts('/dev/rfcomm*');
  ScanForPorts('/dev/ttyUSB*');
  ScanForPorts('/dev/ttyACM*');
end;

{$ENDIF}

procedure GetCOMPorts(var sl: TStringList; WithPath: boolean = True);
begin
  {$IFDEF MSWINDOWS}
  GetWindowsCOMPorts(sl);
  {$ELSE}
  GetLinuxCOMPorts(sl, WithPath);
  {$ENDIF}
end;

end.
