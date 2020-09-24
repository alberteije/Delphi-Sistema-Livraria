unit Gradpan;

interface
uses
  SysUtils,WinTypes, WinProcs, Messages, Classes, ExtCtrls,Controls,menus,graphics,dialogs;
{--------------TGRADPAN V 1.0 -----------------------------------------------------------}
{- TPanel with gradient fill, bitmap background and text effects, moveable and sizeable -}
{-------------(C) Santiago Portela 1.998 ------------------------------------------------}
{--------------   sportela@cece.es ------------------------------------------------------}
{--------------  http://www.geocities.com/SiliconValley/Lakes/6217/index.htm  -----------}
{------ Free , free, free Free , free, free Free , free, free Free , free, free ---------}
{
   This is just as any other TPanel, whith some improvements on background paint,
    MOVEABLE AND SIZEABLE

   property Canvas:	tcanvas		Not published, but public so you can draw on it!
   property ColorStart:	tcolor		First color for gradients, or fill color if flat
   property ColorEnd:	tcolor		Last color for gradients
   property ColorShadow:tcolor		Color for the shadow of the text
   property Bitmap:	tbitmap		A bitmap to use as background
   					 Note: when you do GradPan1.Bitmap:=MyBitmap,
                                         it is ASSIGNED (copied), so you could free MyBitmap
   property BackGroundEffect:           Background effect:
		bdFlat   		Flat color (ColorStart)
                bdStretchImage		Use bitmap stretched to panel dimension
                bdTileImage		Use bitmap tiled
                bdUp			Vertical gradient from ColorStart to ColorEnd
                bdDown			Vertical gradient from ColorEnd to ColorStart
                bdLeft			Horizontal gradient from ColorStart to ColorEnd
                bdRight			Horizontal gradient from ColorEnd to ColorStart
                bdHorzIn                Horizontal gradient from ColorStart to ColorEnd and back
                bdHorzOut		Horizontal gradient from ColorEnd to ColorStart and back
                bdVertIn		Vertical gradient from ColorStart to ColorEnd and back
                bdVertOut		Vertical gradient from ColorEnd to ColorStart
   property Ctl3D:boolean		If true (beware of ParentCtl3d), the border is drawn
   					in the Color property color. If false, the background
                                        effect covers the whole extend of the panel
   property TextEffect:                 Text effect for the caption
   		tenone			The text is simply drawn in the Font property font
                teShadow		A shadow is drawn below the text in the ColorShadow property color
                teRaised		A shadow is drawn below the text in black; the borders are highlighted in Colorshadow
                teLowered		A highlight is drawn below the text in black; the borders are shadowed in black
                teEmbossed		A highlight is drawn around the text in ColorShadow
   property TextRotation:		Direction for drawing the text
		trNone			Horizontal, left to right
                TrUp			Vertical, down to up
                TrDown			Vertical, up to down
   property VertAlign:			Where to put the text
                vlTop			close (aligned if vertical) to the up border
                vlCenter		centered vertically
                VlBottom		close (aligned if vertical) to the udown border
   property Alignment:			Alignment of the text
   		taCenter      		centered horizontally
                taLeftJustify		close (aligned y horizontal) to the left border
                taRightJustify          close (aligned y horizontal) to the right border

   Property Moveable:boolean		Whether the panel is user-moveable ot not
   property Marge:			Marge -in pixels- for detecting the mouse in
   					the sizeable borders. If 0, not sizeable
   property OnPanelMove:		An event if you want to do something when it moves


}
const mxcolors=100;
type
   TDirection = (bdFlat,bdStretchImage,bdTileImage,bdUp, bdDown, bdLeft, bdRight, bdHorzIn, bdHorzOut, bdVertIn, bdVertOut);
   TOneWayType = (Up, Down, DLeft, DRight);
   TTwoWayType = (DIn, DOut);
   TTwoWayDir = (Horz, Vert);
   TVertAlign = (vlTop,vlCenter,VlBottom);
   TTextEffect = (tenone, teShadow, teRaised,teLowered,teEmbossed);
   TTextRotation = (trNone, TrUp, TrDown);
   TGrArray=array[1..mxcolors] of tcolor;

type
  TGradPan = class(Tpanel)
   constructor Create(AComponent: TComponent); override;
   destructor destroy; override;
   procedure Loaded; override;
  private
    { Private declarations }
   FDir: TDirection;
   fvertalign:TVertAlign;
   bgrgb,fgrgb,forgb:tcolor;
   fte:TTextEffect;
   ftr:TTextRotation;
   fCtl3D:boolean;
   fpicture:TBitmap;
   ga:tgrarray;
    fmarge:integer;
    fOnPanelMoved:TNotifyEvent;
    fmoveable:boolean;

   {***}
   procedure SetDir(Dir: TDirection);
   procedure SetbgColor(Clr: TColor);
   procedure SetfgColor(Clr: TColor);
   procedure SetfoColor(Clr: TColor);
   procedure SetTextEffect(e:TTextEffect);
   procedure SetVertAlign(a:TVertAlign);
   procedure SetTextRotation(r:TTextRotation);
   procedure SetCtl3d(v:boolean);
   procedure SetBitmap(b:tbitmap);
   Procedure BitmapChanged(sender:tobject);


   {***}
   procedure TextOutAngle(x,y: Integer; angle: Word; s: string);
   Procedure CalcColGradients(col1,col2:tcolor;n:integer);
   procedure HorzOneWay;
   procedure HorzTwoWay;
   procedure VertOneWay;
   procedure VertTwoWay;
   procedure FillOneWay(WType: TOneWayType);
   procedure FillTwoWay(WType: TTwoWayType; WDir: TTwoWayDir);
   procedure FillSimple;
   procedure Borders;
   procedure Images;

  protected
     procedure Paint; override;
     procedure PanelMove(var M: TWMNCHitTest); message WM_NCHITTEST;
     procedure PanelMoved(var M: Tmessage); message WM_MOVE;
  public
    property canvas;

  published
   { Published declarations }
   property Bitmap:TBitmap read fpicture write SetBitmap;
   property BackGroundEffect: TDirection read FDir write SetDir default bdVertIn;
   property ColorEnd:TColor read Bgrgb write SetBgColor default clwhite;
   property ColorShadow:TColor read Forgb write SetFoColor default clGray;
   property ColorStart:TColor read fgrgb write SetFgColor default clTeal;
   property Ctl3D:boolean read fCtl3D write SetCtl3D default false;
   property TextEffect:TTextEffect read fte write SetTextEffect default teShadow;
   property TextRotation:TTextRotation read ftr write SetTextRotation default trNone;
   property VertAlign:TVertAlign read fVertAlign write SetVertAlign default vlCenter;

   property Marge:integer read fmarge write fmarge default 6;
   property OnPanelMove:TNotifyEvent read fOnPanelMoved write fOnPanelMoved;
   Property Moveable:boolean read fmoveable write fmoveable default false;
  end;

procedure Register;

implementation
{=========================================================================}

procedure TGradPan.PanelMove(var M: TWMNCHitTest);
var p:tpoint;
begin
 if csDesigning in ComponentState then begin
    parent.dispatch(m);
    exit;
 end;
 if fmoveable then begin
  p.x:=m.xpos;p.y:=m.ypos;
  p:=screentoclient(p);
  if ((p.x<fmarge) and (p.y<fmarge)) then m.result:=httopleft
  else
  if ((p.x<fmarge) and (height-p.y<fmarge)) then m.result:=htbottomleft
  else
  if (p.x<fmarge) then m.result:=htleft
  else
  if ((width- p.x<fmarge) and (p.y<fmarge)) then m.result:=httopright
  else
  if ((width- p.x<fmarge) and (height-p.y<fmarge)) then m.result:=htbottomright
  else
  if (width- p.x<fmarge) then m.result:=htright
  else
  if (p.y<fmarge) then m.result:=httop
  else
  if (height-p.y<fmarge) then m.result:=htbottom
  else m.result:=htcaption;
 end;
end;

procedure TGradPan.PanelMoved(var M: Tmessage);
begin
  if assigned(FonPanelMoved) then FOnPanelMoved(self);
  inherited;
end;


procedure TGradPan.CalcColGradients(col1,col2:tcolor;n:integer);
   var i:integer;
       ar,ag,ab,br,bb,bg:integer;
       kr,kg,kb:real;
   begin
     ar:=GetRValue(col1);br:=GetRValue(col2);
     AG:=GetGValue(col1);bG:=GetGValue(col2);
     AB:=GetBValue(col1);bB:=GetBValue(col2);
     kr:=(br-ar) /n;
     kg:=(bg-ag) /n;
     kb:=(bb-ab) /n;
     for i:=0 to n-1 do
     ga[i+1]:=rgb(trunc(ar + i*kr),trunc(ag+i*kg),trunc(ab+i*kb));
   end;

procedure TGradPan.TextOutAngle(x,y: Integer; angle: Word; s: string);
var
  h:hdc;
  LogRec: TLOGFONT;
  OldFontHandle,
  NewFontHandle: HFONT;
  a:array[0..255] of char;
begin
  h:=canvas.handle;
  angle:=angle*10;
  GetObject(canvas.font.handle, SizeOf(LogRec), Addr(LogRec));
  LogRec.lfEscapement := angle;
  NewFontHandle := CreateFontIndirect(LogRec);
  OldFontHandle:=SelectObject(h,NewFontHandle);
  strpcopy(a,s);
  textout(h,x,y,a,length(s));
  SelectObject(h,OldFontHandle);
  DeleteObject(NewFontHandle);
end;

constructor TGradPan.Create(AComponent: TComponent);
begin
   inherited Create(AComponent);
   FDir := bdVertIn;
   fte:=teShadow;
   ftr:=trNone;
   fvertalign:=vlcenter;
   bgrgb:=clwhite;
   fgrgb:=clteal;
   forgb:=clgray;
   fpicture:=tbitmap.create;
   fpicture.width:=50;
   fpicture.height:=50;
   fpicture.canvas.brush.color:=clwhite;
   fpicture.canvas.rectangle(0,0,49,49);
   fpicture.Onchange:=BitmapChanged;
   fmarge:=6;
   fmoveable:=false;
end;

destructor TGradPan.Destroy;
begin
   fpicture.free;
   inherited destroy;
end;
procedure TGradPan.Loaded;
begin
   inherited Loaded;
end;



procedure TGradPan.SetBitmap(b:tbitmap);
begin
  fpicture.assign(b);
end;

Procedure TGradPan.BitmapChanged(sender:tobject);
begin
      if FDir in [bdStretchImage,bdTileImage] then repaint;
end;

procedure TGradPan.SetCtl3d(v:boolean);
begin
 fCtl3D:=v;
 repaint;
end;

procedure TGradPan.SetTextEffect(e:TTextEffect);
begin
 fte:=e;
 repaint;
end;

procedure TGradPan.SetVertAlign(a:TVertAlign);
begin
 fVertAlign:=a;
 repaint;
end;

procedure TGradPan.SetTextRotation(r:TTextRotation);
begin
   ftr:=r;
   repaint;
end;

procedure TGradPan.SetDir(Dir: TDirection);
begin
   FDir := Dir;
   Repaint;
end;

procedure TGradPan.SetFgColor(Clr: TColor);
begin
   fgrgb:=clr;
   Repaint;
end;

procedure TGradPan.SetBgColor(Clr: TColor);
begin
   bgrgb:=Clr;
   Repaint;
end;

procedure TGradPan.SetFoColor(Clr: TColor);
begin
   forgb:=Clr;
   Repaint;
end;


procedure TGradPan.Borders;
   procedure line(x1,y1,x2,y2:integer);
   begin
    canvas.moveto(x1,y1);canvas.lineto(x2,y2);
   end;
var i,k:integer;
begin

   k:=1;
   if bevelouter<>bvnone then with canvas do begin
         if bevelouter=bvraised then pen.color:=clwhite
         else pen.color:=clgray;
                for i:=0 to bevelwidth-1 do begin
                line(i,i,width,i);line(i,i,i,height);
                end;
         if bevelouter=bvraised then pen.color:=clgray
         else pen.color:=clwhite;
                for i:=0 to bevelwidth-1 do begin
                line(i,height-1-i,width-i,height-1-i);
                line(width-1-i,height-1-i,width-1-i,i);
                end;
         k:=bevelwidth;
   end;

   k:=k+borderwidth;
   if bevelinner<>bvnone then with canvas do begin
         if bevelinner =bvraised then pen.color:=clwhite
         else pen.color:=clgray;
                for i:=0 to bevelwidth-1 do begin
                line(i+k,i+k,width-k-i,i+k);
                line(i+k,i+k,i+k,height-k-i);
                end;
         if bevelinner=bvraised then pen.color:=clgray
         else pen.color:=clwhite;
                for i:=0 to bevelwidth-1 do begin
                line(i+k,height-k-i-1,width-k-i,height-k-i-1);
                line(width-k-i-1,height-k-1,width-k-i-1,i+k);
                end;
   end;
   if bevelouter<>bvnone then k:=bevelwidth-1 else k:=0;
   if Ctl3D then
   if bevelinner<>bvnone then begin
    canvas.brush.color:=color;
    for i:=1 to borderwidth do
    canvas.framerect(rect ( k+i,k+i,width-i-k,height-i-k));
   end;

end;

procedure TGradPan.FillSimple;
var
  Banda : TRect;
begin
   Banda.Left := 0;
   Banda.Right := Width;
   Banda.top:=0;
   Banda.bottom:=height;
   canvas.brush.color:=fgrgb;
   canvas.FillRect (Banda);
end;


procedure TGradPan.HorzOneWay;
var
  Banda : TRect;
  I         : Integer;
begin
   Banda.Left := 0;
   Banda.Right := Width;
   with canvas do
   for I := 0 to mxcolors-1 do
   begin
       Banda.Top    := MulDiv (I    , Height, mxcolors);
       Banda.Bottom := MulDiv (I + 1, Height, mxcolors);
       Brush.Color := ga[i+1];
       FillRect (Banda);
   end;
end;

procedure TGradPan.VertOneWay;
var
  Banda : TRect;
  I         : Integer;
begin
   Banda.Top := 0;
   Banda.Bottom := Height;
   with canvas do
   for I := 0 to mxcolors-1 do
   begin
       Banda.Left    := MulDiv (I    , Width, mxcolors);
       Banda.Right := MulDiv (I + 1, Width, mxcolors);
       Brush.Color := ga[i+1];
       FillRect (Banda);
   end;
end;

procedure TGradPan.HorzTwoWay;
var
  Banda : TRect;
  q,I         : Integer;
begin
   Banda.Left := 0;
   Banda.Right := Width;
   q:= mxcolors div 2;
   with canvas do
   for I := 0 to q-1 do
   begin
       Banda.Top    := MulDiv (I    , Height, mxcolors);
       Banda.Bottom := MulDiv (I + 1, Height, mxcolors);
       Brush.Color := ga[2*(i+1)];
       FillRect (Banda);
   end;
   with canvas do for I := q to mxcolors-1 do
   begin
       Banda.Top    := MulDiv (I    , Height, mxcolors);
       Banda.Bottom := MulDiv (I + 1, Height, mxcolors);
       Brush.Color := ga[mxcolors+1 - 2*(i-q+1)];
       FillRect (Banda);
   end;
end;

procedure TGradPan.VertTwoWay;
var
  Banda : TRect;
  I,q         : Integer;
begin
   Banda.Top := 0;
   Banda.Bottom := Height;
   q:=mxcolors div 2;
   with canvas do
   for I := 0 to q -1 do
   begin
       Banda.Left    := MulDiv (I    , Width, mxcolors);
       Banda.Right := MulDiv (I + 1, Width, mxcolors);
       Brush.Color := ga[2*(i+1)];
       FillRect (Banda);
   end;
   with canvas do
   for I := q  to mxcolors-1 do
   begin
       Banda.Left    := MulDiv (I    , Width, mxcolors);
       Banda.Right := MulDiv (I + 1, Width, mxcolors);
       Brush.Color := ga[mxcolors+1 - 2*(i-q+1)];
       FillRect (Banda);
   end;
end;




procedure TGradPan.FillOneWay(WType: TOneWayType);
begin
  if wtype in[Up,Dleft] then CalcColGradients(fgrgb,bgrgb,mxcolors)
  else CalcColGradients(bgrgb,fgrgb,mxcolors);
   if WType = Up then HorzOneWay;
   if WType = Down then HorzOneWay;
   if WType = DLeft then VertOneWay;
   if WType = DRight then VertOneWay;
end;

procedure TGradPan.FillTwoWay(WType: TTwoWayType; WDir: TTwoWayDir);
begin
  if wtype=DIn then CalcColGradients(fgrgb,bgrgb,mxcolors)
  else CalcColGradients(bgrgb,fgrgb,mxcolors);
  if WDir = Horz then HorzTwoWay else VertTwoWay;
end;


procedure TGradPan.Images;
var i,j,k:integer;
    x,y:integer;
begin
      if ctl3d then k:=borderwidth+2*bevelwidth else k:=0;
      if fpicture=nil then FillSimple
      else
      if fpicture.empty then FillSimple
      else
      if FDir=bdStretchImage then begin
          canvas.StretchDraw(rect(k,k,width-k-1,height-k-1),fpicture);
      end
      else begin
          x:=1+(width-2*k) div fpicture.width;
          y:=1+(height-2*k) div fpicture.height;
          for i:=1 to x do for j:=1 to y do
	  canvas.Draw(k+fpicture.width*(i-1),k+fpicture.height*(j-1),fpicture);
      end;
end;



procedure TGradPan.Paint;
var
   UseClr: TColor;
   x,y,angle:integer;
   downcol,upcol:tcolor;

begin
   canvas.font.assign(font);
   Canvas.Pen.Style := psSolid;
   Canvas.Pen.Mode := pmCopy;
   inherited paint;
   x:=0;y:=0;angle:=0;
   if FDir = bdFlat then FillSimple;
   if FDir = bdUp then   FillOneWay(Up);
   if FDir = bdDown then FillOneWay(Down);
   if FDir = bdLeft then FillOneWay(DLeft);
   if FDir = bdRight then FillOneWay(DRight);
   if FDir = bdHorzOut then FillTwoWay(DOut, Horz);
   if FDir = bdHorzIn then FillTwoWay(DIn, Horz);
   if FDir = bdVertIn then FillTwoWay(DIn, Vert);
   if FDir = bdVertOut then FillTwoWay(DOut, Vert);
   if FDir in [bdStretchImage,bdTileImage] then Images;
   {-------------------Draw text ---------------------------}
   setBkMode(canvas.handle,1);

   case ftr of
     trUp:begin
      case alignment of
       taleftjustify:begin
                        x:=borderwidth+bevelwidth+2;
                     end;
       tarightjustify:begin
                        x:=width-borderwidth-bevelwidth- canvas.textHEIGHT('^_')-1;
                     end;
       tacenter:begin
                        x:=width div 2  - canvas.textHEIGHT('^_') div 2;
                end;
      end;
      case VertAlign of
          vlTop: begin
           		y:=borderwidth+bevelwidth+2;
                        settextalign(canvas.handle,TA_RIGHT OR TA_TOP);
                 end;
          vlCenter: begin
                        settextalign(canvas.handle,TA_CENTER OR TA_TOP);
          		y:=height div 2 - canvas.textHEIGHT('^_') div 2;
                    end;
          VlBottom: begin
                        settextalign(canvas.handle,TA_LEFT OR TA_TOP);
         		y:=height -borderwidth -bevelwidth -1;
                    end;
      end;
     end;
     trDown:begin
      case alignment of
       taleftjustify:begin
                        x:=borderwidth+bevelwidth+ canvas.textHEIGHT('^_')+1;
                     end;
       tarightjustify:begin
                        x:=width-borderwidth-bevelwidth-2;
                     end;
       tacenter:begin
                        x:=width div 2  + canvas.textHEIGHT('^_') div 2;
                end;
      end;
      case VertAlign of
          vlTop: begin
                        settextalign(canvas.handle,TA_LEFT OR TA_TOP);
         		y:=borderwidth +bevelwidth +1;
                 end;
          vlCenter: begin
                        settextalign(canvas.handle,TA_CENTER OR TA_TOP);
          		y:=height div 2 - canvas.textHEIGHT('^_') div 2;
                    end;
          VlBottom: begin
           		y:=height-borderwidth-bevelwidth-2;
                        settextalign(canvas.handle,TA_RIGHT OR TA_TOP);
                    end;
      end;
     end;

     else begin
      case alignment of
       taleftjustify:begin
                        settextalign(canvas.handle,TA_LEFT OR TA_TOP);
                        x:=borderwidth+bevelwidth+2;
                     end;
       tarightjustify:begin
                        settextalign(canvas.handle,TA_RIGHT OR TA_TOP);
                        x:=width-borderwidth-bevelwidth-2;
                     end;
       tacenter:begin
                        settextalign(canvas.handle,TA_CENTER OR TA_TOP);
                        x:=width div 2;
                end;
      end;
      case VertAlign of
          vlTop: y:=borderwidth+bevelwidth+2;
          vlCenter: y:=height div 2 - canvas.textHEIGHT('^_') div 2;
          VlBottom: y:=height -borderwidth -bevelwidth - canvas.textHEIGHT('^_')-1;
      end;
     end;

    end;

  useclr:=canvas.font.color;
  canvas.font.color:=forgb;
  downcol:=clblack;
  upcol:=forgb;

  case ftr of trnone:angle:=0;trup:angle:=90;trdown:angle:=270;end;
  case ftr of
	trNone:case fte of
        	tenone:canvas.textout(x,y,caption);
                teShadow:begin
		                canvas.textout(x+1,y+1,caption);
				canvas.font.color:=useclr;
				canvas.textout(x,y,caption);
                          end;
                teLowered:begin
                                canvas.font.color:=upcol;
                                canvas.textout(x+1,y,caption);
                                canvas.textout(x,y+1,caption);
                                canvas.font.color:=downcol;
		                canvas.textout(x-1,y,caption);
                                canvas.textout(x,y-1,caption);
				canvas.font.color:=useclr;
				canvas.textout(x,y,caption);
                          end;
                teRaised:begin
                                canvas.font.color:=upcol;
		                canvas.textout(x-1,y,caption);
                                canvas.textout(x,y-1,caption);
                                canvas.font.color:=downcol;
                                canvas.textout(x+1,y,caption);
                                canvas.textout(x,y+1,caption);
				canvas.font.color:=useclr;
				canvas.textout(x,y,caption);
                          end;
                teEmbossed:begin
				canvas.font.color:=upcol;
		                canvas.textout(x-1,y,caption);
                                canvas.textout(x+1,y,caption);
		                canvas.textout(x,y-1,caption);
                                canvas.textout(x,y+1,caption);

				canvas.font.color:=useclr;
				canvas.textout(x,y,caption);
                          end;
               end;
        TrUp,TrDown:  case fte of
        	tenone:textoutangle(x,y,angle,caption);
                teShadow:begin
		                textoutangle(x+1,y+1,angle,caption);
				canvas.font.color:=useclr;
				textoutangle(x,y,angle,caption);
                          end;
                telowered:begin
                                canvas.font.color:=upcol;
		                TextOutAngle(x+1,y,angle,caption);
                                TextOutAngle(x,y+1,angle,caption);
                                canvas.font.color:=downcol;
		                TextOutAngle(x-1,y,angle,caption);
                                TextOutAngle(x,y-1,angle,caption);
				canvas.font.color:=useclr;
				textoutangle(x,y,angle,caption);
                          end;
                teRaised:begin
                                canvas.font.color:=upcol;
		                TextOutAngle(x-1,y,angle,caption);
                                TextOutAngle(x,y-1,angle,caption);
                                canvas.font.color:=downcol;
		                TextOutAngle(x+1,y,angle,caption);
                                TextOutAngle(x,y+1,angle,caption);
				canvas.font.color:=useclr;
				textoutangle(x,y,angle,caption);
                          end;
                teEmbossed:begin
                                canvas.font.color:=upcol;
                                textoutangle(x,y-1,angle,caption);
		                textoutangle(x,y+1,angle,caption);
                                textoutangle(x-1,y,angle,caption);
		                textoutangle(x+1,y,angle,caption);
				canvas.font.color:=useclr;
				textoutangle(x,y,angle,caption);
                          end;
               end;
  end;
  borders;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TGradPan]);
end;


end.
