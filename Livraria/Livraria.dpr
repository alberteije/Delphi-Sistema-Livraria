program Livraria;

uses
  Forms,
  UBase in 'UBase.pas' {FBase},
  UMenu in 'UMenu.pas' {FMenu},
  U_Dados in 'U_Dados.pas' {F_Dados: TDataModule},
  U_Clientes in 'U_Clientes.pas' {F_Clientes},
  Biblioteca in 'Biblioteca.pas',
  ULogin in 'ULogin.pas' {FLogin},
  U_Fornecedores in 'U_Fornecedores.pas' {F_Fornecedores},
  U_Funcionarios in 'U_Funcionarios.pas' {F_Funcionarios},
  U_Unidades in 'U_Unidades.pas' {F_Unidades},
  U_Livros in 'U_Livros.pas' {F_Livros},
  U_PegaUnd2 in 'U_PegaUnd2.pas' {F_PegaUnd2},
  U_Produtos in 'U_Produtos.pas' {F_Produtos},
  U_Particulares in 'U_Particulares.pas' {F_Particulares},
  U_Bancos in 'U_Bancos.pas' {F_Bancos},
  U_Departamentos in 'U_Departamentos.pas' {F_Departamentos},
  U_Orcamento in 'U_Orcamento.pas' {F_Orcamento},
  U_PegaColegio in 'U_PegaColegio.pas' {F_PegaColegio},
  U_PegaProdutos in 'U_PegaProdutos.pas' {F_PegaProd},
  U_Precos in 'U_Precos.pas' {F_Precos},
  U_Soma in 'U_Soma.pas' {F_Soma},
  U_PegaProd1 in 'U_PegaProd1.pas' {F_PegaProd1},
  U_NC in 'U_NC.pas' {F_NC},
  U_Contas in 'U_Contas.pas' {F_Contas},
  U_DadosNF in 'U_DadosNF.pas' {F_DadosNF},
  U_PegaForn1 in 'U_PegaForn1.pas' {F_PegaForn1},
  U_Outros in 'U_Outros.pas' {F_Outros},
  U_Cheques in 'U_Cheques.pas' {F_Cheques},
  U_PegaConta in 'U_PegaConta.pas' {F_PegaConta},
  U_PegaBanco2 in 'U_PegaBanco2.pas' {F_PegaBanco2},
  U_PegaBanco in 'U_PegaBanco.pas' {F_PegaBanco},
  U_PegaForn in 'U_PegaForn.pas' {F_PegaForn},
  U_aReceber in 'U_aReceber.pas' {F_aReceber},
  U_NFEntrada in 'U_NFEntrada.pas' {F_NFEntrada},
  U_Ajusta in 'U_Ajusta.pas' {F_Ajusta},
  U_NivelAcesso in 'U_NivelAcesso.pas' {F_NivelAcesso};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMenu, FMenu);
  Application.CreateForm(TFBase, FBase);
  Application.CreateForm(TF_Dados, F_Dados);
  Application.Run;
end.
