unit untCategorias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, classCategoria, DataModule.Principal, FireDAC.Comp.Client, Data.DB,
  uListViewLoader;

type
  TfrmCategorias = class(TForm)
    Rectangle1: TRectangle;
    imgAdd: TImage;
    lblQtdCat: TLabel;
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
    procedure ListarCategorias;
    { Public declarations }
  end;

var
  frmCategorias: TfrmCategorias;

implementation

{$R *.fmx}

uses untPrincipal, untCategoriasCad;

procedure TfrmCategorias.ListarCategorias;
var
  cat : TCategoria;
  qry: TFDQuery;
  erro: string;
  icone: TStream;
  i: Integer;
begin
  lvCategorias.Items.Clear;

  try
    cat := TCategoria.Create(DMPrincipal.FDConn);
    qry := cat.ListarCategoria(erro);

    qry.First;
    for i := 0 to qry.RecordCount - 1 do
      begin
        if qry.FieldByName('ICONE').AsString <> '' then
          icone := qry.CreateBlobStream(qry.FieldByName('ICONE'), TBlobStreamMode.bmRead)
        else
          icone := nil;

        TListViewLoader.AddCategoriaLv(lvCategorias,
                                       qry.FieldByName('ID_CATEGORIA').AsInteger,
                                       qry.FieldByName('DESCRICAO').AsString,
                                       icone);

        if icone <> nil then
          icone.DisposeOf;

        qry.Next;
      end;

    lblQtdCat.Text := lvCategorias.Items.Count.ToString + ' categoria(s)';
  finally
    qry.DisposeOf;
    cat.DisposeOf;
  end;
end;

procedure TfrmCategorias.CadCategorias(id: integer);
begin
  if NOT Assigned(frmCategoriaCad) then
    Application.CreateForm(TfrmCategoriaCad, frmCategoriaCad);

  frmCategoriaCad.id_cat := id;

  if id = 0 then
    begin
      frmCategoriaCad.modo := 'I';
      frmCategoriaCad.lblTitle.Text := 'Nova Categoria';
    end
  else
    begin
      frmCategoriaCad.modo := 'A';
      frmCategoriaCad.lblTitle.Text := 'Alterar Categoria';
    end;

  frmCategoriaCad.Show;
end;

procedure TfrmCategorias.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmCategorias := nil;
end;

procedure TfrmCategorias.FormShow(Sender: TObject);
begin
  ListarCategorias;
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
  CadCategorias(AItem.Tag);
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
