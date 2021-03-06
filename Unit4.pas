unit Unit4;

interface

uses
  System.SysUtils, System.Classes, ZAbstractConnection, ZConnection, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, ZSqlUpdate;

type
  TdmDataModule = class(TDataModule)
    upSystem: TZUpdateSQL;
    dsSystem: TDataSource;
    qSystem: TZQuery;
    qSystemcode: TWideStringField;
    qSystemdescription: TWideStringField;
    conn: TZConnection;
    dsModule: TDataSource;
    qModule: TZQuery;
    qModulesystem_code: TWideStringField;
    qModulecode: TWideStringField;
    qModuledescription: TWideStringField;
    qModulemandatory: TBooleanField;
    qSystemVersion: TZQuery;
    qSystemVersionversion: TWideStringField;
    upSystemVersion: TZUpdateSQL;
    dsSystemVersion: TDataSource;
    qModuleVersion: TZQuery;
    qModuleVersionmodule_code: TWideStringField;
    qModuleVersionversion: TWideStringField;
    upModuleVersion: TZUpdateSQL;
    dsModuleVersion: TDataSource;
    qModuleVerDiffInsrt: TZQuery;
    qModuleVerDiff: TZQuery;
    qModuleVerDiffdestination_path: TWideStringField;
    qModuleVerDiffsize_in_bytes: TIntegerField;
    qModuleVerDiffDel: TZQuery;
    dsModuleVerDiff: TDataSource;
    qDropBox: TZQuery;
    qDropBoxsystem_code: TWideStringField;
    qDropBoxcode: TWideStringField;
    dsComboBox: TDataSource;
    qSite: TZQuery;
    upSite: TZUpdateSQL;
    dsSite: TDataSource;
    qSiteRunsSystem: TZQuery;
    qSiteRunsSystemsystem_code: TWideStringField;
    qSiteRunsSystemlast_deployment: TIntegerField;
    qSiteRunsSystemlast_successfull_deployment: TIntegerField;
    dsSiteRunsSystem: TDataSource;
    qSiteRunsModule: TZQuery;
    qSiteRunsModulemodule_code: TWideStringField;
    qSiteRunsModulenum_of_lic: TIntegerField;
    dsSiteRunsModule: TDataSource;
    qUser: TZQuery;
    qUserusername: TWideStringField;
    qUsername: TWideStringField;
    qUseremail: TWideStringField;
    qUserphone: TWideStringField;
    qUseractive: TBooleanField;
    upUser: TZUpdateSQL;
    dsUser: TDataSource;
    qUserCombobox: TZQuery;
    dsUserComboBox: TDataSource;
    qUserComboboxusername: TWideStringField;
    qSiteid: TIntegerField;
    qSiteupdater_user: TWideStringField;
    qSitedescription: TWideStringField;
    qSiteaddress: TWideStringField;
    qSitecontact_person: TWideStringField;
    qSitecontact_phone: TWideStringField;
    qSitecontact_email: TWideStringField;
    qSitecomment: TWideStringField;
    qSitemanager: TWideStringField;
    qSitedb_uri: TWideStringField;
    upSiteRunsSystem: TZUpdateSQL;
    upSiteRunsModule: TZUpdateSQL;
    qSiteRunsSystemCmbBox: TZQuery;
    dsSiteRunsSystemCmbBox: TDataSource;
    dsSiteRunsModuleCmbBox: TDataSource;
    qSiteRunsModuleCmbBox: TZQuery;
    qSiteRunsSystemCmbBoxcode: TWideStringField;
    qSiteRunsModuleCmbBoxsystem_code: TWideStringField;
    qSiteRunsModuleCmbBoxcode: TWideStringField;
    qModFileDiffView: TZQuery;
    dsModFileDiffView: TDataSource;
    qModFileDiffViewsystem_code: TWideMemoField;
    qModFileDiffViewmodule_code: TWideMemoField;
    qModFileDiffViewdestination_path: TWideMemoField;
    qModFileDiffViewfile_content: TBlobField;
    procedure DataModuleCreate(Sender: TObject);
    procedure readConfigFile();
    procedure qSystemAfterScroll(DataSet: TDataSet);
    procedure qSystemVersionAfterScroll(DataSet: TDataSet);
    procedure qSystemVersionAfterPost(DataSet: TDataSet);
    procedure qSystemVersionBeforeOpen(DataSet: TDataSet);
    procedure qModuleVersionAfterScroll(DataSet: TDataSet);
    procedure qModuleVersionBeforeOpen(DataSet: TDataSet);
    procedure qModuleVersionBeforeScroll(DataSet: TDataSet);
    procedure qModuleAfterInsert(DataSet: TDataSet);
    procedure upModuleVersionBeforeDeleteSQL(Sender: TObject);
    procedure upModuleVersionBeforeInsertSQL(Sender: TObject);
    procedure upModuleVersionBeforeModifySQL(Sender: TObject);
    procedure upSystemVersionBeforeDeleteSQL(Sender: TObject);
    procedure upSystemVersionBeforeInsertSQL(Sender: TObject);
    procedure upSystemVersionBeforeModifySQL(Sender: TObject);
    procedure qSiteAfterScroll(DataSet: TDataSet);
    procedure qSiteRunsSystemAfterScroll(DataSet: TDataSet);
    procedure upSiteRunsSystemBeforeInsertSQL(Sender: TObject);
    procedure upSiteRunsSystemBeforeDeleteSQL(Sender: TObject);
    procedure upSiteRunsSystemBeforeModifySQL(Sender: TObject);
    procedure upSiteRunsModuleBeforeInsertSQL(Sender: TObject);
    procedure upSiteRunsModuleBeforeModifySQL(Sender: TObject);
    procedure upSiteRunsModuleBeforeDeleteSQL(Sender: TObject);



  private
    FHost            : string;
    FPort            : string;
    FDbName          : string;
    FUser            : string;
    FPasswrd         : string;

  public
    { Public declarations }
  end;

var
  dmDataModule: TdmDataModule;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmDataModule.DataModuleCreate(Sender: TObject);
begin
  readConfigFile();

  conn.HostName := FHost;
  conn.Port := strtoint(FPort);
  conn.Database := FDbName;
  conn.User := FUser;
  conn.Password := FPasswrd;
  conn.Connect;
end;


procedure TdmDataModule.readConfigFile();
var
_InputConfigFile : TextFile;
_Line            : string;

begin
if not FileExists('config.ini') then
  //ShowMessage('File: config.ini was not found')
else
  begin
    AssignFile(_InputConfigFile, 'config.ini');
    Reset(_InputConfigFile);
    while not Eof(_InputConfigFile) do
    begin
      Readln(_InputConfigFile, _Line);
      FHost := _Line;
      Readln(_InputConfigFile, _Line);
      FPort := _Line;
      Readln(_InputConfigFile, _Line);
      FDbName := _Line;
      Readln(_InputConfigFile, _Line);
      FUser := _Line;
      Readln(_InputConfigFile, _Line);
      FPasswrd := _Line;
    end;
    CloseFile(_InputConfigFile);
  end;
end;

procedure TdmDataModule.upModuleVersionBeforeDeleteSQL(Sender: TObject);
begin
  dmDataModule.upModuleVersion.Params.ParamByName('prm_system_code').Value := dmDataModule.qSystemcode.Value;
  dmDataModule.upModuleVersion.Params.ParamByName('prm_system_version').Value := dmDataModule.qSystemVersionversion.Value;
end;

procedure TdmDataModule.upModuleVersionBeforeInsertSQL(Sender: TObject);
begin
  dmDataModule.upModuleVersion.Params.ParamByName('prm_system_code').Value := dmDataModule.qSystemcode.Value;
  dmDataModule.upModuleVersion.Params.ParamByName('prm_system_version').Value := dmDataModule.qSystemVersionversion.Value;
end;

procedure TdmDataModule.upModuleVersionBeforeModifySQL(Sender: TObject);
begin
  dmDataModule.upModuleVersion.Params.ParamByName('prm_system_code').Value := dmDataModule.qSystemcode.Value;
  dmDataModule.upModuleVersion.Params.ParamByName('prm_system_version').Value := dmDataModule.qSystemVersionversion.Value;
end;


procedure TdmDataModule.upSiteRunsModuleBeforeDeleteSQL(Sender: TObject);
begin
  upSiteRunsModule.Params.ParamByName('prm_site').Value := qSiteid.Value;
  upSiteRunsModule.Params.ParamByName('prm_system_code').Value := dmDataModule.qSiteRunsSystemsystem_code.Value;
end;

procedure TdmDataModule.upSiteRunsModuleBeforeInsertSQL(Sender: TObject);
begin
  upSiteRunsModule.Params.ParamByName('prm_site').Value := qSiteid.Value;
  upSiteRunsModule.Params.ParamByName('prm_system_code').Value := dmDataModule.qSiteRunsSystemsystem_code.Value;
end;

procedure TdmDataModule.upSiteRunsModuleBeforeModifySQL(Sender: TObject);
begin
  upSiteRunsModule.Params.ParamByName('prm_site').Value := qSiteid.Value;
  upSiteRunsModule.Params.ParamByName('prm_system_code').Value := dmDataModule.qSiteRunsSystemsystem_code.Value;
end;

procedure TdmDataModule.upSiteRunsSystemBeforeDeleteSQL(Sender: TObject);
begin
  upSiteRunsSystem.Params.ParamByName('prm_site').Value := qSiteid.Value;
end;


procedure TdmDataModule.upSiteRunsSystemBeforeInsertSQL(Sender: TObject);
begin
  upSiteRunsSystem.Params.ParamByName('prm_site').Value := qSiteid.Value;
end;

procedure TdmDataModule.upSiteRunsSystemBeforeModifySQL(Sender: TObject);
begin
  upSiteRunsSystem.Params.ParamByName('prm_site').Value := qSiteid.Value;
end;

procedure TdmDataModule.upSystemVersionBeforeDeleteSQL(Sender: TObject);
begin
  dmDataModule.upSystemVersion.Params.ParamByName('prm_system_code2').Value := dmDataModule.qSystemcode.Value;
end;

procedure TdmDataModule.upSystemVersionBeforeInsertSQL(Sender: TObject);
begin
  dmDataModule.upSystemVersion.Params.ParamByName('prm_system_code').Value := dmDataModule.qSystemcode.Value;
end;

procedure TdmDataModule.upSystemVersionBeforeModifySQL(Sender: TObject);
begin
  dmDataModule.upSystemVersion.Params.ParamByName('prm_system_code3').Value := dmDataModule.qSystemcode.Value;
end;

procedure TdmDataModule.qModuleAfterInsert(DataSet: TDataSet);
begin
  dmDataModule.qModulesystem_code.Value := dmDataModule.qSystemcode.Value;
end;

procedure TdmDataModule.qModuleVersionAfterScroll(DataSet: TDataSet);
begin
  if (dmDataModule.qModuleVersionmodule_code.Value <> '') or (dmDataModule.qModuleVersionversion.Value <> '') then
  begin
    dmDataModule.qModuleVerDiff.Close;
    dmDataModule.qModuleVerDiff.ParamByName('prm_system_code').Value := dmDataModule.qSystemcode.Value;
    dmDataModule.qModuleVerDiff.ParamByName('prm_module_code').Value := dmDataModule.qModuleVersionmodule_code.Value;
    dmDataModule.qModuleVerDiff.ParamByName('prm_module_ver').Value := dmDataModule.qModuleVersionversion.Value;
    dmDataModule.qModuleVerDiff.Open;
  end
  else
  begin
    dmDataModule.qModuleVerDiff.Close;
    // nustatomi tiketina neegzistuojancios parametru vertes, kad failu gride nieko nerodytu
    dmDataModule.qModuleVerDiff.ParamByName('prm_system_code').Value := 'test_test';
    dmDataModule.qModuleVerDiff.ParamByName('prm_module_code').Value := 'test_test';
    dmDataModule.qModuleVerDiff.ParamByName('prm_module_ver').Value := '0.0.0.0';
    dmDataModule.qModuleVerDiff.Open;
  end;
end;

procedure TdmDataModule.qModuleVersionBeforeOpen(DataSet: TDataSet);
begin
  dmDataModule.qModuleVersion.ParamByName('prm_system').Value := dmDataModule.qSystemcode.Value;
end;

procedure TdmDataModule.qModuleVersionBeforeScroll(DataSet: TDataSet);
begin
  if (not dmDataModule.qModuleVersionmodule_code.IsNull) and ( not dmDataModule.qModuleVersionmodule_code.IsNull) then
    dmDataModule.qModuleVersion.ApplyUpdates;
end;

procedure TdmDataModule.qSiteAfterScroll(DataSet: TDataSet);
begin
  qSiteRunsSystem.Close;
  qSiteRunsSystem.ParamByName('prm_site').Value := dmDataModule.qSiteid.Value;
  qSiteRunsSystem.Open;

  qSiteRunsModule.Close;
  qSiteRunsModule.ParamByName('prm_site').Value := qSiteid.Value;
  qSiteRunsModule.ParamByName('prm_system_code').Value := qSiteRunsSystemsystem_code.Value;
  qSiteRunsModule.Open;

  qSiteRunsModuleCmbBox.Close;
  qSiteRunsModuleCmbBox.ParamByName('prm_system_code').Value := qSiteRunsSystemsystem_code.Value;
  qSiteRunsModuleCmbBox.Open;

  //upSiteRunsSystem

end;



procedure TdmDataModule.qSiteRunsSystemAfterScroll(DataSet: TDataSet);
begin
  qSiteRunsModule.Close;
  qSiteRunsModule.ParamByName('prm_site').Value := qSiteid.Value;
  qSiteRunsModule.ParamByName('prm_system_code').Value := qSiteRunsSystemsystem_code.Value;
  qSiteRunsModule.Open;

  qSiteRunsModuleCmbBox.Close;
  qSiteRunsModuleCmbBox.ParamByName('prm_system_code').Value := qSiteRunsSystemsystem_code.Value;
  qSiteRunsModuleCmbBox.Open;
end;

procedure TdmDataModule.qSystemAfterScroll(DataSet: TDataSet);
begin
  dmDataModule.qModule.Close;
  dmDataModule.qModule.Params.ParamByName('prm_system').Value := dmDataModule.qSystemcode.Value;
  dmDataModule.qModule.Open;

  qDropBox.Close;
  qDropBox.ParamByName('prm_system').Value := dmDataModule.qSystemcode.Value;
  qDropBox.Open;
end;

procedure TdmDataModule.qSystemVersionAfterPost(DataSet: TDataSet);
begin
  dmDataModule.qSystemVersion.Close;
  dmDataModule.qModuleVersion.Params.ParamByName('prm_system').Value := dmDataModule.qSystemcode.Value;
  dmDataModule.qSystemVersion.Open;
end;

procedure TdmDataModule.qSystemVersionAfterScroll(DataSet: TDataSet);
begin
  //cbDBLookupComboBox.Visible := False;

  if (not dmDataModule.qSystemVersionversion.IsNull) then
  begin
    dmDataModule.qModuleVersion.Close;
    dmDataModule.qModuleVersion.Params.ParamByName('prm_system').Value := dmDataModule.qSystemcode.Value;
    dmDataModule.qModuleVersion.Params.ParamByName('prm_system_version').Value := dmDataModule.qSystemVersionversion.Value;
    dmDataModule.qModuleVersion.Open;
  end;
end;

procedure TdmDataModule.qSystemVersionBeforeOpen(DataSet: TDataSet);
begin
 dmDataModule.qSystemVersion.ParamByName('prm_system').Value := dmDataModule.qSystemcode.Value;
end;

end.
