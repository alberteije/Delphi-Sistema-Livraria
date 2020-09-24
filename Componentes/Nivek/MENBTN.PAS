{ TMenuButton version 1.0 copyright © by Alexander Meeder, 1996

  This button is 'subclassed' from TSpeedButton. You can assign a 'popupmenu' to it.
  When you click this button, the popupmenu appears at the bottom of this button, you
  can also click with the right mousebutton.

  Added properties/changed standard behaviour:

  added properties
  * Popupmenu
  * SeparateLine (yes/no)

  changed behaviour
  * default caption is '&Menu'
  * default height is 22
  * default layout is blGlyphRight
  * default margin between border and glyph is 4
  * default SeparateLine is false
  * default spacing between caption and glyph is 12
  * default width is 60

  You can use it for free, if you make changes or have suggestions,
  please mail me: ameeder@dds.nl
}

unit MenBtn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TUpDown = (IsUp, IsDown);

  TMenuButton = class(TSpeedButton)
  private
    FSeparateLine: boolean;
    MouseState: TUpDown;
    Mouse_Down: boolean;

    procedure SetSeparateLine(value: boolean);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure DrawSeparateLine(UpDown: TUpDown);
    procedure Click; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property SeparateLine: boolean read FSeparateLine write SetSeparateLine default false;
    property PopupMenu;
  end;

procedure Register;

implementation

procedure TMenuButton.DrawSeparateLine(UpDown: TUpDown);
var
  ExtraSpace, ShiftDown: integer;
  LinePoint: TPoint;
begin
  if SeparateLine then
  begin
    if UpDown = IsUp then ExtraSpace := 1 else ExtraSpace := -1;
    if UpDown = IsUp then ShiftDown := 0 else ShiftDown := 1;

    LinePoint.X := ClientWidth - ((2 * Margin) + (Glyph.Width div NumGlyphs) + 3);
    LinePoint.Y := 2 + ShiftDown;

    Canvas.Pen.Color := clWhite;
    Canvas.MoveTo(LinePoint.X, LinePoint.Y);
    Canvas.LineTo(LinePoint.X, (Height - 3) + ShiftDown);
    Canvas.Pen.Color := clGray;
    Canvas.MoveTo(LinePoint.X - ExtraSpace, LinePoint.Y);
    Canvas.LineTo(LinePoint.X - ExtraSpace, (Height - 3) + ShiftDown);
  end;
end;

procedure TMenuButton.SetSeparateLine(value: boolean);
begin
  if value <> FSeparateLine then
  begin
    FSeparateLine := value;
    invalidate;
  end;
end;

procedure TMenuButton.CMMouseEnter(var Message: TMessage);
begin
  if (Mouse_Down) and (SeparateLine) then
  begin
    MouseState := IsDown;
    invalidate;
  end
  else if (SeparateLine) then MouseState := IsUp;
end;

procedure TMenuButton.CMMouseLeave(var Message: TMessage);
begin
  if SeparateLine then
  begin
    MouseState := IsUp;
    invalidate;
  end;
end;

procedure TMenuButton.Click;
var
  P, Q: TPoint;
begin
  inherited Click;
  if PopupMenu <> nil then
  begin
    Q.X := 0;
    Q.Y := 0;
    P := ClientToScreen(Q);
    PopupMenu.Popup(P.X - 1, P.Y + Height)
  end;
end;

procedure TMenuButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    Mouse_Down := true;
    MouseState := IsDown;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure TMenuButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
  begin
    Mouse_Down := false;
    MouseState := IsUp;
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TMenuButton.Paint;
begin
  inherited Paint;
  DrawSeparateLine(MouseState);
end;

constructor TMenuButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  
  caption := '&Menu';
  height := 22;
  layout := blGlyphRight;
  margin := 4;
  SeparateLine := false;
  spacing := 12;
  width := 60;

  MouseState := IsUp;
  Mouse_Down := false;
end;

destructor TMenuButton.Destroy;
begin
  inherited Destroy;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TMenuButton]);
end;

end.
