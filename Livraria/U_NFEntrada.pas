unit U_NFEntrada;

interface

uses

  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, StdCtrls, ExtCtrls, EditNum, DBCGrids, Mask, DBCtrls,
  Grids, DBGrids, MenBtn, Menus, ComCtrls, Db, DBTables, Biblioteca;

type
  TF_NFEntrada = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn10: TBitBtn;
    ScrollBox2: TScrollBox;
    Label4: TLabel;
    Label1: TLabel;
    EditNum2: TEditNum;
    Edit1: TEdit;
    BitBtn14: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    DBGrid1: TDBGrid;
    Label13: TLabel;
    Label2: TLabel;
    opcoes2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    BitBtn1: TMenuButton;
    Panel3: TPanel;
    Label5: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    MaskEdit5: TMaskEdit;
    Label6: TLabel;
    datainicio: TMaskEdit;
    MaskEdit1: TMaskEdit;
    Label3: TLabel;
    Label7: TLabel;
    Edit2: TEdit;
    procedure aguarde;
    procedure pronto;
    procedure pegaitensNF;
    procedure habilita;
    procedure desabilita;
    procedure limpa;
    procedure grava;
    procedure grava_cabecalho;
    procedure BitBtn10Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure EditNum2Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    { Private declarations }
  public
    Inclui: Integer;
    { Public declarations }
  end;

var
  F_NFEntrada: TF_NFEntrada;

implementation

uses U_Dados, U_PegaProdutos, U_PegaForn;
{$R *.DFM}

Procedure TF_NFEntrada.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_NFEntrada.pronto;
begin
  Panel3.Visible := False;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

procedure TF_NFEntrada.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_NFEntrada.limpa;
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  datainicio.Clear;
  MaskEdit1.Clear;
  MaskEdit5.Clear;
  EditNum2.Text := '0,00';
end;

procedure TF_NFEntrada.pegaitensNF;
begin
  F_Dados.Q_ItensNF.Active := False;
  F_Dados.Q_ItensNF.Sql.Clear;
  F_Dados.Q_ItensNF.Sql.add('select * from nf_entrada_detalhe where id_nf_entrada_cabecalho=' + chr(39) + Edit2.Text + chr(39));
  F_Dados.Q_ItensNF.Sql.add('order by descricao');
  F_Dados.Q_ItensNF.Active := True;
  F_Dados.cds_ItensNF.Close;
  F_Dados.cds_ItensNF.open;
end;

procedure TF_NFEntrada.grava;
begin
  F_Dados.cds_ItensNF.applyupdates(0);
  grava_cabecalho;
end;

procedure TF_NFEntrada.grava_cabecalho;
begin
  F_Dados.cds_NFEntradaid.AsString := Edit2.Text;
  F_Dados.cds_NFEntradaid_fornecedor.AsString := Edit3.Text;
  F_Dados.cds_NFEntradanome_fornecedor.Value := Edit4.Text;
  F_Dados.cds_NFEntradacnpj_fornecedor.Value := MaskEdit5.Text;
  F_Dados.cds_NFEntradanumero_nf.Value := Edit1.Text;
  F_Dados.cds_NFEntradatotal_nf.AsString := EditNum2.Text;
  if datainicio.Text <> '  /  /    ' then
    F_Dados.cds_NFEntradadata_emissao.AsString := datainicio.Text;
  if MaskEdit1.Text <> '  /  /    ' then
    F_Dados.cds_NFEntradadata_entrada.AsString := MaskEdit1.Text;
  F_Dados.cds_NFEntrada.Post;
  F_Dados.cds_NFEntrada.applyupdates(0);
end;

procedure TF_NFEntrada.habilita;
begin
  Edit1.Enabled := True;
  Edit2.Enabled := True;
  Edit3.Enabled := True;
  Edit4.Enabled := True;
  EditNum2.Enabled := True;
  MaskEdit1.Enabled := True;
  MaskEdit5.Enabled := True;
  datainicio.Enabled := True;
  BitBtn1.Enabled := False;
  BitBtn10.Enabled := False;
  BitBtn3.Enabled := True;
  BitBtn4.Enabled := True;
  BitBtn14.Enabled := True;
end;

procedure TF_NFEntrada.desabilita;
begin
  Edit1.Enabled := False;
  Edit2.Enabled := False;
  Edit3.Enabled := False;
  Edit4.Enabled := False;
  EditNum2.Enabled := False;
  MaskEdit1.Enabled := False;
  MaskEdit5.Enabled := False;
  datainicio.Enabled := False;
  BitBtn1.Enabled := True;
  BitBtn10.Enabled := True;
  BitBtn3.Enabled := False;
  BitBtn4.Enabled := False;
  BitBtn14.Enabled := False;
end;

procedure TF_NFEntrada.FormActivate(Sender: TObject);
begin
  Inclui := 0;
  limpa;
  pegaitensNF;
  desabilita;
  F_Dados.cds_NFEntrada.Close;
  F_Dados.cds_NFEntrada.open;
end;

procedure TF_NFEntrada.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If F_Dados.cds_ItensNF.State in [dsEdit, dsInsert] then
  begin
    F_Dados.cds_ItensNF.Post;
    F_Dados.cds_ItensNF.applyupdates(0);
  end;
  F_Dados.Q_NFEntrada.Close;
  Release;
end;

procedure TF_NFEntrada.BitBtn4Click(Sender: TObject);
var
  opc: Integer;
begin
  If Edit2.Text = '' then begin
    Application.MessageBox('Não Existe uma Nota em Andamento para Ser Confirmada', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    opc := Application.MessageBox('Confirma a Entrada da Nota?', 'Confirmar a Entrada da Nota', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      If F_Dados.cds_ItensNF.State in [dsEdit, dsInsert] then
      begin
        F_Dados.cds_ItensNF.Post;
        F_Dados.cds_ItensNF.applyupdates(0);
      end;
      If Inclui = 1 then begin
        F_Dados.cds_NFEntrada.Append;
        grava;
      end
      else if Inclui = 2 then begin
        F_Dados.cds_NFEntrada.Edit;
        grava;
      end;
      limpa;
      desabilita;
      pegaitensNF;
      Inclui := 0;
    end;
  end;
end;

procedure TF_NFEntrada.BitBtn14Click(Sender: TObject);
var
  opc: Integer;
begin
  if F_Dados.cds_ItensNFCodigo.Value <> '' then begin
    opc := Application.MessageBox('Confirma Exclusão?', 'Exclusão de Registros', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then
    begin
      F_Dados.cds_ItensNF.Delete;
      F_Dados.cds_ItensNF.applyupdates(0);
    end;
  end
  else begin
    Application.MessageBox('Não Existem Ítens para Serem Excluídos', 'Informação do Sistema', Mb_IconInformation);
  end;
end;

procedure TF_NFEntrada.BitBtn3Click(Sender: TObject);
var
  opc: Integer;
begin
  If Edit2.Text = '' then begin
    Application.MessageBox('Não Existe uma Nota em Andamento para Ser Cancelada', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    opc := Application.MessageBox('Deseja Cancelar a Entrada da Nota Acima?', 'Cancela a Entrada da Nota', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      limpa;
      desabilita;
      pegaitensNF;
      Inclui := 0;
    end;
  end;
end;

procedure TF_NFEntrada.DBGrid1DblClick(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) then begin
    Application.CreateForm(TF_PegaProd, F_PegaProd);
    F_PegaProd.QuemChamou := 'NF';
    F_PegaProd.ShowModal
  end
  else
    Application.MessageBox('Não Existe uma Nota em Andamento', 'Informação do Sistema', Mb_IconInformation);
end;

procedure TF_NFEntrada.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = Vk_Return then
    DBGrid1.SelectedIndex := DBGrid1.SelectedIndex + 1;
end;

procedure TF_NFEntrada.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  If Key = 113 then begin // ok
    WinExec('C:\Windows\Calc.Exe', 1)
  end;
  //
  If Key = 115 then begin // ok
    If (Inclui = 1) or (Inclui = 2) then begin
      Application.CreateForm(TF_PegaProd, F_PegaProd);
      F_PegaProd.QuemChamou := 'NF';
      F_PegaProd.ShowModal;
    end
    else
      Application.MessageBox('Não Existe uma Nota em Andamento', 'Informação do Sistema', Mb_IconInformation);
  end;
end;

procedure TF_NFEntrada.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  If Key = '.' then
    Key := #44;
end;

procedure TF_NFEntrada.MenuItem1Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma ' + #13 + 'Nota. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    Inclui := 1;
    limpa;

    //Exercício: para realizar o controle de numeração das notas em rede, estamos
    //inserindo um registro numa tabela que controla apenas isso. Pense numa melhor
    //maneira de realizar tal controle.
    F_Dados.Conexao.AutoClone := False;
    F_Dados.Q_Rap.Active := False;
    F_Dados.Q_Rap.Sql.Clear;
    F_Dados.Q_Rap.Sql.add('insert into minutas() values ()');
    F_Dados.Q_Rap.ExecSql();

    F_Dados.Q_Rap.Active := False;
    F_Dados.Q_Rap.Sql.Clear;
    F_Dados.Q_Rap.Sql.add('select LAST_INSERT_ID() as id');
    F_Dados.Q_Rap.Open();
    F_Dados.Conexao.AutoClone := True;
    //
    Edit2.Text := StringOfChar('0', 10 - Length(F_Dados.Q_Rap.FieldByName('id').AsString)) + F_Dados.Q_Rap.FieldByName('id').AsString;
    F_Dados.cds_NFEntrada.Append;
    grava_cabecalho;
    //
    MyConsulta(F_Dados.Q_NFEntrada, 'select * from nf_entrada_cabecalho where id=' + chr(39) + Edit2.text + chr(39));
    F_Dados.cds_NFEntrada.Close;
    F_Dados.cds_NFEntrada.Open;
    //
    pegaitensNF;
    habilita;
    Edit2.Enabled := False;
    Edit3.SetFocus;
    MaskEdit1.Text := DateToStr(Now);
    datainicio.Text := DateToStr(Now);
  end;
end;

procedure TF_NFEntrada.MenuItem2Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma ' + #13 + 'Nota. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    limpa;
    pegaitensNF;
    habilita;
    Edit2.Enabled := True;
    Edit2.SetFocus;
  end;
end;

procedure TF_NFEntrada.Edit2Exit(Sender: TObject);
begin
  Edit2.Text := StringOfChar('0', 10 - Length(Edit2.Text)) + Edit2.Text;
  //
  F_Dados.Q_NFEntrada.Active := False;
  F_Dados.Q_NFEntrada.Sql.Clear;
  F_Dados.Q_NFEntrada.Sql.add('select * from nf_entrada_cabecalho where id=' + chr(39) + Edit2.Text + chr(39));
  F_Dados.Q_NFEntrada.Active := True;
  F_Dados.cds_NFEntrada.Close;
  F_Dados.cds_NFEntrada.open;
  If F_Dados.Q_NFEntradaid.AsString <> '' then begin
    Inclui := 2;
    Edit3.Text := F_Dados.Q_NFEntradaid_fornecedor.AsString;
    Edit4.Text := F_Dados.Q_NFEntradanome_fornecedor.Value;
    MaskEdit5.Text := F_Dados.Q_NFEntradacnpj_fornecedor.Value;
    Edit1.Text := F_Dados.Q_NFEntradanumero_nf.Value;
    EditNum2.Text := F_Dados.Q_NFEntradatotal_nf.AsString;
    datainicio.Text := F_Dados.Q_NFEntradadata_emissao.AsString;
    MaskEdit1.Text := F_Dados.Q_NFEntradadata_entrada.AsString;
    //
    pegaitensNF;
    Edit2.Enabled := False;
  end
  else begin
    If Edit2.Text <> '' then begin
      Application.MessageBox('O Codigo Acima Não Existe', 'Informação do Sistema', Mb_IconInformation);
      limpa;
      desabilita;
      Edit2.Enabled := False;
    end
    else begin
      desabilita;
    end;
  end;
end;

procedure TF_NFEntrada.EditNum2Exit(Sender: TObject);
begin
  DBGrid1.SetFocus;
end;

procedure TF_NFEntrada.Edit3DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaForn, F_PegaForn);
  F_PegaForn.ShowModal;
end;

procedure TF_NFEntrada.Edit3Exit(Sender: TObject);
begin
  Edit3.Text := StringOfChar('0', 4 - Length(Edit3.Text)) + Edit3.Text;
  If Edit3.Text <> '' then begin
    F_Dados.Q_Fornecedor.Active := False;
    F_Dados.Q_Fornecedor.Sql.Clear;
    F_Dados.Q_Fornecedor.Sql.add('select * from fornecedor where id=' + chr(39) + Edit3.Text + chr(39));
    F_Dados.Q_Fornecedor.Active := True;
    If F_Dados.Q_FornecedorId.AsString = '' then begin
      Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
      Edit3.Clear;
      Edit4.Clear;
      Edit3.SetFocus;
    end
    else begin
      Edit4.Text := F_Dados.Q_FornecedorRazao.Value;
      MaskEdit5.Text := F_Dados.Q_Fornecedorcnpj.Value;
      MaskEdit5.SetFocus;
    end;
  end
  else
    Edit4.Text := '';
end;

end.
