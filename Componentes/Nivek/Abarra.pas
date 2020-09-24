{ Arquivo     : ABARRA.PAS                                                    }
{ Componentes : TABARRA, TABARRAPRINTER                                       }
{ Notas       : Componentes para Apresentacao e impressao de codigos de barra }
{ Autor       : Alvaro Luiz Arouche Carneiro Ramos                            }

unit abarra;

interface

uses 
   SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
   Forms, Dialogs, ExtCtrls, Printers, Stdctrls;

type

   TTipo   = (cdEAN13,cdEAN8,cdUPC,cd2de5,cd3x9);

   TABarra = class(TGraphicControl)

   private
      fCorBarra  : TColor;
      fCorEspaco : TColor;
      fTipo      : TTipo;
      fCodigo    : string;
      fDigito    : string; 
      fLargura   : integer;
      procedure  SetCorBarra  (Value: TColor);
      procedure  SetCorEspaco (Value: TColor);
      procedure  SetTipo      (Value: TTipo);
      procedure  SetCodigo    (Value: string);
      procedure  SetLargura   (Value: integer);
      procedure  DrawColuna   (Coluna,Modo:Integer);

   protected
      procedure Paint; Override;

   public
      constructor Create(AOwner: TComponent); override;
      destructor  Destroy; override;
      procedure   Barra(Sender: TObject);

   published
      property Align;
      property ShowHint;
      property Visible;
      property OnClick;
      property OnDblClick;
      property OnDragDrop;
      property OnDragOver;
      property OnEndDrag;
      property OnMouseDown;
      property OnMouseMove;
      property OnMouseUp;
      property Digito    : string  read fDigito    write fDigito; 
      property CorBarra  : TColor  read fCorBarra  write SetCorBarra;
      property CorEspaco : TColor  read fCorEspaco write SetCorEspaco;
      property Tipo      : TTipo   read fTipo      write SetTipo;
      property Codigo    : string  read fCodigo    write SetCodigo;
      property Largura   : integer read fLargura   write SetLargura;
   end;

type

   TABarraPrinter = class(TComponent)

   private
      fLinhaPrinter  : integer;
      fColunaPrinter : integer;
      fCorBarra      : TColor;
      fCorEspaco     : TColor;
      fTipo          : TTipo;
      fCodigo        : string;
      fDigito        : string;
      fLargura       : integer;
      fComprimento   : integer;
      procedure      Imprime;
      procedure      DrawColunaPrinter(Coluna,Modo:Integer);

   protected

   public
      procedure Execute;

   published
      property Digito        : string  read fDigito        write fDigito;  
      property LinhaPrinter  : integer read fLinhaPrinter  write fLinhaPrinter;
      property ColunaPrinter : integer read fColunaPrinter write fColunaPrinter;
      property CorBarra      : TColor  read fCorBarra      write fCorBarra;
      property CorEspaco     : TColor  read fCorEspaco     write fCorEspaco;
      property Tipo          : TTipo   read fTipo          write fTipo;
      property Codigo        : string  read fCodigo        write fCodigo;
      property Largura       : integer read fLargura       write fLargura;
      property Comprimento   : integer read fComprimento   write fComprimento;
   end;

procedure Register;
function  DefineEAN13 (CodigoC:string):string;
function  DefineEAN8  (CodigoC:string):string;
function  DefineUPC   (CodigoC:string):string;
function  Define2de5  (CodigoC:string):string;
function  Define3x9   (CodigoC:string):string;

var
   DigitoPEG : string;

implementation

Procedure Register;
begin
   RegisterComponents('Samples',[TABarra,TABarraPrinter]);
end;

constructor TABarra.Create(AOwner: TComponent);
begin
   inherited Create(AOwner);
   left      := 20;
   top       := 20;
   height    := 100;
   width     := 100;
   Largura   := 1;
   Codigo    := '123456789123';
   fDigito   := ' ';
   Tipo      := cdEAN13;
   CorBarra  := clBlack;
   CorEspaco := clWhite;
end;

destructor TABarra.Destroy;
begin
   Repaint;
   inherited Destroy;
end;

procedure TABarra.Barra(Sender: TObject);
begin
   Paint;
end;

procedure TABarra.Paint;
var
   X         : integer;
   Col       : integer;
   Lar       : integer;
   CodigoExt : string;
begin
   if Tipo = cdEAN13 then CodigoExt := DefineEAN13 (Codigo);
   if Tipo = cdEAN8  then CodigoExt := DefineEAN8  (Codigo);
   if Tipo = cdUPC   then CodigoExt := DefineUPC   (Codigo);
   if Tipo = cd2de5  then CodigoExt := Define2de5  (Codigo);
   if Tipo = cd3x9   then CodigoExt := Define3x9   (Codigo);
   Digito := DigitoPEG;
   Col    := 0;
   if Largura < 1 then Largura := 1;
   if CodigoExt <> 'Erro' then
   begin
      for X := 1 to length(CodigoExt) do
      begin
         for Lar := 1 to Largura do
         begin
            if CodigoExt[X] = '0' then DrawColuna(Col,0);
            if CodigoExt[X] = '1' then DrawColuna(Col,1);
            Col := Col + 1;
         end;
      end;
      Width := Col + 1;
   end
   else
   begin
      Canvas.TextOut(0,0,'Erro');
      Width := 30;
   end;
end;

procedure  TABarra.DrawColuna(Coluna,Modo:Integer);
begin
   with Canvas do
   begin
      if Modo = 0 then Pen.Color := CorEspaco;
      if Modo = 1 then Pen.Color := CorBarra;
      moveto(Coluna,0);
      lineto(Coluna,height);
   end;
end;

procedure TABarraPrinter.Execute;
begin
   Imprime;
end;

procedure TABarraPrinter.Imprime;
var
   X         : integer;
   Col       : integer;
   Lar       : integer;
   CodigoExt : string;
begin
   if Tipo = cdEAN13 then CodigoExt := DefineEAN13 (Codigo);
   if Tipo = cdEAN8  then CodigoExt := DefineEAN8  (Codigo);
   if Tipo = cdUPC   then CodigoExt := DefineUPC   (Codigo);
   if Tipo = cd2de5  then CodigoExt := Define2de5  (Codigo);
   if Tipo = cd3x9   then CodigoExt := Define3x9   (Codigo);
   Digito := DigitoPEG;
   Col    := 0;
   if Largura < 1 then Largura := 1;
   if CodigoExt <> 'Erro' then
   begin
      for X := 1 to length(CodigoExt) do
      begin
         for Lar := 1 to Largura do
         begin
            if CodigoExt[X] = '0' then DrawColunaPrinter(Col,0);
            if CodigoExt[X] = '1' then DrawColunaPrinter(Col,1);
            Col := Col + 1;
         end;
      end;
   end
   else Printer.Canvas.TextOut(ColunaPrinter,LinhaPrinter,'Erro');
end;

procedure TABarraPrinter.DrawColunaPrinter(Coluna,Modo:Integer);
begin
   with Printer.Canvas do
   begin
      if Modo = 0 then Pen.Color := CorEspaco;
      if Modo = 1 then Pen.Color := CorBarra;
      moveto(Coluna+ColunaPrinter,LinhaPrinter);
      lineto(Coluna+ColunaPrinter,LinhaPrinter+(8*Comprimento));
   end;
end;

function DefineEAN13(CodigoC:string):string;
var
   Codifi  : string;
   Guarda  : string;
   Central : string;
   Te13A   : array[0..9] of string;
   Te13B   : array[0..9] of string;
   Te13C   : array[0..9] of string;
   Soma1   : integer;
   Soma2   : integer;
   Soma    : integer;
   Digi    : integer;
   I       : integer;
begin
   DefineEAN13 := 'Erro';
   for I := 1 to length(CodigoC) do
   begin
      if (CodigoC[I] <> '0') and
         (CodigoC[I] <> '1') and
         (CodigoC[I] <> '2') and
         (CodigoC[I] <> '3') and
         (CodigoC[I] <> '4') and
         (CodigoC[I] <> '5') and
         (CodigoC[I] <> '6') and
         (CodigoC[I] <> '7') and
         (CodigoC[I] <> '8') and
         (CodigoC[I] <> '9') then exit;
   end;
   if (length(CodigoC) = 12) then
   begin
      Guarda   := '101';
      Central  := '01010';
      Te13A[0] := '0001101'; {0}
      Te13A[1] := '0011001'; {1}
      Te13A[2] := '0010011'; {2}
      Te13A[3] := '0111101'; {3}
      Te13A[4] := '0100011'; {4}
      Te13A[5] := '0110001'; {5}
      Te13A[6] := '0101111'; {6}
      Te13A[7] := '0111011'; {7}
      Te13A[8] := '0110111'; {8}
      Te13A[9] := '0001011'; {9}
      Te13B[0] := '0100111';
      Te13B[1] := '0110011';
      Te13B[2] := '0011011';
      Te13B[3] := '0100001';
      Te13B[4] := '0011101';
      Te13B[5] := '0111001';
      Te13B[6] := '0000101';
      Te13B[7] := '0010001';
      Te13B[8] := '0001001';
      Te13B[9] := '0010111';
      Te13C[0] := '1110010';
      Te13C[1] := '1100110';
      Te13C[2] := '1101100';
      Te13C[3] := '1000010';
      Te13C[4] := '1011100';
      Te13C[5] := '1001110';
      Te13C[6] := '1010000';
      Te13C[7] := '1000100';
      Te13C[8] := '1001000';
      Te13C[9] := '1110100';
      { Calcula digito Verificador }
      Soma1 := StrToInt(CodigoC[ 2])+
               StrToInt(CodigoC[ 4])+
               StrToInt(CodigoC[ 6])+
               StrToInt(CodigoC[ 8])+
               StrToInt(CodigoC[10])+
               StrToInt(CodigoC[12]);
      Soma2 := StrToInt(CodigoC[ 1])+
               StrToInt(CodigoC[ 3])+
               StrToInt(CodigoC[ 5])+
               StrToInt(CodigoC[ 7])+
               StrToInt(CodigoC[ 9])+
               StrToInt(CodigoC[11]);
      Soma1 := Soma1 * 3;
      Soma  := Soma1 + Soma2;
      Digi := 0;
      if ((Soma mod 10) <> 0) and (Soma > 9) then Digi := 10-(Soma mod 10);
      if (Soma < 10) and (Soma > 0) then Digi := 10-Soma;
      DigitoPEG := IntToStr(Digi);
      { Caracter de Guarda }
      Codifi := Guarda;
      { Digitos }
      for I := 2 to 12 do
      begin
         if I = 8 then Codifi := Codifi + Central;
         if I > 7 then Codifi := Codifi + Te13C[StrToInt(CodigoC[I])]
         else
         begin
            Case CodigoC[1] of
            '0' :
            begin
               Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '1' :
            begin
               if (I=4) or (I=6) or (I=7) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '2' :
            begin
               if (I=4) or (I=5) or (I=7) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '3' :
            begin
               if (I=4) or (I=5) or (I=6) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '4' :
            begin
               if (I=3) or (I=6) or (I=7) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '5' :
            begin
               if (I=3) or (I=4) or (I=7) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '6' :
            begin
               if (I=3) or (I=4) or (I=5) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '7' :
            begin
               if (I=3) or (I=5) or (I=7) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '8' :
            begin
               if (I=3) or (I=5) or (I=6) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            '9' :
            begin
              if (I=3) or (I=4) or (I=6) then
                  Codifi := Codifi + Te13B[StrToInt(CodigoC[I])]
               else
                  Codifi := Codifi + Te13A[StrToInt(CodigoC[I])];
            end;
            end;
         end;
      end;
      { Digito de Controle }
      Codifi      := Codifi + Te13C[Digi];
      { Caracter de Guarda }
      Codifi      := Codifi + Guarda;
      DefineEAN13 := Codifi;
   end;
end;

function DefineEAN8(CodigoC:string):string;
var
   Codifi  : string;
   Guarda  : string;
   Central : string;
   Te8A    : array[0..9] of string;
   Te8C    : array[0..9] of string;
   Soma1   : integer;
   Soma2   : integer;
   Soma    : integer;
   Digi    : integer;
   I       : integer;
begin
   DefineEAN8 := 'Erro';
   for I := 1 to length(CodigoC) do
   begin
      if (CodigoC[I] <> '0') and
         (CodigoC[I] <> '1') and
         (CodigoC[I] <> '2') and
         (CodigoC[I] <> '3') and
         (CodigoC[I] <> '4') and
         (CodigoC[I] <> '5') and
         (CodigoC[I] <> '6') and
         (CodigoC[I] <> '7') and
         (CodigoC[I] <> '8') and
         (CodigoC[I] <> '9') then exit;
   end;
   if (length(CodigoC) = 7) then
   begin
      Guarda  := '101';
      Central := '01010';
      Te8A[0] := '0001101'; {0}
      Te8A[1] := '0011001'; {1}
      Te8A[2] := '0010011'; {2}
      Te8A[3] := '0111101'; {3}
      Te8A[4] := '0100011'; {4}
      Te8A[5] := '0110001'; {5}
      Te8A[6] := '0101111'; {6}
      Te8A[7] := '0111011'; {7}
      Te8A[8] := '0110111'; {8}
      Te8A[9] := '0001011'; {9}
      Te8C[0] := '1110010';
      Te8C[1] := '1100110';
      Te8C[2] := '1101100';
      Te8C[3] := '1000010';
      Te8C[4] := '1011100';
      Te8C[5] := '1001110';
      Te8C[6] := '1010000';
      Te8C[7] := '1000100';
      Te8C[8] := '1001000';
      Te8C[9] := '1110100';
      { Calcula digito Verificador }
      Soma1 := StrToInt(CodigoC[ 1])+
               StrToInt(CodigoC[ 3])+
               StrToInt(CodigoC[ 5])+
               StrToInt(CodigoC[ 7]);
      Soma2 := StrToInt(CodigoC[ 2])+
               StrToInt(CodigoC[ 4])+
               StrToInt(CodigoC[ 6]);
      Soma1 := Soma1 * 3;
      Soma  := Soma1 + Soma2;
      Digi  := 0;
      if ((Soma mod 10) <> 0) and (Soma > 9) then Digi := 10-(Soma mod 10);
      if (Soma < 10) and (Soma > 0) then Digi := 10-Soma;
      DigitoPEG := IntToStr(Digi);
      { Caracter de Guarda }
      Codifi := Guarda;
      { Digitos }
      for I := 1 to 7 do
      begin
         if I = 5 then Codifi := Codifi + Central;
         If I < 5 then Codifi := Codifi + Te8A[StrToInt(CodigoC[I])];
         if I > 4 then Codifi := Codifi + Te8C[StrToInt(CodigoC[I])];
      end;
      { Digito Verificador }
      Codifi     := Codifi + Te8C[Digi];
      { Caracter de Guarda }
      Codifi     := Codifi + Guarda;
      DefineEAN8 := Codifi;
   end;
end;

function DefineUPC(CodigoC:string):string;
var
   Codifi  : string;
   Guarda  : string;
   Central : string;
   TUPCA   : array[0..9] of string;
   TUPCC   : array[0..9] of string;
   Soma1   : integer;
   Soma2   : integer;
   Soma    : integer;
   Digi    : integer;
   I       : integer;
begin
   DefineUPC := 'Erro';
   for I := 1 to length(CodigoC) do
   begin
      if (CodigoC[I] <> '0') and
         (CodigoC[I] <> '1') and
         (CodigoC[I] <> '2') and
         (CodigoC[I] <> '3') and
         (CodigoC[I] <> '4') and
         (CodigoC[I] <> '5') and
         (CodigoC[I] <> '6') and
         (CodigoC[I] <> '7') and
         (CodigoC[I] <> '8') and
         (CodigoC[I] <> '9') then exit; 
   end;
   if (length(CodigoC) = 11) then
   begin
      Guarda   := '101';
      Central  := '01010';
      TUPCA[0] := '0001101'; {0}
      TUPCA[1] := '0011001'; {1}
      TUPCA[2] := '0010011'; {2}
      TUPCA[3] := '0111101'; {3}
      TUPCA[4] := '0100011'; {4}
      TUPCA[5] := '0110001'; {5}
      TUPCA[6] := '0101111'; {6}
      TUPCA[7] := '0111011'; {7}
      TUPCA[8] := '0110111'; {8}
      TUPCA[9] := '0001011'; {9}
      TUPCC[0] := '1110010';
      TUPCC[1] := '1100110';
      TUPCC[2] := '1101100';
      TUPCC[3] := '1000010';
      TUPCC[4] := '1011100';
      TUPCC[5] := '1001110';
      TUPCC[6] := '1010000';
      TUPCC[7] := '1000100';
      TUPCC[8] := '1001000';
      TUPCC[9] := '1110100';
      { Calcula digito Verificador }
      Soma1 := StrToInt(CodigoC[ 1])+
               StrToInt(CodigoC[ 3])+
               StrToInt(CodigoC[ 5])+
               StrToInt(CodigoC[ 7])+
               StrToInt(CodigoC[ 9])+
               StrToInt(CodigoC[11]);
      Soma2 := StrToInt(CodigoC[ 2])+
               StrToInt(CodigoC[ 4])+
               StrToInt(CodigoC[ 6])+
               StrToInt(CodigoC[ 8])+
               StrToInt(CodigoC[10]);
      Soma1 := Soma1 * 3;
      Soma  := Soma1 + Soma2;
      Digi := 0;
      if ((Soma mod 10) <> 0) and (Soma > 9) then Digi := 10-(Soma mod 10);
      if (Soma < 10) and (Soma > 0) then Digi := 10-Soma;
      DigitoPEG := IntToStr(Digi);
      { Caracter de Guarda }
      Codifi    := Guarda;
      { Digitos }
      for I := 1 to 11 do
      begin
         if I = 7  then Codifi := Codifi + Central;
         if I <= 6 then Codifi := Codifi + TUPCA[StrToInt(CodigoC[I])]
         else Codifi := Codifi + TUPCC[StrToInt(CodigoC[I])];
      end;
      { Digito de Controle }
      Codifi    := Codifi + TUPCC[Digi];
      { Caracter de Guarda }
      Codifi    := Codifi + Guarda;
      DefineUPC := Codifi;
   end;
end;

function Define2de5(CodigoC:string):string;
var
   Start   : string;
   Stop    : string;
   T2de5   : array[0..9] of string;
   Codifi  : string;
   I       : integer;
begin
   Define2de5 := 'Erro';   
   Start    := '110011001';
   Stop     := '110010011';
   T2de5[0] := '100100110011001';
   T2de5[1] := '110010010010011';
   T2de5[2] := '100110010010011';
   T2de5[3] := '110011001001001';
   T2de5[4] := '100100110010011';
   T2de5[5] := '110010011001001';
   T2de5[6] := '100110011001001';
   T2de5[7] := '100100100110011';
   T2de5[8] := '110010010011001';
   T2de5[9] := '100110010011001';
   DigitoPEG := ' ';
   if length(CodigoC) < 14 then
   begin
      { Caracter Start }
      Codifi := Start+'00';
      { Digitos }
      for I := 1 to length(CodigoC) do
      begin
          if (CodigoC[I] <> '0') and
             (CodigoC[I] <> '1') and
             (CodigoC[I] <> '2') and
             (CodigoC[I] <> '3') and
             (CodigoC[I] <> '4') and
             (CodigoC[I] <> '5') and
             (CodigoC[I] <> '6') and
             (CodigoC[I] <> '7') and
             (CodigoC[I] <> '8') and
             (CodigoC[I] <> '9') then exit
          else
             Codifi := Codifi + T2de5[StrToInt(CodigoC[I])]+'00';
      end;
      { Caracter Stop }
      Codifi     := Codifi + Stop;
      Define2de5 := Codifi;
   end;
end;

function Define3x9(CodigoC:string):string;
var
   Codifi : string;
   T3x9   : array[0..43] of string;
   I      : integer;
   J      : integer;
begin
   Define3x9 := 'Erro';
   T3x9[ 0] := '110100101011'; {1}
   T3x9[ 1] := '101100101011'; {2}
   T3x9[ 2] := '110110010101'; {3}
   T3x9[ 3] := '101001101011'; {4}
   T3x9[ 4] := '110100110101'; {5}
   T3x9[ 5] := '101100110101'; {6}
   T3x9[ 6] := '101001011011'; {7}
   T3x9[ 7] := '110100101101'; {8}
   T3x9[ 8] := '101100101101'; {9}
   T3x9[ 9] := '101001101101'; {0}
   T3x9[10] := '110101001011'; {A}
   T3x9[11] := '101101001011'; {B}
   T3x9[12] := '110110100101'; {C}
   T3x9[13] := '101011001011'; {D}
   T3x9[14] := '110101100101'; {E}
   T3x9[15] := '101101100101'; {F}
   T3x9[16] := '101010011011'; {G}
   T3x9[17] := '110101001101'; {H}
   T3x9[18] := '101101001101'; {I}
   T3x9[19] := '101011001101'; {J}
   T3x9[20] := '110101010011'; {K}
   T3x9[21] := '101101010011'; {L}
   T3x9[22] := '110110101001'; {M}
   T3x9[23] := '101011010011'; {N}
   T3x9[24] := '110101101001'; {O}
   T3x9[25] := '101101101001'; {P}
   T3x9[26] := '101010110011'; {Q}
   T3x9[27] := '110101011001'; {R}
   T3x9[28] := '101101011001'; {S}
   T3x9[29] := '101011011001'; {T}
   T3x9[30] := '110010101011'; {U}
   T3x9[31] := '100110101011'; {V}
   T3x9[32] := '110011010101'; {W}
   T3x9[33] := '100101101011'; {X}
   T3x9[34] := '110010110101'; {Y}
   T3x9[35] := '100110110101'; {Z}
   T3x9[36] := '100101011011'; {-}
   T3x9[37] := '110010101101'; {.}
   T3x9[38] := '100110101101'; { }
   T3x9[39] := '100101101101'; {*}
   T3x9[40] := '100100100101'; {Dolar}
   T3x9[41] := '100100101001'; {/}
   T3x9[42] := '100101001001'; {+}
   T3x9[43] := '101001001001'; {%} 
   DigitoPEG := ' ';
   if length(CodigoC) < 18 then
   begin
      Codifi := T3x9[39]+'0';
      for I := 1 to Length(CodigoC) do
      begin
         Case CodigoC[I] of
              '0' : J :=  9; '1' : J :=  0; '2' : J :=  1; '3' : J :=  2;
              '4' : J :=  3; '5' : J :=  4; '6' : J :=  5; '7' : J :=  6;
              '8' : J :=  7; '9' : J :=  8; 'A' : J := 10; 'B' : J := 11;
              'C' : J := 12; 'D' : J := 13; 'E' : J := 14; 'F' : J := 15;
              'G' : J := 16; 'H' : J := 17; 'I' : J := 18; 'J' : J := 19;
              'K' : J := 20; 'L' : J := 21; 'M' : J := 22; 'N' : J := 23;
              'O' : J := 24; 'P' : J := 25; 'Q' : J := 26; 'R' : J := 27;
              'S' : J := 28; 'T' : J := 29; 'U' : J := 30; 'V' : J := 31;
              'W' : J := 32; 'X' : J := 33; 'Y' : J := 34; 'Z' : J := 35;
              '-' : J := 36; '.' : J := 37; ' ' : J := 38; '*' : J := 39;
              '$' : j := 40; '/' : J := 41; '+' : J := 42; '%' : J := 43;
          else exit;
          end;
          Codifi := Codifi+T3x9[J]+'0';
      end;
      Codifi    := Codifi + T3x9[39];
      Define3x9 := Codifi;
   end;
end;

procedure TABarra.SetCorBarra(Value: TColor);
begin
   if fCorBarra <> Value then fCorBarra := Value;
   Repaint;
end;

procedure TABarra.SetCorEspaco(Value: TColor);
begin
   if fCorEspaco <> Value then fCorEspaco := Value;
   Repaint;
end;

procedure TABarra.SetTipo(Value: TTipo);
begin
   if fTipo <> Value then fTipo := Value;
   Repaint;
end;

procedure TABarra.SetCodigo(Value: string);
begin
   if fCodigo <> Value then fCodigo := Value;
   Repaint;
end;

procedure TABarra.SetLargura(Value: integer);
begin
   if fLargura <> Value then fLargura := Value;
   Repaint;
end;

end.

{ Fim do Arquivo ABARRA.PAS }
