unit ValorPor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TTipoTexto = (ttMaiuscula, ttMinuscula);

  TValorPorExtenso = class(TComponent)
  private
    FValor: Extended;
    FTexto: String;
    FMoedaNoSingular: String;
    FMoedaNoPlural: String;
    FLabelAssociado: TLabel;
    FTipoTexto: TTipoTexto;
    procedure MudaValor(V: Extended);
    procedure MudaMoedaNoSingular(M: String);
    procedure MudaMoedaNoPlural(M: String);
    procedure MudaLabelAssociado(Lbl: TLabel);
    procedure MudaTipoTexto(TipoTxt: TTipoTexto);
    function TrataGrupo(const S: String): String;
  protected
    function PorExtenso: String; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(Owner: TComponent); override;
    property Texto: String read FTexto;
  published
    property Valor: Extended read FValor write MudaValor;
    property MoedaNoSingular: String read FMoedaNoSingular write MudaMoedaNoSingular;
    property MoedaNoPlural: String read FMoedaNoPlural write MudaMoedaNoPlural;
    property LabelAssociado: TLabel read FLabelAssociado write MudaLabelAssociado;
    property TipoDoTexto: TTipoTexto read FTipoTexto write MudaTipoTexto;
  end;

procedure Register;

implementation

{ cria o componente e inicializa defaults }
constructor TValorPorExtenso.Create(Owner: TComponent);
begin
  inherited Create(Owner);
  FMoedaNoSingular := 'REAL';
  FMoedaNoPlural := 'REAIS';
  FValor := 0.00;
  FTipoTexto := ttMaiuscula;
  FTexto := PorExtenso;
end;

{ altera o valor }
procedure TValorPorExtenso.MudaValor(V: Extended);
begin
  if V <> FValor then
  begin
    if V < 0.0 then
      raise Exception.Create('O valor deve ser sempre maior ou igual a 0,00');
    FValor := V;
    FTexto := PorExtenso;
    if FLabelAssociado <> nil then
      FLabelAssociado.Caption := FTexto;
  end;
end;

{ muda moeda no singular }
procedure TValorPorExtenso.MudaMoedaNoSingular(M: String);
begin
  if AnsiCompareText(M, FMoedaNoSingular) <> 0 then
  begin
    FMoedaNoSingular := M;
    FTexto := PorExtenso;
    if FLabelAssociado <> nil then
      FLabelAssociado.Caption := FTexto;
  end;
end;

{ muda moeda no plural }
procedure TValorPorExtenso.MudaMoedaNoPlural(M: String);
begin
  if AnsiCompareText(M, FMoedaNoPlural) <> 0 then
  begin
    FMoedaNoPlural := M;
    FTexto := PorExtenso;
    if FLabelAssociado <> nil then
      FLabelAssociado.Caption := FTexto;
  end;
end;

{ muda label associado }
procedure TValorPorExtenso.MudaLabelAssociado(Lbl: TLabel);
begin
  if Lbl <> FLabelAssociado then
  begin
    FLabelAssociado := Lbl;
    if FLabelAssociado <> nil then
      FLabelAssociado.Caption := FTexto;
  end;
end;

{ muda tipo texto }
procedure TValorPorExtenso.MudaTipoTexto(TipoTxt: TTipoTexto);
begin
  if FTipoTexto <> TipoTxt then
  begin
    FTipoTexto := TipoTxt;
    FTexto := PorExtenso;
    if FLabelAssociado <> nil then
      FLabelAssociado.Caption := FTexto;
  end;
end;

{ verifica se o label associado foi deletado }
procedure TValorPorExtenso.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FLabelAssociado) then
    FLabelAssociado := nil;
end;

{ escreve por extenso um numero entre 0 e 999 }
function TValorPorExtenso.TrataGrupo(const S: String): String;
const
  Num1a19: array [1..19] of String = (
    'UM', 'DOIS', 'TRES', 'QUATRO', 'CINCO',
    'SEIS', 'SETE', 'OITO', 'NOVE', 'DEZ',
    'ONZE', 'DOZE', 'TREZE', 'CATORZE', 'QUINZE',
    'DEZESSEIS', 'DEZESSETE', 'DEZOITO', 'DEZENOVE');

  Num10a90: array [1..9] of String = (
    'DEZ', 'VINTE', 'TRINTA', 'QUARENTA', 'CINQUENTA',
    'SESSENTA', 'SETENTA', 'OITENTA', 'NOVENTA');

  Num100a900: array [1..9] of String = (
    'CENTO', 'DUZENTOS', 'TREZENTOS', 'QUATROCENTOS', 'QUINHENTOS',
    'SEISCENTOS', 'SETECENTOS', 'OITOCENTOS', 'NOVECENTOS');
var
  N: Integer;
  Tam: Integer;
  Aux: String;

  function Trata0a99(const S: String; N: Integer): String;
  begin
    case N of
      0:
        Result := '';
      1..19:
        Result := Num1a19[N];
      20..99:
      begin
        Result := Num10a90[Ord(S[1]) - Ord('0')];
        if S[2] <> '0' then
          Result := Result + ' E ' + Num1a19[Ord(S[2]) - Ord('0')];
      end;
    end;
  end;

  function Trata101a999(const S: String; N: Integer): String;
  var
    Aux: String[3];
  begin
    Result := Num100a900[Ord(S[1]) - Ord('0')];
    if (S[2] <> '0') or (S[3] <> '0') then
    begin
      Aux := Copy(S, 2, 2);
      Result := Result + ' E ' + Trata0a99(Aux, StrToInt(Aux));
    end;
  end;

begin
  N := StrToInt(S);
  case N of
    0..99: Result := Trata0a99(IntToStr(N), N);
    100: Result := 'CEM';
    101..999: Result := Trata101a999(S, N);
  end;
end;

{ atualiza o texto }
function TValorPorExtenso.PorExtenso: String;
var
  Lst: TStringList;
  I: Integer;
  Aux: String;
  Grupo: String;
  IndGrupo: Integer;
  Truncado: Longint;
begin
  Lst := nil;
  Result := '';
  try
    if FValor = 0.0 then
    begin
      Result := 'ZERO ' + FMoedaNoPlural;
      Exit;
    end;
    Lst := TStringList.Create;
    Grupo := '';
    Aux := FormatFloat('#,##0.00', FValor);

    // separa em grupos
    for I := 1 to Length(Aux) do
      if (Aux[I] = '.') or (Aux[I] = ',') then
      begin
        Lst.Add(Grupo);
        Grupo := '';
      end
      else
        Grupo := Grupo + Aux[I];
    Lst.Add(Grupo); // inclui o ultimo grupo

    // trata os bilhoes
    I := 0;
    if Lst.Count > 4 then
    begin
      Result := TrataGrupo(Lst[I]);
      if StrToInt(Lst[I]) = 1 then
        Result := Result + ' BILHAO'
      else
        Result := Result + ' BILHOES';
      Inc(I);
    end;

    // trata os milhoes
    if (Lst.Count > 3) then
    begin
      if StrToInt(Lst[I]) <> 0 then
      begin
        if Length(Result) > 0 then
          Result := Result + ', ';
        Result := Result + TrataGrupo(Lst[I]);
        if StrToInt(Lst[I]) = 1 then
          Result := Result + ' MILHAO'
        else
          Result := Result + ' MILHOES';
      end;
      Inc(I);
    end;

    // trata os milhares
    if Lst.Count > 2 then
    begin
      if StrToInt(Lst[I]) <> 0 then
      begin
        if Length(Result) > 0 then
          Result := Result + ', ';
        Result := Result + TrataGrupo(Lst[I]);
        Result := Result + ' MIL';
      end;
      Inc(I);
    end;

    // trata as unidades
    if StrToInt(Lst[I]) > 0 then
    begin
      if Length(Result) > 0 then
        Result := Result + ' E ';
      Result := Result + TrataGrupo(Lst[I]);
    end;
    Truncado := Trunc(Valor);
    if Truncado = 1 then
      Result := Result + ' ' + FMoedaNoSingular
    else if (Truncado = 1000000) or
            (Truncado = 10000000) or
            (Truncado = 100000000) or
            (Truncado = 1000000000) then
      Result := Result + ' DE ' + FMoedaNoPlural
    else if Truncado <> 0 then
      Result := Result + ' ' + FMoedaNoPlural;
    Inc(I);

    // trata os centavos
    if StrToInt(Lst[I]) = 0 then
      Exit;
    if Truncado > 0 then
      Result := Result + ', ';
    Result := Result + TrataGrupo(Lst[I]);
    if StrToInt(Lst[I]) = 1 then
      Result := Result + ' ' + 'CENTAVO'
    else
      Result := Result + ' ' + 'CENTAVOS';
    if Truncado = 0 then
      Result := Result + ' DE ' + FMoedaNoSingular;

  finally
    // trata tipo texto
    if FTipoTexto = ttMaiuscula then
      Result := AnsiUpperCase(Result)
    else
      Result := AnsiLowerCase(Result);
    if Lst <> nil then
      Lst.Free;
  end;
end;

{ register }
procedure Register;
begin
  RegisterComponents('WIMPack', [TValorPorExtenso]);
end;

end.
