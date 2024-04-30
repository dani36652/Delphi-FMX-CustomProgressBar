unit UMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  UCustomProgressBar, FMX.StdCtrls, FMX.Layouts, FMX.Controls.Presentation,
  FMX.Edit, FMX.EditBox, FMX.NumberBox;

type
  TMainForm = class(TForm)
    rectToolbar: TRectangle;
    btnMas: TButton;
    btnMenos: TButton;
    LYProgressBar: TLayout;
    lblPorcentajeProgress: TLabel;
    NumberBox: TNumberBox;
    procedure FormCreate(Sender: TObject);
    procedure btnMasClick(Sender: TObject);
    procedure btnMenosClick(Sender: TObject);
    procedure NumberBoxChange(Sender: TObject);
  private
    { Private declarations }

    var
      ProgressBar: TCustomProgressBar;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnMasClick(Sender: TObject);
begin
  NumberBox.Value:= NumberBox.Value + 1;
end;

procedure TMainForm.btnMenosClick(Sender: TObject);
begin
  NumberBox.Value:= NumberBox.Value - 1;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  ProgressBar:= TCustomProgressBar.Create(Self);
  ProgressBar.Parent:= LYProgressBar;
  ProgressBar.Align:= TAlignLayout.VertCenter;
  ProgressBar.Margins.Left:= 10;
  ProgressBar.Margins.Right:= 10;
  ProgressBar.Max:= NumberBox.Max;
  ProgressBar.Min:= NumberBox.Min;
  ProgressBar.Value:= 0;
  ProgressBar.Color:= TAlphaColors.Mediumseagreen;
  ProgressBar.X_Radius:= 5;
  ProgressBar.Y_Radius:= 5;
  (*
    Para el progressbar se pueden usar colores gradientes
    según su interfaz de usuario en este caso:
  *)
  ProgressBar.FillRect.Fill.Kind := TBrushKind.Gradient;
  //Este es el color que establece el programador
  ProgressBar.FillRect.Fill.Gradient.Points.Points[0].Color := ProgressBar.Color;
  ProgressBar.FillRect.Fill.Gradient.Points.Points[0].Offset := 0.000000000000000000;
  //Y este color es un color al seleccionado pero con un tono más oscuro
  ProgressBar.FillRect.Fill.Gradient.Points.Points[1].Color := $FF28794C;
  ProgressBar.FillRect.Fill.Gradient.Points.Points[1].Offset := 1.000000000000000000;
end;

procedure TMainForm.NumberBoxChange(Sender: TObject);
begin
  ProgressBar.Value:= TNumberBox(Sender).Value;
  lblPorcentajeProgress.Text:= FloatToStrF(ProgressBar.Percent, ffNumber, 3, 0) + '%';
end;

end.
