unit U_Orcamento;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, EditNum, DBCGrids, Mask, DBCtrls,
  Grids, DBGrids, MenBtn, Menus, ComCtrls, Db, DBTables, Biblioteca, RDprint;

type
  TF_Orcamento = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn10: TBitBtn;
    ScrollBox2: TScrollBox;
    Label4: TLabel;
    Label1: TLabel;
    EditNum2: TEditNum;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    BitBtn15: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    Opcoes: TPopupMenu;
    datainicio: TMaskEdit;
    DBGrid1: TDBGrid;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edit3: TEdit;
    Label15: TLabel;
    Panel3: TPanel;
    AtualizaPreos1: TMenuItem;
    RelaoSeparada1: TMenuItem;
    Label2: TLabel;
    EditNum1: TEditNum;
    MenuButton1: TMenuButton;
    RadioButton1: TCheckBox;
    N1: TMenuItem;
    Bobina1: TMenuItem;
    RDprint: TRDprint;
    procedure aguarde;
    procedure pronto;
    procedure limpa;
    procedure grava;
    procedure grava_cabecalho;
    procedure habilita;
    procedure desabilita;
    procedure PegaDorc;
    procedure soma;
    procedure BitBtn10Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit1DblClick(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit3Enter(Sender: TObject);
    procedure AtualizaPreos1Click(Sender: TObject);
    procedure RelaoSeparada1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Bobina1Click(Sender: TObject);
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
  F_Orcamento: TF_Orcamento;
  linha, opc: Integer;
  relatorio: string;

implementation

uses U_Dados, U_PegaColegio, U_PegaProdutos;
{$R *.DFM}

Procedure TF_Orcamento.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_Orcamento.pronto;
begin
  Panel3.Visible := False;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

procedure TF_Orcamento.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_Orcamento.limpa;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  datainicio.Clear;
  EditNum2.Text := '0.00';
  EditNum1.Text := '0';
  RadioButton1.Checked := False
end;

procedure TF_Orcamento.grava;
begin
  F_Dados.cds_Dorc.ApplyUpdates(0);
  soma;
  grava_cabecalho;
end;

procedure TF_Orcamento.grava_cabecalho;
begin
  F_Dados.cds_Corccodigo_orcamento.AsString := Edit4.Text;
  F_Dados.cds_Corcid_escola.AsString := Edit1.Text;
  F_Dados.cds_CorcSerie.AsString := datainicio.Text;
  F_Dados.cds_CorcAno.AsString := Edit3.Text;
  F_Dados.cds_Corcvalor_total.AsString := EditNum2.Text;
  F_Dados.cds_CorcAluno.AsString := EditNum1.Text;
  F_Dados.cds_CorcAuditoria.AsString := DateTimeToStr(Now);
  if RadioButton1.Checked = True then
    F_Dados.cds_CorcPedido.AsString := 'S';
  F_Dados.cds_Corc.Post;
  F_Dados.cds_Corc.ApplyUpdates(0);
end;

procedure TF_Orcamento.habilita;
begin
  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Edit3.Enabled := True;
  Edit4.Enabled := True;
  EditNum2.Enabled := True;
  EditNum1.Enabled := True;
  datainicio.Enabled := True;
  BitBtn15.Enabled := False;
  BitBtn10.Enabled := False;
  BitBtn3.Enabled := True;
  BitBtn4.Enabled := True;
  BitBtn14.Enabled := True;
  MenuButton1.Enabled := True;
end;

procedure TF_Orcamento.desabilita;
begin
  MyConsulta(F_Dados.Q_Corc, 'select * from orcamento_cabecalho where codigo_orcamento=' + chr(39) + Edit4.Text + chr(39));
  F_Dados.cds_Corc.Close;
  F_Dados.cds_Corc.open;
  //
  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit3.Enabled := False;
  Edit4.Enabled := False;
  EditNum2.Enabled := False;
  EditNum1.Enabled := False;
  datainicio.Enabled := False;
  BitBtn15.Enabled := True;
  BitBtn10.Enabled := True;
  BitBtn3.Enabled := False;
  BitBtn4.Enabled := False;
  BitBtn14.Enabled := False;
  MenuButton1.Enabled := False;
end;

Procedure TF_Orcamento.soma;
Begin
  F_Dados.Q_Rap.Active := False;
  F_Dados.Q_Rap.Sql.Clear;
  F_Dados.Q_Rap.Sql.add('delete from orcamento_detalhe where codigobarra is null');
  F_Dados.Q_Rap.ExecSql;
  //
  MyConsulta(F_Dados.Q_Rap, 'select sum(valor_total) as soma from orcamento_detalhe where id_orcamento_cabecalho=' + chr(39) + F_Dados.CDS_Corcid.AsString + chr(39));
  EditNum2.Text := F_Dados.Q_Rap.FieldByName('soma').AsString;
end;

procedure TF_Orcamento.PegaDorc;
begin
  MyConsulta(F_Dados.Q_Dorc, 'select * from orcamento_detalhe where id_orcamento_cabecalho=' + chr(39) + F_Dados.CDS_Corcid.AsString + chr(39) + 'order by descricao');
  F_Dados.cds_Dorc.Close;
  F_Dados.cds_Dorc.open;
end;

procedure TF_Orcamento.FormActivate(Sender: TObject);
begin
  Inclui := 0;
  limpa;
  desabilita;
  PegaDorc;
  BitBtn15.SetFocus;
end;

procedure TF_Orcamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  F_Dados.Q_Corc.Close;
  F_Dados.Q_Dorc.Close;
  Release;
end;

procedure TF_Orcamento.Edit1DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaColegio, F_PegaColegio);
  F_PegaColegio.opc := 1;
  F_PegaColegio.ShowModal;
end;

procedure TF_Orcamento.Edit1Exit(Sender: TObject);
begin
  Edit1.Text := StringOfChar('0', 3 - Length(Edit1.Text)) + Edit1.Text;
  If Edit1.Text <> '' then begin
    MyConsulta(F_Dados.Q_Particular, 'select * from escola where id=' + chr(39) + Edit1.Text + chr(39));
    If F_Dados.Q_Particular.RecordCount <= 0 then begin
      Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
      limpa;
      Edit1.SetFocus;
    end
    else begin
      Edit2.Text := F_Dados.Q_ParticularNome.AsString;
      Label10.Caption := F_Dados.Q_ParticularEndereco.AsString;
      Label11.Caption := F_Dados.Q_ParticularCidade.AsString;
      Label12.Caption := F_Dados.Q_ParticularEstado.AsString;
    end;
  end
  else
    Edit2.Text := '';
end;

procedure TF_Orcamento.BitBtn15Click(Sender: TObject);
begin
  Inclui := 1;
  limpa;
  habilita;
  PegaDorc;
  Edit1.SetFocus;
end;

procedure TF_Orcamento.BitBtn14Click(Sender: TObject);
begin
  opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then
  begin
    F_Dados.cds_Dorc.Delete;
    F_Dados.cds_Dorc.ApplyUpdates(0);
  end;
end;

procedure TF_Orcamento.Edit4Exit(Sender: TObject);
begin
  If (Length(Edit4.Text) <> 12) or (Copy(Edit4.Text, 5, 3) = ' / ') then begin
    Application.MessageBox('O Código do Orçamento está Incorreto. Selecione:' + #13 + #13 + '1º -> O Código da Escola' + #13 + '2º -> A Série / Grau' + #13 + '3º -> O Ano do Orçamento', 'Informação do Sistema', Mb_IconInformation);
    Edit1.Enabled := True;
    Edit1.SetFocus;
    PegaDorc;
  end
  else begin
    MyConsulta(F_Dados.Q_Corc, 'select * from orcamento_cabecalho where codigo_orcamento=' + chr(39) + Edit4.Text + chr(39));
    F_Dados.cds_Corc.Close;
    F_Dados.cds_Corc.open;
    If F_Dados.Q_Corc.RecordCount > 0 then begin
      opc := Application.MessageBox('O Orçamento já Está Cadastrado' + #13 + 'Deseja Acessar o Orçamento Existente', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion);
      If opc = IdYes then begin
        Inclui := 2;
        Edit4.Text := F_Dados.Q_Corccodigo_orcamento.AsString;
        datainicio.Text := F_Dados.Q_CorcSerie.AsString;
        Edit3.Text := F_Dados.Q_CorcAno.AsString;
        EditNum1.Text := F_Dados.Q_CorcAluno.AsString;
        EditNum2.Text := F_Dados.Q_Corcvalor_total.AsString;
        if F_Dados.Q_CorcPedido.AsString = 'S' then
          RadioButton1.Checked := True;
        //
        PegaDorc;
        Edit1.Enabled := False;
      end
      else begin
        limpa;
        desabilita;
      end;
    end
    else begin
      F_Dados.cds_Corc.Append;
      grava_cabecalho;
      MyConsulta(F_Dados.Q_Corc, 'select * from orcamento_cabecalho where codigo_orcamento=' + chr(39) + Edit4.Text + chr(39));
      F_Dados.cds_Corc.Close;
      F_Dados.cds_Corc.Open;
      PegaDorc;
      Edit1.Enabled := False;
    end;
  end;
end;

procedure TF_Orcamento.BitBtn3Click(Sender: TObject);
begin
  opc := Application.MessageBox('Tem Certeza que Deseja Cancelar o Processo Acima?', 'Cancela o Processo', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then begin
    aguarde;
    // F_Dados.cds_Corc.Edit;
    // Grava;
    limpa;
    desabilita;
    BitBtn15.SetFocus;
    PegaDorc;
    pronto;
  end;
end;

procedure TF_Orcamento.DBGrid1DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaProd, F_PegaProd);
  F_PegaProd.ShowModal;
end;

procedure TF_Orcamento.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = Vk_Return then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Orcamento.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = 112 then begin
    aguarde;
    F_Dados.cds_Dorc.ApplyUpdates(0);
    soma;
    pronto;
  end;
  If Key = 115 then begin
    Application.CreateForm(TF_PegaProd, F_PegaProd);
    F_PegaProd.ShowModal;
  end;
  If Key = vk_f9 then
    RelaoSeparada1Click(Sender);
  If Key = vk_f10 then
    Bobina1Click(Sender);
end;

procedure TF_Orcamento.Edit3Exit(Sender: TObject);
begin
  Edit4.Text := Edit1.Text + '-' + datainicio.Text + '-' + Edit3.Text;
end;

procedure TF_Orcamento.Edit3Enter(Sender: TObject);
begin
  Edit3.Text := Copy(datetostr(date), 7, 4);
  Edit3.SelectAll;
end;

procedure TF_Orcamento.BitBtn4Click(Sender: TObject);
begin
  opc := Application.MessageBox('Confirma o Orçamento Acima?', 'Confirmar o Orçamento', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then begin
    aguarde;
    If Inclui = 1 then begin
      F_Dados.cds_Corc.Edit;
      grava;
    end
    else if Inclui = 2 then begin
      F_Dados.cds_Corc.Edit;
      grava;
    end;
    limpa;
    desabilita;
    PegaDorc;
    pronto;
  end;
end;

procedure TF_Orcamento.AtualizaPreos1Click(Sender: TObject);
begin
  aguarde;
  F_Dados.cds_Dorc.DisableControls;
  F_Dados.cds_Dorc.First;
  While not F_Dados.cds_Dorc.EOF do begin
    MyConsulta(F_Dados.Q_Rap, 'select * from produto where codigo=' + chr(39) + F_Dados.cds_DorcCodigoBarra.AsString + chr(39));
    F_Dados.cds_Dorc.Edit;
    F_Dados.cds_Dorcvalor_unitario.AsString := F_Dados.Q_Rap.FieldByName('Preco').AsString;
    F_Dados.Q_DorcDescricao.AsString := F_Dados.Q_Rap.FieldByName('Descricao').AsString;
    F_Dados.cds_DorcReferencia.AsString := F_Dados.Q_Rap.FieldByName('Referencia').AsString;
    F_Dados.cds_DorcUnidade.AsString := F_Dados.Q_Rap.FieldByName('Unidade').AsString;
    F_Dados.cds_DorcAutor_Marca.AsString := F_Dados.Q_Rap.FieldByName('Autor_Marca').AsString;
    F_Dados.cds_Dorc.Post;
    F_Dados.cds_Dorc.Next;
    Continue;
  end;
  F_Dados.cds_Dorc.ApplyUpdates(0);
  F_Dados.cds_Dorc.First;
  F_Dados.cds_Dorc.EnableControls;
  pronto;
end;

procedure TF_Orcamento.Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 119 then
    Edit1DblClick(Sender);
  if Key = 13 then
    Edit2.SetFocus;
end;

procedure TF_Orcamento.Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    EditNum2.SetFocus;
end;

procedure TF_Orcamento.RelaoSeparada1Click(Sender: TObject);
var
  item: Integer;
  liv, mat: double;
begin
  relatorio := 'orcamento';

  aguarde;

  F_Dados.cds_Dorc.ApplyUpdates(0);
  soma;
  item := 0;
  liv := 0;
  mat := 0;

  RDprint.MostrarProgresso := True;
  RDprint.OpcoesPreview.Preview := True;
  RDprint.TitulodoRelatorio := 'Orçamento';
  RDprint.TamanhoQteColunas := 136;
  RDprint.TamanhoQteLinhas := 66;

  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 17;

  F_Dados.cds_Dorc.DisableControls;
  MyConsulta(F_Dados.Q_Dorc, 'select * from orcamento_detalhe where id_orcamento_cabecalho=' + chr(39) + F_Dados.CDS_Corcid.AsString + chr(39) + 'order by livro_material,descricao');
  F_Dados.cds_Dorc.Close;
  F_Dados.cds_Dorc.open;
  //
  F_Dados.cds_Dorc.First;
  while not F_Dados.cds_Dorc.EOF do
  begin
    if F_Dados.CDS_Dorclivro_material.AsString = 'L' then
    begin
      NovaPagina;
      item := item + 1;

      RDprint.ImpVal(linha, 01, '###0', item, []);
      RDprint.Imp(linha, 06, F_Dados.cds_DorcCodigoBarra.AsString);
      RDprint.Imp(linha, 21, F_Dados.cds_DorcUnidade.AsString);
      RDprint.ImpVal(linha, 28, '##,##0', F_Dados.CDS_DorcQuantidade.Value, []);
      RDprint.Imp(linha, 36, Copy(F_Dados.CDS_DorcDescricao.AsString, 1, 37));
      RDprint.Imp(linha, 74, F_Dados.cds_DorcAutor_Marca.AsString);
      RDprint.Imp(linha, 91, F_Dados.cds_DorcReferencia.AsString);
      //
      RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.cds_Dorcvalor_unitario.Value, []);
      RDprint.ImpVal(linha, 121, '##,##0.00', F_Dados.CDS_Dorcvalor_total.Value, []);
      liv := liv + F_Dados.CDS_Dorcvalor_total.Value;
      F_Dados.cds_Dorc.Next;
      inc(linha);
    end
    else
      F_Dados.cds_Dorc.Next;
  end;
  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 80, 'TOTAL DE LIVROS....................: R$ ');
  RDprint.ImpVal(linha, 121, '##,##0.00', liv, []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  F_Dados.cds_Dorc.First;
  while not F_Dados.cds_Dorc.EOF do
  begin
    if F_Dados.CDS_Dorclivro_material.AsString = 'M' then
    begin
      NovaPagina;
      item := item + 1;

      RDprint.ImpVal(linha, 01, '###0', item, []);
      RDprint.Imp(linha, 06, F_Dados.cds_DorcCodigoBarra.AsString);
      RDprint.Imp(linha, 21, F_Dados.cds_DorcUnidade.AsString);
      RDprint.ImpVal(linha, 28, '##,##0', F_Dados.CDS_DorcQuantidade.Value, []);
      RDprint.Imp(linha, 36, Copy(F_Dados.CDS_DorcDescricao.AsString, 1, 37));
      RDprint.Imp(linha, 74, F_Dados.cds_DorcAutor_Marca.AsString);
      RDprint.Imp(linha, 91, F_Dados.cds_DorcReferencia.AsString);
      //
      RDprint.ImpVal(linha, 110, '##,##0.00', F_Dados.cds_Dorcvalor_unitario.Value, []);
      RDprint.ImpVal(linha, 121, '##,##0.00', F_Dados.CDS_Dorcvalor_total.Value, []);
      mat := mat + F_Dados.CDS_Dorcvalor_total.Value;
      F_Dados.cds_Dorc.Next;
      inc(linha);
    end
    else
      F_Dados.cds_Dorc.Next;
  end;

  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 80, 'TOTAL DE MATERIAIS.................: R$ ');
  RDprint.ImpVal(linha, 121, '##,##0.00', mat, []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 80, 'TOTAL GERAL PARA PAGAMENTO A VISTA.: R$ ');
  RDprint.ImpVal(linha, 121, '##,##0.00', StrToFloat(EditNum2.Text), []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 136));

  inc(linha);
  NovaPagina;
  RDprint.impc(linha, 68, 'OBSERVACAO: PRECOS VALIDOS POR 8 (OITO) DIAS - MATERIAIS SUJEITOS A TROCA', []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, '');

  inc(linha);
  NovaPagina;
  RDprint.impc(linha, 68, 'VENDEDOR:_______________________________', []);

  inc(linha);
  NovaPagina;
  RDprint.Imp(linha, 01, StringOfChar('=', 136));

  F_Dados.cds_Dorc.EnableControls;
  F_Dados.cds_Dorc.First;

  RDprint.Fechar;
  pronto;
end;

procedure TF_Orcamento.Bobina1Click(Sender: TObject);
var
  item: Integer;
  liv, mat: double;
begin
  relatorio := 'bobina';

  aguarde;

  F_Dados.cds_Dorc.ApplyUpdates(0);
  soma;
  item := 0;
  liv := 0;
  mat := 0;

  RDprint.TamanhoQteLinhas := 1; // Linhas (deve ser 1 quando for CUPOM)
  RDprint.TamanhoQteColunas := 55; // Largura da Bobina aprox. 7 cm (7 / 2.54 * 20)
  RDprint.FonteTamanhoPadrao := s20cpp; // Fonte Comprimido em 20 cpp
  RDprint.OpcoesPreview.Preview := False;

  RDprint.abrir; // Inicia a montagem do relatório...
  linha := 01;

  RDprint.Imp(linha + 01, 01, '****************************************************');
  RDprint.Imp(linha + 02, 01, F_Dados.NomeEmpresa);
  RDprint.Imp(linha + 03, 01, '****************************************************');
  RDprint.Imp(linha + 04, 01, 'ORCAMENTO No  ' + Edit4.Text);
  RDprint.Imp(linha + 05, 01, Edit2.Text);
  RDprint.Imp(linha + 07, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 08, 01, 'DATA: ' + datetostr(date));
  RDprint.Imp(linha + 08, 38, 'HORA: ' + TimeToStr(Time));
  RDprint.Imp(linha + 09, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 10, 01, 'ITEM   DESCRICAO');
  RDprint.Imp(linha + 11, 01, 'UNIDADE   QUANTIDADE    UNITARIO (R$)     TOTAL (R$)');
  RDprint.Imp(linha + 12, 01, '----------------------------------------------------');
  //
  F_Dados.cds_Dorc.DisableControls;
  MyConsulta(F_Dados.Q_Dorc, 'select * from orcamento_detalhe where id_orcamento_cabecalho=' + chr(39) + F_Dados.CDS_Corcid.AsString + chr(39) + 'order by livro_material,descricao');
  F_Dados.cds_Dorc.Close;
  F_Dados.cds_Dorc.open;
  //
  F_Dados.cds_Dorc.First;

  linha := linha + 13;
  while not F_Dados.cds_Dorc.EOF do
  begin
    if F_Dados.CDS_Dorclivro_material.AsString = 'L' then
    begin
      item := item + 1;

      RDprint.ImpVal(linha, 01, '###0', item, []);
      RDprint.Imp(linha, 07, F_Dados.CDS_DorcDescricao.AsString);
      inc(linha);
      RDprint.Imp(linha, 01, F_Dados.cds_DorcUnidade.AsString);
      RDprint.ImpVal(linha, 14, '##,##0', F_Dados.CDS_DorcQuantidade.Value, []);
      RDprint.ImpVal(linha, 28, '##,##0.00', F_Dados.cds_Dorcvalor_unitario.Value, []);
      RDprint.ImpVal(linha, 43, '##,##0.00', F_Dados.CDS_Dorcvalor_total.Value, []);
      //
      liv := liv + F_Dados.CDS_Dorcvalor_total.Value;
      F_Dados.cds_Dorc.Next;
      inc(linha);
    end
    else
      F_Dados.cds_Dorc.Next;
  end;
  RDprint.Imp(linha + 00, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 01, 01, 'TOTAL DE LIVROS.......: R$ ');
  RDprint.ImpVal(linha + 01, 43, '##,##0.00', liv, []);
  RDprint.Imp(linha + 02, 01, '----------------------------------------------------');

  linha := linha + 03;
  F_Dados.cds_Dorc.First;
  while not F_Dados.cds_Dorc.EOF do
  begin
    if F_Dados.CDS_Dorclivro_material.AsString = 'M' then
    begin
      item := item + 1;

      RDprint.ImpVal(linha, 01, '###0', item, []);
      RDprint.Imp(linha, 07, F_Dados.CDS_DorcDescricao.AsString);
      inc(linha);
      RDprint.Imp(linha, 01, F_Dados.cds_DorcUnidade.AsString);
      RDprint.ImpVal(linha, 14, '##,##0', F_Dados.CDS_DorcQuantidade.Value, []);
      RDprint.ImpVal(linha, 28, '##,##0.00', F_Dados.cds_Dorcvalor_unitario.Value, []);
      RDprint.ImpVal(linha, 43, '##,##0.00', F_Dados.CDS_Dorcvalor_total.Value, []);
      //
      mat := mat + F_Dados.CDS_Dorcvalor_total.Value;
      F_Dados.cds_Dorc.Next;
      inc(linha);
    end
    else
      F_Dados.cds_Dorc.Next;
  end;

  RDprint.Imp(linha + 00, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 01, 01, 'TOTAL DE MATERIAIS....: R$ ');
  RDprint.ImpVal(linha + 01, 43, '##,##0.00', mat, []);
  RDprint.Imp(linha + 02, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 03, 01, 'TOTAL GERAL A VISTA: R$ ');
  RDprint.ImpVal(linha + 03, 43, '##,##0.00', StrToFloat(EditNum2.Text), []);
  RDprint.Imp(linha + 04, 01, '----------------------------------------------------');
  RDprint.Imp(linha + 06, 06, 'VENDEDOR:_______________________________');
  RDprint.Imp(linha + 07, 01, '----------------------------------------------------');

  linha := linha + 22;

  RDprint.Imp(linha, 01, '');

  F_Dados.cds_Dorc.EnableControls;
  F_Dados.cds_Dorc.First;

  { =========================================================================== }
  { Mostra preview com tamanho variavel de um cupom nao Fiscal }
  { }
  { ISTO NAO DEVERIA SER FEITO, NÃO ESTA PREVISTO NOS }
  { RECURSOS DO RDPRINT,  USE POR SUA CONTA E RISCO... }
  { =========================================================================== }
  { } RDprint.OpcoesPreview.Preview := True; { }
  { } RDprint.TamanhoQteLinhas := linha; // Qte de linhas do cupom  {}
  { =========================================================================== }

  RDprint.Fechar;

  pronto;
end;

procedure TF_Orcamento.NovaPagina;
begin
  if linha > 63 then
    RDprint.NovaPagina;
end;

procedure TF_Orcamento.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  if relatorio = 'orcamento' then
  begin
    RDprint.Imp(02, 01, StringOfChar('=', 136));
    RDprint.impf(03, 01, 'Orçamento', [expandido, NEGRITO]);
    RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
    RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
    RDprint.Imp(06, 01, StringOfChar('=', 136));
    RDprint.Imp(07, 01, 'ORCAMENTO DO COLEGIO: ' + Edit2.Text + ' - ' + 'No DO ORCAMENTO: ' + Edit4.Text + ' (SEM VALOR FISCAL)');
    RDprint.Imp(08, 01, StringOfChar('=', 136));
    RDprint.impc(10, 68, 'NOME CLIENTE:___________________________________________     CPF.:_______________________', []);
    RDprint.impc(12, 68, 'ENDERECO....:___________________________________________     FONE:_______________________', []);
    RDprint.Imp(14, 01, StringOfChar('=', 136));

    RDprint.Imp(15, 01, 'ITEM');
    RDprint.Imp(15, 06, 'CODIGO');
    RDprint.Imp(15, 21, 'UNIDADE');
    RDprint.Imp(15, 18, 'QUANT');
    RDprint.Imp(15, 41, 'ESPECIFICACAO DO MATERIAL');
    RDprint.Imp(15, 74, 'AUTOR/MARCA');
    RDprint.Imp(15, 91, 'REF.');
    RDprint.Imp(15, 111, 'UNITARIO');
    RDprint.Imp(15, 125, 'TOTAL');

    RDprint.Imp(16, 01, StringOfChar('-', 136));
    linha := 17;
  end;
end;

procedure TF_Orcamento.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  if relatorio = 'orcamento' then
  begin
    RDprint.Imp(64, 01, StringOfChar('=', 136));
    RDprint.Imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
    RDprint.impd(65, 136, 'Impresso em ' + DateTimeToStr(Now), [italico]);
  end;
end;

procedure TF_Orcamento.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

end.
