object dmDataModule: TdmDataModule
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 592
  Width = 738
  object upSystem: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM private.system'
      'WHERE'
      '  system.code = :OLD_code')
    InsertSQL.Strings = (
      'INSERT INTO private.system'
      '  (code, description)'
      'VALUES'
      '  (:code, :description)')
    ModifySQL.Strings = (
      'UPDATE private.system SET'
      '  code = :code,'
      '  description = :description'
      'WHERE'
      '  system.code = :OLD_code')
    UseSequenceFieldForRefreshSQL = False
    Left = 96
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'description'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_code'
        ParamType = ptUnknown
      end>
  end
  object dsSystem: TDataSource
    DataSet = qSystem
    Left = 136
    Top = 32
  end
  object qSystem: TZQuery
    Connection = conn
    AfterScroll = qSystemAfterScroll
    UpdateObject = upSystem
    Active = True
    SQL.Strings = (
      'SELECT '
      '  code, '
      '  CAST(description AS VARCHAR(50)) AS description'
      'FROM'
      '  private.system'
      'ORDER BY'
      '  description')
    Params = <>
    Left = 88
    Top = 32
    object qSystemcode: TWideStringField
      FieldName = 'code'
      Required = True
      Size = 40
    end
    object qSystemdescription: TWideStringField
      FieldName = 'description'
      Size = 100
    end
  end
  object conn: TZConnection
    ControlsCodePage = cCP_UTF16
    UTF8StringsAsWideField = True
    Connected = True
    HostName = 'dbdev.nsoft.eu'
    Port = 5435
    Database = 'update_prod'
    User = 'update_server_owner'
    Password = '0sEgVwDnSHi6'
    Protocol = 'postgresql-9'
    Left = 40
    Top = 32
  end
  object dsModule: TDataSource
    DataSet = qModule
    Left = 312
    Top = 40
  end
  object qModule: TZQuery
    Connection = conn
    AfterInsert = qModuleAfterInsert
    Active = True
    SQL.Strings = (
      'SELECT '
      
        '  system_code, code, CAST (description AS CHARACTER VARYING(40))' +
        ', mandatory '
      'FROM private.module '
      'WHERE'
      '  system_code = :prm_system '
      'ORDER BY'
      '  code')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end>
    Left = 248
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end>
    object qModulesystem_code: TWideStringField
      FieldName = 'system_code'
      Required = True
      Size = 40
    end
    object qModulecode: TWideStringField
      FieldName = 'code'
      Required = True
      Size = 40
    end
    object qModuledescription: TWideStringField
      FieldName = 'description'
      Required = True
      Size = 80
    end
    object qModulemandatory: TBooleanField
      FieldName = 'mandatory'
      Required = True
    end
  end
  object qSystemVersion: TZQuery
    Connection = conn
    BeforeOpen = qSystemVersionBeforeOpen
    AfterScroll = qSystemVersionAfterScroll
    UpdateObject = upSystemVersion
    AfterPost = qSystemVersionAfterPost
    Active = True
    SQL.Strings = (
      'SELECT '
      '  public.ver4_to_str("version")::::varchar(100) as version'
      'FROM '
      '  private.system_version '
      'WHERE '
      '  system_code = :prm_system'
      'ORDER BY'
      '  version  ')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end>
    Left = 40
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end>
    object qSystemVersionversion: TWideStringField
      FieldName = 'version'
      Size = 200
    end
  end
  object upSystemVersion: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM private.system_version'
      'WHERE'
      '  system_version.system_code = :prm_system_code2 AND'
      '  system_version.version = public.str_to_ver4( :OLD_version)'
      '')
    InsertSQL.Strings = (
      'INSERT INTO private.system_version'
      '  (system_code, version)'
      'VALUES'
      '  (:prm_system_code,  public.str_to_ver4(:version))'
      '')
    ModifySQL.Strings = (
      'UPDATE private.system_version '
      'SET'
      '  version =public.str_to_ver4( :version)'
      'WHERE'
      '  system_version.system_code = :prm_system_code3 AND'
      '  system_version.version = public.str_to_ver4(:OLD_version)')
    UseSequenceFieldForRefreshSQL = False
    BeforeDeleteSQL = upSystemVersionBeforeDeleteSQL
    BeforeInsertSQL = upSystemVersionBeforeInsertSQL
    BeforeModifySQL = upSystemVersionBeforeModifySQL
    Left = 64
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'version'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_code3'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_version'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_code2'
        ParamType = ptUnknown
      end>
  end
  object dsSystemVersion: TDataSource
    DataSet = qSystemVersion
    Left = 120
    Top = 144
  end
  object qModuleVersion: TZQuery
    Connection = conn
    BeforeOpen = qModuleVersionBeforeOpen
    BeforeScroll = qModuleVersionBeforeScroll
    AfterScroll = qModuleVersionAfterScroll
    UpdateObject = upModuleVersion
    CachedUpdates = True
    SQL.Strings = (
      'SELECT '
      '  CAST(module_code AS VARCHAR(20)) AS module_code,'
      
        '  public.ver4_to_str("module_version")::::varchar(100) as versio' +
        'n'
      ' FROM '
      '  private.system_composition'
      'WHERE '
      '  system_code =:prm_system '
      '  AND system_version =str_to_ver4(:prm_system_version)'
      'ORDER BY'
      ' module_code')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_version'
        ParamType = ptUnknown
      end>
    Left = 232
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_version'
        ParamType = ptUnknown
      end>
    object qModuleVersionmodule_code: TWideStringField
      FieldName = 'module_code'
      Required = True
      Size = 40
    end
    object qModuleVersionversion: TWideStringField
      FieldName = 'version'
      Size = 200
    end
  end
  object upModuleVersion: TZUpdateSQL
    DeleteSQL.Strings = (
      'Select public.pgp_pub_check_module_version('
      '  3,'
      '  :prm_system_code, '
      '   public.str_to_ver4(:prm_system_version),'
      '   :module_code,'
      '    public.str_to_ver4(:version),'
      '   CAST(NULL AS character varying),'
      '   CAST(NULL AS ver4)'
      ')')
    InsertSQL.Strings = (
      'Select public.pgp_pub_check_module_version('
      '  1,'
      '  :prm_system_code, '
      '   public.str_to_ver4(:prm_system_version),'
      '   :module_code,'
      '    public.str_to_ver4(:version),'
      '   CAST(NULL AS character varying),'
      '   CAST(NULL AS ver4)'
      ')')
    ModifySQL.Strings = (
      'Select public.pgp_pub_check_module_version('
      '  2,'
      '  :prm_system_code, '
      '   public.str_to_ver4(:prm_system_version),'
      '   :module_code,'
      '    public.str_to_ver4(:version),'
      '   :OLD_module_code,'
      '   public.str_to_ver4(:OLD_version)'
      ')'
      '')
    UseSequenceFieldForRefreshSQL = False
    BeforeDeleteSQL = upModuleVersionBeforeDeleteSQL
    BeforeInsertSQL = upModuleVersionBeforeInsertSQL
    BeforeModifySQL = upModuleVersionBeforeModifySQL
    Left = 264
    Top = 160
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_version'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'version'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_version'
        ParamType = ptUnknown
      end>
  end
  object dsModuleVersion: TDataSource
    DataSet = qModuleVersion
    Left = 312
    Top = 136
  end
  object qModuleVerDiffInsrt: TZQuery
    Connection = conn
    SQL.Strings = (
      'INSERT INTO private.module_version_diff '
      
        '  (system_code, module_code, "version", destination_path, file_c' +
        'ontent)'
      
        'VALUES (:prm_system_code, :prm_module_code, str_to_ver4(:prm_mod' +
        'ule_ver),'
      '  :prm_dir_name,:prm_blob);')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_ver'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_dir_name'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_blob'
        ParamType = ptUnknown
      end>
    Left = 216
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_ver'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_dir_name'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_blob'
        ParamType = ptUnknown
      end>
  end
  object qModuleVerDiff: TZQuery
    Connection = conn
    SQL.Strings = (
      'SELECT '
      '  CAST(destination_path AS VARCHAR(160)), '
      '  octet_length(file_content) AS size_in_bytes'
      'FROM '
      '  private.module_version_diff '
      'WHERE'
      
        '  system_code = :prm_system_code AND module_code = :prm_module_c' +
        'ode'
      '  AND "version" = str_to_ver4(:prm_module_ver)'
      'ORDER BY destination_path ')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_ver'
        ParamType = ptUnknown
      end>
    Left = 216
    Top = 256
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_ver'
        ParamType = ptUnknown
      end>
    object qModuleVerDiffdestination_path: TWideStringField
      DisplayLabel = 'Path'
      DisplayWidth = 112
      FieldName = 'destination_path'
      Required = True
      Size = 100
    end
    object qModuleVerDiffsize_in_bytes: TIntegerField
      DisplayLabel = 'Size'
      DisplayWidth = 13
      FieldName = 'size_in_bytes'
      ReadOnly = True
    end
  end
  object qModuleVerDiffDel: TZQuery
    Connection = conn
    SQL.Strings = (
      'DELETE FROM private.module_version_diff '
      'WHERE '
      '  system_code = :prm_system  AND '
      '  module_code = :prm_module_code AND '
      '  destination_path = :prm_dir_path;')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_dir_path'
        ParamType = ptUnknown
      end>
    Left = 288
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_dir_path'
        ParamType = ptUnknown
      end>
  end
  object dsModuleVerDiff: TDataSource
    DataSet = qModuleVerDiff
    Left = 304
    Top = 256
  end
  object qDropBox: TZQuery
    Connection = conn
    Active = True
    SQL.Strings = (
      'SELECT '
      '  system_code, '
      '  code '
      'FROM '
      '  private.module'
      'WHERE '
      '  system_code= :prm_system'
      'ORDER BY'
      '  code')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end>
    DataSource = dsModule
    LinkedFields = 'code'
    Left = 392
    Top = 136
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system'
        ParamType = ptUnknown
      end>
    object qDropBoxsystem_code: TWideStringField
      FieldName = 'system_code'
      Required = True
      Size = 40
    end
    object qDropBoxcode: TWideStringField
      FieldName = 'code'
      Required = True
      Size = 40
    end
  end
  object dsComboBox: TDataSource
    DataSet = qDropBox
    Left = 456
    Top = 136
  end
  object qSite: TZQuery
    Connection = conn
    AfterScroll = qSiteAfterScroll
    UpdateObject = upSite
    Active = True
    SQL.Strings = (
      'SELECT '
      '  id,'
      '  CAST(updater_user AS VARCHAR(30)) AS updater_user,'
      '  CAST(description AS VARCHAR(30)) AS description,'
      '  CAST(address  AS VARCHAR(30)) AS address,'
      '  CAST(contact_person AS VARCHAR(30)) AS contact_person,'
      '  CAST(contact_phone AS VARCHAR(15)) AS contact_phone,'
      '  CAST(contact_email AS VARCHAR(30)) AS contact_email,'
      '  CAST(comment AS VARCHAR(30)) AS comment,'
      '  CAST(manager  AS VARCHAR(30)) AS manager,'
      '  CAST(db_uri AS VARCHAR(30)) AS db_uri '
      'FROM '
      '  private.site'
      'ORDER BY'
      '  id')
    Params = <>
    Left = 32
    Top = 320
    object qSiteid: TIntegerField
      FieldName = 'id'
      Required = True
    end
    object qSiteupdater_user: TWideStringField
      FieldName = 'updater_user'
      Size = 60
    end
    object qSitedescription: TWideStringField
      FieldName = 'description'
      Size = 60
    end
    object qSiteaddress: TWideStringField
      FieldName = 'address'
      Size = 60
    end
    object qSitecontact_person: TWideStringField
      FieldName = 'contact_person'
      Size = 60
    end
    object qSitecontact_phone: TWideStringField
      FieldName = 'contact_phone'
      Size = 30
    end
    object qSitecontact_email: TWideStringField
      FieldName = 'contact_email'
      Size = 60
    end
    object qSitecomment: TWideStringField
      FieldName = 'comment'
      Size = 60
    end
    object qSitemanager: TWideStringField
      FieldName = 'manager'
      Size = 60
    end
    object qSitedb_uri: TWideStringField
      FieldName = 'db_uri'
      Size = 60
    end
  end
  object upSite: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM private.site'
      'WHERE'
      '  site.id = :OLD_id')
    InsertSQL.Strings = (
      'INSERT INTO private.site'
      
        '  (id, updater_user, description, address, contact_person, conta' +
        'ct_phone, '
      '   contact_email, comment, manager, db_uri)'
      'VALUES'
      
        '  (:id, :updater_user, :description, :address, :contact_person, ' +
        ':contact_phone, '
      '   :contact_email, :comment, :manager, :db_uri)')
    ModifySQL.Strings = (
      'UPDATE private.site SET'
      '  id = :id,'
      '  updater_user = :updater_user,'
      '  description = :description,'
      '  address = :address,'
      '  contact_person = :contact_person,'
      '  contact_phone = :contact_phone,'
      '  contact_email = :contact_email,'
      '  comment = :comment,'
      '  manager = :manager,'
      '  db_uri = :db_uri'
      'WHERE'
      '  site.id = :OLD_id')
    UseSequenceFieldForRefreshSQL = False
    Left = 56
    Top = 344
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'updater_user'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'description'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'address'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'contact_person'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'contact_phone'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'contact_email'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'comment'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'manager'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'db_uri'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_id'
        ParamType = ptUnknown
      end>
  end
  object dsSite: TDataSource
    DataSet = qSite
    Left = 104
    Top = 320
  end
  object qSiteRunsSystem: TZQuery
    Connection = conn
    AfterScroll = qSiteRunsSystemAfterScroll
    UpdateObject = upSiteRunsSystem
    Active = True
    SQL.Strings = (
      'SELECT'
      '  CAST(system_code AS VARCHAR(20)) AS system_code,'
      '  last_deployment,'
      '  last_successfull_deployment'
      'FROM'
      '  private.site_runs_system'
      'WHERE'
      ' site =:prm_site')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_site'
        ParamType = ptUnknown
      end>
    Left = 304
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_site'
        ParamType = ptUnknown
      end>
    object qSiteRunsSystemsystem_code: TWideStringField
      DisplayWidth = 16
      FieldName = 'system_code'
      Size = 40
    end
    object qSiteRunsSystemlast_deployment: TIntegerField
      DisplayWidth = 16
      FieldName = 'last_deployment'
    end
    object qSiteRunsSystemlast_successfull_deployment: TIntegerField
      DisplayWidth = 27
      FieldName = 'last_successfull_deployment'
    end
  end
  object dsSiteRunsSystem: TDataSource
    DataSet = qSiteRunsSystem
    Left = 368
    Top = 336
  end
  object qSiteRunsModule: TZQuery
    Connection = conn
    UpdateObject = upSiteRunsModule
    Active = True
    SQL.Strings = (
      'SELECT '
      '  CAST(module_code AS VARCHAR(20)) AS module_code,'
      '  num_of_lic'
      'FROM private.site_runs_module'
      'WHERE'
      '  site =:prm_site AND'
      '  system_code =:prm_system_code  ')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_site'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end>
    Left = 448
    Top = 328
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_site'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end>
    object qSiteRunsModulemodule_code: TWideStringField
      FieldName = 'module_code'
      Size = 40
    end
    object qSiteRunsModulenum_of_lic: TIntegerField
      FieldName = 'num_of_lic'
      Required = True
    end
  end
  object dsSiteRunsModule: TDataSource
    DataSet = qSiteRunsModule
    Left = 528
    Top = 344
  end
  object qUser: TZQuery
    Connection = conn
    UpdateObject = upUser
    Active = True
    SQL.Strings = (
      'SELECT '
      '  CAST(username AS VARCHAR(20)) AS username,'
      '  CAST(name AS VARCHAR(20)) AS name, '
      '  CAST(email AS VARCHAR(30)) AS email, '
      '  CAST(phone AS VARCHAR(20)) AS phone, '
      '  active '
      'FROM '
      '  private.user'
      'ORDER BY'
      '  username ')
    Params = <>
    Left = 24
    Top = 400
    object qUserusername: TWideStringField
      FieldName = 'username'
      Size = 40
    end
    object qUsername: TWideStringField
      FieldName = 'name'
      Size = 40
    end
    object qUseremail: TWideStringField
      FieldName = 'email'
      Size = 60
    end
    object qUserphone: TWideStringField
      FieldName = 'phone'
      Size = 40
    end
    object qUseractive: TBooleanField
      FieldName = 'active'
      Required = True
    end
  end
  object upUser: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM private.user'
      'WHERE'
      '  username = :OLD_username')
    InsertSQL.Strings = (
      'INSERT INTO private.user'
      '  (username, name, email, phone, active)'
      'VALUES'
      '  (:username, :name, :email, :phone, :active)')
    ModifySQL.Strings = (
      'UPDATE private."user" SET'
      '  username = :username,'
      '  name = :name,'
      '  email = :email,'
      '  phone = :phone,'
      '  active = :active'
      'WHERE'
      '  username = :OLD_username')
    UseSequenceFieldForRefreshSQL = False
    Left = 64
    Top = 424
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'username'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'name'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'email'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'phone'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'active'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_username'
        ParamType = ptUnknown
      end>
  end
  object dsUser: TDataSource
    DataSet = qUser
    Left = 88
    Top = 400
  end
  object qUserCombobox: TZQuery
    Connection = conn
    AutoCalcFields = False
    Active = True
    SQL.Strings = (
      'SELECT'
      '  CAST(username AS VARCHAR(30)) AS username'
      'FROM'
      '  private.user'
      'ORDER BY'
      '  username')
    Params = <>
    Left = 160
    Top = 328
    object qUserComboboxusername: TWideStringField
      DisplayWidth = 25
      FieldName = 'username'
      ReadOnly = True
      Size = 40
    end
  end
  object dsUserComboBox: TDataSource
    DataSet = qUserCombobox
    Left = 216
    Top = 336
  end
  object upSiteRunsSystem: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM private.site_runs_system'
      'WHERE'
      '  site_runs_system.site = :prm_site AND'
      '  site_runs_system.system_code = :OLD_system_code')
    InsertSQL.Strings = (
      'INSERT INTO private.site_runs_system'
      
        '  (site, system_code, last_deployment, last_successfull_deployme' +
        'nt)'
      'VALUES'
      
        '  (:prm_site, :system_code, :last_deployment, :last_successfull_' +
        'deployment)')
    ModifySQL.Strings = (
      'UPDATE private.site_runs_system SET'
      '  system_code = :system_code,'
      '  last_deployment = :last_deployment,'
      '  last_successfull_deployment = :last_successfull_deployment'
      'WHERE'
      '  site_runs_system.site = :prm_site AND'
      '  site_runs_system.system_code = :OLD_system_code')
    UseSequenceFieldForRefreshSQL = False
    BeforeDeleteSQL = upSiteRunsSystemBeforeDeleteSQL
    BeforeInsertSQL = upSiteRunsSystemBeforeInsertSQL
    BeforeModifySQL = upSiteRunsSystemBeforeModifySQL
    Left = 320
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'last_deployment'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'last_successfull_deployment'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_site'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_system_code'
        ParamType = ptUnknown
      end>
  end
  object upSiteRunsModule: TZUpdateSQL
    DeleteSQL.Strings = (
      'DELETE FROM private.site_runs_module'
      'WHERE'
      '  site_runs_module.site = :prm_site AND'
      '  site_runs_module.system_code = :prm_system_code AND'
      '  site_runs_module.module_code = :OLD_module_code')
    InsertSQL.Strings = (
      'INSERT INTO private.site_runs_module'
      '  (site, system_code, module_code, num_of_lic)'
      'VALUES'
      '  (:prm_site, :prm_system_code, :module_code, :num_of_lic)')
    ModifySQL.Strings = (
      'UPDATE private.site_runs_module SET'
      '  module_code = :module_code,'
      '  num_of_lic = :num_of_lic'
      'WHERE'
      '  site_runs_module.site = :prm_site AND'
      '  site_runs_module.system_code = :prm_system_code AND'
      '  site_runs_module.module_code = :OLD_module_code')
    UseSequenceFieldForRefreshSQL = False
    BeforeDeleteSQL = upSiteRunsModuleBeforeDeleteSQL
    BeforeInsertSQL = upSiteRunsModuleBeforeInsertSQL
    BeforeModifySQL = upSiteRunsModuleBeforeModifySQL
    Left = 464
    Top = 368
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'module_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'num_of_lic'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_site'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'OLD_module_code'
        ParamType = ptUnknown
      end>
  end
  object qSiteRunsSystemCmbBox: TZQuery
    Connection = conn
    Active = True
    SQL.Strings = (
      'SELECT '
      '  code'
      'FROM '
      '  private.system'
      'ORDER BY'
      '  code')
    Params = <>
    Left = 280
    Top = 424
    object qSiteRunsSystemCmbBoxcode: TWideStringField
      FieldName = 'code'
      Required = True
      Size = 40
    end
  end
  object dsSiteRunsSystemCmbBox: TDataSource
    DataSet = qSiteRunsSystemCmbBox
    Left = 328
    Top = 432
  end
  object dsSiteRunsModuleCmbBox: TDataSource
    DataSet = qSiteRunsModuleCmbBox
    Left = 512
    Top = 432
  end
  object qSiteRunsModuleCmbBox: TZQuery
    Connection = conn
    SQL.Strings = (
      'SELECT '
      '  system_code,'
      '  code'
      'FROM'
      '  private.module'
      'WHERE'
      '   system_code =:prm_system_code '
      'ORDER BY'
      '  code')
    Params = <
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end>
    Left = 448
    Top = 424
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'prm_system_code'
        ParamType = ptUnknown
      end>
    object qSiteRunsModuleCmbBoxsystem_code: TWideStringField
      FieldName = 'system_code'
      Required = True
      Size = 40
    end
    object qSiteRunsModuleCmbBoxcode: TWideStringField
      FieldName = 'code'
      Required = True
      Size = 40
    end
  end
  object qModFileDiffView: TZQuery
    Connection = conn
    SQL.Strings = (
      'SELECT'
      '  system_code, '
      '  module_code,'
      '  "version",'
      '  destination_path,'
      '  file_content '
      'FROM '
      '  public.module_file_diff ')
    Params = <>
    Left = 72
    Top = 488
    object qModFileDiffViewsystem_code: TWideMemoField
      FieldName = 'system_code'
      BlobType = ftWideMemo
    end
    object qModFileDiffViewmodule_code: TWideMemoField
      FieldName = 'module_code'
      BlobType = ftWideMemo
    end
    object qModFileDiffViewdestination_path: TWideMemoField
      FieldName = 'destination_path'
      BlobType = ftWideMemo
    end
    object qModFileDiffViewfile_content: TBlobField
      FieldName = 'file_content'
    end
  end
  object dsModFileDiffView: TDataSource
    DataSet = qModFileDiffView
    Left = 136
    Top = 504
  end
end
