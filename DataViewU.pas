unit DataViewU;

interface

uses
  SysUtils, Classes, DB, DBClient, NLDClientDataSet, Contnrs, Variants;

type
  TCDSFilter = class(TObject)
  private
    FName: string;
    FField: TField;
    FBeginValue: Variant;
    FEndValue: Variant;
    FActive: Boolean;
  public
    property Active: Boolean read FActive write FActive;
    property Field: TField read FField write FField;
    property Name: string read FName write FName;
    property BeginValue: Variant read FBeginValue write FBeginValue;
    property EndValue: Variant read FEndValue write FEndValue;
  end;

type
  TDataView = class(TDataModule)
    ClientDataSet: TNLDClientDataSet;
  private
    FFilterObject: TObjectList;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function FieldTypeToStr(FieldType: TFieldType): string;

    procedure OpenData;
    procedure CloseData;
    procedure FilterCDS;

    property FilterObject: TObjectList read FFilterObject write FFilterObject;
  end;

implementation

uses Math, TypInfo;

{$R *.dfm}

constructor TDataView.Create(AOwner: TComponent);
begin
  inherited;
  FFilterObject := TObjectList.Create;
end;

destructor TDataView.Destroy;
begin
  FFilterObject.Free;
  ClientDataSet.Close;
  inherited;
end;

function TDataView.FieldTypeToStr(FieldType: TFieldType): string;
begin
  Result := GetEnumName(TypeInfo(TFieldType), Ord(FieldType));
end;

procedure TDataView.OpenData;
begin
  ClientDataSet.Open;
end;

procedure TDataView.CloseData;
var
  I: Integer;
begin
  with ClientDataSet do
  begin
    for I := 0 to FieldDefs.Count -1 do
      FieldDefs[0].Destroy;

    Active := False;
  end;
end;

procedure TDataView.FilterCDS;
var
  i: Integer;
  CDSFilter: TCDSFilter;
  FieldName: string;
  BeginValue: string;
  EndValue: string;
  FilterText: string;
begin
  FilterText := '';
  ClientDataSet.Filtered := False;
  for i := 0 to FilterObject.Count - 1 do
  begin
    CDSFilter := TCDSFilter(FilterObject[i]);
    if CDSFilter.Active then
    begin
      FieldName := TField(CDSFilter.Field).FieldName;
      BeginValue := CDSFilter.BeginValue;
      EndValue := CDSFilter.EndValue;

      if VarIsEmpty(EndValue) or (Length(EndValue) < 1) then
        FilterText := FilterText + FieldName + '=' + QuotedStr(BeginValue)
      else
        FilterText := FilterText +
          FieldName + '>=' + QuotedStr(BeginValue) + ' AND ' +
          FieldName + '<=' + QuotedStr(EndValue);


      FilterText := FilterText + ' AND ';
    end;
  end;

  if FilterText <> '' then
  begin
    Delete(FilterText, Length(FilterText) -4, 5);
    ClientDataSet.Filter := FilterText;
    ClientDataSet.Filtered := True;
  end;
  
end;

end.
