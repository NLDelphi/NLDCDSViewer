program NLDCDSViewer;

uses
  Forms,
  MainFormU in 'MainFormU.pas' {MainForm},
  DataViewU in 'DataViewU.pas' {DataView: TDataModule},
  DataFrameU in 'DataFrameU.pas' {DataFrame: TFrame},
  NLDCsvStringUtilsU in 'Units\NLDCsvStringUtilsU.pas',
  InfoFormU in 'InfoFormU.pas' {InfoForm},
  FilterFormU in 'FilterFormU.pas' {FilterForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.CreateForm(TFilterForm, FilterForm);
  Application.Run;
end.

