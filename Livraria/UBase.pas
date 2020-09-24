unit UBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvArrowButton, Buttons, JvPageList, Rtti, ActnList,
  ComCtrls;

type
  TFBase = class(TForm)
  private
    //function GetSessaoUsuario: TSessaoUsuario;
    function GetCustomKeyPreview: Boolean;
    procedure SetCustomKeyPreview(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }

    procedure FechaFormulario;
    property CustomKeyPreview: Boolean read GetCustomKeyPreview write SetCustomKeyPreview default False;
  end;

var
  FBase: TFBase;

implementation

uses
  UMenu;

{$R *.dfm}

{ TFBase }

procedure TFBase.FechaFormulario;
begin
  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
    FMenu.FecharPagina(TJvStandardPage(Self.Owner))
  else
    Self.Close;
end;

function TFBase.GetCustomKeyPreview: Boolean;
begin
  Result := Self.KeyPreview;
end;

procedure TFBase.SetCustomKeyPreview(const Value: Boolean);
begin
  Self.KeyPreview := Value;

  if (Self.Owner is TJvStandardPage) and (Assigned(FMenu)) then
  begin
    FMenu.KeyPreview := Value;
  end;
end;


end.
