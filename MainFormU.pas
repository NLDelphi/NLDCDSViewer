unit MainFormU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, ActnList, Menus, DataFrameU, Grids, 
  JvStringGrid, JvImageList, JvJCLUtils, ComCtrls, ToolWin;

type
  TMainForm = class(TForm)
    ActionList: TActionList;
    DataPanel: TPanel;
    JvImageList1: TJvImageList;
    acOpen: TAction;
    acSave: TAction;
    acClose: TAction;
    acExit: TAction;
    OpenDialog: TOpenDialog;
    CDSFrame: TDataFrame;
    acExportCSV: TAction;
    SaveDialog: TSaveDialog;
    acImportCSV: TAction;
    acInfo: TAction;
    PopupMenu1: TPopupMenu;
    Open2: TMenuItem;
    Save2: TMenuItem;
    N3: TMenuItem;
    Close2: TMenuItem;
    N4: TMenuItem;
    Exit2: TMenuItem;
    Import2: TMenuItem;
    CSV2: TMenuItem;
    Export1: TMenuItem;
    CSVfile2: TMenuItem;
    acFile: TAction;
    PopupMenu2: TPopupMenu;
    MenuItem10: TMenuItem;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Help1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Save1: TMenuItem;
    Import1: TMenuItem;
    CSV1: TMenuItem;
    Export2: TMenuItem;
    CSVfile1: TMenuItem;
    Close1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Info1: TMenuItem;
    N5: TMenuItem;
    acFilter: TAction;
    Filter1: TMenuItem;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    StatusBar: TStatusBar;
    ToolButton12: TToolButton;
    acClearFilter: TAction;
    ClearFilter1: TMenuItem;
    procedure acOpenExecute(Sender: TObject);
    procedure acExportCSVExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction;
      var Handled: Boolean);
    procedure acSaveExecute(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acExitExecute(Sender: TObject);
    procedure acImportCSVExecute(Sender: TObject);
    procedure acInfoExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure acFilterExecute(Sender: TObject);
    procedure acClearFilterExecute(Sender: TObject);
  private
    procedure OpenFile(AFileName: string);
    procedure UpdateStatusBar;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

uses DataViewU, DateUtils, Math, InfoFormU, FilterFormU;

{$R *.dfm}

procedure TMainForm.acOpenExecute(Sender: TObject);
begin
  acCloseExecute(Self);
  if OpenDialog.Execute then
    OpenFile(OpenDialog.FileName);
end;

procedure TMainForm.acExportCSVExecute(Sender: TObject);
begin
  if SaveDialog.Execute then
    with CDSFrame.DataView do
      ClientDataSet.ExportToCSV(SaveDialog.FileName);
end;

procedure TMainForm.ActionListUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  Enable: Boolean;
  ClearFilter: Boolean;
begin
  Enable := Assigned(CDSFrame.DataView) and
    (CDSFrame.DataView.ClientDataSet.Active);

  ClearFilter := False;
  if Enable then
    ClearFilter := CDSFrame.DataView.FilterObject.Count > 0;

  acExportCSV.Enabled := Enable;
  acFilter.Enabled := Enable;
  acClearFilter.Enabled := Enable and ClearFilter;
  acSave.Enabled := Enable;
  acClose.Enabled := Enable;
end;

procedure TMainForm.acSaveExecute(Sender: TObject);
begin
  with CDSFrame.DataView.ClientDataSet do
    SaveToFile(CDSFrame.Filename);
end;

procedure TMainForm.acCloseExecute(Sender: TObject);
begin
  with CDSFrame.DataView do
  begin
    if ClientDataSet.Active then
      CloseData;

    CDSFrame.DestroyForm;
    DataPanel.Visible := ClientDataSet.Active;
    UpdateStatusBar;
  end;
end;

procedure TMainForm.acExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.acImportCSVExecute(Sender: TObject);
begin
  if OpenDialog.Execute then
    with CDSFrame.DataView do
    begin
      ClientDataSet.ImportFormCSV(OpenDialog.FileName);
      CDSFrame.FieldInfo;
      DataPanel.Visible := ClientDataSet.Active;
    end;
end;

procedure TMainForm.acInfoExecute(Sender: TObject);
begin
  InfoForm.ShowModal;

end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  AssociateExtension(Application.ExeName + ', 1', 'NLDCDSViewer',
    Application.Exename, 'cds');

  { Lees ook even de parameter uit (als die er is). }
  if Length(Trim(ParamStr(1))) > 0 then
    OpenFile(ParamStr(1));
end;

procedure TMainForm.acFilterExecute(Sender: TObject);
begin
  FilterForm.ShowModal;
  UpdateStatusBar;
end;

procedure TMainForm.UpdateStatusBar;
var
  Active: Boolean;
begin
  Active := CDSFrame.DataView.ClientDataSet.Active;

  StatusBar.Panels[0].Text := '';
  StatusBar.Panels[1].Text := '';

  if Active then
  begin
    StatusBar.Panels[0].Text := CDSFrame.Filename;
    StatusBar.Panels[1].Text := 'Records: ' +
      IntToStr(CDSFrame.DataView.ClientDataSet.RecordCount);
  end;
end;

procedure TMainForm.acClearFilterExecute(Sender: TObject);
var
  i: Integer;
begin
  with CDSFrame.DataView do
  begin
    for i := 0 to FilterObject.Count -1 do
      TCDSFilter(FilterObject[i]).Active := False;

    FilterCDS;
  end;

  UpdateStatusBar;
end;

procedure TMainForm.OpenFile(AFileName: string);
begin
  with CDSFrame do
  begin

    with DataSource.DataSet do
      if Active then
        DataView.CloseData;

    DataPanel.Visible := True;
    FileName := AFileName;
    OpenData;
    UpdateStatusBar;
  end;
end;

end.
