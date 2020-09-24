unit U_Bancos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, Db, Grids, DBGrids, DBTables,
  DBIProcs, Menus, MenBtn, RDprint, UBase;

type
  TF_Bancos = class(TFBase)
    PanTitulo: TPanel;
    PanEdits: TPanel;
    PanGrid: TPanel;
    DBGrid1: TDBGrid;
    PanProcura: TPanel;
    GroupBox1: TGroupBox;
    BitBtn11: TBitBtn;
    BitBtn15: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    Label3: TLabel;
    EditProcura: TEdit;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    MenuButton1: TMenuButton;
    Label16: TLabel;
    Label17: TLabel;
    Label13: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    SpeedButton2: TSpeedButton;
    PopupMenu1: TPopupMenu;
    Vdeo1: TMenuItem;
    Impressora2: TMenuItem;
    Panel3: TPanel;
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
    procedure impbanco;
    procedure Cancelar(Sender: TObject);
    procedure incluir(Sender: TObject);
    procedure Confirma(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure Consultar(Sender: TObject);
    procedure alterar(Sender: TObject);
    procedure Retorna(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Vdeo1Click(Sender: TObject);
    procedure Impressora2Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
  F_Bancos: TF_Bancos;
  idCol,conf,confere:integer;
  nCol:string;
  Linha: integer;

implementation

uses U_Dados, UMenu;

{$R *.DFM}

procedure TF_Bancos.aguarde;
begin
   Panel3.Visible := True;
   Panel3.BringToFront;
   Panel3.Width := BitBtn10.Left + BitBtn10.Width - Panel3.Left;
   Panel3.Repaint;
end;

procedure TF_Bancos.pronto;
begin
   Panel3.Visible := False;
   Panel3.BringToFront;
   Panel3.Repaint;
end;

procedure TF_Bancos.impbanco;
begin
  RDprint.MostrarProgresso  := True;
  RDprint.TitulodoRelatorio := 'Relação dos Bancos';
  RDprint.TamanhoQteColunas := 130;
  RDprint.TamanhoQteLinhas  := 66;

  RDprint.abrir;            // Inicia a montagem do relatório...
  linha            := 9;

  aguarde;
  F_Dados.CDS_Bancos.DisableControls;
  F_Dados.CDS_Bancos.First;
  while not F_Dados.CDS_Bancos.eof do begin
    if linha > 63 then // Salto de Pagina chama automaticamente cabecalho/rodape
       RDprint.novapagina;

     RDprint.Imp(linha, 01, StringOfChar('0',3-Length(F_Dados.CDS_Bancos.FieldByName('id').AsString))+F_Dados.CDS_Bancos.FieldByName('id').AsString);
     RDprint.Imp(linha, 06, F_Dados.CDS_BancosBanco.AsString);
     RDprint.Imp(linha, 38, F_Dados.CDS_BancosCc.AsString);
     RDprint.Imp(linha, 55, F_Dados.CDS_BancosAgencia.AsString);
     RDprint.Imp(linha, 72, F_Dados.CDS_BancosFone.AsString);
     RDprint.Imp(linha, 90, F_Dados.CDS_BancosGerente.AsString);
     F_Dados.CDS_Bancos.next;
     inc(linha);
  end;
  F_Dados.CDS_Bancos.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_Bancos.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  rdprint.imp (02,01,StringOfChar('=',130));
  rdprint.impf(03,01,'Relação dos Bancos', [expandido,NEGRITO]);
  rdprint.imp (04,01,F_Dados.NomeEmpresa);
  rdprint.imp (05,01,F_Dados.EnderecoEmpresa);
  rdprint.imp (06,01,StringOfChar('=',130));

   RDprint.Imp(07, 01, 'COD.');
   RDprint.Imp(07, 06, 'NOME DO BANCO');
   RDprint.Imp(07, 38, 'C/C');
   RDprint.Imp(07, 55, 'AGENCIA');
   RDprint.Imp(07, 72, 'FONE');
   RDprint.Imp(07, 90, 'GERENTE');

  rdprint.imp (08,01,StringOfChar('-',130));
  Linha  := 9;
end;

procedure TF_Bancos.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  rdprint.imp (64,01,StringOfChar('=',130));
  rdprint.imp (65,01,'Página: ' + formatfloat('##',pagina) + ' de &page&');
  rdprint.impd(65,130,'Impresso em ' +  DateTimeToStr(Now),[italico]);
end;

procedure TF_Bancos.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0);     // Pressiona tecla Escape
end;

procedure TF_Bancos.Visualiza;
begin
   PanEdits.Visible:=False;
   PanGrid.Visible:=True;
   PanTitulo.Caption:='Cadastro dos Bancos - Visualizando...';
end;

procedure TF_Bancos.Insere;
begin
   PanEdits.Visible:=True;
   PanGrid.Visible:=False;
   PanTitulo.Caption:='Cadastro dos Bancos - Inserindo...';
   Edit1.SetFocus;
end;

procedure TF_Bancos.Altera;
begin
   PanEdits.Visible:=True;
   PanGrid.Visible:=False;
   PanTitulo.Caption:='Cadastro dos Bancos - Alterando...';
   Edit1.SetFocus;
end;

procedure TF_Bancos.Consulta;
begin
   PanEdits.Visible:=True;
   PanGrid.Visible:=False;
   PanTitulo.Caption:='Cadastro dos Bancos - Consultando...';
   BitBtn4.SetFocus;
end;

procedure TF_Bancos.QueryToEdits;
begin
   Edit1.Text     := F_Dados.CDS_Bancos.FieldByName('Banco').AsString;
   Edit2.Text     := F_Dados.CDS_Bancos.FieldByName('CC').AsString;
   Edit3.Text     := F_Dados.CDS_Bancos.FieldByName('Agencia').AsString;
   Edit4.Text     := F_Dados.CDS_Bancos.FieldByName('Endereco').AsString;
   Edit5.Text     := F_Dados.CDS_Bancos.FieldByName('Bairro').AsString;
   Edit6.Text     := F_Dados.CDS_Bancos.FieldByName('Cidade').AsString;
   Edit7.Text     := F_Dados.CDS_Bancos.FieldByName('Estado').AsString;
   Edit7.Text     := F_Dados.CDS_Bancos.FieldByName('Gerente').AsString;
   MaskEdit1.Text := F_Dados.CDS_Bancos.FieldByName('Cep').AsString;
   MaskEdit2.Text := F_Dados.CDS_Bancos.FieldByName('Fone').AsString;
   MaskEdit3.Text := F_Dados.CDS_Bancos.FieldByName('Fax').AsString;
end;

procedure TF_Bancos.Grava;
begin
	auditoria;
   F_Dados.CDS_Bancos.FieldByName('Banco').AsString        :=   Edit1.Text;
   F_Dados.CDS_Bancos.FieldByName('CC').AsString           :=   Edit2.Text;
   F_Dados.CDS_Bancos.FieldByName('Agencia').AsString      :=   Edit3.Text;
   F_Dados.CDS_Bancos.FieldByName('Endereco').AsString     :=   Edit4.Text;
   F_Dados.CDS_Bancos.FieldByName('Bairro').AsString       :=   Edit5.Text;
   F_Dados.CDS_Bancos.FieldByName('Cidade').AsString       :=   Edit6.Text;
   F_Dados.CDS_Bancos.FieldByName('Estado').AsString       :=   Edit7.Text;
   F_Dados.CDS_Bancos.FieldByName('Gerente').AsString      :=   Edit8.Text;
   F_Dados.CDS_Bancos.FieldByName('Cep').AsString          :=   MaskEdit1.Text;
   F_Dados.CDS_Bancos.FieldByName('Fone').AsString         :=   MaskEdit2.Text;
   F_Dados.CDS_Bancos.FieldByName('Fax').AsString          :=   MaskEdit3.Text;
   //
   F_Dados.CDS_Bancos.Post;
   F_Dados.CDS_Bancos.ApplyUpdates(0);
end;

procedure TF_Bancos.Limpa;
var
   i:integer;
begin
   for i := 0 to ComponentCount - 1 do begin
      if (Components [I] is TEdit) then
         (Components [I] as TEdit).Clear;
   end;
   for i := 0 to ComponentCount - 1 do begin
      if (Components [I] is TMaskEdit) then
         (Components [I] as TMaskEdit).Clear;
   end;
end;

procedure TF_Bancos.incluir(Sender: TObject);
begin
   Conf:=1;
   Insere;
end;

procedure TF_Bancos.alterar(Sender: TObject);
begin
   If F_Dados.CDS_Bancos.FieldByName('id').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Alterado','Sistema de Segurança',mb_Ok+mb_IconError)
   else begin
      Conf:=2;
      Altera;
      QueryToEdits;
   end;
end;

procedure TF_Bancos.Excluir(Sender: TObject);
var
   opc:Integer;
begin
   opc:=Application.MessageBox('Confirma Exclusão?','Exclusão de Registros',Mb_YesNo + Mb_IconQuestion);
   If opc=IdYes then begin
      If F_Dados.CDS_Bancos.FieldByName('id').AsString = '' then
         Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído','Sistema de Segurança',mb_Ok+mb_IconError)
      else
      begin
        F_Dados.CDS_Bancos.Delete;
        F_Dados.CDS_Bancos.ApplyUpdates(0);
      end;
   end;
end;

procedure TF_Bancos.Consultar(Sender: TObject);
begin
   If F_Dados.CDS_Bancos.FieldByName('id').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Consultado','Sistema de Segurança',mb_Ok+mb_IconError)
   else begin
      Conf:=3;
      Consulta;
      QueryToEdits;
   end;
end;

procedure TF_Bancos.Retorna(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TF_Bancos.Confirma(Sender: TObject);
begin
   F_Dados.CDS_Bancos.Open;
   if conf = 1 then begin
      if Edit1.text = '' then begin
         Application.MessageBox('O nome do banco não pode ficar em branco','Informação do Sistema',mb_Ok+mb_IconError);
         Edit1.setfocus;
      end
      else begin
         F_Dados.CDS_Bancos.Append;
         Grava;
         idCol := 1;
         nCol  := 'banco';
         pinta;
         Visualiza;
         EditProcura.Text := Edit1.Text;
         procura;
      end;
   end
   else if conf = 2 then begin
      F_Dados.CDS_Bancos.Edit;
      Grava;
      Visualiza;
   end
   else if conf = 3 then
      Visualiza;
   Limpa;
   Conf := 0;
end;

procedure TF_Bancos.Cancelar(Sender: TObject);
begin
   Limpa;
   Visualiza;
   Conf := 0;
end;

procedure TF_Bancos.pinta;
var
   i:integer;
begin
   For i := 0 to DbGrid1.Columns.Count -1 do
      DBgrid1.Columns.Items[i].Color := ClWindow;
   DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_Bancos.procura;
begin
   if EditProcura.Text <> '' then begin
      If nCol = '' then
         Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta','Informação do Sistema',mb_Ok+mb_IconError)
      else begin
         F_Dados.Q_Bancos.Active:=false;
         F_Dados.Q_Bancos.Sql.clear;
         if nCol = 'id' then
            F_Dados.Q_Bancos.SQL.add('select * from banco where ' + nCol + ' like '+chr(39)+editprocura.text+chr(39))
         else
            F_Dados.Q_Bancos.SQL.add('select * from banco where ' + nCol + ' like '+chr(39)+editprocura.text+'%'+chr(39));
         F_Dados.Q_Bancos.SQL.add('order by ' + nCol + ',banco');
         F_Dados.Q_Bancos.Active:=true;
         F_Dados.CDS_Bancos.Close;
         F_Dados.CDS_Bancos.Open;
      end;
   end
   else
         F_Dados.CDS_Bancos.Close;
end;

procedure TF_Bancos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   If Conf <> 0 then begin
     Application.MessageBox('Antes de Sair Clique em Confirmar ou Cancelar','Aviso do Sistema',Mb_IconInformation);
     Action := caNone;
   end
   else begin
     F_Dados.CDS_Bancos.Active := False;
     Release;
   end;
end;

procedure TF_Bancos.DBGrid1TitleClick(Column: TColumn);
begin
   Aguarde;
   idCol := Column.ID;
   nCol := column.FieldName;
   pinta;
   procura;
   Pronto;
  EditProcura.SetFocus;
end;

procedure TF_Bancos.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=113 then
      SpeedButton2Click(Sender);
   if (Key=9) or (key=13) then
      DBGrid1.SetFocus;
end;

procedure TF_Bancos.SpeedButton2Click(Sender: TObject);
begin
   Aguarde;
   Procura;
   Pronto;
end;

procedure TF_Bancos.Vdeo1Click(Sender: TObject);
begin
  If F_Dados.CDS_Bancos.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos','Informação do Sistema',mb_Ok+mb_IconInformation)
  else
  begin
    if Application.MessageBox('Deseja imprimir os dados em tela?','Pergunta do Sistema',Mb_YesNo + Mb_IconQuestion) = idYes then
    begin
      RDprint.OpcoesPreview.Preview       := True;
      impbanco;
    end;
  end;
end;

procedure TF_Bancos.Impressora2Click(Sender: TObject);
begin
  If F_Dados.CDS_Bancos.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos','Informação do Sistema',mb_Ok+mb_IconInformation)
  else begin
    if Application.MessageBox('Deseja imprimir os dados na impressora?','Pergunta do Sistema',Mb_YesNo + Mb_IconQuestion) = idYes then
    begin
      RDprint.OpcoesPreview.Preview       := False;
      impbanco;
    end;
  end;
end;

procedure TF_Bancos.FormCreate(Sender: TObject);
begin
   F_Dados.Q_Bancos.Active := False;
   F_Dados.CDS_Bancos.Close;
   F_Dados.CDS_Bancos.Open;
   Visualiza;
end;

procedure TF_Bancos.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=9 then
      EditProcura.SetFocus;
   if key=13 then
      DBGrid1.SelectedIndex := DBGrid1.SelectedIndex+1;
end;

procedure TF_Bancos.Auditoria;
begin
   if conf = 1 then
      F_Dados.CDS_Bancos.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - INCLUSAO'
   else if conf = 2 then
      F_Dados.CDS_Bancos.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - ALTERACAO';
end;

procedure TF_Bancos.FormShow(Sender: TObject);
begin
  DBGrid1TitleClick(DBGrid1.Columns.Items[0]);
  EditProcura.SetFocus;
end;

end.
