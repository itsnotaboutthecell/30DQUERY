/*
  Submitted: 5/2/2020
  URL: https://www.reddit.com/r/PowerBI/comments/gc8rgv/30_days_30_power_query_query_folding_challenges/fpay4oq?utm_source=share&utm_medium=web2x
*/

let
    Source = Sql.Databases("..."),
    AdventureWorksDW = Source{[Name="AdventureWorksDW"]}[Data],
    dbo_DimEmployee = AdventureWorksDW{[Schema="dbo",Item="DimEmployee"]}[Data],
    Only1974 = Table.SelectRows(dbo_DimEmployee, each [BirthDate] >= #date(1974, 1, 1) and [BirthDate] < #date(1975, 1, 1)),
    AddFullName = Table.AddColumn(Only1974, "FullName", each [FirstName] & " " & (if [MiddleName] = null then "" else [MiddleName] & " ") & [LastName]),
   SelectColumns = Table.SelectColumns(AddFullName,{"EmployeeKey", "Gender", "BirthDate", "FullName"})
in
    SelectColumns
