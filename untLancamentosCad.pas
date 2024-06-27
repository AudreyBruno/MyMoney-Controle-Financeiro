unit untLancamentosCad;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.DateTimeCtrls, FMX.ListBox, classCategoria, DataModule.Principal,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, classLancamento, uFormat;

type
  TfrmLancamentosCad = class(TForm)
    rectDelete: TRectangle;
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
    Layout5: TLayout;
    Label5: TLabel;
    Line4: TLine;
    imgOntem: TImage;
    imgHoje: TImage;
    edtDate: TDateEdit;
    imgTipoLanc: TImage;
    imgDespesa: TImage;
    imgReceita: TImage;
    cbCategorias: TComboBox;
    procedure imgBackClick(Sender: TObject);
    procedure imgTipoLancClick(Sender: TObject);
    procedure imgHojeClick(Sender: TObject);
    procedure imgOntemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgSaveClick(Sender: TObject);
    procedure edtValorTyping(Sender: TObject);
  private
    procedure ListaCategorias;
    function TrataValor(value: string): Double;
    { Private declarations }
  public
    { Public declarations }
    modo: string;
    id_lanc: Integer;
  end;

var
  frmLancamentosCad: TfrmLancamentosCad;

implementation

{$R *.fmx}

function TfrmLancamentosCad.TrataValor(value: string): Double;
begin
  value := StringReplace(value, '.', '', [rfReplaceAll]);
  value := StringReplace(value, ',', '', [rfReplaceAll]);

  try
    Result := StrToFloat(value) / 100;
  except
    Result := 0;
  end;
end;

procedure TfrmLancamentosCad.ListaCategorias;
var
  c: TCategoria;
  erro: string;
  qry: TFDQuery;
  i: Integer;
begin
  cbCategorias.Items.Clear;

  try
    c := TCategoria.Create(DMPrincipal.FDConn);
    qry := c.ListarCategoria(erro);

    if erro <> '' then
      ShowMessage(erro);

    qry.First;
    for i := 0 to qry.RecordCount - 1 do
      begin
        cbCategorias.Items.AddObject(qry.FieldByName('DESCRICAO').AsString,
                                     TObject(qry.FieldByName('ID_CATEGORIA').AsInteger));

        qry.Next;
      end;
  finally
    c.DisposeOf;
    qry.DisposeOf;
  end;
end;

procedure TfrmLancamentosCad.edtValorTyping(Sender: TObject);
begin
  Formatar(edtValor, TFormato.Valor);
end;

procedure TfrmLancamentosCad.FormShow(Sender: TObject);
var
  lanc: TLancamento;
  qry: TFDQuery;
  erro: string;
begin
  ListaCategorias;

  if modo = 'I' then
    begin
      edtDescricao.Text := '';
      edtValor.Text := '';
      edtDate.Date := Date;

      imgTipoLanc.Bitmap := imgDespesa.Bitmap;
      imgTipoLanc.Tag := -1;

      rectDelete.Visible := False;
    end
  else
    begin
      try
        lanc := TLancamento.Create(DMPrincipal.FDConn);
        lanc.ID_LANCAMENTO := id_lanc;
        qry := lanc.ListarLancamento(0, erro);

        edtDescricao.Text := qry.FieldByName('DESCRICAO').AsString;
        edtDate.Date := qry.FieldByName('DATA').AsDateTime;

        if qry.FieldByName('VALOR').AsFloat < 0 then
          begin
            edtValor.Text := FormatFloat('#,##0.00', qry.FieldByName('VALOR').AsFloat * -1);  

            imgTipoLanc.Bitmap := imgDespesa.Bitmap;
            imgTipoLanc.Tag := -1;
          end
        else
          begin
            edtValor.Text := FormatFloat('#,##0.00', qry.FieldByName('VALOR').AsFloat);  

            imgTipoLanc.Bitmap := imgReceita.Bitmap;
            imgTipoLanc.Tag := 1;
          end;

        cbCategorias.ItemIndex := cbCategorias.Items.IndexOf(qry.FieldByName('DESCRICAO_CATEGORIA').AsString);
                                                      
        rectDelete.Visible := True;
      finally
        lanc.DisposeOf;
        qry.DisposeOf;
      end;
    end;
end;

procedure TfrmLancamentosCad.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLancamentosCad.imgHojeClick(Sender: TObject);
begin
  edtDate.Date := Date;
end;

procedure TfrmLancamentosCad.imgOntemClick(Sender: TObject);
begin
  edtDate.Date := Date - 1;
end;

procedure TfrmLancamentosCad.imgSaveClick(Sender: TObject);
var
  lanc: TLancamento;
  erro: string;
begin
  try
    lanc := TLancamento.Create(DMPrincipal.FDConn);
    lanc.DESCRICAO := edtDescricao.Text;
    lanc.VALOR := TrataValor(edtValor.Text) * imgTipoLanc.Tag;
    lanc.DATA := edtDate.Date;
    lanc.ID_CATEGORIA := integer(cbCategorias.Items.Objects[cbCategorias.ItemIndex]);

    if modo = 'I' then
      begin
        lanc.Inserir(erro);
      end
    else
      begin
        lanc.ID_LANCAMENTO := id_lanc;
        lanc.Alterar(erro);
      end;

    if erro <> '' then
      begin
        ShowMessage(erro);
        Exit;
      end;

    Close;
  finally
    lanc.DisposeOf;
  end;
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
