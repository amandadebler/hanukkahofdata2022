# Run Day1.ps1 and Day2.ps1
# All customers matching Day2's "JD"'s Zip Code (a good approximation for neighborhood in US cities)
$JDsNeighbors = $customersRaw | where { $_.citystatezip.split(' ')[-1] -eq '11420' }
# 55 customers in this Zip, so might just need the birth year
# Looked up Chinese Zodiac; first Dog year listed was 1934
1934 % 12
# 2
function Test-IsDogYear { param($year); ([Int]$year % 12 -eq 2) } 
$JDsNeighbors | where { Test-IsDogYear $_.birthdate.split('-')[0] }
# 4 results, only one of which was March/April, so no Test-IsAries needed
