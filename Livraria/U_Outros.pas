unit U_Outros;

interface

uses

  Windows, Forms, SysUtils, MenBtn, StdCtrls, Buttons, Controls, ExtCtrls,
  Classes, Menus, EditNum, Mask;

type
  TF_Outros = class(TForm)
    ScrollBox1: TScrollBox;
    BitBtn10: TBitBtn;
    ScrollBox2: TScrollBox;
    BitBtn4: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn1: TMenuButton;
    Panel3: TPanel;
    Label5: TLabel;
    datainicio: TMaskEdit;
    Label7: TLabel;
    Edit2: TEdit;
    Edit4: TEdit;
    Label9: TLabel;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    Label3: TLabel;
    MaskEdit2: TMaskEdit;
    Label31: TLabel;
    EditNum18: TEditNum;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
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
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
  private
    { Private declarations }
  public
    Inclui: Integer;
    { Public declarations }
  end;

var
  F_Outros: TF_Outros;

implementation

uses U_Dados;
{$R *.DFM}

Procedure TF_Outros.aguarde;
begin
  Panel3.Visible := True;
  Panel3.BringToFront;
  Panel3.Repaint;
end;

Procedure TF_Outros.pronto;
begin
  Panel3.Visible := False;
  Panel3.SendToBack;
  Panel3.Repaint;
end;

procedure TF_Outros.BitBtn10Click(Sender: TObject);
begin
  Close;
end;

procedure TF_Outros.limpa;
begin
  Edit2.Clear;
  Edit4.Clear;
  datainicio.Clear;
  MaskEdit1.Text := '';
  MaskEdit2.Text := '';
  EditNum18.Text := '0,00';
end;

procedure TF_Outros.grava;
begin
  F_Dados.CDS_APagarhistorico.Value := Edit4.Text;
  F_Dados.CDS_APagarnumero_nf.Value := Edit2.Text;
  F_Dados.CDS_APagarEmissao.AsString := datainicio.Text;
  F_Dados.CDS_APagarEntrada.AsString := MaskEdit1.Text;
  F_Dados.CDS_APagarVencimento.AsString := MaskEdit2.Text;
  F_Dados.CDS_APagartotal_nf.AsString := EditNum18.Text;
  F_Dados.CDS_APagar.Post;
  F_Dados.CDS_APagar.ApplyUpdates(0);
end;

procedure TF_Outros.habilita;
begin
  Edit2.Enabled := True;
  Edit4.Enabled := True;
  datainicio.Enabled := True;
  MaskEdit1.Enabled := True;
  MaskEdit2.Enabled := True;
  EditNum18.Enabled := True;
  BitBtn1.Enabled := False;
  BitBtn10.Enabled := False;
  BitBtn3.Enabled := True;
  BitBtn4.Enabled := True;
end;

procedure TF_Outros.desabilita;
begin
  Edit2.Enabled := False;
  Edit4.Enabled := False;
  datainicio.Enabled := False;
  MaskEdit1.Enabled := False;
  MaskEdit2.Enabled := False;
  EditNum18.Enabled := False;
  BitBtn1.Enabled := True;
  BitBtn10.Enabled := True;
  BitBtn3.Enabled := False;
  BitBtn4.Enabled := False;
end;

procedure TF_Outros.FormActivate(Sender: TObject);
begin
  F_Dados.Q_APagar.Active := False;
  F_Dados.CDS_APagar.Close;
  F_Dados.CDS_APagar.Open;
  //
  Inclui := 0;
  limpa;
  desabilita;
end;

procedure TF_Outros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

procedure TF_Outros.BitBtn4Click(Sender: TObject);
var
  opc: Integer;
begin
  If Edit2.Text = '' then begin
    Application.MessageBox('Não Existe um Pagamento em Andamento para Ser Confirmado', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    opc := Application.MessageBox('Confirma a Entrada do Pagamento?', 'Confirmar a Entrada do Pagamento', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      aguarde;
      If Inclui = 1 then begin
        F_Dados.CDS_APagar.Append;
        grava;
      end
      else if Inclui = 2 then begin
        F_Dados.CDS_APagar.Edit;
        grava;
      end;
      limpa;
      desabilita;
      Inclui := 0;
      pronto;
    end;
  end;
end;

procedure TF_Outros.BitBtn3Click(Sender: TObject);
var
  opc: Integer;
begin
  If Edit2.Text = '' then begin
    Application.MessageBox('Não Existe um Pagamento em Andamento para Ser Cancelado', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    opc := Application.MessageBox('Deseja Cancelar a Entrada do Pagamento Acima?', 'Cancela a Entrada do Pagamento', Mb_YesNo + Mb_IconQuestion);
    If opc = IdYes then begin
      limpa;
      desabilita;
      Inclui := 0;
    end;
  end;
end;

procedure TF_Outros.MenuItem1Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma Entrada' + #13 + 'de Pagamento. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
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

procedure TF_Outros.MenuItem2Click(Sender: TObject);
begin
  If (Inclui = 1) or (Inclui = 2) then begin
    Application.MessageBox('Você já Iniciou ou está Acessando uma Entrada' + #13 + 'de Pagamento. Clique em CONFIRMAR ou CANCELAR', 'Informação do Sistema', Mb_IconInformation);
  end
  else begin
    Inclui := 2;
    limpa;
    habilita;
    Edit2.Enabled := True;
    Edit2.SetFocus;
  end;
end;

procedure TF_Outros.Edit4Exit(Sender: TObject);
begin
  //Exercício: apresente a lista de pagamentos já gravados para que o usuário possa selecionar o que deseja alterar
  if Inclui = 2 then begin
    F_Dados.Q_APagar.Active := False;
    F_Dados.Q_APagar.Sql.Clear;
    F_Dados.Q_APagar.Sql.add('select * from pagar where numero_nf=' + chr(39) + Edit2.Text + chr(39));
    F_Dados.Q_APagar.Sql.add(' and historico=' + chr(39) + Edit4.Text + chr(39));
    F_Dados.Q_APagar.Active := True;
    F_Dados.CDS_APagar.Close;
    F_Dados.CDS_APagar.Open;
    If F_Dados.CDS_APagarnumero_nf.Value <> '' then begin
      Edit4.Text := F_Dados.CDS_APagarFornecedor.Value;
      datainicio.Text := F_Dados.CDS_APagarEmissao.AsString;
      MaskEdit1.Text := F_Dados.CDS_APagarEntrada.AsString;
      MaskEdit2.Text := F_Dados.CDS_APagarVencimento.AsString;
      EditNum18.Text := F_Dados.CDS_APagartotal_nf.AsString;
      //
      Edit2.Enabled := False;
    end
    else begin
      If Edit2.Text <> '' then begin
        Application.MessageBox('O Pagamento não foi Localizado', 'Informação do Sistema', Mb_IconInformation);
        limpa;
        desabilita;
        Edit2.Enabled := False;
        Inclui := 0;
      end
      else begin
        Inclui := 0;
        desabilita;
      end;
    end;
  end;
  if Edit2.Text = '' then
    desabilita;
end;

end.
