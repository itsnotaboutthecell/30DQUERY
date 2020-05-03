/*
  Date: 5/2/2020
  URL: https://www.reddit.com/r/PowerBI/comments/gc8rgv/30_days_30_power_query_query_folding_challenges/fpasemy?utm_source=share&utm_medium=web2x
*/

let
  Source = Sql.Databases("localhost\SQLEXPRESS", [CreateNavigationProperties = false]),
  AdventureWorksDW2017 = Source{[Name = "AdventureWorksDW2017"]}[Data],
  dbo_DimEmployee = AdventureWorksDW2017{[Schema = "dbo", Item = "DimEmployee"]}[Data],
  Select1974 = Table.SelectRows(
    dbo_DimEmployee, 
    each Date.Year([BirthDate]) = 1974
  ),
  AddFullName = Table.AddColumn(
    Select1974, 
    "FullName", 
    each [FirstName] & " " & (if [MiddleName] = null
      then ""
      else [MiddleName] & " ") & [LastName], 
    type text
  ),
  SelectColumns = AddFullName[[EmployeeKey], [Gender], [BirthDate], [FullName]]
in
  SelectColumns
