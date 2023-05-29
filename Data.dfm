object DataForm: TDataForm
  OldCreateOrder = False
  Height = 150
  Width = 215
  object GameConnection: TUniConnection
    ProviderName = 'SQLite'
    SpecificOptions.Strings = (
      'SQLite.Direct=True'
      'SQLite.UseUnicode=True')
    LoginPrompt = False
    Left = 48
    Top = 14
  end
end
