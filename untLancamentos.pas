unit untLancamentos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  uListViewLoader;

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
    imgAdd: TImage;
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
    procedure lvLancamentosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure imgAddClick(Sender: TObject);
  private
    procedure EditarLançamentos(id: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLancamentos: TfrmLancamentos;

implementation

uses untPrincipal, untLancamentosCad;

{$R *.fmx}

procedure TfrmLancamentos.EditarLançamentos(id: integer);
begin
  if NOT Assigned(frmLancamentosCad) then
    Application.CreateForm(TfrmLancamentosCad, frmLancamentosCad);

  frmLancamentosCad.Show;
end;

procedure TfrmLancamentos.FormShow(Sender: TObject);

var
  foto: TStream;
  i: Integer;
begin
  foto := TMemoryStream.Create;
  frmPrincipal.imgCategoria.Bitmap.SaveToStream(foto);
  foto.Position := 0;

  for i := 1 to 10 do
    TListViewLoader.AddLancamentosLv(lvLancamentos, 1, 'Compra', 'Teste', -50, foto, Date);

  foto.DisposeOf;
end;

procedure TfrmLancamentos.imgAddClick(Sender: TObject);
begin
  EditarLançamentos(0);
end;

procedure TfrmLancamentos.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLancamentos.lvLancamentosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  EditarLançamentos(AItem.Tag);
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
