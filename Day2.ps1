# Run Day1.ps1 first
$productsRaw = import-csv ./noahs-csv/noahs-products.csv
$ordersItemsRaw = import-csv ./noahs-csv/noahs-orders_items.csv
$ordersRaw = import-csv ./noahs-csv/noahs-orders.csv
function Get-FirstName { param ($fullName); $tokenized = $fullName.split(' '); $tokenized[0]}
function Get-Initials { param($fullName); $firstInitial = (Get-FirstName $fullName).toCharArray()[0]; $lastInitial = (Get-LastName $fullName).toCharArray()[0]; ($firstInitial + $lastInitial).toUpper() }
$allJDs = $customersRaw | where { (Get-Initials $_.name) -eq 'JD' }
# 66 results - plausible!
$productsRaw | where { ($_.desc -like "*coffee*") -or ($_.desc -like "*bagel*") }
# several coffee accessories, but only coffee to consume is DLI1464, and two bagel types are BKY5887 and BKY4234
# look for orders that contain both coffee and at least one of the two bagels
$ordersWithCoffee = $ordersItemsRaw | where { $_.sku -eq 'DLI1464' }
# orders from 'JD' in 2017
$allJD2017Orders = $ordersRaw | where { ($_.ordered.split('-')[0] -eq '2017') -and ($_.customerid -in $allJDs.customerid) }
# $allJD2017Orders.count = 223; also plausible
$allJD2017OrdersWithCoffee = $allJD2017Orders | where { $_.orderid -in $ordersWithCoffee.orderid }
# single result with total purchase of 33.22! No need to go on with the bagels
