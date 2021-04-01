 $report = @()
 $Dls = Get-DistributionGroup
 foreach ($dl in $dls) {
     $count = (Get-DistributionGroupMember $Dl).Count
     $Members = (get-distributiongroupmember $dl.name | select-object -ExpandProperty name ) -join "`n"
     $acccept1 = (Get-DistributionGroup $dl.Name | Select-Object -ExpandProperty AcceptMessagesOnlyFrom) -join "`n"
     $acccept2 = (Get-DistributionGroup $dl.Name | Select-Object -ExpandProperty AcceptMessagesOnlyFromDLMembers) -join "`n"
     $acccept3 = (Get-DistributionGroup $dl.Name | Select-Object -ExpandProperty AcceptMessagesOnlyFromSendersOrMembers) -join "`n"
     $memberof = Get-ADGroup $dl.Name -Properties memberof | select @{Expression = {$_.MemberOf}; Label="Value"}
      
      
     $reportObj = New-Object PSObject
     $reportObj | Add-Member NoteProperty -Name "Name" -Value $Dl.Displayname
     $reportObj | Add-Member NoteProperty -Name "PrimarySmtpAddress" -Value $dl.PrimarySmtpAddress
     $reportObj | Add-Member NoteProperty -Name "OrganizationalUnit" -Value $dl.OrganizationalUnit
     $reportObj | Add-Member NoteProperty -Name "GroupType" -Value $dl.GroupType
     $reportObj | Add-Member NoteProperty -Name "RequireSenderAuthenticationEnabled" -Value $dl.RequireSenderAuthenticationEnabled
     $reportObj | Add-Member NoteProperty -Name "MemberCount" -Value $count
     $reportObj | Add-Member NoteProperty -Name "HiddenFromAddressListsEnabled" -Value $dl.HiddenFromAddressListsEnabled
     $reportObj | Add-Member NoteProperty -Name "ManagedBy" -Value $dl.ManagedBy.name
     $reportObj | Add-Member NoteProperty -Name "DistributionGroupMember" -Value $Members
     $reportObj | Add-Member NoteProperty -Name "AcceptMessagesOnlyFrom" -Value $acccept1
     $reportObj | Add-Member NoteProperty -Name "AcceptMessagesOnlyFromDLMembers" -Value $acccept2
     $reportObj | Add-Member NoteProperty -Name "AcceptMessagesOnlyFromSendersOrMembers" -Value $acccept3
     $reportObj | Add-Member NoteProperty -Name "MemberOf" -Value $memberof.value  
            
     $report += $reportObj  
 }
 $report
