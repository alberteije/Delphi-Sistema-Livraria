unit U_Fornecedores;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, Db, Grids, DBGrids, DBTables,
  DBIProcs, Menus, MenBtn, Biblioteca, Printfast, UBase, RDprint;

type
  TF_Fornecedores = class(TFBase)
    PanTitulo: TPanel;
    PanEdits: TPanel;
    PanGrid: TPanel;
    DBGrid1: TDBGrid;
    PanProcura: TPanel;
    BitBtn11: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    MenuButton1: TMenuButton;
    Label16: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    EditProcura: TEdit;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    Vdeo1: TMenuItem;
    Impressora2: TMenuItem;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    MaskEdit5: TMaskEdit;
    MaskEdit6: TMaskEdit;
    Edit7: TEdit;
    RDprint: TRDprint;
    procedure auditoria;
    procedure aguarde;
    procedure pronto;
    procedure pinta;
    procedure procura;
    procedure Visualiza;
    procedure Insere;
    procedure Altera;
    procedure Consulta;
    procedure QueryToEdits;
    procedure Limpa;
    procedure Grava;
    procedure impforn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cancelar(Sender: TObject);
    procedure incluir(Sender: TObject);
    procedure Confirma(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure Consultar(Sender: TObject);
    procedure alterar(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Retorna(Sender: TObject);
    procedure MaskEdit5Exit(Sender: TObject);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Vdeo1Click(Sender: TObject);
    procedure Impressora2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  F_Fornecedores: TF_Fornecedores;
  idCol, conf, confere: Integer;
  nCol: string;
  Linha: Integer;

implementation

uses U_Dados, UMenu;
{$R *.DFM}

procedure TF_Fornecedores.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Width := BitBtn10.Left + BitBtn10.Width - Panel3.Left;
  Panel3.Repaint;
end;

procedure TF_Fornecedores.pronto;
begin
  Panel3.Visible := False;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

procedure TF_Fornecedores.impforn;
begin
  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Relação dos Fornecedores';
  RDprint.TamanhoQteColunas := 146;
  RDprint.TamanhoQteLinhas := 66;

  RDprint.abrir; // Inicia a montagem do relatório...
  Linha := 9;

  aguarde;
  F_Dados.Q_Fornecedor.First;
  while not F_Dados.Q_Fornecedor.eof do begin
    if Linha > 63 then // Salto de Pagina chama automaticamente cabecalho/rodape
      RDprint.novapagina;

    RDprint.Imp(Linha, 01, StringOfChar('0', 3 - Length(F_Dados.Q_Fornecedor.FieldByName('id').AsString)) + F_Dados.Q_Fornecedor.FieldByName('id').AsString);
    RDprint.Imp(Linha, 06, Copy(F_Dados.Q_FornecedorRazao.AsString, 1, 40));
    RDprint.Imp(Linha, 48, F_Dados.Q_FornecedorEndereco.AsString);
    RDprint.Imp(Linha, 89, F_Dados.Q_FornecedorFone.AsString);
    RDprint.Imp(Linha, 106, F_Dados.Q_FornecedorContato.AsString);
    RDprint.Imp(Linha, 128, F_Dados.Q_Fornecedorcnpj.AsString);
    F_Dados.Q_Fornecedor.next;
    inc(Linha);
  end;
  RDprint.Fechar;
  pronto;
end;

procedure TF_Fornecedores.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  RDprint.Imp(02, 01, StringOfChar('=', 146));
  RDprint.impf(03, 01, 'Relação dos Fornecedores', [expandido, NEGRITO]);
  RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
  RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
  RDprint.Imp(06, 01, StringOfChar('=', 146));

  RDprint.Imp(07, 01, 'COD.');
  RDprint.Imp(07, 06, 'NOME DO FORNECEDOR');
  RDprint.Imp(07, 48, 'ENDEREÇO');
  RDprint.Imp(07, 89, 'FONE');
  RDprint.Imp(07, 106, 'CONTATO');
  RDprint.Imp(07, 128, 'CNPJ');

  RDprint.Imp(08, 01, StringOfChar('-', 146));
  Linha := 9;
end;

procedure TF_Fornecedores.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  RDprint.Imp(64, 01, StringOfChar('=', 146));
  RDprint.Imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
  RDprint.impd(65, 146, 'Impresso em ' + DateTimeToStr(Now), [italico]);
end;

procedure TF_Fornecedores.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

procedure TF_Fornecedores.Visualiza;
begin
  PanEdits.Visible := False;
  PanGrid.Visible := True;
  PanTitulo.Caption := 'Cadastro dos Fornecedores - Visualizando...';
end;

procedure TF_Fornecedores.Insere;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Fornecedores - Inserindo...';
  Edit1.SetFocus;
end;

procedure TF_Fornecedores.Altera;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Fornecedores - Alterando...';
  Edit1.SetFocus;
end;

procedure TF_Fornecedores.Consulta;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Fornecedores - Consultando...';
  BitBtn4.SetFocus;
end;

procedure TF_Fornecedores.QueryToEdits;
begin
  Edit1.Text := F_Dados.CDS_Fornecedor.FieldByName('Razao').AsString;
  Edit2.Text := F_Dados.CDS_Fornecedor.FieldByName('Fantasia').AsString;
  Edit3.Text := F_Dados.CDS_Fornecedor.FieldByName('Endereco').AsString;
  Edit4.Text := F_Dados.CDS_Fornecedor.FieldByName('Bairro').AsString;
  Edit5.Text := F_Dados.CDS_Fornecedor.FieldByName('Cidade').AsString;
  Edit6.Text := F_Dados.CDS_Fornecedor.FieldByName('Estado').AsString;
  Edit7.Text := F_Dados.CDS_Fornecedor.FieldByName('Contato').AsString;
  MaskEdit1.Text := F_Dados.CDS_Fornecedor.FieldByName('Cep').AsString;
  MaskEdit2.Text := F_Dados.CDS_Fornecedor.FieldByName('Fone').AsString;
  MaskEdit3.Text := F_Dados.CDS_Fornecedor.FieldByName('Fax').AsString;
  MaskEdit4.Text := F_Dados.CDS_Fornecedor.FieldByName('Celular').AsString;
  MaskEdit5.Text := F_Dados.CDS_Fornecedor.FieldByName('cnpj').AsString;
  MaskEdit6.Text := F_Dados.CDS_Fornecedor.FieldByName('inscricao_estadual').AsString;
end;

procedure TF_Fornecedores.Grava;
begin
  auditoria;
  F_Dados.CDS_Fornecedor.FieldByName('Razao').AsString := Edit1.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Fantasia').AsString := Edit2.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Endereco').AsString := Edit3.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Bairro').AsString := Edit4.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Cidade').AsString := Edit5.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Estado').AsString := Edit6.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Contato').AsString := Edit7.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Cep').AsString := MaskEdit1.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Fone').AsString := MaskEdit2.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Fax').AsString := MaskEdit3.Text;
  F_Dados.CDS_Fornecedor.FieldByName('Celular').AsString := MaskEdit4.Text;
  F_Dados.CDS_Fornecedor.FieldByName('cnpj').AsString := MaskEdit5.Text;
  F_Dados.CDS_Fornecedor.FieldByName('inscricao_estadual').AsString := MaskEdit6.Text;
  //
  F_Dados.CDS_Fornecedor.Post;
  F_Dados.CDS_Fornecedor.ApplyUpdates(0);
end;

procedure TF_Fornecedores.Limpa;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  Edit7.Clear;
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  MaskEdit3.Clear;
  MaskEdit4.Clear;
  MaskEdit5.Clear;
  MaskEdit6.Clear;
end;

procedure TF_Fornecedores.incluir(Sender: TObject);
begin
  conf := 1;
  Insere;
end;

procedure TF_Fornecedores.alterar(Sender: TObject);
begin
  If F_Dados.CDS_Fornecedor.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Alterado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 2;
    Altera;
    QueryToEdits;
  end;
end;

procedure TF_Fornecedores.Excluir(Sender: TObject);
var
  opc: Integer;
begin
  opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then begin
    If F_Dados.CDS_Fornecedor.FieldByName('id').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído', 'Sistema de Segurança', mb_Ok + mb_IconError)
    else
    begin
      F_Dados.CDS_Fornecedor.Delete;
      F_Dados.CDS_Fornecedor.ApplyUpdates(0);
    end;
  end;
end;

procedure TF_Fornecedores.Consultar(Sender: TObject);
begin
  If F_Dados.CDS_Fornecedor.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Consultado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 3;
    Consulta;
    QueryToEdits;
  end;
end;

procedure TF_Fornecedores.Retorna(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TF_Fornecedores.Confirma(Sender: TObject);
begin
  F_Dados.CDS_Fornecedor.Open;
  if conf = 1 then begin
    if Edit1.Text = '' then begin
      Application.MessageBox('O nome do fornecedor não pode ficar em branco', 'Informação do Sistema', mb_Ok + mb_IconError);
      Edit1.SetFocus;
    end
    else begin
      F_Dados.CDS_Fornecedor.Append;
      Grava;
      idCol := 1;
      nCol := 'razao';
      pinta;
      Visualiza;
      EditProcura.Text := Edit1.Text;
      procura;
    end;
  end
  else if conf = 2 then begin
    F_Dados.CDS_Fornecedor.Edit;
    Grava;
    Visualiza;
  end
  else if conf = 3 then
    Visualiza;
  Limpa;
  conf := 0;
end;

procedure TF_Fornecedores.Cancelar(Sender: TObject);
begin
  Limpa;
  Visualiza;
  conf := 0;
end;

procedure TF_Fornecedores.pinta;
var
  i: Integer;
begin
  For i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns.Items[i].Color := ClWindow;
  DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_Fornecedores.procura;
begin
  if EditProcura.Text <> '' then begin
    If nCol = '' then
      Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta', 'Informação do Sistema', mb_Ok + mb_IconError)
    else begin
      F_Dados.Q_Fornecedor.Active := False;
      F_Dados.Q_Fornecedor.Sql.Clear;
      if nCol = 'id' then
        F_Dados.Q_Fornecedor.Sql.add('select * from fornecedor where ' + nCol + ' like ' + chr(39) + EditProcura.Text + chr(39))
      else
        F_Dados.Q_Fornecedor.Sql.add('select * from fornecedor where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
      F_Dados.Q_Fornecedor.Sql.add('order by ' + nCol + ',razao');
      F_Dados.Q_Fornecedor.Active := True;
      F_Dados.CDS_Fornecedor.Close;
      F_Dados.CDS_Fornecedor.Open;
    end;
  end
  else
    F_Dados.CDS_Fornecedor.Close;
end;

procedure TF_Fornecedores.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If conf <> 0 then begin
    Application.MessageBox('Antes de Sair Clique em Confirmar ou Cancelar', 'Aviso do Sistema', Mb_IconInformation);
    Action := caNone;
  end
  else begin
    F_Dados.Q_Fornecedor.Active := False;
    Release;
  end;
end;

procedure TF_Fornecedores.DBGrid1TitleClick(Column: TColumn);
begin
  aguarde;
  idCol := Column.ID;
  nCol := Column.FieldName;
  pinta;
  procura;
  pronto;
  EditProcura.SetFocus;
end;

procedure TF_Fornecedores.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton2Click(Sender);
  if (Key = 9) or (Key = 13) then
    DBGrid1.SetFocus;
end;

procedure TF_Fornecedores.SpeedButton2Click(Sender: TObject);
begin
  aguarde;
  procura;
  pronto;
end;

procedure TF_Fornecedores.Vdeo1Click(Sender: TObject);
begin
  If F_Dados.CDS_Fornecedor.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + Mb_IconInformation)
  else
  begin
    if Application.MessageBox('Deseja imprimir os dados em tela?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      RDprint.OpcoesPreview.Preview := True;
      impforn;
    end;
  end;
end;

procedure TF_Fornecedores.Impressora2Click(Sender: TObject);
begin
  If F_Dados.CDS_Fornecedor.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + Mb_IconInformation)
  else
  begin
    if Application.MessageBox('Deseja imprimir os dados na impressora?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      RDprint.OpcoesPreview.Preview := False;
      impforn;
    end;
  end;
end;

procedure TF_Fornecedores.FormCreate(Sender: TObject);
begin
  F_Dados.Q_Fornecedor.Active := False;
  F_Dados.CDS_Fornecedor.Close;
  F_Dados.CDS_Fornecedor.Open;
  Visualiza;
end;

procedure TF_Fornecedores.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    EditProcura.SetFocus;
  if Key = 13 then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Fornecedores.auditoria;
begin
  if conf = 1 then
    F_Dados.CDS_Fornecedor.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - INCLUSAO'
  else if conf = 2 then
    F_Dados.CDS_Fornecedor.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - ALTERACAO';
end;

procedure TF_Fornecedores.FormShow(Sender: TObject);
begin
  DBGrid1TitleClick(DBGrid1.Columns.Items[0]);
  EditProcura.SetFocus;
end;

procedure TF_Fornecedores.MaskEdit5Exit(Sender: TObject);
var
  VCCG: String;
begin
  Try
    VCCG := Copy(MaskEdit5.Text, 1, 1);
    If (VCCG = '0') or (VCCG = '1') or (VCCG = '2') or (VCCG = '3') or (VCCG = '4') or (VCCG = '5') or (VCCG = '6') or (VCCG = '7') or (VCCG = '8') or (VCCG = '9') then begin
      If ValidaCNPJ(MaskEdit5.Text) = False then begin
        Showmessage('CNPJ Inválido - Tente Novamente');
        MaskEdit5.SetFocus;
      End;
    end
    except
      on exception do begin
        Application.MessageBox('Existe um Erro na Digitação do CNPJ', 'Informação do Sistema', mb_IconError);
        MaskEdit5.SetFocus;
      end;
    end;
  end;

end.
