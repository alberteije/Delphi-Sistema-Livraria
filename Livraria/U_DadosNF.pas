unit U_DadosNF;

interface

uses

  Windows, SysUtils, Forms, EditNum, Mask, Menus, MenBtn, Grids, DBGrids, StdCtrls,
  Buttons, ExtCtrls, Controls, Classes, Biblioteca;

type
  TF_DadosNF = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn10: TBitBtn;
    ScrollBox2: TScrollBox;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TMenuButton;
    Panel3: TPanel;
    Label5: TLabel;
    Edit3: TEdit;
    datainicio: TMaskEdit;
    Label7: TLabel;
    Edit2: TEdit;
    Edit4: TEdit;
    Label9: TLabel;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    Label3: TLabel;
    MaskEdit2: TMaskEdit;
    Label19: TLabel;
    EditNum17: TEditNum;
    Label31: TLabel;
    EditNum18: TEditNum;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Label4: TLabel;
    EditNum1: TEditNum;
    DBGrid1: TDBGrid;
    procedure aguarde;
    procedure pronto;
    procedure habilita;
    procedure desabilita;
    procedure limpa;
    procedure grava;
    procedure BitBtn10Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit3DblClick(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure EditNum18Enter(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    Inclui: Integer;
    { Public declarations }
  end;

var
  F_DadosNF: TF_DadosNF;

implementation

uses U_Dados, U_PegaForn1;
{$R *.DFM}

Procedure TF_DadosNF.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_DadosNF.pronto;
begin
  Panel3.Visible := False;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

procedure TF_DadosNF.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_DadosNF.limpa;
begin
  Edit2.Clear;
  Edit3.Clear;
  Edit4.Clear;
  datainicio.Clear;
  MaskEdit1.Text := '';
  MaskEdit2.Text := '';
  EditNum17.Text := '0,00';
  EditNum18.Text := '0,00';
end;

procedure TF_DadosNF.grava;
begin
  F_Dados.CDS_APagarid_fornecedor.AsString := Edit3.Text;
  F_Dados.CDS_APagarhistorico.AsString := Edit4.Text;
  F_Dados.CDS_APagarnumero_nf.AsString := Edit2.Text;
  F_Dados.CDS_APagarEmissao.AsString := datainicio.Text;
  F_Dados.CDS_APagarEntrada.AsString := MaskEdit1.Text;
  F_Dados.CDS_APagarVencimento.AsString := MaskEdit2.Text;
  F_Dados.CDS_APagartotal_produtos.AsString := EditNum17.Text;
  F_Dados.CDS_APagartotal_nf.AsString := EditNum18.Text;
  F_Dados.CDS_APagarnumero_pedido.AsString := 'SEM-PEDIDO';
  F_Dados.CDS_APagar.Post;
  F_Dados.CDS_APagar.ApplyUpdates(0);
end;

procedure TF_DadosNF.habilita;
begin
  Edit2.Enabled := True;
  Edit3.Enabled := True;
  datainicio.Enabled := True;
  MaskEdit1.Enabled := True;
  MaskEdit2.Enabled := True;
  EditNum17.Enabled := True;
  EditNum18.Enabled := True;
  BitBtn1.Enabled := False;
  BitBtn10.Enabled := False;
  BitBtn3.Enabled := True;
  BitBtn4.Enabled := True;
end;

procedure TF_DadosNF.desabilita;
begin
  Edit2.Enabled := False;
  Edit3.Enabled := False;
  datainicio.Enabled := False;
  MaskEdit1.Enabled := False;
  MaskEdit2.Enabled := False;
  EditNum17.Enabled := False;
  EditNum18.Enabled := False;
  BitBtn1.Enabled := True;
  BitBtn10.Enabled := True;
  BitBtn3.Enabled := False;
  BitBtn4.Enabled := False;
end;

procedure TF_DadosNF.FormActivate(Sender: TObject);
begin
  F_Dados.Q_APagar.Active := True;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
  //
  Inclui := 0;
  limpa;
  desabilita;
end;

procedure TF_DadosNF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_DadosNF.BitBtn4Click(Sender: TObject);
var
  opc: Integer;
  vlrnf, vari: double;
begin
  If Edit2.Text = '' then begin
    Application.MessageBox('Não Existe uma Entrada de NF em Andamento para Ser Confirmada', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    opc := Application.MessageBox('Confirma a Entrada da NF?', 'Confirmar a Entrada da NF', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      aguarde;
      if EditNum1.Text <> '1' then begin
        vari := 0;
        vlrnf := StrToFloat(EditNum18.Text) / StrToFloat(EditNum1.Text);
        While vari < StrToFloat(EditNum1.Text) do begin
          vari := vari + 1;
          F_Dados.CDS_APagar.Append;
          F_Dados.CDS_APagarid_fornecedor.AsString := Edit3.Text;
          F_Dados.CDS_APagarhistorico.AsString := Edit4.Text;
          F_Dados.CDS_APagarnumero_nf.AsString := Edit2.Text;
          F_Dados.CDS_APagarEmissao.AsString := datainicio.Text;
          F_Dados.CDS_APagarEntrada.AsString := MaskEdit1.Text;
          F_Dados.CDS_APagartotal_produtos.AsString := EditNum17.Text;
          F_Dados.CDS_APagartotal_nf.Value := vlrnf;
          F_Dados.CDS_APagarVencimento.Value := StrToDate(MaskEdit2.Text) + ((vari * 30) - 30);
          F_Dados.CDS_APagar.Post;
          F_Dados.CDS_APagar.ApplyUpdates(0);
          if vari = StrToFloat(EditNum1.Text) then begin
            pronto;
            desabilita;
            Inclui := 0;
            break;
          end;
        end;
        F_Dados.Q_APagar.Active := False;
        F_Dados.Q_APagar.Sql.Clear;
        F_Dados.Q_APagar.Sql.add('select * from pagar where numero_nf=' + chr(39) + Edit2.Text + chr(39));
        F_Dados.Q_APagar.Sql.add('and id_fornecedor=' + chr(39) + Edit3.Text + chr(39));
        F_Dados.Q_APagar.Active := True;
        F_Dados.CDS_APagar.Close;
        F_Dados.CDS_APagar.Open;
        DBGrid1.Visible := True;
        DBGrid1.SetFocus;
        limpa;
      end
      else begin
        If Inclui = 1 then begin
          F_Dados.CDS_APagar.Append;
          grava;
        end
        else if Inclui = 2 then begin
          F_Dados.CDS_APagar.Edit;
          grava;
        end;
        F_Dados.Q_APagar.Active := False;
        F_Dados.Q_APagar.Sql.Clear;
        F_Dados.Q_APagar.Sql.add('select * from pagar where numero_nf=' + chr(39) + Edit2.Text + chr(39));
        F_Dados.Q_APagar.Sql.add('and id_fornecedor=' + chr(39) + Edit3.Text + chr(39));
        F_Dados.Q_APagar.Active := True;
        F_Dados.CDS_APagar.Close;
        F_Dados.CDS_APagar.Open;
        DBGrid1.Visible := True;
        DBGrid1.SetFocus;
        limpa;
        desabilita;
        Inclui := 0;
        pronto;
      end;
    end;
  end;
end;

procedure TF_DadosNF.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then begin
    DBGrid1.Visible := False;
    BitBtn10.SetFocus;
  end;
end;

procedure TF_DadosNF.BitBtn3Click(Sender: TObject);
var
  opc: Integer;
begin
  If Edit2.Text = '' then begin
    Application.MessageBox('Não Existe uma Entrada de NF em Andamento para Ser Cancelada', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    opc := Application.MessageBox('Deseja Cancelar a Entrada de NF Acima?', 'Cancela a Entrada de NF', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      limpa;
      desabilita;
      Inclui := 0;
    end;
  end;
end;

procedure TF_DadosNF.Edit3DblClick(Sender: TObject);
begin
  Application.CreateForm(TF_PegaForn1, F_PegaForn1);
  F_PegaForn1.ShowModal;
end;

procedure TF_DadosNF.Edit3Exit(Sender: TObject);
begin
  If Edit3.Text <> '' then begin
    Edit3.Text := StringOfChar('0', 4 - Length(Edit3.Text)) + Edit3.Text;
    MyConsulta(F_Dados.Q_Fornecedor, 'select * from fornecedor where id=' + #39 + Edit3.Text + #39);
    If F_Dados.Q_FornecedorId.AsString = '' then begin
      Application.MessageBox('O Código Inserido não Está Cadastrado', 'Informação do Sistema', Mb_IconInformation);
      Edit3.Clear;
      Edit4.Clear;
      Edit3.SetFocus;
    end
    else begin
      if Inclui = 2 then begin
        F_Dados.Q_APagar.Active := False;
        F_Dados.Q_APagar.Sql.Clear;
        F_Dados.Q_APagar.Sql.add('select * from pagar where numero_nf=' + chr(39) + Edit2.Text + chr(39));
        F_Dados.Q_APagar.Sql.add('and id_fornecedor=' + chr(39) + Edit3.Text + chr(39));
        F_Dados.Q_APagar.Active := True;
        F_Dados.CDS_APagar.Close;
        F_Dados.CDS_APagar.Open;
        If F_Dados.CDS_APagarnumero_nf.Value <> '' then begin
          Edit3.Text := F_Dados.CDS_APagarid_fornecedor.AsString;
          Edit4.Text := F_Dados.CDS_APagarhistorico.AsString;
          Edit2.Text := F_Dados.CDS_APagarnumero_nf.Value;
          datainicio.Text := F_Dados.CDS_APagarEmissao.AsString;
          MaskEdit1.Text := F_Dados.CDS_APagarEntrada.AsString;
          MaskEdit2.Text := F_Dados.CDS_APagarVencimento.AsString;
          EditNum17.Text := F_Dados.CDS_APagartotal_produtos.AsString;
          EditNum18.Text := F_Dados.CDS_APagartotal_nf.AsString;
          //
          Edit2.Enabled := False;
        end
        else begin
          Application.MessageBox('O Número Acima Não Existe', 'Informação do Sistema', Mb_IconInformation);
          limpa;
          desabilita;
          Edit2.Enabled := False;
          Inclui := 0;
        end;
      end
      else begin
        Edit4.Text := F_Dados.Q_FornecedorRazao.Value;
        datainicio.SetFocus;
      end;
    end;
  end
  else
    Edit4.Text := '';
end;

procedure TF_DadosNF.MenuItem1Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma Entrada' + #13 + 'de Nota Fiscal. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    Inclui := 1;
    limpa;
    habilita;
    Edit2.Enabled := True;
    Edit2.SetFocus;
    datainicio.Text := DateToStr(Date);
    MaskEdit1.Text := DateToStr(Date);
    MaskEdit2.Text := DateToStr(Date);
  end;
end;

procedure TF_DadosNF.MenuItem2Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma Entrada' + #13 + 'de Nota Fiscal. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    Inclui := 2;
    limpa;
    habilita;
    Edit2.Enabled := True;
    Edit2.SetFocus;
  end;
end;

procedure TF_DadosNF.EditNum18Enter(Sender: TObject);
begin
  EditNum18.Text := EditNum17.Text;
end;

end.
