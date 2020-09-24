unit Biblioteca;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Dbtables, Inifiles, DBClient, DB, SqlExpr, DBXMySql, Grids, DBGrids,
  IdHashMessageDigest, Math, Rtti, TypInfo, JvDBUltimGrid,
  {$IFDEF VER210} SWSystem, {$ELSE} IWSystem, {$ENDIF} DBXJSON;

Function ValidaCNPJ(xCNPJ: String):Boolean;
Function ValidaCPF( xCPF:String ):Boolean;
Function ValidaEstado(Dado : string) : boolean;
Function MixCase(InString: String): String;
Function Hora_Seg( Horas:string ):LongInt;
Function Seg_Hora( Seg:LongInt ):string;
Function Minuscula(InString: String): String;
Function StrZero(Num:Real ; Zeros,Deci:integer): string;
Function OrdenaPinta(xGrid: DBGrids.TDBGrid; Column: DBGrids.TColumn; cds: TClientDataSet): boolean;
Procedure ZapFiles(vMasc:String);
Procedure SetTaskBar(Visible: Boolean);
function MD5File(const fileName: string): string;
function MD5String(const texto: string): string;
Function TruncaValor(Value:Extended;Casas:Integer):Extended;
Function ArredondaTruncaValor(Operacao:String;Value:Extended;Casas:Integer):Extended;
function UltimoDiaMes(Mdt: TDateTime) : String;
function FormataFloat(Tipo:String; Valor: Extended): string; //Tipo => 'Q'=Quantidade | 'V'=Valor
procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
function CriaGuidStr: string;
procedure AtualizaCaptionGrid(pGrid: TJvDBUltimGrid; pFieldName, pCaption: string);
procedure ConfiguraTamanhoColunaGrid(pGrid: TJvDBUltimGrid; pFieldName: string; pTamanho: Integer);
function CaminhoApp: string;
function TextoParaData(pData: string): TDate;
function DataParaTexto(pData: TDate): string;
function ExtrairValorJSONObject(pObj: TJSONObject; pCampo: string): string;
function DateToSQL(pDate : TDateTime; pComAspas: Boolean = True; pComHoras: Boolean = True): string;
function DatesToSQL(pDataInicial, pDataFinal: TDateTime; pCondicao: string; pIncluirHora: Boolean): string;
function MyConsulta(MyConsulta:TSQLQuery;Expressao:string):Boolean;
function DataToSQL(sdata:string):string;
function DataToSQLIntegracao(sdata:string):string;
function DevolveInteiro(Const Texto:String):String;
function VerificaNULL(Texto:string;Tipo:integer):string;
function RetiraMascara(Texto:string):string;

var
  InString : String;

implementation

function RetiraMascara(Texto:string):string;
begin
  Result := Texto;
  Result := StringReplace(Result,'*','',[rfReplaceAll]);
  Result := StringReplace(Result,'.','',[rfReplaceAll]);
  Result := StringReplace(Result,'-','',[rfReplaceAll]);
  Result := StringReplace(Result,'/','',[rfReplaceAll]);
  Result := StringReplace(Result,'\','',[rfReplaceAll]);
end;

{ Valida o CNPJ digitado }
function ValidaCNPJ(xCNPJ: String):Boolean;
Var
d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
Check : String;
begin
d1 := 0;
d4 := 0;
xx := 1;
for nCount := 1 to Length( xCNPJ )-2 do
    begin
    if Pos( Copy( xCNPJ, nCount, 1 ), '/-.' ) = 0 then
       begin
       if xx < 5 then
          begin
          fator := 6 - xx;
          end
       else
          begin
          fator := 14 - xx;
          end;
       d1 := d1 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
       if xx < 6 then
          begin
          fator := 7 - xx;
          end
       else
          begin
          fator := 15 - xx;
          end;
       d4 := d4 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
       xx := xx+1;
       end;
    end;
    resto := (d1 mod 11);
    if resto < 2 then
       begin
       digito1 := 0;
       end
   else
       begin
       digito1 := 11 - resto;
       end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
      begin
      digito2 := 0;
      end
   else
      begin
      digito2 := 11 - resto;
      end;
   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCNPJ,succ(length(xCNPJ)-2),2) then
      begin
      Result := False;
      end
   else
      begin
      Result := True;
      end;
end;

{ Valida o CPF digitado }
function ValidaCPF( xCPF:String ):Boolean;
Var
d1,d4,xx,nCount,resto,digito1,digito2 : Integer;
Check : String;
Begin
d1 := 0; d4 := 0; xx := 1;
for nCount := 1 to Length( xCPF )-2 do
    begin
    if Pos( Copy( xCPF, nCount, 1 ), '/-.' ) = 0 then
       begin
       d1 := d1 + ( 11 - xx ) * StrToInt( Copy( xCPF, nCount, 1 ) );
       d4 := d4 + ( 12 - xx ) * StrToInt( Copy( xCPF, nCount, 1 ) );
       xx := xx+1;
       end;
    end;
resto := (d1 mod 11);
if resto < 2 then
   begin
   digito1 := 0;
   end
else
   begin
   digito1 := 11 - resto;
   end;
d4 := d4 + 2 * digito1;
resto := (d4 mod 11);
if resto < 2 then
   begin
   digito2 := 0;
   end
else
   begin
   digito2 := 11 - resto;
   end;
Check := IntToStr(Digito1) + IntToStr(Digito2);
if Check <> copy(xCPF,succ(length(xCPF)-2),2) then
   begin
   Result := False;
   end
else
   begin
   Result := True;
   end;
end;

{ Valida a UF digitada }
function ValidaEstado(Dado : string) : boolean;
const
  Estados = 'SPMGRJRSSCPRESDFMTMSGOTOBASEALPBPEMARNCEPIPAAMAPFNACRRRO';
var
  Posicao : integer;
begin
Result := true;
if Dado <> '' then
   begin
   Posicao := Pos(UpperCase(Dado),Estados);
   if (Posicao = 0) or ((Posicao mod 2) = 0) then
      begin
      Result := false;
      end;
    end;
end;

{ Corrige a string que contenha caracteres maiusculos
  inseridos no meio dela para tudo minusculo e com a
  primeira letra maiuscula}
Function  MixCase(InString: String): String;
Var I: Integer;
Begin
  Result := LowerCase(InString);
  Result[1] := UpCase(Result[1]);
  For I := 1 To Length(InString) - 1 Do Begin
    If (Result[I] = ' ') Or (Result[I] = '''') Or (Result[I] = '"')
    Or (Result[I] = '-') Or (Result[I] = '.')  Or (Result[I] = '(') Then
      Result[I + 1] := UpCase(Result[I + 1]);
    if Result[I] = 'Ç' then
      Result[I] := 'ç';
    if Result[I] = 'Ã' then
      Result[I] := 'ã';
    if Result[I] = 'Á' then
      Result[I] := 'á';
    if Result[I] = 'É' then
      Result[I] := 'é';
    if Result[I] = 'Í' then
      Result[I] := 'í';
    if Result[I] = 'Õ' then
      Result[I] := 'õ';
    if Result[I] = 'Ó' then
      Result[I] := 'ó';
    if Result[I] = 'Ú' then
      Result[I] := 'ú';
    if Result[I] = 'Â' then
      Result[I] := 'â';
    if Result[I] = 'Ê' then
      Result[I] := 'ê';
    if Result[I] = 'Ô' then
      Result[I] := 'ô';
  End;
End;

{Apaga arquivos usando mascaras tipo: c:\Temp\*.zip, c:\Temp\*.*
 Obs: Requer o Path dos arquivos a serem deletados}
procedure ZapFiles(vMasc:String);
var
  Dir : TsearchRec;
  Erro: Integer;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  Erro := FindFirst(vMasc,faArchive,Dir);
  while Erro = 0 do
  begin
   DeleteFile( ExtractFilePAth(vMasc)+Dir.Name );
   Erro := FindNext(Dir);
  end;
  FindClose(Dir);
  {$WARN SYMBOL_PLATFORM ON}
end;

{Converte de hora para segundos}
function Hora_Seg( Horas:string ):LongInt;
Var Hor,Min,Seg:LongInt;
begin
   Horas[Pos(':',Horas)]:= '[';
   Horas[Pos(':',Horas)]:= ']';
   Hor := StrToInt(Copy(Horas,1,Pos('[',Horas)-1));
   Min := StrToInt(Copy(Horas,Pos('[',Horas)+1,(Pos(']',Horas)-Pos('[',Horas)-1)));
   if Pos(':',Horas) > 0 then
      Seg := StrToInt(Copy(Horas,Pos(']',Horas)+1,(Pos(':',Horas)-Pos(']',Horas)-1)))
   else
      Seg := StrToInt(Copy(Horas,Pos(']',Horas)+1,2));
   Result := Seg + (Hor*3600) + (Min*60);
end;

{Converte de segundos para hora}
function Seg_Hora( Seg:LongInt ):string;
Var Hora,Min:LongInt;
    Tmp : Double;
begin
   Tmp := Seg / 3600;
   Hora := Round(Int(Tmp));
   Seg :=  Round(Seg - (Hora*3600));
   Tmp := Seg / 60;
   Min := Round(Int(Tmp));
   Seg :=  Round(Seg - (Min*60));
   Result := StrZero(Hora,2,0)+':'+StrZero(Min,2,0)+':'+StrZero(Seg,2,0);
end;

{converte tudo para minuscula}
Function  Minuscula(InString: String): String;
Var I: Integer;
Begin
  Result := LowerCase(InString);
  For I := 1 To Length(InString) - 1 Do Begin
    If (Result[I] = ' ') Or (Result[I] = '''') Or (Result[I] = '"')
    Or (Result[I] = '-') Or (Result[I] = '.')  Or (Result[I] = '(') Then
      Result[I] := UpCase(Result[I]);
    if Result[I] = 'Ç' then
      Result[I] := 'ç';
    if Result[I] = 'Ã' then
      Result[I] := 'ã';
    if Result[I] = 'Á' then
      Result[I] := 'á';
    if Result[I] = 'É' then
      Result[I] := 'é';
    if Result[I] = 'Í' then
      Result[I] := 'í';
    if Result[I] = 'Õ' then
      Result[I] := 'õ';
    if Result[I] = 'Ó' then
      Result[I] := 'ó';
    if Result[I] = 'Ú' then
      Result[I] := 'ú';
    if Result[I] = 'Â' then
      Result[I] := 'â';
    if Result[I] = 'Ê' then
      Result[I] := 'ê';
    if Result[I] = 'Ô' then
      Result[I] := 'ô';
  End;
End;

{esconde|exibe a barra do Windows}
procedure SetTaskBar(Visible: Boolean);
var
  wndHandle : THandle;
  wndClass : array[0..50] of Char;
begin
  StrPCopy(@wndClass[0],'Shell_TrayWnd');
  wndHandle := FindWindow(@wndClass[0], nil);
  If Visible = True then
    ShowWindow(wndHandle, SW_RESTORE)
  else ShowWindow(wndHandle, SW_HIDE);
end;

function StrZero(Num:Real; Zeros, Deci: Integer): string;
var
  Tam,Z:integer;
  Res,Zer: string;
begin
  {$WARNINGS OFF}
  Str(Num:Zeros:Deci,Res);
  Res := Trim(Res);
  Tam := Length(Res);
  Zer := '';
  for z := 01 to (Zeros-Tam) do
    Zer := Zer + '0';
  Result := Zer+Res;
  {$WARNINGS ON}
end;

Function OrdenaPinta(xGrid: DBGrids.TDBGrid; Column: DBGrids.TColumn; cds: TClientDataSet): boolean;
const
  idxDefault = 'DEFAULT_ORDER';
var
  strColumn: string;
  bolUsed: boolean;
  idOptions: TIndexOptions;
  i: integer;
  VDescendField: string;
  coluna : String;
begin

  result := False;
  if not cds.Active then
    exit;

  strColumn := idxDefault;

  // não faz nada caso seja um campo calculado
  if (Column.Field.FieldKind = fkCalculated) then
    exit;

  // índice já está sendo utilizado
  bolUsed := (Column.Field.FieldName = cds.IndexName);

  // seta o nome da coluna na variavel para carga de dados e pesquisa
  coluna := Column.Field.FieldName;

  // verifica a existência do índice e propriedades
  cds.IndexDefs.Update;
  idOptions := [];
  for i := 0 to cds.IndexDefs.Count - 1 do
  begin
    if cds.IndexDefs.Items[i].Name = Column.Field.FieldName then
    begin
      strColumn := Column.Field.FieldName;
      // determina como deve ser criado o índice, inverte a condição ixDescending
      case (ixDescending in cds.IndexDefs.Items[i].Options) of
        True:
          begin
            idOptions := [];
            VDescendField := '';
          end;
        False:
          begin
            idOptions := [ixDescending];
            VDescendField := strColumn;
          end;
      end;
    end;
  end;

  // caso não encontre o índice ou o mesmo esteja em uso
  if (strColumn = idxDefault) or bolUsed then
  begin
    if bolUsed then
      cds.DeleteIndex(Column.Field.FieldName);
    try
      cds.AddIndex(Column.Field.FieldName, Column.Field.FieldName, idOptions,
        VDescendField, '', 0);
      strColumn := Column.Field.FieldName;
    except
      // se índice indeterminado, seta o padrão
      if bolUsed then
        strColumn := idxDefault;
    end;
  end;

  // pinta todas as outras colunas com a cor padrão e a coluna clicada com a cor Azul
  for i := 0 to xGrid.Columns.Count - 1 do
  begin
    if Pos(strColumn, xGrid.Columns[i].Field.FieldName) <> 0 then
      xGrid.Columns[i].Title.Font.Color := clBlue
    else
      xGrid.Columns[i].Title.Font.Color := clWindowText;
  end;

  // tenta setar o índice, caso ocorra algum erro seta o padrão
  try
    cds.IndexName := strColumn;
  except
    cds.IndexName := idxDefault;
  end;

  result := True;
end;

function MD5File(const fileName: string): string;
var
  idmd5 : TIdHashMessageDigest5;
  fs : TFileStream;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  fs := TFileStream.Create(fileName, fmOpenRead OR fmShareDenyWrite) ;
  try
    result := idmd5.HashStreamAsHex(fs);
  finally
    fs.Free;
    idmd5.Free;
  end;
end;

function MD5String(const texto: string): string;
var
  idmd5: TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := LowerCase(idmd5.HashStringAsHex(texto));
  finally
  idmd5.Free;
  end;
end;

Function TruncaValor(Value:Extended;Casas:Integer):Extended;
Var sValor:String;
    nPos:Integer;
begin
   //Transforma o valor em string
   sValor := FloatToStr(Value);

   //Verifica se possui ponto decimal
   nPos := Pos(DecimalSeparator,sValor);
   If ( nPos > 0 ) Then begin
      sValor := Copy(sValor,1,nPos+Casas);
   End;

   Result := StrToFloat(sValor);
end;

Function ArredondaTruncaValor(Operacao:String;Value:Extended;Casas:Integer):Extended;
Var
  sValor:String;
  nPos:Integer;
begin
  if Operacao = 'A' then
    result := SimpleRoundTo(Value,Casas*-1)
  else
  begin
    //Transforma o valor em string
    sValor := FloatToStr(Value);

    //Verifica se possui ponto decimal
    nPos := Pos(DecimalSeparator,sValor);
    If ( nPos > 0 ) Then begin
      sValor := Copy(sValor,1,nPos+Casas);
    End;

    Result := StrToFloat(sValor);
  end;
end;

function UltimoDiaMes(Mdt: TDateTime) : String;
var
  ano, mes, dia : word;
  mDtTemp : TDateTime;
begin
  Decodedate(mDt, ano, mes, dia);
  mDtTemp := (mDt - dia) + 33;
  Decodedate(mDtTemp, ano, mes, dia);
  mDtTemp := mDtTemp - dia;
  Decodedate(mDtTemp, ano, mes, dia);
  Result := IntToStr(dia)
end;

function FormataFloat(Tipo:String; Valor: Extended): string; //Tipo => 'Q'=Quantidade | 'V'=Valor
var
  i:integer;
  Mascara:String;
begin
  Mascara := '0.';

  if Tipo = 'Q' then
  begin
    for i := 1 to 2 do
      Mascara := Mascara + '0';
  end
  else if Tipo = 'V' then
  begin
    for i := 1 to 2 do
      Mascara := Mascara + '0';
  end;

  Result := FormatFloat(Mascara, Valor);
end;

procedure Split(const Delimiter: Char; Input: string; const Strings: TStrings);
begin
  Assert(Assigned(Strings)) ;
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function CriaGuidStr: string;
var
  Guid: TGUID;
begin
  CreateGUID(Guid);
  Result := GUIDToString(Guid);
end;

procedure AtualizaCaptionGrid(pGrid: TJvDBUltimGrid; pFieldName, pCaption: string);
var
  I: Integer;
begin
  for I := 0 to pGrid.Columns.Count - 1 do
  begin
    if pGrid.Columns[I].FieldName = pFieldName then
    begin
      pGrid.Columns[I].Title.Caption := pCaption;
      Break;
    end;
  end;
end;

procedure ConfiguraTamanhoColunaGrid(pGrid: TJvDBUltimGrid; pFieldName: string; pTamanho: Integer);
var
  I: Integer;
begin
  for I := 0 to pGrid.Columns.Count - 1 do
  begin
    if pGrid.Columns[I].FieldName = pFieldName then
    begin
      if pTamanho <= 0 then
      begin
        pGrid.Columns[I].Visible := False;
      end
      else
      begin
        pGrid.Columns[I].Visible := True;
        pGrid.Columns[I].Width := pTamanho;
      end;
      Break;
    end;
  end;
end;

function CaminhoApp: string;
begin
  Result := gsAppPath;
end;

function TextoParaData(pData: string): TDate;
var
  Dia, Mes, Ano: Integer;
begin
  if (pData <> '') AND (pData <> '0000-00-00') then
  begin
    Dia := StrToInt(Copy(pData,9,2));
    Mes := StrToInt(Copy(pData,6,2));
    Ano := StrToInt(Copy(pData,1,4));
    Result := EncodeDate(Ano,Mes,Dia);
  end
  else
  begin
    Result := 0;
  end;
end;

function DataParaTexto(pData: TDate): string;
begin
  if pData > 0 then
    Result := FormatDateTime('YYYY-MM-DD',pData)
  else
    Result := '0000-00-00';
end;

function ExtrairValorJSONObject(pObj: TJSONObject; pCampo: string): string;
var
  I, F: Integer;
  Campo: string;
  jObj: TJSONObject;
begin
  for I := 0 to pObj.Size - 1 do
  begin
    Campo := pObj.Get(I).JsonString.Value;
    if Campo = 'fields' then
    begin
      jObj := pObj.Get(I).JsonValue as TJSONObject;
      for F := 0 to jObj.Size - 1 do
      begin
        Campo := jObj.Get(F).JsonString.Value;
        if LowerCase(Campo) = LowerCase('F'+pCampo) then
        begin
          Result := jObj.Get(F).JsonValue.ToString;
          Break;
        end;
      end;
    end;
  end;

  //Remove primeira aspa se ela existir
  if Length(Result) > 0 then
  begin
    if Result[1] = '"' then
    begin
      Delete(Result,1,1);
    end;
  end;

  //Remove última aspa se ela existir
  if Length(Result) > 0 then
  begin
    if Result[Length(Result)] = '"' then
    begin
      Delete(Result,Length(Result),1);
    end;
  end;
end;

function DateToSQL(pDate : TDateTime; pComAspas: Boolean = True; pComHoras: Boolean = True): string;
var
  Ano, Mes, Dia, Hora, Minuto, Segundo, MileSegundo: Word;
begin
  DecodeDate(pDate, Ano, Mes, Dia);

  Result := IntToStr(Ano) + '-'+
            IntToStr(Mes) + '-'+
            IntToStr(Dia);

  DecodeTime(pDate,Hora,Minuto,Segundo, MileSegundo);

  if ((Hora + Minuto + Segundo) > 0) and (pComHoras) then
  begin
    Result := Result + ' '+
              IntToStr(Hora) + ':'+
              IntToStr(Minuto) + ':'+
              IntToStr(Segundo);
  end;

  if pComAspas then
  begin
    Result := QuotedStr(Result);
  end;
end;

function DatesToSQL(pDataInicial, pDataFinal: TDateTime; pCondicao: string;
  pIncluirHora: Boolean): string;
begin
  if (pDataInicial > 0) and (pDataFinal > 0) then
  begin
    if pIncluirHora then
    begin
      Result := pCondicao+' BETWEEN '+ QuotedStr(DateToSQL(pDataInicial,False,False)+' 00:00:00')+
                ' AND '+QuotedStr(DateToSQL(pDataFinal,False,False)+' 23:59:59');
    end
    else
    begin
      Result := pCondicao+' BETWEEN '+DateToSQL(pDataInicial,True,False)+
                ' AND '+DateToSQL(pDataFinal,True,False);
    end;
  end
  else
  if (pDataInicial > 0) and (pDataFinal = 0) then
    Result := pCondicao + ' >= ' + DateToSQL(pDataInicial,True,False)
  else
  if (pDataInicial = 0) and (pDataFinal > 0) then
  begin
    if pIncluirHora then
    begin
      Result := pCondicao+' <= '+ QuotedStr(DateToSQL(pDataFinal,False,False)+' 23:59:59');
    end
    else
    begin
      Result := pCondicao+' <= '+ DateToSQL(pDataFinal,True,False);
    end;
  end
  else
    Result := '';
end;

function MyConsulta(MyConsulta:TSqlQuery;Expressao:string):Boolean;
begin
   result := true;
   MyConsulta.active := false;
   MyConsulta.sql.clear;
   MyConsulta.sql.add(expressao);
   MyConsulta.active := true;
   MyConsulta.first;
   if MyConsulta.eof then
      result := false;
end;

function DataToSQL(sdata:string):string;
begin
  result := copy(sdata,7,4)+'-'+copy(sdata,4,2)+'-'+copy(sdata,1,2);
end;

function DataToSQLIntegracao(sdata:string):string;
begin
  if sdata = '' then
    Result := ''
  else
    result := copy(sdata,7,4)+'-'+copy(sdata,4,2)+'-'+copy(sdata,1,2);
end;

function DevolveInteiro(Const Texto:String):String;
var I: integer;
    S: string;
begin
  S := '';
  for I := 1 To Length(Texto) Do
  begin
    if CharInSet((Texto[I]),['0'..'9']) then
    begin
      S := S + Copy(Texto, I, 1);
    end;
  end;
  result := S;
end;

function VerificaNULL(Texto:string;Tipo:integer):string;
begin

  case tipo of

    0:begin
      if trim(Texto) = '' then
        Result := 'NULL'
      else
        Result := trim(Texto);
    end;
    1:begin
      if trim(Texto) = '' then
        Result := 'NULL'
      else
        Result := QuotedStr(trim(Texto));
    end;
    2:begin
      if trim(Texto) = '' then
        Result := ''
      else
        Result := (trim(Texto));
    end;

  end;

end;

end.
