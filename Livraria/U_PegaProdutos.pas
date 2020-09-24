unit U_PegaProdutos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, DBTables,
  biblioteca, JvExControls, JvgLabel;

type
  TF_PegaProd = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBGrid1: TDBGrid;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    EditProcura: TEdit;
    Panel3: TJvgLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    QuemChamou: String;
    { Public declarations }
  end;

var
  F_PegaProd: TF_PegaProd;

implementation

uses U_Dados;
{$R *.DFM}

procedure TF_PegaProd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_PegaProd.BitBtn1Click(Sender: TObject);
begin
  if QuemChamou = 'NF' then
  begin
    F_Dados.cds_ItensNF.Append;
    F_Dados.CDS_ItensNFid_produto.Value := F_Dados.CDS_Produtosid.Value;
    F_Dados.CDS_ItensNFvalor_unitario.Value := F_Dados.CDS_Produtospreco.Value;
    F_Dados.cds_ItensNFCodigo.Value := F_Dados.cds_ProdutosCodigo.Value;
    F_Dados.cds_ItensNFDescricao.Value := F_Dados.cds_ProdutosDescricao.Value;
    F_Dados.cds_ItensNFUnidade.Value := F_Dados.cds_ProdutosUnidade.Value;
  end
  else
  begin
    F_Dados.cds_Dorc.Append;
    F_Dados.cds_DorcCodigobarra.AsString := F_Dados.cds_ProdutosCodigo.AsString;
  end;
  Close;
end;

procedure TF_PegaProd.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TF_PegaProd.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then
    SpeedButton3Click(Sender);
  if Key = 113 then begin
    Panel3.Visible := True;
    Panel3.Repaint;
    MyConsulta(F_Dados.Q_Produtos, 'select * from produto where descricao like' + chr(39) + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
    F_Dados.cds_Produtos.Close;
    F_Dados.cds_Produtos.OPen;
    Panel3.Visible := False;
    Panel3.Repaint;
  end;
  if Key = 115 then begin
    Panel3.Visible := True;
    Panel3.Repaint;
    MyConsulta(F_Dados.Q_Produtos, 'select * from produto where autor_marca like' + chr(39) + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
    F_Dados.cds_Produtos.Close;
    F_Dados.cds_Produtos.OPen;
    Panel3.Visible := False;
    Panel3.Repaint;
  end;
  if Key = 13 then
    DBGrid1.SetFocus;
end;

procedure TF_PegaProd.SpeedButton3Click(Sender: TObject);
begin
  Panel3.Visible := True;
  Panel3.Repaint;
  MyConsulta(F_Dados.Q_Produtos, 'select * from produto where descricao like' + chr(39) + '%' + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
  F_Dados.cds_Produtos.Close;
  F_Dados.cds_Produtos.OPen;
  Panel3.Visible := False;
  Panel3.Repaint;
end;

procedure TF_PegaProd.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 9 then
    EditProcura.SetFocus;
  if Key = 13 then
    BitBtn1Click(Sender);
end;

end.
