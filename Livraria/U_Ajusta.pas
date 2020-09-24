unit U_Ajusta;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DBCtrls, StdCtrls, DB, DBTables, Mask, ExtCtrls,
  Buttons, MenBtn, Grids, DBGrids, EditNum, Menus;

type
  TF_Ajusta = class(TForm)
    PanTitulo: TPanel;
    PanGrid: TPanel;
    DBGrid1: TDBGrid;
    PanProcura: TPanel;
    BitBtn14: TBitBtn;
    BitBtn10: TBitBtn;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    EditProcura: TEdit;
    Panel3: TPanel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label16: TLabel;
    EditNum5: TEditNum;
    MenuButton1: TMenuButton;
    procedure procura;
    procedure pinta;
    procedure aguarde;
    procedure pronto;
    procedure Excluir(Sender: TObject);
    procedure Retorna(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MenuButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Ajusta: TF_Ajusta;
  idCol, conf, confere: integer;
  nCol, anterior: string;

implementation

uses U_Dados;
{$R *.DFM}

procedure TF_Ajusta.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

procedure TF_Ajusta.pronto;
begin
  Panel3.Visible := False;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

procedure TF_Ajusta.Excluir(Sender: TObject);
var
  opc: integer;
begin
  opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
  If opc = IdYes then
  begin
    If F_Dados.CDS_Produtos.FieldByName('Codigo').AsString = '' then
      Application.MessageBox('Não Existe Registro Selecionado para Ser Excluído', 'Sistema de Segurança', mb_Ok + mb_IconError)
    else
    begin
      F_Dados.CDS_Produtos.Delete;
      F_Dados.CDS_Produtos.ApplyUpdates(0);
    end;
  end;
end;

procedure TF_Ajusta.Retorna(Sender: TObject);
begin
  Close;
end;

procedure TF_Ajusta.pinta;
var
  i: integer;
begin
  For i := 0 to DBGrid1.Columns.Count - 1 do
    DBGrid1.Columns.Items[i].Color := ClWindow;
  DBGrid1.Columns.Items[idCol].Color := clInfoBk;
end;

procedure TF_Ajusta.procura;
begin
  if EditProcura.Text <> '' then begin
    If nCol = '' then
      Application.MessageBox('Primeiro ordene uma coluna para então executar uma consulta', 'Informação do Sistema', mb_Ok + mb_IconError)
    else begin
      F_Dados.Q_Produtos.Active := False;
      F_Dados.Q_Produtos.Sql.clear;
      if nCol = 'codigo' then
        F_Dados.Q_Produtos.Sql.add('select * from produto where ' + nCol + ' like ' + chr(39) + EditProcura.Text + chr(39))
      else
        F_Dados.Q_Produtos.Sql.add('select * from produto where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
      F_Dados.Q_Produtos.Sql.add('order by ' + nCol + ',descricao');
      F_Dados.Q_Produtos.Active := True;
      F_Dados.CDS_Produtos.Close;
      F_Dados.CDS_Produtos.open;
    end;
  end
  else
    F_Dados.Q_Produtos.Active := False;
end;

procedure TF_Ajusta.DBGrid1TitleClick(Column: TColumn);
begin
  aguarde;
  idCol := Column.ID;
  nCol := Column.FieldName;
  pinta;
  procura;
  pronto;
end;

procedure TF_Ajusta.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 113 then begin
    aguarde;
    procura;
    pronto;
  end;
  if Key = 9 then
    DBGrid1.SetFocus;
end;

procedure TF_Ajusta.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    EditProcura.SetFocus;
  if Key = 13 then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_Ajusta.MenuButton1Click(Sender: TObject);
var
  taxa, txmenor: double;
  tax, taxmenor: string;
begin
  aguarde;
  // atualiza preços para maior
  If RadioButton1.Checked then begin
    taxa := strtofloat(EditNum5.Text) / 100;
    tax := FloatToStr(taxa);
    //
    F_Dados.Q_Rap.Sql.clear;
    F_Dados.Q_Rap.Sql.add('update produto set preco=(preco*1.' + Copy(tax, 3, 4) + ') where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
    F_Dados.Q_Rap.ExecSql;
    // arredonda precos
    F_Dados.Q_Rap.Sql.clear;
    F_Dados.Q_Rap.Sql.add('update produto set produto.preco=round(produto.preco,1)');
    F_Dados.Q_Rap.ExecSql;
  end
  // atualiza preços para menor
  Else If RadioButton2.Checked then begin
    txmenor := 100 - strtofloat(EditNum5.Text);
    txmenor := txmenor / 100;
    taxmenor := FloatToStr(txmenor);
    //
    F_Dados.Q_Rap.Sql.clear;
    F_Dados.Q_Rap.Sql.add('update produto set preco=(preco*0.' + Copy(taxmenor, 3, 4) + ') where ' + nCol + ' like ' + chr(39) + EditProcura.Text + '%' + chr(39));
    F_Dados.Q_Rap.ExecSql;
    // arredonda precos
    F_Dados.Q_Rap.Sql.clear;
    F_Dados.Q_Rap.Sql.add('update produto set produto.preco=round(produto.preco,1)');
    F_Dados.Q_Rap.ExecSql;
  end;
  //
  procura;
  //
  pronto;
end;

End.
