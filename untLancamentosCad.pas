unit untLancamentosCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, untPrincipal, FMX.Edit,
  FMX.DateTimeCtrls;

type
  TfrmLancamentosCad = class(TForm)
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout1: TLayout;
    Label1: TLabel;
    imgBack: TImage;
    imgSave: TImage;
    Layout2: TLayout;
    Label2: TLabel;
    edtDescricao: TEdit;
    Layout3: TLayout;
    Label3: TLabel;
    edtValor: TEdit;
    Line1: TLine;
    Line2: TLine;
    Layout4: TLayout;
    Label4: TLabel;
    Edit3: TEdit;
    Line3: TLine;
    Layout5: TLayout;
    Label5: TLabel;
    Line4: TLine;
    Image2: TImage;
    Image3: TImage;
    edtDate: TDateEdit;
    imgTipoLanc: TImage;
    imgDespesa: TImage;
    imgReceita: TImage;
    procedure imgBackClick(Sender: TObject);
    procedure imgTipoLancClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLancamentosCad: TfrmLancamentosCad;

implementation

{$R *.fmx}

procedure TfrmLancamentosCad.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLancamentosCad.imgTipoLancClick(Sender: TObject);
begin
  if imgTipoLanc.Tag = 1 then
    begin
      imgTipoLanc.Bitmap := imgDespesa.Bitmap;
      imgTipoLanc.Tag := -1;
    end
  else
    begin
      imgTipoLanc.Bitmap := imgReceita.Bitmap;
      imgTipoLanc.Tag := 1;
    end;
end;

end.
