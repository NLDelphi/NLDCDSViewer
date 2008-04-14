unit FilterFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DataViewU, ActnList;

type
  TFilterForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    FilterList: TListBox;
    BeginValue: TEdit;
    EndValue: TEdit;
    FieldCombo: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NameEdit: TEdit;
    ActiveCheck: TCheckBox;
    SluitenKnop: TButton;
    OkKnop: TButton;
    NieuwButton: TButton;
    DelButton: TButton;
    ActionList1: TActionList;
    OpslaanAction: TAction;
    SluitenAction: TAction;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FilterListClick(Sender: TObject);
    procedure NieuwButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure SluitenActionExecute(Sender: TObject);
    procedure OpslaanActionExecute(Sender: TObject);
  private
    { Private declarations }
    FAdd: Boolean;
    FFilter: TCDSFilter;
    DataView: TDataView;
    procedure ClearScreen;
    procedure FillListBox;
    procedure FillForm(Filter: TCDSFilter);
  public
    { Public declarations }
  end;

var
  FilterForm: TFilterForm;

implementation

uses MainFormU, DB;

{$R *.dfm}

procedure TFilterForm.FormCreate(Sender: TObject);
begin
  DataView := MainForm.CDSFrame.DataView;
  FAdd := True;
end;

procedure TFilterForm.FillListBox;
var
  i: Integer;
begin
  FilterList.Items.Clear;

  { Vul de reeds aanwezige Filter regels }
  for i := 0 to DataView.FilterObject.Count -1  do
    FilterList.AddItem(
      TCDSFilter(DataView.FilterObject[i]).Name, DataView.FilterObject[i]);
end;

procedure TFilterForm.FormActivate(Sender: TObject);
var
  i: Integer;
begin
  FillListBox;

  { Vul de velden van de CDS in de combobox }
  for i := 0 to DataView.ClientDataSet.FieldCount -1 do
    FieldCombo.Items.AddObject(
      DataView.ClientDataSet.Fields[i].FieldName,
      TField(DataView.ClientDataSet.Fields[i]));

  FieldCombo.ItemIndex := 0;
end;

procedure TFilterForm.ClearScreen;
begin
  NameEdit.Clear;
  ActiveCheck.Checked := False;
  FieldCombo.ItemIndex := -1;
  BeginValue.Clear;
  EndValue.Clear;
end;

procedure TFilterForm.FillForm(Filter: TCDSFilter);
var
  Field: TField;
begin
  NameEdit.Text := Filter.Name;
  ActiveCheck.Checked := Filter.Active;

  Field := TField(Filter.Field);
  FieldCombo.ItemIndex := FieldCombo.Items.IndexOf(Field.FieldName);

  BeginValue.Text := Filter.BeginValue;
  EndValue.Text := Filter.EndValue;
end;

procedure TFilterForm.FilterListClick(Sender: TObject);
begin
  FFilter := TCDSFilter(FilterList.Items.Objects[FilterList.ItemIndex]);
  FillForm(FFilter);
end;

procedure TFilterForm.NieuwButtonClick(Sender: TObject);
begin
  FAdd := True;
  OkKnop.Enabled := FAdd;
  ClearScreen;
end;

procedure TFilterForm.DelButtonClick(Sender: TObject);
begin
  DataView.FilterObject.Delete(FilterList.ItemIndex);
  DataView.FilterCDS;
  FillListBox;
end;

procedure TFilterForm.SluitenActionExecute(Sender: TObject);
begin
  ClearScreen;
  DataView.FilterCDS;
  Close;
end;

procedure TFilterForm.OpslaanActionExecute(Sender: TObject);
var
  Filter: TCDSFilter;
begin
  if Length(NameEdit.Text) < 1 then
    raise Exception.Create('Naam moet worden opgegeven');

  if Length(BeginValue.Text) < 1 then
    raise Exception.Create('Er moet minimaal 1 waarde worden opgegeven');

  if FAdd then
  begin
    Filter := TCDSFilter.Create;
    FFilter := Filter;
  end;

  FFilter.Active := ActiveCheck.Checked;
  FFilter.Name := NameEdit.Text;
  FFilter.Field := TField(FieldCombo.Items.Objects[FieldCombo.ItemIndex]);
  FFilter.BeginValue := BeginValue.Text;
  FFilter.EndValue := EndValue.Text;

  if FAdd then
    DataView.FilterObject.Add(FFilter);

  ClearScreen;
  FillListBox;
  DataView.FilterCDS;
  FAdd := False;
end;

end.
