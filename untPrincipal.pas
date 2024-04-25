unit untPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.Controls.Presentation, FMX.StdCtrls, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TfrmPrincipal = class(TForm)
    Layout1: TLayout;
    imgMenu: TImage;
    circleAvatar: TCircle;
    imgNotification: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Image1: TImage;
    Image2: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Rectangle1: TRectangle;
    Layout7: TLayout;
    Image3: TImage;
    Layout8: TLayout;
    Label8: TLabel;
    Label9: TLabel;
    lvLancamentos: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

end.
