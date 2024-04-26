unit untCategorias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TfrmCategorias = class(TForm)
    Rectangle1: TRectangle;
    imgAdd: TImage;
    Label6: TLabel;
    Layout1: TLayout;
    Label1: TLabel;
    imgBack: TImage;
    lvCategorias: TListView;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure imgBackClick(Sender: TObject);
    procedure lvCategoriasUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormShow(Sender: TObject);
    procedure imgAddClick(Sender: TObject);
    procedure lvCategoriasItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    procedure CadCategorias(id: integer);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCategorias: TfrmCategorias;

implementation

{$R *.fmx}

uses untPrincipal, untCategoriasCad;

procedure TfrmCategorias.CadCategorias(id: integer);
begin
  if NOT Assigned(frmCategoriaCad) then
    Application.CreateForm(TfrmCategoriaCad, frmCategoriaCad);

  if id = 0 then
    frmCategoriaCad.lblTitle.Text := 'Nova Categoria'
  else
    frmCategoriaCad.lblTitle.Text := 'Alterar Categoria';

  frmCategoriaCad.Show;
end;

procedure TfrmCategorias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmCategorias := nil;
end;

procedure TfrmCategorias.FormShow(Sender: TObject);
var
  foto: TStream;
  i: Integer;
begin
  foto := TMemoryStream.Create;
  frmPrincipal.imgCategoria.Bitmap.SaveToStream(foto);
  foto.Position := 0;

  for i := 1 to 10 do
    frmPrincipal.AddCategoriaLv(lvCategorias, 1, 'CategoriaTeste', foto);

  foto.DisposeOf;
end;

procedure TfrmCategorias.imgAddClick(Sender: TObject);
begin
  CadCategorias(0);
end;

procedure TfrmCategorias.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCategorias.lvCategoriasItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  CadCategorias(1);
end;

procedure TfrmCategorias.lvCategoriasUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
var
  txt: TListItemText;
begin
  txt := TListItemText(AItem.Objects.FindDrawable('txtDescricao'));
  txt.Width := lvCategorias.Width - txt.PlaceOffset.X - 20;
end;

end.
