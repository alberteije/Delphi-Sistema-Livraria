unit U_Livros;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DBCtrls, StdCtrls, DB, DBTables, Mask, ExtCtrls,
  Printers, abarra, Buttons, MenBtn, Grids, DBGrids, EditNum, Menus, RDprint,
  AlignEdit, UBase, Biblioteca, ComCtrls, LabeledCtrls, StrUtils;

type
  TF_Livros = class(TFBase)
    ABarraPrinter1: TABarraPrinter;
    PanTitulo: TPanel;
    PanGrid: TPanel;
    DBGrid1: TDBGrid;
    PanProcura: TPanel;
    MenuButton1: TMenuButton;
    BitBtn11: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    PanEdits: TPanel;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    EditProcura: TEdit;
    PopupMenu1: TPopupMenu;
    Vdeo1: TMenuItem;
    Impressora2: TMenuItem;
    Panel3: TPanel;
    SpeedButton3: TSpeedButton;
    RDprint: TRDprint;
    PageControl1: TPageControl;
    TabSheetPrincipal: TTabSheet;
    PanelDadosPrincipais: TPanel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label10: TLabel;
    SpeedButton2: TSpeedButton;
    Label12: TLabel;
    Edit6: TEdit;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit3: TEdit;
    EditNum1: TEditNum;
    edit11: TAlignEdit;
    Panel1: TPanel;
    ABarra1: TABarra;
    Label8: TLabel;
    Edit2: TEdit;
    Edit8: TEdit;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBoxTipoItemSped: TLabeledComboBox;
    procedure auditoria;
    procedure procura;
    procedure pinta;
    procedure aguarde;
    procedure pronto;
    procedure Visualiza;
    procedure Insere;
    procedure Altera;
    procedure Consulta;
    procedure QueryToEdits;
    procedure Limpa;
    procedure Cancelar(Sender: TObject);
    procedure incluir(Sender: TObject);
    procedure Confirma(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure alterar(Sender: TObject);
    procedure Retorna(Sender: TObject);
    procedure Consultar(Sender: TObject);
    procedure Grava;
    procedure impmat;
    procedure FormCreate(Sender: TObject);
    procedure Vdeo1Click(Sender: TObject);
    procedure Impressora2Click(Sender: TObject);
    procedure edit11Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton2Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    barra: Integer;
  end;

var
  F_Livros: TF_Livros;
  idCol, conf, confere: Integer;
  nCol, anterior: string;
  Linha: Integer;

implementation

uses U_Dados, UMenu, U_PegaUnd2;
{$R *.DFM}

procedure TF_Livros.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Width := BitBtn10.Left + BitBtn10.Width - Panel3.Left;
  Panel3.Repaint;
end;

procedure TF_Livros.pronto;
begin
  Panel3.Visible := False;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

procedure TF_Livros.impmat;
begin
  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Relação dos Livros';
  RDprint.TamanhoQteColunas := 124;
  RDprint.TamanhoQteLinhas := 66;

  RDprint.abrir; // Inicia a montagem do relatório...
  Linha := 9;

  aguarde;
  F_Dados.CDS_Livros.DisableControls;
  F_Dados.CDS_Livros.First;
  while not F_Dados.CDS_Livros.eof do begin
    if Linha > 63 then // Salto de Pagina chama automaticamente cabecalho/rodape
      RDprint.novapagina;

    RDprint.Imp(Linha, 01, F_Dados.CDS_LivrosCodigo.AsString);
    RDprint.Imp(Linha, 16, F_Dados.CDS_LivrosDescricao.AsString);
    RDprint.Imp(Linha, 64, F_Dados.CDS_Livrosisbn.AsString);
    RDprint.Imp(Linha, 74, F_Dados.CDS_LivrosAutor_Marca.AsString);
    RDprint.Imp(Linha, 91, F_Dados.CDS_LivrosReferencia.AsString);
    RDprint.ImpVal(Linha, 111, '#,###,##0.00', F_Dados.CDS_LivrosPreco.AsFloat, []);
    F_Dados.CDS_Livros.next;
    inc(Linha);
  end;
  F_Dados.CDS_Livros.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_Livros.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  RDprint.Imp(02, 01, StringOfChar('=', 124));
  RDprint.impf(03, 01, 'Relação dos Livros', [expandido, NEGRITO]);
  RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
  RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
  RDprint.Imp(06, 01, StringOfChar('=', 124));

  RDprint.Imp(07, 01, 'CODIGO');
  RDprint.Imp(07, 16, 'DESCRICAO');
  RDprint.Imp(07, 64, 'ISBN');
  RDprint.Imp(07, 74, 'AUTOR');
  RDprint.Imp(07, 91, 'REF.');
  RDprint.Imp(07, 111, 'PREÇO');

  RDprint.Imp(08, 01, StringOfChar('-', 124));
  Linha := 9;
end;

procedure TF_Livros.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  RDprint.Imp(64, 01, StringOfChar('=', 124));
  RDprint.Imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
  RDprint.impd(65, 124, 'Impresso em ' + DateTimeToStr(Now), [italico]);
end;

procedure TF_Livros.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

procedure TF_Livros.Visualiza;
begin
  PanEdits.Visible := False;
  PanGrid.Visible := True;
  PanTitulo.Caption := 'Cadastro dos Livros - Visualizando...';
  if conf = 1 then begin
    pinta;
    procura;
  end;
end;

procedure TF_Livros.Insere;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Livros - Inserindo...';
  edit11.SetFocus;
end;

procedure TF_Livros.Altera;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Livros - Alterando...';
  edit11.SetFocus;
end;

procedure TF_Livros.Consulta;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Livros - Consultando...';
  BitBtn4.SetFocus;
end;

procedure TF_Livros.QueryToEdits;
var
  barra, digito: string;
begin
  Edit8.Text := F_Dados.CDS_Livrosisbn.Value;
  edit11.Text := F_Dados.CDS_LivrosCodigo.Value;
  Edit3.Text := F_Dados.CDS_LivrosDescricao.Value;
  Edit4.Text := F_Dados.CDS_Livrosid_unidade.AsString;
  Edit5.Text := F_Dados.CDS_LivrosReferencia.Value;
  Edit6.Text := F_Dados.CDS_LivrosAutor_Marca.Value;
  EditNum1.Text := FloatToStr(F_Dados.CDS_LivrosPreco.Value);
  //
  barra := Copy(F_Dados.CDS_LivrosCodigo.AsString, 1, 12);
  digito := Copy(F_Dados.CDS_LivrosCodigo.AsString, 13, 1);
  ABarra1.Codigo := barra;
  ABarra1.digito := digito;
  Label8.Caption := ABarra1.Codigo + '-' + ABarra1.digito;
  //
  ComboBoxTipoItemSped.ItemIndex := AnsiIndexStr(F_Dados.CDS_Livrostipo_item_sped.AsString, ['00', '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '99']);
end;

procedure TF_Livros.Grava;
begin
  auditoria;
  F_Dados.CDS_Livrosisbn.Value := Edit8.Text;
  F_Dados.CDS_LivrosCodigo.Value := edit11.Text;
  F_Dados.CDS_LivrosDescricao.Value := Edit3.Text;
  F_Dados.CDS_Livrosid_unidade.AsString := Edit4.Text;
  F_Dados.CDS_LivrosReferencia.Value := Edit5.Text;
  F_Dados.CDS_LivrosAutor_Marca.Value := Edit6.Text;
  F_Dados.CDS_LivrosPreco.AsString := EditNum1.Text;
  F_Dados.CDS_LivrosLivro_Material.AsString := 'L';
  if conf = 2 then
    F_Dados.CDS_LivrosCodigo_Anterior.AsString := anterior;
  //
  // Dados Adicionais
  F_Dados.CDS_Livrostotalizador_parcial.AsString := 'I1';
  F_Dados.CDS_Livrosnome.AsString := Edit3.Text;
  F_Dados.CDS_Livrosdescricao_pdv.AsString := Edit3.Text;
  F_Dados.CDS_Livrosiat.AsString := 'T';
  F_Dados.CDS_Livrosippt.AsString := 'T';
  F_Dados.CDS_Livrosncm.AsString := '49019900';
  F_Dados.CDS_Livrostipo_item_sped.AsString := Copy(ComboBoxTipoItemSped.Text, 1, 2);
  F_Dados.CDS_Livroscst.AsString := '040';
  F_Dados.CDS_Livrosecf_icms_st.AsString := 'II';
  //
  F_Dados.CDS_Livros.Post;
  F_Dados.CDS_Livros.ApplyUpdates(0);
end;

procedure TF_Livros.Limpa;
begin
  ComboBoxTipoItemSped.ItemIndex := 0;
  Edit8.Clear;
  edit11.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  EditNum1.Text := '0.00';
  Label8.Caption := '000000000000-0';
end;

procedure TF_Livros.incluir(Sender: TObject);
begin
  conf := 1;
  Insere;
end;

procedure TF_Livros.alterar(Sender: TObject);
begin
  If F_Dados.CDS_Livros.FieldByName('Codigo').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Alterado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 2;
    Altera;
    QueryToEdits;
    anterior := F_Dados.CDS_LivrosCodigo.AsString;
  end;
end;

procedure TF_Livros.Excluir(Sender: TObject);
var
  opc: Integer;
begin
  Application.MessageBox('Item não pode ser excluído.', 'Aviso do Sistema', mb_Ok + mb_IconInformation)
  { opc:=Application.MessageBox('Confirma Exclusão?','Exclusão de Registros',Mb_YesNo + Mb_IconQuestion);
    If opc=IdYes then
    begin
    If F_Dados.CDS_Livros.FieldByName('Codigo').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído','Sistema de Segurança',mb_Ok+mb_IconError)
    else
    begin
    F_Dados.CDS_Livros.Delete;
    F_Dados.CDS_Livros.ApplyUpdates(0);
    end;
    end; }
end;

procedure TF_Livros.Consultar(Sender: TObject);
begin
  If F_Dados.CDS_Livros.FieldByName('Codigo').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Consultado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 3;
    Consulta;
    QueryToEdits;
  end;
end;

procedure TF_Livros.Retorna(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TF_Livros.Confirma(Sender: TObject);
begin
  if Edit4.Text = '' then
  begin
    Application.MessageBox('É necessário selecionar uma Unidade', 'Informação do Sistema', mb_Ok + mb_IconError);
    Edit4.SetFocus;
  end
  else
  begin
    F_Dados.CDS_Livros.Open;
    if conf = 1 then begin
      if edit11.Text = '' then begin
        Application.MessageBox('O código de barra não pode ficar em branco', 'Informação do Sistema', mb_Ok + mb_IconError);
        edit11.SetFocus;
      end
      else begin
        F_Dados.CDS_Livros.Append;
        EditProcura.Text := Edit3.Text;
        Grava;
      end;
    end
    else if conf = 2 then begin
      F_Dados.CDS_Livros.Edit;
      Grava;
      conf := 1;
    end
    else if conf = 3 then
      Visualiza;
    Limpa;
  end;
end;

procedure TF_Livros.Cancelar(Sender: TObject);
begin
  Limpa;
  conf := 1;
end;

procedure TF_Livros.pinta;
var
  i: Integer;
begin
  For i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns.Items[i].Color := ClWindow;
  DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_Livros.procura;
begin
  if EditProcura.Text <> '' then begin
    If nCol = '' then
      Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta', 'Informação do Sistema', mb_Ok + mb_IconError)
    else begin
      F_Dados.Q_Livros.Active := False;
      F_Dados.Q_Livros.Sql.Clear;
      if nCol = 'codigo' then
        F_Dados.Q_Livros.Sql.add('select * from produto where ' + nCol + ' like ' + chr(39) + EditProcura.Text + chr(39))
      else
        F_Dados.Q_Livros.Sql.add('select * from produto where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
      F_Dados.Q_Livros.Sql.add('and livro_material=' + chr(39) + 'L' + chr(39));
      F_Dados.Q_Livros.Sql.add('order by ' + nCol + ',descricao');
      F_Dados.Q_Livros.Active := True;
      F_Dados.CDS_Livros.Close;
      F_Dados.CDS_Livros.Open;
    end;
  end
  else
    F_Dados.CDS_Livros.Close;
end;

procedure TF_Livros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If conf <> 0 then begin
    Application.MessageBox('Antes de Sair Clique em Confirmar ou Cancelar', 'Aviso do Sistema', mb_IconInformation);
    Action := caNone;
  end
  else begin
    F_Dados.CDS_Livros.Active := False;
    Release;
  end;
end;

procedure TF_Livros.DBGrid1TitleClick(Column: TColumn);
begin
  aguarde;
  idCol := Column.ID;
  nCol := Column.FieldName;
  pinta;
  procura;
  pronto;
  EditProcura.SetFocus;
end;

procedure TF_Livros.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton3Click(Sender);
  if (Key = 9) or (Key = 13) then
    DBGrid1.SetFocus;
end;

procedure TF_Livros.SpeedButton3Click(Sender: TObject);
begin
  aguarde;
  procura;
  pronto;
end;

procedure TF_Livros.Vdeo1Click(Sender: TObject);
begin
  If F_Dados.CDS_Livros.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + mb_IconInformation)
  else
  begin
    if Application.MessageBox('Deseja imprimir os dados em tela?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = idYes then
    begin
      RDprint.OpcoesPreview.Preview := True;
      impmat;
    end;
  end;
end;

procedure TF_Livros.Impressora2Click(Sender: TObject);
begin
  If F_Dados.CDS_Livros.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + mb_IconInformation)
  else begin
    if Application.MessageBox('Deseja imprimir os dados na impressora?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = idYes then
    begin
      RDprint.OpcoesPreview.Preview := False;
      impmat;
    end;
  end;
end;

procedure TF_Livros.FormCreate(Sender: TObject);
begin
  F_Dados.Q_Livros.Active := False;
  F_Dados.CDS_Livros.Close;
  F_Dados.CDS_Livros.Open;
  F_Dados.CDS_Unidade.Close;
  F_Dados.CDS_Unidade.Open;
  Visualiza;
end;

procedure TF_Livros.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    EditProcura.SetFocus;
  if Key = 13 then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Livros.auditoria;
begin
  if conf = 1 then
    F_Dados.CDS_Livros.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - INCLUSAO'
  else if conf = 2 then
    F_Dados.CDS_Livros.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - ALTERACAO';
end;

procedure TF_Livros.FormShow(Sender: TObject);
begin
  DBGrid1TitleClick(DBGrid1.Columns.Items[0]);
  EditProcura.SetFocus;
end;

procedure TF_Livros.edit11Exit(Sender: TObject);
var
  descricao: string;
begin
  If conf = 1 then begin
    MyConsulta(F_Dados.Q_Rap, 'select id,descricao from produto where codigo=' + chr(39) + edit11.Text + chr(39));
    If F_Dados.Q_Rap.FieldByName('id').AsString <> '' then begin
      descricao := F_Dados.Q_Rap.FieldByName('descricao').AsString;
      ShowMessage('Esse Código Já Existe Para o Seguinte Produto:' + #13 + #13 + descricao);
      edit11.SetFocus;
      edit11.SelectAll;
    end
    else begin
      If edit11.Text <> '' then begin
        ABarra1.Codigo := Copy(edit11.Text, 1, 12);
        Label8.Caption := ABarra1.Codigo + '-' + ABarra1.digito;
        if Copy(edit11.Text, 13, 1) <> ABarra1.digito then begin
          Application.MessageBox('O Número Digitado não é Válido' + #13 + 'o Dígito Verificador não Confere', 'Informação do Sistema', mb_IconInformation);
          edit11.SetFocus;
          edit11.SelectAll;
        end
        else begin
          Edit3.SetFocus;
        end;
      end;
    end;
  end;
end;

procedure TF_Livros.BitBtn1Click(Sender: TObject);
begin
  Limpa;
  nCol := 'descricao';
  idCol := 1;
  Visualiza;
  conf := 0;
end;

procedure TF_Livros.BitBtn2Click(Sender: TObject);
var
  dia, mes, ano, hora, minuto, segundo, proc: string;
begin
  dia := Copy(DateToStr(Date), 1, 2);
  mes := Copy(DateToStr(Date), 4, 2);
  ano := Copy(DateToStr(Date), 9, 2);
  //
  hora := Copy(TimeToStr(Time), 1, 2);
  minuto := Copy(TimeToStr(Time), 4, 2);
  segundo := Copy(TimeToStr(Time), 7, 2);
  //
  ABarra1.digito := '';
  ABarra1.Codigo := dia + mes + ano + hora + minuto + segundo;
  Label8.Caption := ABarra1.Codigo + '-' + ABarra1.digito;
  proc := ABarra1.Codigo + ABarra1.digito;
  //
  MyConsulta(F_Dados.Q_Rap, 'select id,descricao from produto where codigo=' + chr(39) + proc + chr(39));
  If F_Dados.Q_Rap.FieldByName('id').AsString = proc then
    Application.MessageBox('Por Favor, Clique no Botão <C. Barra> Novamente', 'Solicitação do Sistema', mb_IconInformation)
  else begin
    edit11.Text := ABarra1.Codigo + ABarra1.digito;
    Label8.Caption := ABarra1.Codigo + '-' + ABarra1.digito;
    Edit3.SetFocus;
  end;
end;

procedure TF_Livros.SpeedButton2Click(Sender: TObject);
begin
  Application.CreateForm(TF_PegaUnd2, F_PegaUnd2);
  F_PegaUnd2.ShowModal;
  // Exercício: Como exibir a descrição da unidade?
  Edit4.Text := F_Dados.CDS_Unidadeid.AsString;
end;

procedure TF_Livros.Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 119 then
  begin
    Application.CreateForm(TF_PegaUnd2, F_PegaUnd2);
    F_PegaUnd2.ShowModal;
    // Exercício: Como exibir a descrição da unidade?
    Edit4.Text := F_Dados.CDS_Unidadeid.AsString;
  end;
  if Key = VK_RETURN then
    Edit5.SetFocus;
end;

End.
