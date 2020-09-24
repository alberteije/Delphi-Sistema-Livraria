unit EditNum;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TEditNum = class(TCustomEdit)
  private
    { Private declarations }
    FInteiro: byte;
    FDecimais: byte;
    FAlignment: TAlignment;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit);   message CM_EXIT;
    function GetText: string;
    procedure SetText(const Value: string);
    function Desformata: string;
  protected
    { Protected declarations }
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    //procedure CreateWindowHandle(const Params: TCreateParams); override;
    property Alignment: TAlignment read FAlignment write FAlignment
      default taRightJustify;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property Color;
    property Ctl3D;
    property Decimais: byte read FDecimais write FDecimais default 2;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Inteiro: byte read FInteiro write FInteiro default 9;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Text: string read GetText write SetText;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Additional', [TEditNum]);
end;

constructor TEditNum.Create(AOwner: TComponent);
begin  inherited Create(AOwner);	{ perform inherited initialization }
  Alignment := taRightJustify;
  Inteiro := 6;  Decimais := 2;  Text := '';end;

procedure TEditNum.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Longint = (ES_LEFT, ES_RIGHT,
      ES_CENTER);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or
      Alignments[FAlignment];
end;

{procedure TEditNum.CreateWindowHandle(const Params: TCreateParams);
begin
  with Params do
  begin
    WindowHandle := CreateWindowEx(ExStyle, WinClassName, '', Style,
        X, Y, Width, Height, WndParent, 0, HInstance, Param);
    SendMessage(WindowHandle, WM_SETTEXT, 0, Longint(Caption));
  end;
end;}

procedure TEditNum.CMEnter(var Message: TCMEnter);
var
  s: string;
  i: integer;
begin
  s := Text;
  if Length(s) > 0 then begin
    i := Pos(ThousandSeparator, s);
    while i > 0 do begin
      s := Copy(s, 1, i - 1) + Copy(s, i + 1, 255);
      i := Pos(ThousandSeparator, s);
    end;
    Text := s;
    SelStart := 0;
    SelectAll;
  end;
  inherited;
end;

procedure TEditNum.KeyPress(var Key: Char);
var
  s: string;
  i, j, k: integer;
  r: double;
begin
  inherited KeyPress(Key);
  ClearSelection;
  s := inherited Text;
  i := SelStart;
  if Key = '-' then begin
    if Copy(s, 1, 1) = '-' then begin
      s := Copy(s, 2, 255);
      Dec(i);
    end else begin
      s := '-' + s;
      Inc(i);
    end;
    Key := #0;
  end else begin
    if Ord(Key) = 8 then begin
      if SelStart = Pos(DecimalSeparator, s) then begin
        i := Pos(DecimalSeparator, s) - 1;
        Key := #0;
      end;
    end else begin
      if not (Key in ['0','1','2','3','4','5','6','7','8','9','.'])
          then
        Key := #0
      else begin
        if Key = '.' then begin
          s := inherited Text;
          i := Pos(DecimalSeparator, s);
          if i = 0 then begin
            i := SelStart;
            s := Copy(s, 1, i) + DecimalSeparator + Copy(s, i + 1,
                255);
            i := Pos(DecimalSeparator, s);
          end;
          Key := #0;
        end else begin
          k := Pos(DecimalSeparator, s);
          s := Desformata;
          if (k = 0) or (i < k) then begin
            if k = 0 then begin
              if Length(s) >= Inteiro then begin
                MessageBeep($FFFFFFFF);
                Key := #0;
              end;
            end else begin
              if Length(Copy(s, 1, k - 1)) >= Inteiro then begin
                MessageBeep($FFFFFFFF);
                Key := #0;
              end;
            end;
          end else begin
            if Length(Copy(s, k + 1, 255)) >= Decimais then begin
              MessageBeep($FFFFFFFF);
              Key := #0;
            end;
          end;
        end;
      end;
    end;
  end;
  inherited Text := s;
  SelStart := i;
end;

procedure TEditNum.CMExit(var Message: TCMExit);
var
  s: string;
  r: double;
  i: integer;
begin
  s := inherited Text;
  if (s = DecimalSeparator) or (s = '') then
    r := 0
  else begin
    i := Pos(ThousandSeparator, s);
    while i > 0 do begin
      s := Copy(s, 1, i - 1) + Copy(s, i + 1, 255);
      i := Pos(ThousandSeparator, s);
    end;
    r := StrToFloat(s);
  end;
  inherited Text := FloatToStrF(r, ffNumber, Inteiro + Decimais,
      Decimais);
  inherited;
end;

function TEditNum.GetText: string;
begin
  result := Desformata;
end;

procedure TEditNum.SetText(const Value: string);
var
  s: string;
  r: double;
  i: integer;
begin
  if (Value = DecimalSeparator) or (Value = '') then
    r := 0
  else begin
    s := Value;
    for i := 1 to Length(s) do begin
      if (Copy(s, i, 1) = '.') or (Copy(s, i, 1) = ',') then
        s := Copy(s, 1, i - 1) + DecimalSeparator +
            Copy(s, i + 1, Length(s));
    end;
    r := StrToFloat(s);
  end;
  inherited Text := FloatToStrF(r, ffNumber, Inteiro + Decimais,
      Decimais);
end;

function TEditNum.Desformata: string;
var
  s: string;
  i: integer;
begin
  s := inherited Text;
  if Length(s) > 0 then begin
    i := Pos(ThousandSeparator, s);
    while i > 0 do begin
      s := Copy(s, 1, i - 1) + Copy(s, i + 1, 255);
      i := Pos(ThousandSeparator, s);
    end;
  end;
  result := s;
end;

end.
