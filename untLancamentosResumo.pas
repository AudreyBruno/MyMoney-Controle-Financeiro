unit untLancamentosResumo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, untPrincipal,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, classLancamento, FireDAC.Comp.Client, DataModule.Principal,
  System.DateUtils, Data.DB, uListViewLoader;

type
  TfrmLancamentoResumo = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    imgBack: TImage;
    Layout2: TLayout;
    RoundRect1: TRoundRect;
    lblMes: TLabel;
    lvResumo: TListView;
    procedure imgBackClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure MontarResumo;
    { Private declarations }
  public
    { Public declarations }
    dt_filtro : TDate;
  end;

var
  frmLancamentoResumo: TfrmLancamentoResumo;

implementation

{$R *.fmx}

procedure TfrmLancamentoResumo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
  frmLancamentoResumo := nil;
end;

procedure TfrmLancamentoResumo.FormShow(Sender: TObject);
begin
  MontarResumo;
end;

procedure TfrmLancamentoResumo.imgBackClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmLancamentoResumo.MontarResumo;
var
  lanc : TLancamento;
  qry: TFDQuery;
  erro: string;
  icone: TStream;
  i: Integer;
begin
  lvResumo.Items.Clear;

  try
    lanc := TLancamento.Create(DMPrincipal.FDConn);
    lanc.DATA_DE := FormatDateTime('YYYY-MM-DD', StartOfTheMonth(dt_filtro));
    lanc.DATA_ATE := FormatDateTime('YYYY-MM-DD', EndOfTheMonth(dt_filtro));
    qry := lanc.ListarResumo(erro);

    qry.First;
    for i := 0 to qry.RecordCount - 1 do
      begin
        if qry.FieldByName('ICONE').AsString <> '' then
          icone := qry.CreateBlobStream(qry.FieldByName('ICONE'), TBlobStreamMode.bmRead)
        else
          icone := nil;

        TListViewLoader.AddCategoriaLv(lvResumo,
                                       0,
                                       qry.FieldByName('DESCRICAO').AsString,
                                       'S',
                                       qry.FieldByName('VALOR').AsFloat,
                                       icone);

        if icone <> nil then
          icone.DisposeOf;

        qry.Next;
      end;
  finally
    qry.DisposeOf;
    lanc.DisposeOf;
  end;
end;

end.
