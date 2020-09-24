unit U_Contas;

interface

uses
  Windows, SysUtils, Forms, Dialogs, Graphics, Buttons, ExtCtrls, Grids, DBGrids,
  DB, Menus, StdCtrls, Controls, MenBtn, Classes, RDprint;

type
  TF_Contas = class(TForm)
    PanTitulo: TPanel;
    PanGrid: TPanel;
    DBGrid1: TDBGrid;
    PanProcura: TPanel;
    BitBtn15: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    MenuButton1: TMenuButton;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    Vdeo1: TMenuItem;
    Impressora2: TMenuItem;
    RDprint: TRDprint;
    procedure id0;
    procedure id1;
    procedure impcaixas;
    procedure incluir(Sender: TObject);
    procedure Excluir(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure alterar(Sender: TObject);
    procedure Retorna(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Vdeo1Click(Sender: TObject);
    procedure Impressora2Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure PanTituloClick(Sender: TObject);
    procedure RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintNewPage(Sender: TObject; Pagina: Integer);
    procedure RDprintAfterPrint(Sender: TObject);
    procedure NovaPagina;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  F_Contas: TF_Contas;
  linha:integer;

implementation

uses U_Dados;

{$R *.DFM}

procedure TF_Contas.impcaixas;
begin
  RDprint.MostrarProgresso  := True;
  RDprint.TitulodoRelatorio := 'Centro de Custo - Contas';
  RDprint.TamanhoQteColunas := 80;
  RDprint.TamanhoQteLinhas  := 66;

  RDprint.abrir;            // Inicia a montagem do relatório...
  linha            := 09;

   //
   Panel3.Visible := True;
   Panel3.BringToFront;
   Panel3.Repaint;
   //
  F_Dados.CDS_Contas.DisableControls;
  F_Dados.CDS_Contas.First;
  while not F_Dados.CDS_Contas.eof do begin
      novapagina;

     RDprint.Imp(linha, 01, F_Dados.CDS_ContasCodigo.AsString);
     RDprint.Imp(linha, 10, F_Dados.CDS_ContasConta.AsString);

     F_Dados.CDS_Contas.next;
     inc(linha);
  end;
  NovaPagina;
  rdprint.imp (linha,01,StringOfChar('=',80));
  RDprint.Fechar;

  F_Dados.CDS_Contas.EnableControls;
  F_Dados.CDS_Contas.First;
   //
   Panel3.Visible := False;
   Panel3.SendToBack;
   Panel3.Repaint;
   //
end;

procedure TF_Contas.ID0;
Begin
   F_Contas.DBGrid1.Columns.Items[0].Color := clInfoBk;
   F_Dados.Q_Contas.Active := False;
   F_Dados.Q_Contas.SQL.clear;
   F_Dados.Q_Contas.SQL.add('select * from centro_custo');
   F_Dados.Q_Contas.SQL.add('order by codigo,conta');
   F_Dados.Q_Contas.Active := True;
   F_Dados.CDS_Contas.Close;
   F_Dados.CDS_Contas.Open;
end;

procedure TF_Contas.ID1;
Begin
   F_Contas.DBGrid1.Columns.Items[1].Color := clInfoBk;
   F_Dados.Q_Contas.Active := False;
   F_Dados.Q_Contas.SQL.clear;
   F_Dados.Q_Contas.SQL.add('select * from centro_custo');
   F_Dados.Q_Contas.SQL.add('order by conta,codigo');
   F_Dados.Q_Contas.Active := True;
   F_Dados.CDS_Contas.Close;
   F_Dados.CDS_Contas.Open;
end;

procedure TF_Contas.incluir(Sender: TObject);
var
   codigo:string;
   i:integer;
begin
   For i := 0 to F_Contas.dbgrid1.Columns.Count -1 do begin
      F_Contas.DBgrid1.Columns.Items[i].Color := clWindow;
   end;
   id0;
   F_Dados.CDS_Contas.Last;
   If F_Dados.CDS_ContasCodigo.AsString = '' then
      Codigo := '2000'
   else
      codigo := F_Dados.CDS_ContasCodigo.AsString;
   F_Dados.CDS_Contas.Append;
   codigo := IntToStr(StrToInt(Codigo) + 1);
   F_Dados.CDS_ContasCodigo.AsString := codigo;
   //
   PanTitulo.Caption:='Cadastro das Contas - Inserindo...';
   DBGrid1.ReadOnly := False;
   DBGrid1.Columns.Items[0].ReadOnly := True;
   DBGrid1.SetFocus;
   DBGrid1.SelectedIndex:=1;
end;

procedure TF_Contas.alterar(Sender: TObject);
begin
   F_Dados.CDS_Contas.Edit;
   PanTitulo.Caption:='Cadastro das Contas - Alterando...';
   DBGrid1.ReadOnly := False;
   DBGrid1.Columns.Items[0].ReadOnly := True;
   DBGrid1.SetFocus;
   DBGrid1.SelectedIndex:=1;
end;

procedure TF_Contas.Excluir(Sender: TObject);
var
   opc:Integer;
begin
     opc:=Application.MessageBox('Confirma Exclusão?','Exclusão de Registros',Mb_YesNo + Mb_IconQuestion);
     If opc=IdYes then
     begin
        F_Dados.cds_Contas.Delete;
        F_Dados.cds_Contas.ApplyUpdates(0);
     end;
end;

procedure TF_Contas.Retorna(Sender: TObject);
begin
     Close;
end;

procedure TF_Contas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   If F_Dados.CDS_Contas.State in [dsEdit, dsInsert] then begin
     Application.MessageBox('Antes de Sair Confirme a Inclusão/Alteração Efetuada','Aviso do Sistema',Mb_IconInformation);
     Action := caNone;
   end
   else begin
     F_Dados.Q_Contas.Close;
     F_Dados.CDS_Contas.Close;
     Release;
   end;
end;

procedure TF_Contas.FormActivate(Sender: TObject);
begin
   F_Dados.Q_Contas.Active := True;
   F_Dados.CDS_Contas.Close;
   F_Dados.CDS_Contas.open;
end;

procedure TF_Contas.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
   If Key = Vk_Return then
      DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Contas.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
   KEY := UPCASE(KEY);
   If Key = #27 then
      DBGrid1.ReadOnly := True;
end;

procedure TF_Contas.Vdeo1Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja imprimir os dados em tela?','Pergunta do Sistema',Mb_YesNo + Mb_IconQuestion) = idYes then
  begin
    RDprint.OpcoesPreview.Preview       := True;
    impcaixas;
  end;
end;

procedure TF_Contas.Impressora2Click(Sender: TObject);
begin
  if Application.MessageBox('Deseja imprimir os dados na impressora?','Pergunta do Sistema',Mb_YesNo + Mb_IconQuestion) = idYes then
  begin
    RDprint.OpcoesPreview.Preview       := False;
    impcaixas;
  end;
end;

procedure TF_Contas.DBGrid1TitleClick(Column: TColumn);
var
   i:integer;
begin
     If Column.ID = 0 then begin
        For i := 0 to F_Contas.dbgrid1.Columns.Count -1 do begin
           F_Contas.DBgrid1.Columns.Items[i].Color := clWindow;
        end;
        ID0;
     end
     else If Column.ID = 1 then begin
        For i := 0 to F_Contas.dbgrid1.Columns.Count -1 do begin
           F_Contas.DBgrid1.Columns.Items[i].Color := clWindow;
        end;
        ID1;
     end
end;

procedure TF_Contas.PanTituloClick(Sender: TObject);
begin
   F_Contas.DBGrid1.Columns.Items[1].Color := clWindow;
   ID0;
end;

procedure TF_Contas.NovaPagina;
begin
  if linha > 63 then
     RDprint.novapagina;
end;

procedure TF_Contas.RDprintNewPage(Sender: TObject; Pagina: Integer);
begin
    rdprint.imp (02,01,StringOfChar('=',80));
    rdprint.impf(03,01,'Relacao das Contas para Controle Financeiro',[NEGRITO]);
    rdprint.imp (04,01,F_Dados.NomeEmpresa);
    rdprint.imp (05,01,F_Dados.EnderecoEmpresa);
    rdprint.imp (06,01,StringOfChar('=',80));

     RDprint.Imp(07, 01, 'CODIGO');
     RDprint.Imp(07, 10, 'DESCRICAO DA CONTA');

    rdprint.imp (08,01,StringOfChar('-',80));
    Linha  := 09;
end;

procedure TF_Contas.RDprintBeforeNewPage(Sender: TObject; Pagina: Integer);
begin
  // Rodapé...
    rdprint.imp (64,01,StringOfChar('=',80));
    rdprint.imp (65,01,'Página: ' + formatfloat('##',pagina) + ' de &page&');
    rdprint.impd(65,80,'Impresso em ' +  DateTimeToStr(Now),[italico]);
end;

procedure TF_Contas.RDprintAfterPrint(Sender: TObject);
begin
  // Força o fechamento do form preview após a impressão...
  Keybd_Event(VK_Escape, 0, 0, 0);     // Pressiona tecla Escape
end;

end.
