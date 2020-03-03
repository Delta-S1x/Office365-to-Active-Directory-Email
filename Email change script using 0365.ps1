#########################################################################################
# THIS SCRIPT WILL PULL ALL OFFICE 365 NAMES IN AND MATCH THEM TO AD USER ACCOUNTS FIRST AND LAST NAMES, POPULATING THE EMAIL FIELD WITH THE RIGHT EMAIL

Connect-AzureAD


$users = Get-AzureADUser -All:$True
$users.DisplayName.count
#$users.UserPrincipalName
Get-ADUser -Filter * | Sort-Object -Property Name |
ForEach-Object {$currentADUser = $_ 
    write-host $currentADUser.Name
    $users | ForEach-Object{
    If ($currentADUser.Name -eq $_.DisplayName){
    write-host $currentADUser.Name
    Set-ADUser  -Identity $currentADUser.samaccountname  -EmailAddress ($_.UserPrincipalName)
    }
}

}
#########################################################################################

#########################################################################################
 # THIS SCRIPT WILL PULL ALL OFFICE 365 EMAILS AND MATCH THEM IF THE SAMACCOUNT NAME IS IN THE EMAIL ADDRESS, POPULATING THE EMAIL FIELD WITH THE RIGHT EMAIL
 
Connect-AzureAD

#$users.UserPrincipalName
Get-ADUser -Filter * | Sort-Object -Property Name |
ForEach-Object {$currentADUser = $_ 
    write-host $currentADUser.Name
    $users | ForEach-Object{
    $sam = $currentADUser.samaccountname
    If ($_.UserPrincipalName -like "$sam*"){
    write-host $currentADUser.Name
    Set-ADUser  -Identity $currentADUser.samaccountname  -EmailAddress ($_.UserPrincipalName)
    }
}

}

#########################################################################################