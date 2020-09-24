unit U_aReceber;

interface

uses

  Windows, SysUtils, Graphics, Forms, Buttons, Db, Biblioteca, Classes,
  Controls, StdCtrls, ExtCtrls, EditNum, Mask, Grids, DBGrids, MenBtn, Menus,
  ValorPor, RDprint;

type
  TF_aReceber = class(TForm)
    ScrollBox1: TScrollBox;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    opcoes2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    Label2: TLabel;
    Label4: TLabel;
    EditProcura: TEdit;
    MaskEdit4: TMaskEdit;
    MaskEdit1: TMaskEdit;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    Panel1: TPanel;
    data: TMaskEdit;
    Label1: TLabel;
    Edit7: TEdit;
    EditNum1: TEditNum;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Label8: TLabel;
    MaskEdit3: TMaskEdit;
    MaskEdit5: TMaskEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    EditNum2: TEditNum;
    EditNum3: TEditNum;
    Label12: TLabel;
    Label13: TLabel;
    EditNum4: TEditNum;
    Label14: TLabel;
    EditNum5: TEditNum;
    Label15: TLabel;
    EditNum6: TEditNum;
    Label16: TLabel;
    EditNum7: TEditNum;
    Label17: TLabel;
    EditNum8: TEditNum;
    Label18: TLabel;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    Extenso: TValorPorExtenso;
    Label19: TLabel;
    Label20: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    PopupMenu1: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuButton1: TMenuButton;
    ContasRecebidas1: TMenuItem;
    RadioGroup1: TRadioGroup;
    Edit2: TComboBox;
    EditNum9: TEditNum;
    N1: TMenuItem;
    CaixaEscolas1: TMenuItem;
    CaixaCarteira1: TMenuItem;
    Incluir1: TMenuItem;
    Alterar1: TMenuItem;
    N2: TMenuItem;
    RDprint: TRDprint;
    Label7: TLabel;
    Label21: TLabel;
    Edit5: TEdit;
    procedure limpa;
    procedure procura;
    procedure pinta;
    procedure aguarde;
    procedure pronto;
    procedure BitBtn10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn14Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure EditNum4Exit(Sender: TObject);
    procedure EditNum6Exit(Sender: TObject);
    procedure EditNum8Enter(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure EditNum3Enter(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure ContasRecebidas1Click(Sender: TObject);
    procedure dataEnter(Sender: TObject);
    procedure EditNum9Exit(Sender: TObject);
    procedure CaixaEscolas1Click(Sender: TObject);
    procedure CaixaCarteira1Click(Sender: TObject);
    procedure Incluir1Click(Sender: TObject);
    procedure Alterar1Click(Sender: TObject);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure NovaPagina;
  private
    { Private declarations }
  public
    Inclui: Integer;
    { Public declarations }
  end;

var
  F_aReceber: TF_aReceber;
  valortxt, relatorio, data1, data2, nCol: string;
  linha, idCol, conf, confere: Integer;

implementation

uses U_Dados, U_PegaBanco;
{$R *.DFM}

procedure TF_aReceber.limpa;
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TEdit) then (Components[i] as TEdit)
      .Clear;
  end;
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TMaskEdit) then (Components[i] as TMaskEdit)
      .Clear;
  end;
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TEditNum) then (Components[i] as TEditNum)
      .Text := '0.00';
  end;
  for i := 0 to ComponentCount - 1 do begin
    if (Components[i] is TComboBox) then (Components[i] as TComboBox)
      .Text := '';
  end;
end;

procedure TF_aReceber.pinta;
var
  i: Integer;
begin
  For i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns.Items[i].Color := ClWindow;
  DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_aReceber.procura;
begin
  if EditProcura.Text <> '' then
  begin
    data1 := DataToSQL(MaskEdit4.Text);
    data2 := DataToSQL(MaskEdit1.Text);
    If nCol = '' then
      Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta', 'Informação do Sistema', mb_Ok + mb_IconError)
    else begin
      F_Dados.Q_Rec.Active := false;
      F_Dados.Q_Rec.Sql.Clear;
      F_Dados.Q_Rec.Sql.add('select * from receber where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
      F_Dados.Q_Rec.Sql.add('and vencimento between ' + chr(39) + data1 + chr(39) + ' and ' + chr(39) + data2 + chr(39));
      F_Dados.Q_Rec.Sql.add('order by vencimento,' + nCol + ',id_cliente');
      F_Dados.Q_Rec.Active := true;
      F_Dados.cds_Rec.close;
      F_Dados.cds_Rec.open;
    end;
  end
  else
    F_Dados.Q_Rec.Active := false;
end;

Procedure TF_aReceber.aguarde;
begin
  Panel3.Visible := true;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_aReceber.pronto;
begin
  Panel3.Visible := false;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

procedure TF_aReceber.BitBtn10Click(Sender: TObject);
begin
  F_Dados.Q_Rap.Active := false;
  F_Dados.Q_Rap.Sql.Clear;
  F_Dados.Q_Rap.Sql.add('delete from receber where nf_fatura is null');
  F_Dados.Q_Rap.ExecSql;
  close;
end;

procedure TF_aReceber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_Dados.Q_Rec.close;
  Release;
end;

procedure TF_aReceber.BitBtn14Click(Sender: TObject);
var
  opc: Integer;
begin
  opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then begin
    If F_Dados.cds_Rec.FieldByName('nf_fatura').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído', 'Sistema de Segurança', mb_Ok + mb_IconError)
    else
    begin
      F_Dados.cds_Rec.Delete;
      F_Dados.cds_Rec.ApplyUpdates(0);
    end;
  end;
end;

procedure TF_aReceber.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = Vk_Return then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_aReceber.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := UPCASE(Key);
end;

procedure TF_aReceber.FormCreate(Sender: TObject);
begin
  MaskEdit4.Text := DateToStr(Date);
  MaskEdit1.Text := DateToStr(Date);
end;

procedure TF_aReceber.DBGrid1TitleClick(Column: TColumn);
begin
  aguarde;
  idCol := Column.ID;
  nCol := Column.FieldName;
  pinta;
  procura;
  pronto;
end;

procedure TF_aReceber.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton2Click(Sender);
end;

procedure TF_aReceber.SpeedButton2Click(Sender: TObject);
begin
  if EditProcura.Text = '*' then
    EditProcura.Text := '%';
  aguarde;
  procura;
  pronto;
end;

procedure TF_aReceber.EditNum4Exit(Sender: TObject);
begin
  EditNum5.Text := FloatTostr(StrToFloat(EditNum3.Text) * StrToFloat(EditNum4.Text) / 100);
end;

procedure TF_aReceber.EditNum6Exit(Sender: TObject);
begin
  EditNum7.Text := FloatTostr(StrToFloat(EditNum3.Text) * StrToFloat(EditNum6.Text) / 100);
end;

procedure TF_aReceber.EditNum8Enter(Sender: TObject);
begin
  EditNum8.Text := FloatTostr(StrToFloat(EditNum3.Text) + StrToFloat(EditNum5.Text) + StrToFloat(EditNum7.Text));
end;

procedure TF_aReceber.BitBtn4Click(Sender: TObject);
var
  mes, ano: string;
begin
  mes := copy(data.Text, 4, 2);
  ano := copy(data.Text, 7, 4);
  //
  F_Dados.cds_Rec.Edit;
  F_Dados.cds_Recnf_fatura.AsString := Edit7.Text;
  F_Dados.cds_RecCliente.AsString := Edit1.Text;
  F_Dados.CDS_Rechistorico.AsString := Edit5.Text;
    F_Dados.cds_RecEmissao.AsString := MaskEdit3.Text;
  if MaskEdit5.Text <> '  /  /    ' then
    F_Dados.cds_RecVencimento.AsString := MaskEdit5.Text;
  F_Dados.cds_RecValor.AsString := EditNum1.Text;
  F_Dados.cds_RecTaxa_desconto.AsString := EditNum9.Text;
  F_Dados.cds_RecDesconto_Nota.AsString := EditNum2.Text;
  F_Dados.cds_RecTotal_Nota.AsString := EditNum3.Text;
  F_Dados.cds_RecTaxa_Juro.AsString := EditNum4.Text;
  F_Dados.cds_RecJuro.AsString := EditNum5.Text;
  F_Dados.cds_RecTaxa_Multa.AsString := EditNum6.Text;
  F_Dados.cds_RecMulta.AsString := EditNum7.Text;
  F_Dados.cds_Recvalor_recebido.AsString := EditNum8.Text;
  if data.Text <> '  /  /    ' then
    F_Dados.cds_Recdata_recebimento.AsString := data.Text;
  F_Dados.cds_Rectipo_recebimento.AsString := Edit2.Text;
  F_Dados.cds_RecBanco.AsString := Edit3.Text;
  F_Dados.cds_RecMes.AsString := mes;
  F_Dados.cds_RecAno.AsString := ano;
  F_Dados.cds_Rectipo_cliente.AsString := IntToStr(RadioGroup1.ItemIndex + 1);
  F_Dados.cds_RecAuditoria.AsString := DateTimeToStr(Now);
  F_Dados.cds_Rec.Post;
  F_Dados.cds_Rec.ApplyUpdates(0);
  Panel1.Visible := false;
end;

procedure TF_aReceber.BitBtn3Click(Sender: TObject);
begin
  Panel1.Visible := false;
end;

procedure TF_aReceber.MenuItem1Click(Sender: TObject);
begin
  F_Dados.cds_Rec.Edit;
  F_Dados.cds_RecEmissao.AsString := '';
  F_Dados.cds_Rec.Post;
  F_Dados.cds_Rec.ApplyUpdates(0);
end;

procedure TF_aReceber.MenuItem2Click(Sender: TObject);
begin
  F_Dados.cds_Rec.Edit;
  F_Dados.cds_Recdata_recebimento.AsString := '';
  F_Dados.cds_Rec.Post;
  F_Dados.cds_Rec.ApplyUpdates(0);
end;

procedure TF_aReceber.Edit3DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_Pegabanco, F_Pegabanco);
  F_Pegabanco.ShowModal;
end;

procedure TF_aReceber.Edit3Exit(Sender: TObject);
begin
  If Edit3.Text <> '' then begin
    Edit3.Text := StringOfChar('0', 2 - Length(Edit3.Text)) + Edit3.Text;
    MyConsulta(F_Dados.Q_Rap, 'select * from banco where id=' + chr(39) + Edit3.Text + chr(39));
    If F_Dados.Q_Rap.FieldByName('id').AsString = '' then begin
      Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
      Edit3.SetFocus;
    end
    else begin
      Edit4.Text := F_Dados.Q_Rap.FieldByName('Banco').AsString;
    end;
  end;
  MyConsulta(F_Dados.Q_Bancos, 'select * from banco order by id');
  F_Dados.cds_Bancos.close;
  F_Dados.cds_Bancos.open;
end;

procedure TF_aReceber.EditNum3Enter(Sender: TObject);
begin
  EditNum3.Text := FloatTostr(StrToFloat(EditNum1.Text) - StrToFloat(EditNum2.Text));
end;

procedure TF_aReceber.dataEnter(Sender: TObject);
begin
  data.Text := MaskEdit5.Text;
end;

procedure TF_aReceber.EditNum9Exit(Sender: TObject);
begin
  EditNum2.Text := FloatTostr(StrToFloat(EditNum1.Text) * StrToFloat(EditNum9.Text) / 100);
end;

procedure TF_aReceber.Incluir1Click(Sender: TObject);
begin
  F_Dados.cds_Rec.open;
  F_Dados.cds_Rec.Append;
  limpa;
  Panel1.Visible := true;
  Edit7.SetFocus;
  MyConsulta(F_Dados.Q_Bancos, 'select * from banco order by id');
  F_Dados.cds_Bancos.close;
  F_Dados.cds_Bancos.open;
end;

procedure TF_aReceber.Alterar1Click(Sender: TObject);
begin
  if F_Dados.cds_Recnf_fatura.AsString <> '' then begin
    Edit7.Text := F_Dados.cds_Recnf_fatura.AsString;
    Edit1.Text := F_Dados.cds_RecCliente.AsString;
    Edit5.Text := F_Dados.CDS_Rechistorico.AsString;
    MaskEdit3.Text := F_Dados.cds_RecEmissao.AsString;
    MaskEdit5.Text := F_Dados.cds_RecVencimento.AsString;
    EditNum1.Text := F_Dados.cds_RecValor.AsString;
    EditNum9.Text := F_Dados.cds_RecTaxa_Desconto.AsString;
    EditNum2.Text := F_Dados.cds_RecDesconto_Nota.AsString;
    EditNum3.Text := F_Dados.cds_RecTotal_Nota.AsString;
    EditNum4.Text := F_Dados.cds_RecTaxa_Juro.AsString;
    EditNum5.Text := F_Dados.cds_RecJuro.AsString;
    EditNum6.Text := F_Dados.cds_RecTaxa_Multa.AsString;
    EditNum7.Text := F_Dados.cds_RecMulta.AsString;
    EditNum8.Text := F_Dados.cds_RecValor_Recebido.AsString;
    data.Text := F_Dados.cds_Recdata_recebimento.AsString;
    Edit2.Text := F_Dados.cds_Rectipo_recebimento.AsString;
    Edit3.Text := F_Dados.cds_RecBanco.AsString;
    if F_Dados.cds_Rectipo_cliente.AsString <> '' then
      RadioGroup1.ItemIndex := StrToInt(F_Dados.cds_Rectipo_cliente.AsString) - 1
    else
      RadioGroup1.ItemIndex := -1;
    //
    MyConsulta(F_Dados.Q_Rap, 'select * from banco where id=' + chr(39) + F_Dados.cds_RecBanco.AsString + chr(39));
    Edit4.Text := F_Dados.Q_Rap.FieldByName('Banco').AsString;
    //
    Panel1.Visible := true;
    Edit7.SetFocus;
    MyConsulta(F_Dados.Q_Bancos, 'select * from banco order by id');
    F_Dados.cds_Bancos.close;
    F_Dados.cds_Bancos.open;
  end
end;

procedure TF_aReceber.BitBtn1Click(Sender: TObject);
begin
  relatorio := 'recibo';

  aguarde;
  RDprint.MostrarProgresso := true;
  RDprint.TitulodoRelatorio := 'Recibo';
  RDprint.TamanhoQteColunas := 100;
  RDprint.TamanhoQteLinhas := 66;
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 10;

  RDprint.imp(linha, 01, StringOfChar('=', 100));
  RDprint.imp(linha + 01, 01, 'DOCUMENTO....: ' + Edit7.Text);
  RDprint.imp(linha + 02, 01, 'CLIENTE......: ' + Edit1.Text);
  RDprint.imp(linha + 03, 01, 'EMISSAO......: ' + MaskEdit3.Text + '  -  VENCIMENTO...: ' + MaskEdit5.Text + '  -  RECEBIMENTO..: ' + data.Text);
  RDprint.imp(linha + 04, 01, StringOfChar('=', 100));
  RDprint.imp(linha + 05, 01, 'TOTAL........: ' + formatfloat('##,##0.00', StrToFloat(EditNum3.Text)));
  RDprint.imp(linha + 06, 01, 'JUROS........: ' + formatfloat('##,##0.00', StrToFloat(EditNum5.Text)));
  RDprint.imp(linha + 07, 01, 'MULTA........: ' + formatfloat('##,##0.00', StrToFloat(EditNum7.Text)));
  RDprint.imp(linha + 08, 01, 'RECEBIDO.....: ' + formatfloat('##,##0.00', StrToFloat(EditNum8.Text)));
  RDprint.imp(linha + 09, 01, StringOfChar('=', 100));
  RDprint.imp(linha + 10, 01, 'Recebi de ' + Edit1.Text + ' a importancia supra de R$' + formatfloat('##,##0.00', StrToFloat(EditNum8.Text)));
  Extenso.Valor := StrToFloat(EditNum8.Text);
  RDprint.imp(linha + 12, 01, '(' + Label19.Caption + ')');
  RDprint.imp(linha + 14, 01, 'Referente a(s) taxa(s) acima mencionada(s).');
  RDprint.impc(linha + 18, 50, '__________________________________________', []);
  RDprint.impc(linha + 19, 50, F_Dados.NomeEmpresa, []);
  RDprint.imp(linha + 22, 01, StringOfChar('=', 100));

  RDprint.Fechar;
  pronto;
end;

procedure TF_aReceber.MenuItem3Click(Sender: TObject);
var
  total, juro, multa, recebido, receber: double;
begin
  relatorio := 'geral';

  aguarde;
  RDprint.MostrarProgresso := true;
  RDprint.TitulodoRelatorio := 'Relatorio do Contas a Receber - Geral';
  RDprint.TamanhoQteColunas := 136;
  RDprint.TamanhoQteLinhas := 66;
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 11;
  //
  total := 0;
  juro := 0;
  multa := 0;
  recebido := 0;
  receber := 0;
  //
  F_Dados.cds_Rec.DisableControls;
  F_Dados.cds_Rec.First;
  while not F_Dados.cds_Rec.eof do begin
    NovaPagina;
    RDprint.imp(linha, 01, F_Dados.cds_Recnf_fatura.AsString);
    RDprint.imp(linha, 11, copy(F_Dados.cds_RecCliente.AsString, 1, 41));
    RDprint.imp(linha, 68, F_Dados.cds_RecEmissao.AsString);
    RDprint.imp(linha, 79, F_Dados.cds_RecVencimento.AsString);
    RDprint.imp(linha, 90, F_Dados.cds_Recdata_recebimento.AsString);
    RDprint.ImpVal(linha, 101, '##,##0.00', F_Dados.cds_Rectotal_nota.Value, []);
    RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.cds_RecJuro.Value, []);
    RDprint.ImpVal(linha, 122, '##,##0.00', F_Dados.cds_Recvalor_recebido.Value, []);
    total := ArredondaTruncaValor('A', total, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
    juro := ArredondaTruncaValor('A', juro, 2) + ArredondaTruncaValor('A', F_Dados.cds_RecJuro.Value, 2);
    recebido := ArredondaTruncaValor('A', recebido, 2) + ArredondaTruncaValor('A', F_Dados.cds_Recvalor_recebido.Value, 2);
    if F_Dados.cds_Recdata_recebimento.AsString = '' then
      receber := ArredondaTruncaValor('A', receber, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
    F_Dados.cds_Rec.Next;
    inc(linha);
  end;
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, 'TOTAIS EM (R$): ');
  RDprint.ImpVal(linha, 101, '##,##0.00', total, []);
  RDprint.ImpVal(linha, 110, '##,##0.00', juro, []);
  RDprint.ImpVal(linha, 122, '##,##0.00', recebido, []);

  linha := linha + 2;
  NovaPagina;
  RDprint.imp(linha, 01, 'SALDO A RECEBER EM (R$): ');
  RDprint.ImpVal(linha, 122, '##,##0.00', receber, []);

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  F_Dados.cds_Rec.First;
  F_Dados.cds_Rec.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_aReceber.MenuItem4Click(Sender: TObject);
var
  total, juro, multa, recebido, receber: double;
begin
  relatorio := 'receber';

  aguarde;
  RDprint.MostrarProgresso := true;
  RDprint.TitulodoRelatorio := 'Relatorio do Contas a Receber';
  RDprint.TamanhoQteColunas := 136;
  RDprint.TamanhoQteLinhas := 66;
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 11;
  //
  total := 0;
  juro := 0;
  multa := 0;
  recebido := 0;
  receber := 0;
  //
  F_Dados.cds_Rec.DisableControls;
  F_Dados.cds_Rec.First;
  while not F_Dados.cds_Rec.eof do begin
    if F_Dados.cds_Recdata_recebimento.AsString = '' then
    begin
      NovaPagina;
      RDprint.imp(linha, 01, F_Dados.cds_Recnf_fatura.AsString);
      RDprint.imp(linha, 11, copy(F_Dados.cds_RecCliente.AsString, 1, 41));
      RDprint.imp(linha, 68, F_Dados.cds_RecEmissao.AsString);
      RDprint.imp(linha, 79, F_Dados.cds_RecVencimento.AsString);
      RDprint.imp(linha, 90, F_Dados.cds_Recdata_recebimento.AsString);
      RDprint.ImpVal(linha, 101, '##,##0.00', F_Dados.cds_Rectotal_nota.Value, []);
      RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.cds_RecJuro.Value, []);
      RDprint.ImpVal(linha, 122, '##,##0.00', F_Dados.cds_Recvalor_recebido.Value, []);
      total := ArredondaTruncaValor('A', total, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      juro := ArredondaTruncaValor('A', juro, 2) + ArredondaTruncaValor('A', F_Dados.cds_RecJuro.Value, 2);
      recebido := ArredondaTruncaValor('A', recebido, 2) + ArredondaTruncaValor('A', F_Dados.cds_Recvalor_recebido.Value, 2);
      if F_Dados.cds_Recdata_recebimento.AsString = '' then
        receber := ArredondaTruncaValor('A', receber, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      F_Dados.cds_Rec.Next;
      inc(linha);
    end
    else
    begin
      F_Dados.cds_Rec.Next;
    end;
  end;
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, 'TOTAIS EM (R$): ');
  RDprint.ImpVal(linha, 101, '##,##0.00', total, []);
  RDprint.ImpVal(linha, 110, '##,##0.00', juro, []);
  RDprint.ImpVal(linha, 122, '##,##0.00', recebido, []);

  linha := linha + 2;
  NovaPagina;
  RDprint.imp(linha, 01, 'SALDO A RECEBER EM (R$): ');
  RDprint.ImpVal(linha, 122, '##,##0.00', receber, []);

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  F_Dados.cds_Rec.First;
  F_Dados.cds_Rec.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_aReceber.ContasRecebidas1Click(Sender: TObject);
var
  total, juro, multa, recebido, receber: double;
begin
  relatorio := 'recebidas';

  aguarde;
  RDprint.MostrarProgresso := true;
  RDprint.TitulodoRelatorio := 'Relatorio do Contas Recebidas';
  RDprint.TamanhoQteColunas := 136;
  RDprint.TamanhoQteLinhas := 66;
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 11;
  //
  total := 0;
  juro := 0;
  multa := 0;
  recebido := 0;
  receber := 0;
  //
  F_Dados.cds_Rec.DisableControls;
  F_Dados.cds_Rec.First;
  while not F_Dados.cds_Rec.eof do begin
    if F_Dados.cds_Recdata_recebimento.AsString <> '' then
    begin
      NovaPagina;
      RDprint.imp(linha, 01, F_Dados.cds_Recnf_fatura.AsString);
      RDprint.imp(linha, 11, copy(F_Dados.cds_RecCliente.AsString, 1, 41));
      RDprint.imp(linha, 68, F_Dados.cds_RecEmissao.AsString);
      RDprint.imp(linha, 79, F_Dados.cds_RecVencimento.AsString);
      RDprint.imp(linha, 90, F_Dados.cds_Recdata_recebimento.AsString);
      RDprint.ImpVal(linha, 101, '##,##0.00', F_Dados.cds_Rectotal_nota.Value, []);
      RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.cds_RecJuro.Value, []);
      RDprint.ImpVal(linha, 122, '##,##0.00', F_Dados.cds_Recvalor_recebido.Value, []);
      total := ArredondaTruncaValor('A', total, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      juro := ArredondaTruncaValor('A', juro, 2) + ArredondaTruncaValor('A', F_Dados.cds_RecJuro.Value, 2);
      recebido := ArredondaTruncaValor('A', recebido, 2) + ArredondaTruncaValor('A', F_Dados.cds_Recvalor_recebido.Value, 2);
      if F_Dados.cds_Recdata_recebimento.AsString = '' then
        receber := ArredondaTruncaValor('A', receber, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      F_Dados.cds_Rec.Next;
      inc(linha);
    end
    else
    begin
      F_Dados.cds_Rec.Next;
    end;
  end;
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, 'TOTAIS EM (R$): ');
  RDprint.ImpVal(linha, 101, '##,##0.00', total, []);
  RDprint.ImpVal(linha, 110, '##,##0.00', juro, []);
  RDprint.ImpVal(linha, 122, '##,##0.00', recebido, []);

  linha := linha + 2;
  NovaPagina;
  RDprint.imp(linha, 01, 'SALDO A RECEBER EM (R$): ');
  RDprint.ImpVal(linha, 122, '##,##0.00', receber, []);

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  F_Dados.cds_Rec.First;
  F_Dados.cds_Rec.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_aReceber.CaixaEscolas1Click(Sender: TObject);
var
  total, juro, multa, recebido, receber: double;
begin
  relatorio := 'caixa';

  aguarde;
  RDprint.MostrarProgresso := true;
  RDprint.TitulodoRelatorio := 'Caixa do Periodo';
  RDprint.TamanhoQteColunas := 136;
  RDprint.TamanhoQteLinhas := 66;
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 11;
  //
  total := 0;
  juro := 0;
  multa := 0;
  recebido := 0;
  receber := 0;
  //
  F_Dados.cds_Rec.DisableControls;
  F_Dados.cds_Rec.First;
  while not F_Dados.cds_Rec.eof do begin
    if ((F_Dados.cds_Rectipo_cliente.AsString = '1') or (F_Dados.cds_Rectipo_cliente.AsString = '2')) and (F_Dados.cds_Rectipo_recebimento.AsString = 'CARTEIRA') then
    begin
      NovaPagina;
      RDprint.imp(linha, 01, F_Dados.cds_Recnf_fatura.AsString);
      RDprint.imp(linha, 11, copy(F_Dados.cds_RecCliente.AsString, 1, 41));
      RDprint.imp(linha, 68, F_Dados.cds_RecEmissao.AsString);
      RDprint.imp(linha, 79, F_Dados.cds_RecVencimento.AsString);
      RDprint.imp(linha, 90, F_Dados.cds_Recdata_recebimento.AsString);
      RDprint.ImpVal(linha, 101, '##,##0.00', F_Dados.cds_Rectotal_nota.Value, []);
      RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.cds_RecJuro.Value, []);
      RDprint.ImpVal(linha, 122, '##,##0.00', F_Dados.cds_Recvalor_recebido.Value, []);
      total := ArredondaTruncaValor('A', total, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      juro := ArredondaTruncaValor('A', juro, 2) + ArredondaTruncaValor('A', F_Dados.cds_RecJuro.Value, 2);
      recebido := ArredondaTruncaValor('A', recebido, 2) + ArredondaTruncaValor('A', F_Dados.cds_Recvalor_recebido.Value, 2);
      if F_Dados.cds_Recdata_recebimento.AsString = '' then
        receber := ArredondaTruncaValor('A', receber, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      F_Dados.cds_Rec.Next;
      inc(linha);
    end
    else
    begin
      F_Dados.cds_Rec.Next;
    end;
  end;
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, 'TOTAIS EM (R$): ');
  RDprint.ImpVal(linha, 101, '##,##0.00', total, []);
  RDprint.ImpVal(linha, 110, '##,##0.00', juro, []);
  RDprint.ImpVal(linha, 122, '##,##0.00', recebido, []);

  linha := linha + 2;
  NovaPagina;
  RDprint.imp(linha, 01, 'SALDO A RECEBER EM (R$): ');
  RDprint.ImpVal(linha, 122, '##,##0.00', receber, []);

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  F_Dados.cds_Rec.First;
  F_Dados.cds_Rec.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_aReceber.CaixaCarteira1Click(Sender: TObject);
var
  total, juro, multa, recebido, receber: double;
begin
  relatorio := 'caixa';

  aguarde;
  RDprint.MostrarProgresso := true;
  RDprint.TitulodoRelatorio := 'Caixa do Periodo';
  RDprint.TamanhoQteColunas := 136;
  RDprint.TamanhoQteLinhas := 66;
  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 11;
  //
  total := 0;
  juro := 0;
  multa := 0;
  recebido := 0;
  receber := 0;
  //
  F_Dados.cds_Rec.DisableControls;
  F_Dados.cds_Rec.First;
  while not F_Dados.cds_Rec.eof do begin
    if (F_Dados.cds_Rectipo_cliente.AsString = '4') and (F_Dados.cds_Rectipo_recebimento.AsString = 'CARTEIRA') then
    begin
      NovaPagina;
      RDprint.imp(linha, 01, F_Dados.cds_Recnf_fatura.AsString);
      RDprint.imp(linha, 11, copy(F_Dados.cds_RecCliente.AsString, 1, 41));
      RDprint.imp(linha, 68, F_Dados.cds_RecEmissao.AsString);
      RDprint.imp(linha, 79, F_Dados.cds_RecVencimento.AsString);
      RDprint.imp(linha, 90, F_Dados.cds_Recdata_recebimento.AsString);
      RDprint.ImpVal(linha, 101, '##,##0.00', F_Dados.cds_Rectotal_nota.Value, []);
      RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.cds_RecJuro.Value, []);
      RDprint.ImpVal(linha, 122, '##,##0.00', F_Dados.cds_Recvalor_recebido.Value, []);
      total := ArredondaTruncaValor('A', total, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      juro := ArredondaTruncaValor('A', juro, 2) + ArredondaTruncaValor('A', F_Dados.cds_RecJuro.Value, 2);
      recebido := ArredondaTruncaValor('A', recebido, 2) + ArredondaTruncaValor('A', F_Dados.cds_Recvalor_recebido.Value, 2);
      if F_Dados.cds_Recdata_recebimento.AsString = '' then
        receber := ArredondaTruncaValor('A', receber, 2) + ArredondaTruncaValor('A', F_Dados.cds_Rectotal_nota.Value, 2);
      F_Dados.cds_Rec.Next;
      inc(linha);
    end
    else
    begin
      F_Dados.cds_Rec.Next;
    end;
  end;
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, 'TOTAIS EM (R$): ');
  RDprint.ImpVal(linha, 101, '##,##0.00', total, []);
  RDprint.ImpVal(linha, 110, '##,##0.00', juro, []);
  RDprint.ImpVal(linha, 122, '##,##0.00', recebido, []);

  linha := linha + 2;
  NovaPagina;
  RDprint.imp(linha, 01, 'SALDO A RECEBER EM (R$): ');
  RDprint.ImpVal(linha, 122, '##,##0.00', receber, []);

  inc(linha);
  NovaPagina;
  RDprint.imp(linha, 01, StringOfChar('=', 136));

  F_Dados.cds_Rec.First;
  F_Dados.cds_Rec.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_aReceber.NovaPagina;
begin
  if linha > 63 then
    RDprint.NovaPagina;
end;

procedure TF_aReceber.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  if (relatorio = 'geral') or (relatorio = 'receber') or (relatorio = 'recebidas') or (relatorio = 'caixa') then
  begin
    RDprint.imp(02, 01, StringOfChar('=', 136));
    if relatorio = 'geral' then
      RDprint.impf(03, 01, 'Relatorio do Contas a Receber - Geral', [expandido, NEGRITO])
    else if relatorio = 'receber' then
      RDprint.impf(03, 01, 'Relatorio do Contas a Receber', [expandido, NEGRITO])
    else if relatorio = 'recebidas' then
      RDprint.impf(03, 01, 'Relatorio do Contas Recebidas', [expandido, NEGRITO])
    else if relatorio = 'caixa' then
      RDprint.impf(03, 01, 'Caixa do Período', [expandido, NEGRITO]);
    RDprint.imp(04, 01, F_Dados.NomeEmpresa);
    RDprint.imp(05, 01, F_Dados.EnderecoEmpresa);
    RDprint.imp(06, 01, StringOfChar('=', 136));
    RDprint.imp(07, 01, 'PERIODO: ' + MaskEdit4.Text + ' A ' + MaskEdit1.Text);
    RDprint.imp(08, 01, StringOfChar('=', 136));
    RDprint.imp(09, 01, 'DOCUMENTO');
    RDprint.imp(09, 11, 'CLIENTE');
    RDprint.imp(09, 68, 'EMISSAO');
    RDprint.imp(09, 79, 'VENCIMENTO');
    RDprint.imp(09, 90, 'RECEBIMENTO');
    RDprint.imp(09, 102, 'A RECEBER');
    RDprint.imp(09, 113, 'JUROS');
    RDprint.imp(09, 122, 'RECEBIDO');
    RDprint.imp(10, 01, StringOfChar('-', 136));
    linha := 11;
  end;
end;

procedure TF_aReceber.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  if (relatorio = 'geral') or (relatorio = 'receber') or (relatorio = 'recebidas') or (relatorio = 'caixa') then
  begin
    RDprint.imp(64, 01, StringOfChar('=', 136));
    RDprint.imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
    RDprint.impd(65, 136, 'Impresso em ' + DateTimeToStr(Now), [italico]);
  end;
end;

procedure TF_aReceber.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

end.
