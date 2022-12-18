$customersRaw = Import-Csv ./noahs-csv/noahs-customers.csv
function Get-NumbersOnlyPhone { param ($phoneRaw); $phoneRaw.replace('-','') }
function Get-LastName { param ($fullName); $tokenized = $fullName.split(' '); if (('Jr.','Sr.','II','III','IV','V') -notcontains $tokenized[-1]) { $tokenized[-1]} else {$tokenized[-2]}}
$T9Hash = @{'a'=2;'b'=2;'c'=2;'d'=3;'e'=3;'f'=3;'g'=4;'h'=4;'i'=4;'j'=5;'k'=5;'l'=5;'m'=6;'n'=6;'o'=6;'p'=7;'q'=7;'r'=7;'s'=7;'t'=8;'u'=8;'v'=8;'w'=9;'x'=9;'y'=9;z='9'}
function Get-T9 {param ($alphaString); $charArray = $alphaString.ToCharArray(); $T9String=''; foreach ($char in $charArray) {$T9String += $T9Hash."$char"}; $T9String} 
foreach ($customer in $customersRaw) { if ((Get-NumbersOnlyPhone $customer.phone) -match (Get-T9 (Get-LastName $customer.name))) {$customer.name; $customer.phone}}
# Then chose the best result; all of the matches were on really short surnames - except the correct one.
