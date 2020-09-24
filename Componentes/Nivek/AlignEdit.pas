unit AlignEdit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TAlignEdit = class(TEdit)
  private
    { Private declarations }
    FAlignment: TAlignment;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SetAlignment(Value: TAlignment);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  published
    { Published declarations }
    property Alignment: TAlignment read FAlignment
                    write SetAlignment default taLeftJustify;
  end;

procedure Register;

implementation

constructor TAlignEdit.Create(AOwner: TComponent);
begin
  FAlignment:= taLeftJustify;
  inherited create(AOwner);
end;

procedure TAlignEdit.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    RecreateWnd;
  end;
end;

procedure TAlignEdit.CreateParams(var Params: TCreateParams);
const
  Alignments: array[TAlignment] of Longint = (ES_LEFT, ES_RIGHT, ES_CENTER);
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'EDIT');
  Params.Style := Params.Style and not (ES_AUTOVSCROLL or ES_AUTOHSCROLL) or ES_MULTILINE or Alignments[FAlignment] ;
end;

procedure Register;
begin
  RegisterComponents('Samples', [TAlignEdit]);
end;

end.
