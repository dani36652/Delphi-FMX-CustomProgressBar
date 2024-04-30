{
  Autor: Daniel Rodríguez Hernández
  Fecha: 28/04/2024
}
unit UCustomProgressBar;

interface
uses
  System.Classes, System.SysConst, System.SysUtils, System.Types, System.StrUtils,
  FMX.Objects, FMX.Graphics, FMX.Colors, FMX.StdCtrls, FMX.Types, System.UIConsts,
  System.UITypes, FMX.Text;

type TCustomProgressBar = class(TRectangle)
  private
    FValue: Double;
    FMin: Double;
    FMax: Double;
    FBackGroundColor: TAlphaColor;
    FColor: TAlphaColor;
    FFillRect: TRectangle;
    FXRadius: Single;
    FYRadius: Single;
    FPercent: Double;
    procedure setBackGroundColor(AColor: TAlphaColor);
    procedure setColor(AColor: TAlphaColor);
    procedure setValue(AValue: Double);
    procedure setMin(AValue: Double);
    procedure setMax(AValue: Double);
    procedure setX_Radius(AValue: Single);
    procedure setY_Radius(AValue: Single);
    procedure FOnResized(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property Value: Double read FValue write setValue;
    property Min: Double read FMin write setMin;
    property Max: Double read FMax write setMax;
    property BackGroundColor: TAlphaColor read FBackGroundColor write setBackGroundColor;
    property Color: TAlphaColor read FColor write setColor;
    property X_Radius: Single read FXRadius write setX_Radius;
    property Y_Radius: Single read FYRadius write setY_Radius;
    property Percent: Double read FPercent;
    property FillRect: TRectangle read FFillRect; //-> es el TRectangle que rellena al progressbar
end;

implementation

{ TCustomProgressBar }

constructor TCustomProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Self.BackGroundColor:= Self.Fill .Color;
  Self.Stroke.Kind:= TBrushKind.None;
  Self.Height:=
  {$IFDEF ANDROID OR DEF IOS}
  3
  {$ENDIF}
  {$IFDEF MSWINDOWS}
  20
  {$ENDIF};
  FFillRect:= TRectangle.Create(Self);
  FFillRect.Parent:= Self;
  FFillRect.Stroke.Kind:= TBrushKind.None;
  FFillRect.Align:= TAlignLayout.Left;
  FFillRect.Fill.Color:= Self.BackGroundColor;
  FFillRect.Width:= 0;
  FValue:= 0;
  FMin:= 0;
  FMax:= 100;
  FXRadius:= 0;
  FYRadius:= 0;
  FPercent:= 0;
  Self.Value:= FValue;
  Self.Min:=  FMin;
  Self.Max:= FMax;
  Self.XRadius:= FXRadius;
  Self.YRadius:= FYRadius;
  Self.OnResized:= FOnResized;
end;

procedure TCustomProgressBar.FOnResized(Sender: TObject);
begin
  FFillRect.Width:= (Self.Width * FPercent) / 100; // -> establece el ancho del FFillRect según el porcentaje
end;

procedure TCustomProgressBar.setBackGroundColor(AColor: TAlphaColor);
begin
  if Self.BackGroundColor <> AColor then
  begin
    FBackGroundColor:= AColor;
    Self.Fill.Color:= FBackGroundColor;
    Self.BackGroundColor:= FBackGroundColor;
  end;
end;

procedure TCustomProgressBar.setColor(AColor: TAlphaColor);
begin
  if Self.Color <> AColor then
  begin
    FColor:= AColor;
    FFillRect.Fill.Color:= FColor;
    Self.Color:= FColor;
  end;
end;

procedure TCustomProgressBar.setMax(AValue: Double);
begin
  if (FMax <> AValue) and (FValue >= 0) then
  begin
    FMax:= AValue;
  end;
end;

procedure TCustomProgressBar.setMin(AValue: Double);
begin
  if (FMin <> AValue) and (FValue >= 0) then
  begin
    FMin:= AValue;
  end;
end;

procedure TCustomProgressBar.setValue(AValue: Double);
begin
  if AValue >= 0 then
  begin
    if Self.Value <> AValue then
    begin
      if AValue < FMin then // siempre comenzar desde el valor min
        FValue:= FMin else FValue:= AValue;
      FPercent:= (100 * FValue) / FMax; //-> devuelve el porcentaje, ejemplo: #%
      FFillRect.Width:= (Self.Width * FPercent) / 100; // -> establece el ancho del FFillRect según el porcentaje
      Self.Value:= FValue;
    end;
  end;
end;

procedure TCustomProgressBar.setX_Radius(AValue: Single);
begin
  if FXRadius <> AValue then
  begin
    if AValue > Self.Height  then
      FXRadius:= Self.Height / 2 else FXRadius:= AValue;

    Self.XRadius:= FXRadius;
    FFillRect.XRadius:= FXRadius;
  end;
end;

procedure TCustomProgressBar.setY_Radius(AValue: Single);
begin
  if FYRadius <> AValue then
  begin
    if AValue > Self.Height then
      FYRadius:= Self.Height / 2 else FYRadius:= AValue;

    Self.YRadius:= FYRadius;
    FFillRect.YRadius:= FYRadius;
  end;
end;

end.

