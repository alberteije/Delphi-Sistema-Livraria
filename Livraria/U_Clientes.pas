unit U_Clientes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, Db, Grids, DBGrids, DBTables,
  DBIProcs, Menus, MenBtn, EditNum, RDprint, UBase, Biblioteca;

type
  TF_Clientes = class(TFBase)
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
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EditProcura: TEdit;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    Vdeo1: TMenuItem;
    Impressora2: TMenuItem;
    Edit1: TEdit;
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
    Memo1: TMemo;
    Label1: TLabel;
    MaskEdit7: TMaskEdit;
    MaskEdit8: TMaskEdit;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit2: TEdit;
    Edit8: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    MaskEdit9: TMaskEdit;
    Label20: TLabel;
    Edit9: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Label23: TLabel;
    MaskEdit10: TMaskEdit;
    Label24: TLabel;
    Edit12: TEdit;
    Label25: TLabel;
    MaskEdit11: TMaskEdit;
    Label26: TLabel;
    Edit13: TEdit;
    Label27: TLabel;
    MaskEdit12: TMaskEdit;
    EditNum1: TEditNum;
    Label28: TLabel;
    MaskEdit13: TMaskEdit;
    Label29: TLabel;
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
    procedure impcliente;
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
    procedure Vdeo1Click(Sender: TObject);
    procedure Impressora2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure MaskEdit6Exit(Sender: TObject);
    procedure Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MaskEdit9KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MaskEdit13KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  F_Clientes: TF_Clientes;
  idCol, conf, confere: Integer;
  nCol: string;
  Linha: Integer;

implementation

uses U_Dados, UMenu;
{$R *.DFM}

procedure TF_Clientes.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Width := BitBtn10.Left + BitBtn10.Width - Panel3.Left;
  Panel3.Repaint;
end;

procedure TF_Clientes.pronto;
begin
  Panel3.Visible := False;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

procedure TF_Clientes.impcliente;
begin
  RDprint.MostrarProgresso := True;
  RDprint.TitulodoRelatorio := 'Relação dos Clientes';
  RDprint.TamanhoQteColunas := 148;
  RDprint.TamanhoQteLinhas := 66;

  RDprint.abrir; // Inicia a montagem do relatório...
  Linha := 9;

  aguarde;
  F_Dados.CDS_Clientes.DisableControls;
  F_Dados.CDS_Clientes.First;
  while not F_Dados.CDS_Clientes.eof do begin
    if Linha > 63 then // Salto de Pagina chama automaticamente cabecalho/rodape
      RDprint.novapagina;

    RDprint.Imp(Linha, 01, StringOfChar('0', 3 - Length(F_Dados.CDS_Clientes.FieldByName('id').AsString)) + F_Dados.CDS_Clientes.FieldByName('id').AsString);
    RDprint.Imp(Linha, 06, Copy(F_Dados.CDS_ClientesNome.AsString, 1, 40));
    RDprint.Imp(Linha, 48, Copy(F_Dados.CDS_ClientesEndereco.AsString, 1, 40));
    RDprint.Imp(Linha, 89, F_Dados.CDS_ClientesFone.AsString);
    RDprint.Imp(Linha, 106, F_Dados.CDS_ClientesCelular.AsString);
    RDprint.Imp(Linha, 128, F_Dados.CDS_ClientesCpf.AsString);
    F_Dados.CDS_Clientes.next;
    inc(Linha);
  end;
  F_Dados.CDS_Clientes.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_Clientes.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  RDprint.Imp(02, 01, StringOfChar('=', 148));
  RDprint.impf(03, 01, 'Relação dos Clientes', [expandido, NEGRITO]);
  RDprint.Imp(04, 01, F_Dados.NomeEmpresa);
  RDprint.Imp(05, 01, F_Dados.EnderecoEmpresa);
  RDprint.Imp(06, 01, StringOfChar('=', 148));

  RDprint.Imp(07, 01, 'COD.');
  RDprint.Imp(07, 06, 'NOME DO CLIENTE');
  RDprint.Imp(07, 48, 'ENDEREÇO');
  RDprint.Imp(07, 89, 'FONE');
  RDprint.Imp(07, 106, 'CELULAR');
  RDprint.Imp(07, 128, 'CPF');

  RDprint.Imp(08, 01, StringOfChar('-', 148));
  Linha := 9;
end;

procedure TF_Clientes.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  RDprint.Imp(64, 01, StringOfChar('=', 148));
  RDprint.Imp(65, 01, 'Página: ' + formatfloat('##', Pagina) + ' de &page&');
  RDprint.impd(65, 148, 'Impresso em ' + DateTimeToStr(Now), [italico]);
end;

procedure TF_Clientes.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0); // Pressiona tecla Escape
end;

procedure TF_Clientes.Visualiza;
begin
  PanEdits.Visible := False;
  PanGrid.Visible := True;
  PanTitulo.Caption := 'Cadastro dos Clientes - Visualizando...';
end;

procedure TF_Clientes.Insere;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Clientes - Inserindo...';
  Edit1.SetFocus;
end;

procedure TF_Clientes.Altera;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Clientes - Alterando...';
  Edit1.SetFocus;
end;

procedure TF_Clientes.Consulta;
begin
  PanEdits.Visible := True;
  PanGrid.Visible := False;
  PanTitulo.Caption := 'Cadastro dos Clientes - Consultando...';
  BitBtn4.SetFocus;
end;

procedure TF_Clientes.QueryToEdits;
begin
  Edit1.Text := F_Dados.CDS_ClientesNome.AsString;
  Edit2.Text := F_Dados.CDS_ClientesRG.AsString;
  Edit3.Text := F_Dados.CDS_ClientesEndereco.AsString;
  Edit4.Text := F_Dados.CDS_ClientesBairro.AsString;
  Edit5.Text := F_Dados.CDS_ClientesCidade.AsString;
  Edit6.Text := F_Dados.CDS_ClientesEstado.AsString;
  Edit7.Text := F_Dados.CDS_ClientesMae.AsString;
  Edit8.Text := F_Dados.CDS_ClientesOrgao.AsString;
  Edit9.Text := F_Dados.CDS_ClientesSexo.AsString;
  Edit10.Text := F_Dados.CDS_ClientesEmpresa.AsString;
  Edit11.Text := F_Dados.CDS_ClientesProfissao.AsString;
  Edit12.Text := F_Dados.CDS_ClientesRef1.AsString;
  Edit13.Text := F_Dados.CDS_ClientesRef2.AsString;
  MaskEdit1.Text := F_Dados.CDS_ClientesCep.AsString;
  MaskEdit2.Text := F_Dados.CDS_ClientesFone.AsString;
  MaskEdit3.Text := F_Dados.CDS_ClientesFax.AsString;
  MaskEdit4.Text := F_Dados.CDS_ClientesCelular.AsString;
  MaskEdit5.Text := F_Dados.CDS_ClientesCNPJ.AsString;
  MaskEdit6.Text := F_Dados.CDS_ClientesCpf.AsString;
  MaskEdit7.Text := F_Dados.CDS_ClientesNascimento.AsString;
  MaskEdit8.Text := F_Dados.CDS_ClientesDesde.AsString;
  MaskEdit10.Text := F_Dados.CDS_ClientesFone_empresa.AsString;
  MaskEdit11.Text := F_Dados.CDS_Clientesfone_ref1.AsString;
  MaskEdit12.Text := F_Dados.CDS_Clientesfone_ref2.AsString;
  EditNum1.Text := F_Dados.CDS_ClientesRenda.AsString;
  Memo1.Text := F_Dados.CDS_Clientesobs.AsString;
end;

procedure TF_Clientes.Grava;
begin
  auditoria;
  F_Dados.CDS_ClientesNome.AsString := Edit1.Text;
  F_Dados.CDS_ClientesRG.AsString := Edit2.Text;
  F_Dados.CDS_ClientesEndereco.AsString := Edit3.Text;
  F_Dados.CDS_ClientesBairro.AsString := Edit4.Text;
  F_Dados.CDS_ClientesCidade.AsString := Edit5.Text;
  F_Dados.CDS_ClientesEstado.AsString := Edit6.Text;
  F_Dados.CDS_ClientesMae.AsString := Edit7.Text;
  F_Dados.CDS_ClientesOrgao.AsString := Edit8.Text;
  F_Dados.CDS_ClientesSexo.AsString := Edit9.Text;
  F_Dados.CDS_ClientesEmpresa.AsString := Edit10.Text;
  F_Dados.CDS_ClientesProfissao.AsString := Edit11.Text;
  F_Dados.CDS_ClientesRef1.AsString := Edit12.Text;
  F_Dados.CDS_ClientesRef2.AsString := Edit13.Text;
  F_Dados.CDS_ClientesCep.AsString := MaskEdit1.Text;
  F_Dados.CDS_ClientesFone.AsString := MaskEdit2.Text;
  F_Dados.CDS_ClientesFax.AsString := MaskEdit3.Text;
  F_Dados.CDS_ClientesCelular.AsString := MaskEdit4.Text;
  F_Dados.CDS_ClientesCNPJ.AsString := MaskEdit5.Text;
  F_Dados.CDS_ClientesCpf.AsString := MaskEdit6.Text;
  if MaskEdit7.Text <> '  /  /    ' then
    F_Dados.CDS_ClientesNascimento.AsString := MaskEdit7.Text;
  if MaskEdit8.Text <> '  /  /    ' then
    F_Dados.CDS_ClientesDesde.AsString := MaskEdit8.Text;
  F_Dados.CDS_ClientesFone_empresa.AsString := MaskEdit10.Text;
  F_Dados.CDS_Clientesfone_ref1.AsString := MaskEdit11.Text;
  F_Dados.CDS_Clientesfone_ref2.AsString := MaskEdit12.Text;
  F_Dados.CDS_ClientesRenda.AsString := EditNum1.Text;
  F_Dados.CDS_Clientesobs.AsString := Memo1.Text;
  //
  F_Dados.CDS_Clientes.Post;
  F_Dados.CDS_Clientes.ApplyUpdates(0);
end;

procedure TF_Clientes.Limpa;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  Edit5.Clear;
  Edit6.Clear;
  Edit7.Clear;
  Edit8.Clear;
  Edit9.Clear;
  Edit10.Clear;
  Edit11.Clear;
  Edit12.Clear;
  Edit13.Clear;
  EditNum1.Text := '0.00';
  MaskEdit1.Clear;
  MaskEdit2.Clear;
  MaskEdit3.Clear;
  MaskEdit4.Clear;
  MaskEdit5.Clear;
  MaskEdit6.Clear;
  MaskEdit7.Clear;
  MaskEdit8.Clear;
  MaskEdit10.Clear;
  MaskEdit11.Clear;
  MaskEdit12.Clear;
  Memo1.Clear;
end;

procedure TF_Clientes.incluir(Sender: TObject);
begin
  conf := 1;
  Insere;
end;

procedure TF_Clientes.alterar(Sender: TObject);
begin
  If F_Dados.CDS_Clientes.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Alterado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 2;
    Altera;
    QueryToEdits;
  end;
end;

procedure TF_Clientes.Excluir(Sender: TObject);
var
  opc: Integer;
begin
  opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then
  begin
    If F_Dados.CDS_Clientes.FieldByName('id').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído', 'Sistema de Segurança', mb_Ok + mb_IconError)
    else
    begin
      F_Dados.CDS_Clientes.Delete;
      F_Dados.CDS_Clientes.ApplyUpdates(0);
    end;
  end;
end;

procedure TF_Clientes.Consultar(Sender: TObject);
begin
  If F_Dados.CDS_Clientes.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existe Registro Selecionado para Ser Consultado', 'Sistema de Segurança', mb_Ok + mb_IconError)
  else begin
    conf := 3;
    Consulta;
    QueryToEdits;
  end;
end;

procedure TF_Clientes.Retorna(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TF_Clientes.Confirma(Sender: TObject);
begin
  F_Dados.CDS_Clientes.Open;
  if conf = 1 then begin
    if (Edit1.Text = '') or (MaskEdit6.Text = '   .   .   -  ') then begin
      Application.MessageBox('O nome do cliente e o número do CPF não podem ficar em branco', 'Informação do Sistema', mb_Ok + mb_IconError);
      MaskEdit6.SetFocus;
      exit;
    end
    else begin
      F_Dados.CDS_Clientes.Append;
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
    F_Dados.CDS_Clientes.Edit;
    Grava;
    Visualiza;
  end
  else if conf = 3 then
    Visualiza;
  Limpa;
  conf := 0;
end;

procedure TF_Clientes.Cancelar(Sender: TObject);
begin
  Limpa;
  Visualiza;
  conf := 0;
end;

procedure TF_Clientes.pinta;
var
  i: Integer;
begin
  For i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns.Items[i].Color := ClWindow;
  DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_Clientes.procura;
begin
  if EditProcura.Text <> '' then begin
    If nCol = '' then
      Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta', 'Informação do Sistema', mb_Ok + mb_IconError)
    else begin
      F_Dados.Q_Clientes.Active := False;
      F_Dados.Q_Clientes.Sql.Clear;
      if nCol = 'id' then
        F_Dados.Q_Clientes.Sql.add('select * from cliente where ' + nCol + ' like ' + chr(39) + EditProcura.Text + chr(39))
      else
        F_Dados.Q_Clientes.Sql.add('select * from cliente where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
      F_Dados.Q_Clientes.Sql.add('order by ' + nCol + ',nome');
      F_Dados.Q_Clientes.Active := True;
      F_Dados.CDS_Clientes.Close;
      F_Dados.CDS_Clientes.Open;
    end;
  end
  else
    F_Dados.CDS_Clientes.Close;
end;

procedure TF_Clientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If conf <> 0 then begin
    Application.MessageBox('Antes de Sair Clique em Confirmar ou Cancelar', 'Aviso do Sistema', Mb_IconInformation);
    Action := caNone;
  end
  else begin
    F_Dados.CDS_Clientes.Active := False;
    Release;
  end;
end;

procedure TF_Clientes.DBGrid1TitleClick(Column: TColumn);
begin
  aguarde;
  idCol := Column.ID;
  nCol := Column.FieldName;
  pinta;
  procura;
  pronto;
  EditProcura.SetFocus;
end;

procedure TF_Clientes.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then begin
    aguarde;
    procura;
    pronto;
  end;
  if Key = 9 then
    MaskEdit9.SetFocus;
  if Key = 13 then
    MaskEdit9.SetFocus;
end;

procedure TF_Clientes.Vdeo1Click(Sender: TObject);
begin
  If F_Dados.CDS_Clientes.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + Mb_IconInformation)
  else
  begin
    if Application.MessageBox('Deseja imprimir os dados em tela?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      RDprint.OpcoesPreview.Preview := True;
      impcliente;
    end;
  end;
end;

procedure TF_Clientes.Impressora2Click(Sender: TObject);
begin
  If F_Dados.CDS_Clientes.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos', 'Informação do Sistema', mb_Ok + Mb_IconInformation)
  else begin
    if Application.MessageBox('Deseja imprimir os dados na impressora?', 'Pergunta do Sistema', Mb_YesNo + Mb_IconQuestion) = IdYes then
    begin
      RDprint.OpcoesPreview.Preview := False;
      impcliente;
    end;
  end;
end;

procedure TF_Clientes.FormCreate(Sender: TObject);
begin
  F_Dados.Q_Clientes.Active := False;
  F_Dados.CDS_Clientes.Close;
  F_Dados.CDS_Clientes.Open;
  Visualiza;
end;

procedure TF_Clientes.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    EditProcura.SetFocus;
  if Key = 13 then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Clientes.auditoria;
begin
  if conf = 1 then
    F_Dados.CDS_Clientes.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - INCLUSAO'
  else if conf = 2 then
    F_Dados.CDS_Clientes.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - ALTERACAO';
end;

procedure TF_Clientes.FormShow(Sender: TObject);
begin
  DBGrid1TitleClick(DBGrid1.Columns.Items[0]);
  EditProcura.SetFocus;
end;

procedure TF_Clientes.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  Key := UpCase(Key);
end;

procedure TF_Clientes.MaskEdit6Exit(Sender: TObject);
var
  CPF: String;
begin
  CPF := Copy(MaskEdit6.Text, 1, 1);
  If (CPF = '0') or (CPF = '1') or (CPF = '2') or (CPF = '3') or (CPF = '4') or (CPF = '5') or (CPF = '6') or (CPF = '7') or (CPF = '8') or (CPF = '9') then begin
    If ValidaCPF(MaskEdit6.Text) = False then begin
      Application.MessageBox('CPF Inválido - Tente Novamente', 'Informação do Sistema', Mb_IconInformation);
      MaskEdit6.SetFocus;
    End
    else begin
      If conf = 1 then begin
        MyConsulta(F_Dados.Q_Rap, 'select * from cliente where cpf=' + chr(39) + MaskEdit6.Text + chr(39));
        If F_Dados.Q_Rap.FieldByName('cpf').AsString <> '' then begin
          Application.MessageBox('Esse CPF já está cadastrado', 'Informação do Sistema', mb_Ok + Mb_IconInformation);
          MaskEdit6.SelectAll;
          MaskEdit6.SetFocus;
        end;
      end;
    end;
  end;
end;

procedure TF_Clientes.Memo1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    BitBtn4.SetFocus;
end;

procedure TF_Clientes.MaskEdit9KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    DBGrid1.SetFocus;
  if Key = 113 then begin
    aguarde;
    F_Dados.Q_Clientes.Active := False;
    F_Dados.Q_Clientes.Sql.Clear;
    F_Dados.Q_Clientes.Sql.add('select * from cliente where cpf like ' + chr(39) + MaskEdit9.Text + '%' + chr(39));
    F_Dados.Q_Clientes.Sql.add('order by cpf,nome');
    F_Dados.Q_Clientes.Active := True;
    pronto;
    F_Dados.CDS_Clientes.Close;
    F_Dados.CDS_Clientes.Open;
    if F_Dados.Q_ClientesCPF.AsString <> '' then begin
      BitBtn9.click;
      Edit1.SetFocus;
    end;
  end;
  if Key = 13 then
    MaskEdit13.SetFocus;
end;

procedure TF_Clientes.MaskEdit13KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    DBGrid1.SetFocus;
  if Key = 113 then begin
    aguarde;
    F_Dados.Q_Clientes.Active := False;
    F_Dados.Q_Clientes.Sql.Clear;
    F_Dados.Q_Clientes.Sql.add('select * from cliente where cnpj like ' + chr(39) + MaskEdit13.Text + '%' + chr(39));
    F_Dados.Q_Clientes.Sql.add('order by cnpj,nome');
    F_Dados.Q_Clientes.Active := True;
    pronto;
    F_Dados.CDS_Clientes.Close;
    F_Dados.CDS_Clientes.Open;
    if F_Dados.Q_ClientesCNPJ.AsString <> '' then begin
      BitBtn9.click;
      Edit1.SetFocus;
    end;
  end;
  if Key = 13 then
    EditProcura.SetFocus;
end;

procedure TF_Clientes.MaskEdit5Exit(Sender: TObject);
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
