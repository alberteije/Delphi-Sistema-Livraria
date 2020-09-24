unit U_Funcionarios;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, Db, Grids, DBGrids, DBTables,
  DBIProcs, Menus, MenBtn, EditNum, UBase, RDprint, Biblioteca;

type
  TF_Funcionarios = class(TFBase)
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
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    MenuButton1: TMenuButton;
    EditNum1: TEditNum;
    Label12: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    EditProcura: TEdit;
    Panel3: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    RadioGroup1: TRadioGroup;
    PopupMenu1: TPopupMenu;
    Vdeo1: TMenuItem;
    Impressora2: TMenuItem;
    Label1: TLabel;
    Edit6: TEdit;
    CheckBox1: TCheckBox;
    Label8: TLabel;
    Label14: TLabel;
    Edit7: TEdit;
    Edit22: TEdit;
    RDprint: TRDprint;
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
    procedure Grava;
    procedure impfunc;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cancelar(Sender: TObject);
    procedure incluir(Sender: TObject);
    procedure Confirma(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure Consultar(Sender: TObject);
    procedure alterar(Sender: TObject);
    procedure Retorna(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Vdeo1Click(Sender: TObject);
    procedure Impressora2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit22Exit(Sender: TObject);
    procedure Edit6Exit(Sender: TObject);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  F_Funcionarios: TF_Funcionarios;
  idCol, conf, confere: Integer;
  nCol: string;
  Linha: Integer;

implementation

uses U_Dados, UMenu;
{$R *.DFM}

procedure TF_Funcionarios.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Width := BitBtn10.Left + BitBtn10.Width - Panel3.Left;
  Panel3.Repaint;
end;

procedure TF_Funcionarios.pronto;
begin
  Panel3.Visible := False;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

procedure TF_Funcionarios.impfunc;
begin
  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Relação dos Funcionários';
  RDprint.TamanhoQteColunas := 124;
  RDprint.TamanhoQteLinhas := 66;

  RDprint.abrir; // Inicia a montagem do relatório...
  Linha := 9;

  aguarde;
  F_Dados.CDS_Funcionarios.DisableControls;
  F_Dados.CDS_Funcionarios.First;
  while not F_Dados.CDS_Funcionarios.eof do begin
    if Linha > 63 then // Salto de Pagina chama automaticamente cabecalho/rodape
      RDprint.novapagina;

    RDprint.Imp(Linha, 01, StringOfChar('0', 3 - Length(F_Dados.CDS_Funcionarios.FieldByName('id').AsString)) + F_Dados.CDS_Funcionarios.FieldByName('id').AsString);
    RDprint.Imp(Linha, 06, F_Dados.CDS_FuncionariosNome.AsString);
    RDprint.Imp(Linha, 38, F_Dados.CDS_FuncionariosEndereco.AsString);
    RDprint.Imp(Linha, 80, F_Dados.CDS_FuncionariosFone.AsString);
    RDprint.Imp(Linha, 95, F_Dados.CDS_FuncionariosCelular.AsString);
    If F_Dados.CDS_FuncionariosTipo.AsString = 'E' then
      RDprint.Imp(Linha, 112, 'V. EXTERNO')
    Else If F_Dados.CDS_FuncionariosTipo.AsString = 'B' then
      RDprint.Imp(Linha, 112, 'V. BALCAO')
    Else If F_Dados.CDS_FuncionariosTipo.AsString = 'S' then
      RDprint.Imp(Linha, 112, 'SOMADOR')
    Else If F_Dados.CDS_FuncionariosTipo.AsString = 'G' then
      RDprint.Imp(Linha, 112, 'GERENTE');

    F_Dados.CDS_Funcionarios.next;
    inc(Linha);
  end;
  F_Dados.CDS_Funcionarios.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_Funcionarios.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  RDprint.Imp(02, 01, StringOfChar('=', 124));
  RDprint.impf(03, 01, 'Relação dos Funcionários', [expandido, NEGRITO]);
  RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
  RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
  RDprint.Imp(06, 01, StringOfChar('=', 124));

  RDprint.Imp(07, 01, 'COD.');
  RDprint.Imp(07, 06, 'NOME DO FUNCIONARIO');
  RDprint.Imp(07, 38, 'ENDEREÇO');
  RDprint.Imp(07, 80, 'FONE');
  RDprint.Imp(07, 95, 'CELULAR');
  RDprint.Imp(07, 112, 'CARGO');

  RDprint.Imp(08, 01, StringOfChar('-', 124));
  Linha := 9;
end;

procedure TF_Funcionarios.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  RDprint.Imp(64, 01, StringOfChar('=', 124));
  RDprint.Imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
  RDprint.impd(65, 124, 'Impresso em ' + DateTimeToStr(Now), [italico]);
end;

procedure TF_Funcionarios.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

procedure TF_Funcionarios.Visualiza;
begin
  PanEdits.Visible := False;
  PanGrid.Visible := True;
  PanTitulo.Caption := 'Cadastro dos Funcionários - Visualizando...';
end;

procedure TF_Funcionarios.Insere;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Funcionários - Inserindo...';
  Edit1.SetFocus;
end;

procedure TF_Funcionarios.Altera;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Funcionários - Alterando...';
  Edit1.SetFocus;
end;

procedure TF_Funcionarios.Consulta;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Funcionários - Consultando...';
  BitBtn4.SetFocus;
end;

procedure TF_Funcionarios.QueryToEdits;
begin
  Edit1.Text := F_Dados.CDS_FuncionariosNome.AsString;
  Edit2.Text := F_Dados.CDS_FuncionariosEndereco.AsString;
  Edit3.Text := F_Dados.CDS_FuncionariosBairro.AsString;
  Edit4.Text := F_Dados.CDS_FuncionariosCidade.AsString;
  Edit5.Text := F_Dados.CDS_FuncionariosEstado.AsString;
  Edit6.Text := F_Dados.CDS_FuncionariosNick.AsString;
  Edit7.Text := F_Dados.CDS_FuncionariosSenha.AsString;
  Edit22.Text := F_Dados.CDS_FuncionariosSenha.AsString;
  MaskEdit1.Text := F_Dados.CDS_FuncionariosCep.AsString;
  MaskEdit2.Text := F_Dados.CDS_FuncionariosFone.AsString;
  MaskEdit3.Text := F_Dados.CDS_FuncionariosCelular.AsString;
  EditNum1.Text := F_Dados.CDS_FuncionariosComissao.AsString;
  if F_Dados.CDS_FuncionariosTipo.AsString = 'E' then
    RadioGroup1.ItemIndex := 0
  else if F_Dados.CDS_FuncionariosTipo.AsString = 'B' then
    RadioGroup1.ItemIndex := 1
  else if F_Dados.CDS_FuncionariosTipo.AsString = 'S' then
    RadioGroup1.ItemIndex := 2
  else if F_Dados.CDS_FuncionariosTipo.AsString = 'G' then
    RadioGroup1.ItemIndex := 3
  else if F_Dados.CDS_FuncionariosTipo.AsString = 'O' then // Operador de caixa
    RadioGroup1.ItemIndex := 4;
  if F_Dados.CDS_FuncionariosAcesso.AsString = 'S' then
    CheckBox1.Checked := True;
end;

procedure TF_Funcionarios.Grava;
begin
  auditoria;

  // Exercício: Inclua o departamento na janela para o usuário pesquisar e selecionar
  F_Dados.CDS_Funcionariosid_departamento.AsInteger := 1;

  // Exercício: Inclua o CPF na janela para o usuário pesquisar e selecionar
  F_Dados.CDS_Funcionarioscpf.AsString := '11111111111';

  F_Dados.CDS_FuncionariosNome.AsString := Edit1.Text;
  F_Dados.CDS_FuncionariosEndereco.AsString := Edit2.Text;
  F_Dados.CDS_FuncionariosBairro.AsString := Edit3.Text;
  F_Dados.CDS_FuncionariosCidade.AsString := Edit4.Text;
  F_Dados.CDS_FuncionariosEstado.AsString := Edit5.Text;
  F_Dados.CDS_FuncionariosNick.AsString := Edit6.Text;
  F_Dados.CDS_FuncionariosSenha.AsString := Edit7.Text;
  F_Dados.CDS_FuncionariosSenha.AsString := Edit22.Text;
  F_Dados.CDS_FuncionariosCep.AsString := MaskEdit1.Text;
  F_Dados.CDS_FuncionariosFone.AsString := MaskEdit2.Text;
  F_Dados.CDS_FuncionariosCelular.AsString := MaskEdit3.Text;
  F_Dados.CDS_FuncionariosComissao.AsString := EditNum1.Text;
  if RadioGroup1.ItemIndex = 0 then
    F_Dados.CDS_FuncionariosTipo.AsString := 'E'
  else if RadioGroup1.ItemIndex = 1 then
    F_Dados.CDS_FuncionariosTipo.AsString := 'B'
  else if RadioGroup1.ItemIndex = 2 then
    F_Dados.CDS_FuncionariosTipo.AsString := 'S'
  else if RadioGroup1.ItemIndex = 3 then
    F_Dados.CDS_FuncionariosTipo.AsString := 'G'
  else if RadioGroup1.ItemIndex = 4 then
    F_Dados.CDS_FuncionariosTipo.AsString := 'O'; // Operador de caixa
  if CheckBox1.Checked = True then
    F_Dados.CDS_FuncionariosAcesso.AsString := 'S';
  //
  F_Dados.CDS_Funcionarios.Post;
  F_Dados.CDS_Funcionarios.ApplyUpdates(0);
end;

procedure TF_Funcionarios.Limpa;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  Edit7.Clear;
  Edit22.Clear;
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  MaskEdit3.Clear;
  EditNum1.Text := '0.00';
end;

procedure TF_Funcionarios.incluir(Sender: TObject);
begin
  conf := 1;
  Insere;
end;

procedure TF_Funcionarios.alterar(Sender: TObject);
begin
  If F_Dados.CDS_Funcionarios.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Alterado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 2;
    Altera;
    QueryToEdits;
  end;
end;

procedure TF_Funcionarios.Excluir(Sender: TObject);
var
  opc: Integer;
begin
  opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then
  begin
    If F_Dados.CDS_Funcionarios.FieldByName('id').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído', 'Sistema de Segurança', mb_Ok + mb_IconError)
    else
    begin
      F_Dados.CDS_Funcionarios.Delete;
      F_Dados.CDS_Funcionarios.ApplyUpdates(0);
    end;
  end;
end;

procedure TF_Funcionarios.Consultar(Sender: TObject);
begin
  If F_Dados.CDS_Funcionarios.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Consultado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 3;
    Consulta;
    QueryToEdits;
  end;
end;

procedure TF_Funcionarios.Retorna(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TF_Funcionarios.Confirma(Sender: TObject);
begin
  F_Dados.CDS_Funcionarios.Open;
  if conf = 1 then begin
    if Edit1.Text = '' then begin
      Application.MessageBox('O nome do funcionario não pode ficar em branco', 'Informação do Sistema', mb_Ok + mb_IconError);
      Edit1.SetFocus;
    end
    else begin
      F_Dados.CDS_Funcionarios.Append;
      Grava;
      idCol := 1;
      nCol := 'nome';
      pinta;
      Visualiza;
      EditProcura.Text := Edit1.Text;
      procura;
    end;
  end
  else if conf = 2 then begin
    F_Dados.CDS_Funcionarios.Edit;
    Grava;
    Visualiza;
  end
  else if conf = 3 then
    Visualiza;
  Limpa;
  conf := 0;
end;

procedure TF_Funcionarios.Cancelar(Sender: TObject);
begin
  Limpa;
  Visualiza;
  conf := 0;
end;

procedure TF_Funcionarios.pinta;
var
  i: Integer;
begin
  For i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns.Items[i].Color := ClWindow;
  DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_Funcionarios.procura;
begin
  if EditProcura.Text <> '' then begin
    If nCol = '' then
      Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta', 'Informação do Sistema', mb_Ok + mb_IconError)
    else begin
      F_Dados.Q_Funcionarios.Active := False;
      F_Dados.Q_Funcionarios.Sql.Clear;
      if nCol = 'id' then
        F_Dados.Q_Funcionarios.Sql.add('select * from funcionario where ' + nCol + ' like ' + chr(39) + EditProcura.Text + chr(39))
      else
        F_Dados.Q_Funcionarios.Sql.add('select * from funcionario where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
      F_Dados.Q_Funcionarios.Sql.add('order by ' + nCol + ',nome');
      F_Dados.Q_Funcionarios.Active := True;
      F_Dados.CDS_Funcionarios.Close;
      F_Dados.CDS_Funcionarios.Open;
    end;
  end
  else
    F_Dados.CDS_Funcionarios.Close;
end;

procedure TF_Funcionarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If conf <> 0 then begin
    Application.MessageBox('Antes de Sair Clique em Confirmar ou Cancelar', 'Aviso do Sistema', Mb_IconInformation);
    Action := caNone;
  end
  else begin
    F_Dados.CDS_Funcionarios.Active := False;
    Release;
  end;
end;

procedure TF_Funcionarios.DBGrid1TitleClick(Column: TColumn);
begin
  aguarde;
  idCol := Column.ID;
  nCol := Column.FieldName;
  pinta;
  procura;
  pronto;
  EditProcura.SetFocus;
end;

procedure TF_Funcionarios.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then
    SpeedButton2Click(Sender);
  if (Key = 9) or (Key = 13) then
    DBGrid1.SetFocus;
end;

procedure TF_Funcionarios.SpeedButton2Click(Sender: TObject);
begin
  aguarde;
  procura;
  pronto;
end;

procedure TF_Funcionarios.Vdeo1Click(Sender: TObject);
begin
  If F_Dados.CDS_Funcionarios.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + Mb_IconInformation)
  else
  begin
    if Application.MessageBox('Deseja imprimir os dados em tela?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      RDprint.OpcoesPreview.Preview := True;
      impfunc;
    end;
  end;
end;

procedure TF_Funcionarios.Impressora2Click(Sender: TObject);
begin
  If F_Dados.CDS_Funcionarios.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + Mb_IconInformation)
  else begin
    if Application.MessageBox('Deseja imprimir os dados na impressora?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      RDprint.OpcoesPreview.Preview := False;
      impfunc;
    end;
  end;
end;

procedure TF_Funcionarios.FormCreate(Sender: TObject);
begin
  F_Dados.Q_Funcionarios.Active := False;
  F_Dados.CDS_Funcionarios.Close;
  F_Dados.CDS_Funcionarios.Open;
  Visualiza;
end;

procedure TF_Funcionarios.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    EditProcura.SetFocus;
  if Key = 13 then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Funcionarios.auditoria;
begin
  if conf = 1 then
    F_Dados.CDS_Funcionarios.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - INCLUSAO'
  else if conf = 2 then
    F_Dados.CDS_Funcionarios.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - ALTERACAO';
end;

procedure TF_Funcionarios.FormShow(Sender: TObject);
begin
  DBGrid1TitleClick(DBGrid1.Columns.Items[0]);
  EditProcura.SetFocus;
end;

procedure TF_Funcionarios.Edit22Exit(Sender: TObject);
begin
  If Edit7.Text <> Edit22.Text then begin
    Application.MessageBox('Senhas Não Coincidem - Digite Novamente', 'Aviso do Sistema', Mb_IconInformation);
    Edit7.Clear;
    Edit22.Clear;
    Edit7.SetFocus;
  end;
end;

procedure TF_Funcionarios.Edit6Exit(Sender: TObject);
begin
  If conf = 1 then begin
    MyConsulta(F_Dados.Q_Rap, 'select * from funcionario where nick=' + chr(39) + Edit6.Text + chr(39));
    If F_Dados.Q_Rap.FieldByName('nick').AsString <> '' then begin
      ShowMessage('Esse Nick Já Existe - Escolha Outro');
      Edit6.Clear;
      Edit6.SetFocus;
    end;
  end;
end;

end.
