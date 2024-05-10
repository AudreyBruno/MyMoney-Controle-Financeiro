unit untLancamentos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  uListViewLoader, classLancamento, FireDAC.Comp.Client, DataModule.Principal,
  Data.DB, DateUtils;

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
    lblRec: TLabel;
    Label5: TLabel;
    lblDesp: TLabel;
    Label3: TLabel;
    lblSaldo: TLabel;
    Label7: TLabel;
    lvLancamentos: TListView;
    procedure imgBackClick(Sender: TObject);
    procedure lvLancamentosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lvLancamentosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure imgAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgPrevClick(Sender: TObject);
    procedure imgNextClick(Sender: TObject);
  private
    dt_filtro : TDate;

    procedure AbrirLançamentos(id: integer);
    procedure ListarLancamentos;
    procedure NavegarMes(num_mes: integer);
    function NomeMes: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLancamentos: TfrmLancamentos;

implementation

uses untPrincipal, untLancamentosCad;

{$R *.fmx}

function TfrmLancamentos.NomeMes(): string;
begin
    case MonthOf(dt_filtro) of
        1 : Result := 'Janeiro';
        2 : Result := 'Fevereiro';
        3 : Result := 'Março';
        4 : Result := 'Abril';
        5 : Result := 'Maio';
        6 : Result := 'Junho';
        7 : Result := 'Julho';
        8 : Result := 'Agosto';
        9 : Result := 'Setembro';
        10 : Result := 'Outubro';
        11 : Result := 'Novembro';
        12 : Result := 'Dezembro';
    end;

    Result := Result + ' / ' + YearOf(dt_filtro).ToString;
end;

procedure TfrmLancamentos.NavegarMes(num_mes: integer);
begin
  dt_filtro := IncMonth(dt_filtro, num_mes);
  lblMes.Text := NomeMes;
  ListarLancamentos;
end;

procedure TfrmLancamentos.ListarLancamentos;
var
  lanc: TLancamento;
  qry: TFDQuery;
  erro: string;
  i: Integer;
  foto: TStream;
  vl_rec, vl_desp: double;
begin
  lvLancamentos.Items.Clear;
  vl_rec := 0;
  vl_desp := 0;

  try
    lanc := TLancamento.Create(DMPrincipal.FDConn);
    lanc.DATA_DE := FormatDateTime('YYYY-MM-DD', StartOfTheMonth(dt_filtro));
    lanc.DATA_ATE := FormatDateTime('YYYY-MM-DD', EndOfTheMonth(dt_filtro));
    qry := lanc.ListarLancamento(0, erro);

    if erro <> '' then
      begin
        ShowMessage(erro);
        exit;
      end;

    qry.First;
    for i := 0 to qry.RecordCount - 1 do
      begin
        if qry.FieldByName('ICONE').AsString <> '' then
          foto := qry.CreateBlobStream(qry.FieldByName('ICONE'), TBlobStreamMode.bmRead)
        else
          foto := nil;

        TListViewLoader.AddLancamentosLv(lvLancamentos,
                                         qry.FieldByName('ID_LANCAMENTO').AsInteger,
                                         qry.FieldByName('DESCRICAO').AsString,
                                         qry.FieldByName('DESCRICAO_CATEGORIA').AsString,
                                         qry.FieldByName('VALOR').AsFloat,
                                         foto,
                                         qry.FieldByName('DATA').AsDateTime);

        if qry.FieldByName('VALOR').AsFloat > 0 then
          vl_rec := vl_rec + qry.FieldByName('VALOR').AsFloat
        else
          vl_desp := vl_desp + qry.FieldByName('VALOR').AsFloat;

        qry.Next;

        foto.DisposeOf;
      end;

    lblRec.Text := FormatFloat('#,##0.00', vl_rec);
    lblDesp.Text := FormatFloat('#,##0.00', vl_desp);
    lblSaldo.Text := FormatFloat('#,##0.00', vl_rec + vl_desp);

  finally
    lanc.DisposeOf;
  end;
end;

procedure TfrmLancamentos.AbrirLançamentos(id: integer);
begin
  if NOT Assigned(frmLancamentosCad) then
    Application.CreateForm(TfrmLancamentosCad, frmLancamentosCad);

  if id <> 0 then
    frmLancamentosCad.modo := 'A'
  else
    frmLancamentosCad.modo := 'I';

  frmLancamentosCad.id_lanc := id;
  frmLancamentosCad.Show;
end;

procedure TfrmLancamentos.FormShow(Sender: TObject);
begin
  dt_filtro := Date;
  NavegarMes(0);
end;

procedure TfrmLancamentos.imgAddClick(Sender: TObject);
begin
  AbrirLançamentos(0);
end;

procedure TfrmLancamentos.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLancamentos.imgNextClick(Sender: TObject);
begin
  NavegarMes(1);
end;

procedure TfrmLancamentos.imgPrevClick(Sender: TObject);
begin
  NavegarMes(-1);
end;

procedure TfrmLancamentos.lvLancamentosItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
  AbrirLançamentos(AItem.Tag);
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
