unit uListViewLoader;

interface

uses
  FMX.ListView.Types, FMX.Graphics, FMX.ListView, System.Classes,
  System.SysUtils;

type
  TListViewLoader = class
  private
  public
    class procedure AddLancamentosLv(listview: TListView;
      id_lancamento: Integer; descricao, categoria: string; valor: double;
      foto: TStream; dt: TDateTime); static;
    class procedure AddCategoriaLv(listview: TListView;
                                               id_categoria: Integer;
                                               descricao, resumo: string;
                                               valor: double;
                                               foto: TStream);
end;

implementation

class procedure TListViewLoader.AddLancamentosLv(listview: TListView;
                                                 id_lancamento: Integer;
                                                 descricao, categoria: string;
                                                 valor: double; foto: TStream;
                                                 dt: TDateTime);
var
  txt: TListItemText;
  img: TListItemImage;
  bmp : TBitmap;
begin
  with listview.Items.Add do
    begin
      Height := 55;
      Tag := id_lancamento;

      txt := TListItemText(Objects.FindDrawable('txtDescricao'));
      txt.Text := descricao;

      txt := TListItemText(Objects.FindDrawable('txtCategoria'));
      txt.Text := categoria;

      txt := TListItemText(Objects.FindDrawable('txtData'));
      txt.Text := FormatDateTime('dd/mm', dt);

      txt := TListItemText(Objects.FindDrawable('txtValor'));
      txt.Text := FormatFloat('#,##0.00', valor);

      img := TListItemImage(Objects.FindDrawable('imgIcon'));

      if foto <> nil then
        begin
          bmp := TBitmap.Create;
          bmp.LoadFromStream(foto);

          img.OwnsBitmap := true;
          img.Bitmap := bmp;
        end;
    end;
end;

class procedure TListViewLoader.AddCategoriaLv(listview: TListView;
                                               id_categoria: Integer;
                                               descricao, resumo: string;
                                               valor: double;
                                               foto: TStream);
var
  txt: TListItemText;
  img: TListItemImage;
  bmp : TBitmap;
begin
  with listview.Items.Add do
    begin
      Height := 55;
      Tag := id_categoria;

      txt := TListItemText(Objects.FindDrawable('txtDescricao'));
      txt.Text := descricao;

      if resumo = 'S' then
        begin
          txt := TListItemText(Objects.FindDrawable('txtValor'));
          txt.Text := FormatFloat('#,##0.00', valor);
        end;

      img := TListItemImage(Objects.FindDrawable('imgIcon'));

      if foto <> nil then
        begin
          bmp := TBitmap.Create;
          bmp.LoadFromStream(foto);

          img.OwnsBitmap := true;
          img.Bitmap := bmp;
        end;
    end;
end;

end.
