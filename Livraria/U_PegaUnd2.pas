unit U_PegaUnd2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, DBCtrls, Grids, DBGrids, ExtCtrls, Db, DBTables;

type
  TF_PegaUnd2 = class(TForm)
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_PegaUnd2: TF_PegaUnd2;

implementation

uses U_Dados, U_Livros;
{$R *.DFM}

procedure TF_PegaUnd2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     Release;
end;

procedure TF_PegaUnd2.BitBtn1Click(Sender: TObject);
begin
     Close;
end;

procedure TF_PegaUnd2.BitBtn2Click(Sender: TObject);
begin
     Close;
end;

procedure TF_PegaUnd2.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
     if Key=#13 then
        BitBtn1Click(Sender);
end;

procedure TF_PegaUnd2.FormCreate(Sender: TObject);
begin
	F_Dados.CDS_Unidade.Close;
	F_Dados.CDS_Unidade.Open;
end;

procedure TF_PegaUnd2.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_F12 then
    BitBtn1.Click;
  if key = VK_ESCAPE then
    BitBtn2.Click;
end;

end.
