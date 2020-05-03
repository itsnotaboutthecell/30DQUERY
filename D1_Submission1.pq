/*
  Submitted: 5/2/2020
  URL: https://www.linkedin.com/feed/update/urn:li:activity:6662377205487800320?commentUrn=urn%3Ali%3Acomment%3A%28activity%3A6662377205487800320%2C6662469751735934979%29
*/

let
    Source = Sql.Database("localhost", "AdventureWorksDW2017"),
    dbo_DimEmployee = Source{[Schema="dbo",Item="DimEmployee"]}[Data],
    #"Replaced Value" = Table.ReplaceValue(dbo_DimEmployee,null,"",Replacer.ReplaceValue,{"FirstName", "LastName", "MiddleName"}),
    #"Added Custom" = Table.AddColumn(#"Replaced Value", "FullName", each [FirstName] & " " & [MiddleName] & " " & [LastName]),
    #"Changed Type" = Table.TransformColumnTypes(#"Added Custom",{{"FullName", type text}}),
    #"Inserted Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([BirthDate]), Int64.Type),
    #"Filtered Rows" = Table.SelectRows(#"Inserted Year", each ([Year] = 1974)),
    #"Removed Other Columns" = Table.SelectColumns(#"Filtered Rows",{"EmployeeKey", "Gender", "BirthDate", "FullName"})
in
    #"Removed Other Columns"
