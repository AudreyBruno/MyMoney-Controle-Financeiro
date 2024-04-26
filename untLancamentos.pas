unit untLancamentos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmLancamentos = class(TForm)
    Layout1: TLayout;
    imgBack: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    imgPrev: TImage;
    imgNext: TImage;
    RoundRect1: TRoundRect;
    lblMes: TLabel;
    Rectangle1: TRectangle;
    Image1: TImage;
    Layout3: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    lvLancamentos: TListView;
    procedure imgBackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvLancamentosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLancamentos: TfrmLancamentos;

implementation

uses untPrincipal;

{$R *.fmx}

procedure TfrmLancamentos.FormShow(Sender: TObject);

var
  foto: TStream;
  i: Integer;
begin
  foto := TMemoryStream.Create;
  frmPrincipal.imgCategoria.Bitmap.SaveToStream(foto);
  foto.Position := 0;

  for i := 1 to 10 do
    frmPrincipal.AddLancamentosLv(frmLancamentos.lvLancamentos, 1, 'Compra de Passagem', 'Transporte', -50, foto, Date);

  foto.DisposeOf;
end;

procedure TfrmLancamentos.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLancamentos.lvLancamentosUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  txt := TListItemText(AItem.Objects.FindDrawable('txtDescricao'));
  txt.Width := lvLancamentos.Width - txt.PlaceOffset.X - 110;
end;

end.