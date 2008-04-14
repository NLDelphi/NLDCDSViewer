unit DataFrameU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, DBClient, DataViewU, ComCtrls,
  StdCtrls, Contnrs, DBCtrls,
  NLDDBGrid, JvExGrids, JvStringGrid;

type
  TDataFrame = class(TFrame)
    PageControl1: TPageControl;
    TabFields: TTabSheet;
    TabData: TTabSheet;
    DataSource: TDataSource;
    FieldGrid: TJvStringGrid;
    TabFormView: TTabSheet;
    ScrollBox: TScrollBox;
    NLDDBGrid1: TNLDDBGrid;
  private
    FObjectList: TObjectList;
  private
    FFilename: string;
    FDataView: TDataView;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure CreateForm;
    procedure DestroyForm;
    procedure OpenData;
    procedure FieldInfo;

    property DataView: TDataView read FDataView write FDataView;
    property Filename: string read FFilename write FFilename;
  end;

implementation

uses DateUtils, JvDbControls;

{$R *.dfm}

{ TDataFrame }

constructor TDataFrame.Create(AOwner: TComponent);
begin
  inherited;
  FObjectList := TObjectList.Create;
  FObjectList.OwnsObjects := True;
  FDataView := TDataView.Create(Self);
  DataSource.DataSet := FDataView.ClientDataSet;
end;

procedure TDataFrame.OpenData;
begin
  with FDataView do
  begin
    ClientDataSet.LoadFromFile(FFilename);
    OpenData;
  end;
  FieldInfo;
  CreateForm;
end;

destructor TDataFrame.Destroy;
begin
  DestroyForm;
  FObjectList.Clear;
  FDataView.Free;
  inherited;
end;

procedure TDataFrame.FieldInfo;
var
  i: Integer;
begin
  with DataView.ClientDataSet do
  begin
    FieldGrid.ColCount := 3;
    FieldGrid.RowCount := Fields.Count + 1;

    FieldGrid.Cells[0, 0] := 'FieldName';
    FieldGrid.Cells[1, 0] := 'FieldType';
    FieldGrid.Cells[2, 0] := 'FieldSize';

    for i := 0 to Fields.Count - 1 do
    begin
      FieldGrid.Cells[0, i + 1] := UpperCase(Fields[i].FieldName);
      FieldGrid.Cells[1, i + 1] :=
        DataView.FieldTypeToStr(Fields[i].DataType);
      FieldGrid.Cells[2, i + 1] := IntToStr(Fields[i].Size);
    end;
  end;
end;

procedure TDataFrame.CreateForm;
var
  i: Integer;
  FieldLabel: TLabel;
  DataCheck: TDBCheckBox;
  DataEdit: TDBEdit;
  DataDateTime: TJvDBDateEdit;
  TopComponent: Integer;
  LeftComponent: Integer;

  procedure MaakLabel(Field: TField; Index: string);
  begin
    FieldLabel := TLabel.Create(Self);
    FieldLabel.Name := 'Label' + Index + 'Label';
    FieldLabel.Parent := ScrollBox;
    FieldLabel.Caption := Field.FieldName;
    FieldLabel.Top := TopComponent;
    FieldLabel.Width := 100;
    FieldLabel.Left := LeftComponent;
    FieldLabel.Visible := True;

    FObjectList.Add(FieldLabel);
  end;

  procedure MaakDataAware(Field: TField; Index: string);
  begin
    if Field.DataType = ftBoolean then
    begin
      DataCheck := TDBCheckBox.Create(Self);
      DataCheck.Name := 'Check' + Index;
      DataCheck.Parent := ScrollBox;
      DataCheck.DataSource := DataSource;
      DataCheck.DataField := Field.FieldName;
      DataCheck.Caption := '';
      DataCheck.Left := LeftComponent + 100;
      DataCheck.Top := TopComponent;
      DataCheck.Visible := True;

      TopComponent := TopComponent + DataCheck.Height + 10;
      FObjectList.Add(DataCheck);
    end
    else if Field.DataType = ftDateTime then
    begin
      DataDateTime := TJvDBDateEdit.Create(Self);
      DataDateTime.Name := 'Date' + Index;
      DataDateTime.Parent := ScrollBox;
      DataDateTime.DataSource := DataSource;
      DataDateTime.DataField := Field.FieldName;
      DataDateTime.Left := LeftComponent + 100;
      DataDateTime.Top := TopComponent;
      DataDateTime.Visible := True;

      TopComponent := TopComponent + DataDateTime.Height + 10;
      FObjectList.Add(DataDateTime);
    end
    else
    begin
      DataEdit := TDBEdit.Create(Self);
      DataEdit.Name := 'Edit' + Index;
      DataEdit.Parent := ScrollBox;
      DataEdit.DataSource := DataSource;
      DataEdit.DataField := Field.FieldName;
      DataEdit.Left := LeftComponent + 100;
      DataEdit.Top := TopComponent;
      DataEdit.Visible := True;

      TopComponent := TopComponent + DataEdit.Height + 10;
      FObjectList.Add(DataEdit);
    end;

  end;

begin
  { Maak een form met de velden daaraan gekoppeld }
  with FDataView.ClientDataSet do
  begin
    TopComponent := 10;
    LeftComponent := 10;
    for i := 0 to Fields.Count - 1 do
    begin
      MaakLabel(Fields[i], IntToStr(i));
      MaakDataAware(Fields[i], IntToStr(i));
    end;
  end;
end;

procedure TDataFrame.DestroyForm;
var
  i: Integer;
begin
  for i := FObjectList.Count - 1 downto 0 do
    FObjectList.Remove(TObject(FObjectList[0]));
end;

end.
