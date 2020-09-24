unit U_Precos;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, DBTables,
  biblioteca, JvExControls, JvgLabel;

type
  TF_Precos = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    Label9: TLabel;
    SpeedButton3: TSpeedButton;
    EditProcura: TEdit;
    Panel3: TJvgLabel;
    BitBtn10: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_Precos: TF_Precos;

implementation

uses U_Dados;
{$R *.DFM}

procedure TF_Precos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_Precos.BitBtn2Click(Sender: TObject);
begin
  Close;
end;

procedure TF_Precos.EditProcuraKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 114 then begin
    SpeedButton3Click(Sender);
  end;
  if Key = 113 then begin
    Panel3.Visible := True;
    Panel3.Repaint;
    MyConsulta(F_Dados.Q_ProcuraProd, 'select * from produto where descricao like' + chr(39) + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
    F_Dados.cds_ProcuraProd.Close;
    F_Dados.cds_ProcuraProd.open;
    Panel3.Visible := False;
    Panel3.Repaint;
  end;
  if Key = 112 then begin
    Panel3.Visible := True;
    Panel3.Repaint;
    MyConsulta(F_Dados.Q_ProcuraProd, 'select * from produto where codigo like' + chr(39) + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
    F_Dados.cds_ProcuraProd.Close;
    F_Dados.cds_ProcuraProd.open;
    Panel3.Visible := False;
    Panel3.Repaint;
  end;
  if Key = 13 then
    DBGrid1.SetFocus;
end;

procedure TF_Precos.SpeedButton3Click(Sender: TObject);
begin
  Panel3.Visible := True;
  Panel3.Repaint;
  MyConsulta(F_Dados.Q_ProcuraProd, 'select * from produto where descricao like' + chr(39) + '%' + EditProcura.text + '%' + chr(39) + ' order by descricao,codigo');
  F_Dados.cds_ProcuraProd.Close;
  F_Dados.cds_ProcuraProd.open;
  Panel3.Visible := False;
  Panel3.Repaint;
end;

procedure TF_Precos.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_Precos.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 112 then begin
    Panel3.Visible := True;
    Panel3.Repaint;
    MyConsulta(F_Dados.Q_ProcuraProd, 'select * from produto where codigo=' + chr(39) + EditProcura.text + '%' + chr(39) + ' order by descricao, codigo');
    F_Dados.cds_ProcuraProd.Close;
    F_Dados.cds_ProcuraProd.open;
    Panel3.Visible := False;
    Panel3.Repaint;
  end;
  if Key = 9 then begin
    EditProcura.SetFocus;
  end;
end;

end.
