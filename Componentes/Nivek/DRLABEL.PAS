{=====================================================|
| Label 3D - 1.00 - (c) 1996 by Alvaro L. S. Almeida  |
|-----------------------------------------------------|
| Displays a 3D label with some effects, in Delphi    |
| programs. For Delphi 1, 2 e 3 (16 and 32 bits)      |
|                                                     |
| See other components in our home-page.              |
|-----------------------------------------------------|
| DROID Informatica ltda - Rio de Janeiro - Brazil    |
|                                                     |
| Home Page: http://www.di.com.br                     |
| E-Mail:    comp@di.com.br                           |
| Fax:       055 021 224-0331                         |
|=====================================================}

{ Attention: To change the font.color of DRLabel, set
             "Blink" to blNone before change the color. }

unit DrLabel;

interface

uses
  Classes, StdCtrls, Graphics, ExtCtrls;

type
  TDRBorder = (boNone, boSingle, boRaised, boLowered);
  TDRBlink  = (blNone, blBlink, blHiLo);
  TDRLabel  = class(TLabel)
  private
    FTimer       : TTimer;

    FHiColor,                 { used when "Blink" is blHiLo }
    FLoColor,                 { used when "Blink" is blHiLo }
    FFontColor   : TColor;    { save old font color }
    FCtl3D       : boolean;   { use 3D effects when true }
    FDeep        : byte;      { Shadow deep }
    FBorder      : TDRBorder;
    FInterval    : integer;   { Blink interval in miliseconds }
    FBlink       : TDRBlink;
    FShadowColor : TColor;

    procedure SetDeep(Value: byte);
    procedure SetInterval(Value: integer);
    procedure SetBlink(Value: TDRBlink);
    procedure SetShadowColor(Value: TColor);
    procedure SetCtl3D(Value: boolean);
    procedure SetBorder(Value: TDRBorder);
    procedure FTimerOnTimer(sender:TObject);
    procedure SetHiColor(value: TColor);
    procedure SetLoColor(value: TColor);

  protected
    procedure Paint; override;

  public
    constructor Create(AOwner: TComponent); override;

  published
    { Hi Color, when "Blink" is blHiLo }
    property HiColor: TColor read FHiColor write SetHiColor;
    { Lo Color, when "Blink" is blHiLo }
    property LoColor: TColor read FLoColor write SetLoColor;
    property Border: TDRBorder read FBorder write SetBorder;
    property Ctl3D: boolean read FCtl3D write SetCtl3D;
    { speed of blinking }
    property BlinkInterval: integer read FInterval write SetInterval;
    property Blink: TDRBlink read FBlink write SetBlink;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default clBtnHighlight;
    property Deep: byte read FDeep write SetDeep;

  end;

procedure Register;

implementation

uses SysUtils, WinTypes, WinProcs, Controls;

constructor TDRLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDeep        := 1;
  FFontColor   := font.color;
  FHiColor     := clBlue;
  FLoColor     := clNavy;
  FCtl3D       := true;
  FShadowColor := clBtnHighlight;
  FBlink       := blNone;
  FInterval    := 300;
  FTimer := TTimer.create(self);
  FTimer.interval := FInterval;
  FTimer.enabled  := false;
  FTimer.OnTimer  := FTimerOnTimer;

  SetBounds(Left, Top, Width + FDeep,Height + FDeep);
end;

procedure TDRLabel.SetBlink(Value: TDRBlink);
begin
  if (FBlink <> Value) then begin
    FBlink := Value;

    if (value = blBlink)
      then FFontColor := font.color
      else font.color := FFontColor;

    FTimer.enabled  := (value <> blNone);
    Invalidate;
  end;
end;

procedure TDRLabel.SetInterval(Value: integer);
begin
  if (FInterval <> Value) then begin
    FInterval := Value;
    FTimer.interval := FInterval;
    Invalidate;
  end;
end;

procedure TDRLabel.SetDeep(Value: byte);
begin
  if (FDeep <> Value) and (value > 0) and (value < 3) then begin
    FDeep := Value;
    Invalidate;
  end;
end;

procedure TDRLabel.SetShadowColor(Value: TColor);
begin
  if (FShadowColor <> Value) then begin
    FShadowColor := Value;
    Invalidate;
  end;
end;

procedure TDRLabel.SetHiColor(Value: TColor);
begin
  if (FHiColor <> Value) then begin
    FHiColor := Value;
    Invalidate;
  end;
end;

procedure TDRLabel.SetLoColor(Value: TColor);
begin
  if (FLoColor <> Value) then begin
    FLoColor := Value;
    Invalidate;
  end;
end;

procedure TDRLabel.SetBorder(Value: TDRBorder);
begin
  if (FBorder <> Value) then begin
    FBorder := Value;
    Invalidate;
  end;
end;

procedure TDRLabel.SetCtl3D(Value: boolean);
begin
  if (FCtl3D <> Value) then begin
    FCtl3D := Value;
    Invalidate;
  end;
end;

procedure TDRLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  RectBorder,
  MyRect, ShadowRect: TRect;
  Text: array[0..255] of Char;
  Flags: Word;
  Colr : TColor;
begin
  with Canvas do begin
    if not Transparent then begin
    { Fill the area use by DRLabel }
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    MyRect      := ClientRect;
  end;

  { put border }
  RectBorder := Rect(MyRect.left, MyRect.top, MyRect.right-1, MyRect.bottom-1);
  case FBorder of
    boRaised : Frame3D(Canvas, RectBorder, clBtnHighlight,clBtnShadow, 1);
    boLowered: Frame3D(Canvas, RectBorder, clBtnShadow,clBtnHighlight, 1);
    boSingle : Frame3D(Canvas, RectBorder, clWindowFrame,clWindowFrame, 1);
  end;

  { Set flags to API DrawText function }
  Flags := (DT_EXPANDTABS or DT_WORDBREAK) or Alignments[Alignment];
  if not ShowAccelChar
    then Flags := Flags or DT_NOPREFIX;
  GetTextBuf(Text, SizeOf(Text));

  { Check whether the Text contains any characters }
  if (Flags and DT_CALCRECT <> 0) and ((Text[0] = #0) or ShowAccelChar and
     (Text[0] = '&') and (Text[1] = #0)) then
    StrCopy(Text, ' ');

  { Save label's font color and set it to ShadowColor }
  Colr := Font.Color;
  Canvas.Font := Font;
  Canvas.Font.Color := FShadowColor;

  if (FCtl3D) and (font.color <> color) then begin
    { Draw shadowed text in new position }
    ShadowRect.Left   := MyRect.Left + FDeep;
    ShadowRect.Top    := MyRect.Top + FDeep;
    ShadowRect.Right  := MyRect.Right + FDeep;
    ShadowRect.Bottom := MyRect.Bottom + FDeep;
    DrawText(Canvas.Handle, Text, StrLen(Text), ShadowRect, Flags);
  end;

  { Set the color of text }
  if not Enabled
    then Canvas.Font.Color := clGrayText
    else Canvas.Font.Color := Colr;

  { Draw the text in original position }
  if (font.color <> color)
    then DrawText(Canvas.Handle, Text, StrLen(Text), MyRect, Flags);
end;

procedure TDRLabel.FTimerOnTimer(sender:TObject);
begin
  if (FBlink = blHiLo) then begin
    if (font.color = FHiColor)
      then font.color := FLoColor
      else font.color := FHiColor;
  end
  else begin
    if (font.color = color)
      then font.color := FFontColor
      else font.color := color;
  end;
end;

procedure Register;
begin
  RegisterComponents('DROID',[TDRLabel]);
end;

end.
