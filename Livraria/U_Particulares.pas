unit U_Particulares;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask, Db, Grids, DBGrids, DBTables,
  DBIProcs, Menus, MenBtn, Biblioteca, RDprint, UBase;

type
  TF_Particulares = class(TFBase)
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
    Label1: TLabel;
    Label15: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit15: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    MaskEdit5: TMaskEdit;
    MaskEdit6: TMaskEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    MaskEdit7: TMaskEdit;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    SpeedButton2: TSpeedButton;
    EditProcura: TEdit;
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
    procedure impescola;
    procedure Cancelar(Sender: TObject);
    procedure incluir(Sender: TObject);
    procedure Confirma(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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
  F_Particulares: TF_Particulares;
  idCol,conf,confere:integer;
  nCol:string;
  Linha: integer;

implementation

uses U_Dados, UMenu;

{$R *.DFM}

procedure TF_Particulares.aguarde;
begin
   Panel3.Visible := True;
   Panel3.BringToFront;
   Panel3.Width := BitBtn10.Left + BitBtn10.Width - Panel3.Left;
   Panel3.Repaint;
end;

procedure TF_Particulares.pronto;
begin
   Panel3.Visible := False;
   Panel3.BringToFront;
   Panel3.Repaint;
end;

procedure TF_Particulares.impescola;
begin
  RDprint.MostrarProgresso  := True;
  RDprint.TitulodoRelatorio := 'Relação das Escolas Particulares';
  RDprint.TamanhoQteColunas := 132;
  RDprint.TamanhoQteLinhas  := 66;

  RDprint.abrir;            // Inicia a montagem do relatório...
  linha            := 9;

  aguarde;
  F_Dados.CDS_Particular.DisableControls;
  F_Dados.CDS_Particular.First;
  while not F_Dados.CDS_Particular.eof do begin
    if linha > 63 then // Salto de Pagina chama automaticamente cabecalho/rodape
       RDprint.novapagina;

     RDprint.Imp(linha, 01, StringOfChar('0',3-Length(F_Dados.CDS_Particular.FieldByName('id').AsString))+F_Dados.CDS_Particular.FieldByName('id').AsString);
     RDprint.Imp(linha, 06, F_Dados.CDS_ParticularNome.AsString);
     RDprint.Imp(linha, 48, F_Dados.CDS_Particularcnpj.AsString);
     RDprint.Imp(linha, 68, F_Dados.CDS_ParticularEndereco.AsString);
     RDprint.Imp(linha, 110, F_Dados.CDS_ParticularFone.AsString);
     F_Dados.CDS_Particular.next;
     inc(linha);
  end;
  F_Dados.CDS_Particular.EnableControls;
  RDprint.Fechar;
  pronto;
end;

procedure TF_Particulares.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
  // Cabeçalho...
  rdprint.imp (02,01,StringOfChar('=',132));
  rdprint.impf(03,01,'Relação das Escolas Particulares', [expandido,NEGRITO]);
  rdprint.imp (04,01,F_Dados.NomeEmpresa);
  rdprint.imp (05,01,F_Dados.EnderecoEmpresa);
  rdprint.imp (06,01,StringOfChar('=',132));

   RDprint.Imp(07, 01, 'COD.');
   RDprint.Imp(07, 06, 'NOME DA ESCOLA');
   RDprint.Imp(07, 48, 'CNPJ');
   RDprint.Imp(07, 68, 'ENDEREÇO');
   RDprint.Imp(07, 110, 'FONE');

  rdprint.imp (08,01,StringOfChar('-',132));
  Linha  := 9;
end;

procedure TF_Particulares.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
  rdprint.imp (64,01,StringOfChar('=',132));
  rdprint.imp (65,01,'Página: ' + formatfloat('##',pagina) + ' de &page&');
  rdprint.impd(65,132,'Impresso em ' +  DateTimeToStr(Now),[italico]);
end;

procedure TF_Particulares.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0);     // Pressiona tecla Escape
end;

procedure TF_Particulares.Visualiza;
begin
   PanEdits.Visible:=False;
   PanGrid.Visible:=True;
   PanTitulo.Caption:='Cadastro das Escolas Particulares - Visualizando...';
end;

procedure TF_Particulares.Insere;
begin
   PanEdits.Visible:=True;
   PanGrid.Visible:=False;
   PanTitulo.Caption:='Cadastro das Escolas Particulares - Inserindo...';
   Edit1.SetFocus;
end;

procedure TF_Particulares.Altera;
begin
   PanEdits.Visible:=True;
   PanGrid.Visible:=False;
   PanTitulo.Caption:='Cadastro das Escolas Particulares - Alterando...';
   Edit1.SetFocus;
end;

procedure TF_Particulares.Consulta;
begin
   PanEdits.Visible:=True;
   PanGrid.Visible:=False;
   PanTitulo.Caption:='Cadastro das Escolas Particulares - Consultando...';
   BitBtn4.SetFocus;
end;

procedure TF_Particulares.QueryToEdits;
begin
   Edit1.Text := F_Dados.CDS_ParticularNome.AsString;
   Edit2.Text := F_Dados.CDS_ParticularEndereco.AsString;
   Edit3.Text := F_Dados.CDS_ParticularBairro.AsString;
   Edit4.Text := F_Dados.CDS_ParticularCidade.AsString;
   Edit15.Text := F_Dados.CDS_ParticularEstado.AsString;
   MaskEdit1.Text := F_Dados.CDS_ParticularCep.AsString;
   MaskEdit2.Text := F_Dados.CDS_ParticularFone.AsString;
   MaskEdit3.Text := F_Dados.CDS_ParticularFax.AsString;
   MaskEdit4.Text := F_Dados.CDS_ParticularCelular.AsString;
   MaskEdit5.Text := F_Dados.CDS_Particularcnpj.AsString;
   MaskEdit6.Text := F_Dados.CDS_Particularinscricao_estadual.AsString;
   MaskEdit7.Text := F_Dados.CDS_ParticularAniversario.AsString;
   Edit11.Text := F_Dados.CDS_ParticularContato.AsString;
   Edit12.Text := F_Dados.CDS_ParticularDiretor.AsString;
end;

procedure TF_Particulares.Grava;
begin
	auditoria;
   F_Dados.CDS_ParticularNome.AsString          :=   Edit1.Text;
   F_Dados.CDS_ParticularEndereco.AsString      :=   Edit2.Text;
   F_Dados.CDS_ParticularBairro.AsString        :=   Edit3.Text;
   F_Dados.CDS_ParticularCidade.AsString        :=   Edit4.Text;
   F_Dados.CDS_ParticularEstado.AsString        :=   Edit15.Text;
   F_Dados.CDS_ParticularCep.AsString           :=   MaskEdit1.Text;
   F_Dados.CDS_ParticularFone.AsString          :=   MaskEdit2.Text;
   F_Dados.CDS_ParticularFax.AsString           :=   MaskEdit3.Text;
   F_Dados.CDS_ParticularCelular.AsString       :=   MaskEdit4.Text;
   F_Dados.CDS_Particularcnpj.AsString           :=   MaskEdit5.Text;
   F_Dados.CDS_Particularinscricao_estadual.AsString           :=   MaskEdit6.Text;
   F_Dados.CDS_ParticularAniversario.AsString   :=   MaskEdit7.Text;
   F_Dados.CDS_ParticularContato.AsString       :=   Edit11.Text;
   F_Dados.CDS_ParticularDiretor.AsString       :=   Edit12.Text;
   //
   F_Dados.CDS_Particular.Post;
   F_Dados.CDS_Particular.ApplyUpdates(0);
end;

procedure TF_Particulares.Limpa;
begin
   Edit1.Clear;
   Edit2.Clear;
   Edit3.Clear;
   Edit4.Clear;
   Edit15.Clear;
   MaskEdit1.Clear;
   MaskEdit2.Clear;
   MaskEdit3.Clear;
   MaskEdit4.Clear;
   MaskEdit5.Clear;
   MaskEdit6.Clear;
   MaskEdit7.Clear;
   Edit11.Clear;
   Edit12.Clear;
end;

procedure TF_Particulares.incluir(Sender: TObject);
begin
   Conf:=1;
   Insere;
end;

procedure TF_Particulares.alterar(Sender: TObject);
begin
   If F_Dados.CDS_Particular.FieldByName('id').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Alterado','Sistema de Segurança',mb_Ok+mb_IconError)
   else begin
      Conf:=2;
      Altera;
      QueryToEdits;
   end;
end;

procedure TF_Particulares.Excluir(Sender: TObject);
var
   opc:Integer;
begin
   opc:=Application.MessageBox('Confirma Exclusão?','Exclusão de Registros',Mb_YesNo + Mb_IconQuestion);
   If opc=IdYes then
   begin
      If F_Dados.CDS_Particular.FieldByName('id').AsString = '' then
         Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído','Sistema de Segurança',mb_Ok+mb_IconError)
      else
      begin
         F_Dados.CDS_Particular.Delete;
         F_Dados.CDS_Particular.ApplyUpdates(0);
      end;
   end;
end;

procedure TF_Particulares.Consultar(Sender: TObject);
begin
   If F_Dados.CDS_Particular.FieldByName('id').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Consultado','Sistema de Segurança',mb_Ok+mb_IconError)
   else begin
      Conf:=3;
      Consulta;
      QueryToEdits;
   end;
end;

procedure TF_Particulares.Retorna(Sender: TObject);
begin
  FechaFormulario;
end;

procedure TF_Particulares.Confirma(Sender: TObject);
begin
   F_Dados.CDS_Particular.Open;
   if conf = 1 then begin
      if Edit1.text = '' then begin
         Application.MessageBox('O nome da escola não pode ficar em branco','Informação do Sistema',mb_Ok+mb_IconError);
         Edit1.setfocus;
      end
      else begin
         F_Dados.CDS_Particular.Append;
         Grava;
         idCol := 1;
         nCol  := 'nome';
         pinta;
         Visualiza;
         EditProcura.Text := Edit1.Text;
         procura;
      end;
   end
   else if conf = 2 then begin
      F_Dados.CDS_Particular.Edit;
      Grava;
      Visualiza;
   end
   else if conf = 3 then
      Visualiza;
   Limpa;
   Conf := 0;
end;

procedure TF_Particulares.Cancelar(Sender: TObject);
begin
   Limpa;
   Visualiza;
   Conf := 0;
end;

procedure TF_Particulares.pinta;
var
   i:integer;
begin
   For i := 0 to DbGrid1.Columns.Count -1 do
      DBgrid1.Columns.Items[i].Color := ClWindow;
   DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_Particulares.procura;
begin
   if EditProcura.Text <> '' then begin
      If nCol = '' then
         Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta','Informação do Sistema',mb_Ok+mb_IconError)
      else begin
         F_Dados.Q_Particular.Active:=false;
         F_Dados.Q_Particular.Sql.clear;
         if nCol = 'id' then
            F_Dados.Q_Particular.SQL.add('select * from escola where ' + nCol + ' like '+chr(39)+editprocura.text+chr(39))
         else
            F_Dados.Q_Particular.SQL.add('select * from escola where ' + nCol + ' like '+chr(39)+editprocura.text+'%'+chr(39));
         F_Dados.Q_Particular.SQL.add('order by ' + nCol + ',nome');
         F_Dados.Q_Particular.Active:=true;
         F_Dados.CDS_Particular.Close;
         F_Dados.CDS_Particular.Open;
      end;
   end
   else
      F_Dados.CDS_Particular.Active:=False;
end;

procedure TF_Particulares.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   If Conf <> 0 then begin
     Application.MessageBox('Antes de Sair Clique em Confirmar ou Cancelar','Aviso do Sistema',Mb_IconInformation);
     Action := caNone;
   end
   else begin
     F_Dados.CDS_Particular.Active := False;
     Release;
   end;
end;

procedure TF_Particulares.DBGrid1TitleClick(Column: TColumn);
begin
   Aguarde;
   idCol := Column.ID;
   nCol := column.FieldName;
   pinta;
   procura;
   Pronto;
  EditProcura.SetFocus;
end;

procedure TF_Particulares.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=113 then
      SpeedButton2Click(Sender);
   if (Key=9) or (key=13) then
      DBGrid1.SetFocus;
end;

procedure TF_Particulares.SpeedButton2Click(Sender: TObject);
begin
   Aguarde;
   Procura;
   Pronto;
end;

procedure TF_Particulares.Vdeo1Click(Sender: TObject);
begin
  If F_Dados.CDS_Particular.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos','Informação do Sistema',mb_Ok+mb_IconInformation)
  else
  begin
    if Application.MessageBox('Deseja imprimir os dados em tela?','Pergunta do Sistema',Mb_YesNo + Mb_IconQuestion) = idYes then
    begin
      RDprint.OpcoesPreview.Preview       := True;
      impescola;
    end;
  end;
end;

procedure TF_Particulares.Impressora2Click(Sender: TObject);
begin
  If F_Dados.CDS_Particular.FieldByName('id').AsString = '' then
    Application.MessageBox('Não Existem Dados para Serem Impressos','Informação do Sistema',mb_Ok+mb_IconInformation)
  else begin
    if Application.MessageBox('Deseja imprimir os dados na impressora?','Pergunta do Sistema',Mb_YesNo + Mb_IconQuestion) = idYes then
    begin
      RDprint.OpcoesPreview.Preview       := False;
      impescola;
    end;
  end;
end;

procedure TF_Particulares.FormCreate(Sender: TObject);
begin
   F_Dados.Q_Particular.Active := False;
   Visualiza;
   F_Dados.CDS_Particular.Close;
   F_Dados.CDS_Particular.Open;
end;

procedure TF_Particulares.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   if Key=9 then
      EditProcura.SetFocus;
   if key=13 then
      DBGrid1.SelectedIndex := DBGrid1.SelectedIndex+1;
end;

procedure TF_Particulares.Auditoria;
begin
   if conf = 1 then
      F_Dados.CDS_Particular.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - INCLUSAO'
   else if conf = 2 then
      F_Dados.CDS_Particular.FieldByName('Auditoria').AsString := FMenu.User.Caption + ' - ' + DateTimeToStr(Now) + ' - ALTERACAO';
end;

procedure TF_Particulares.FormShow(Sender: TObject);
begin
  DBGrid1TitleClick(DBGrid1.Columns.Items[0]);
  EditProcura.SetFocus;
end;

procedure TF_Particulares.MaskEdit5Exit(Sender: TObject);
var
   VCCG:String;
begin
  Try
     VCCG := Copy(MaskEdit5.Text,1,1);
     If (VCCG='0') or (VCCG='1') or (VCCG='2') or (VCCG='3') or (VCCG='4') or (VCCG='5') or (VCCG='6') or (VCCG='7') or (VCCG='8') or (VCCG='9') then begin
        If ValidaCnpj(MaskEdit5.Text)=False then begin
           Showmessage('CNPJ Inválido - Tente Novamente');
           MaskEdit5.SetFocus;
        End;
  end
  except
     on exception do begin
        Application.MessageBox('Existe um Erro na Digitação do CNPJ','Informação do Sistema',Mb_IconError);
        MaskEdit5.SetFocus;
     end;
  end;
end;

end.
