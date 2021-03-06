#this script is executed as inline script in metarunner

#authorize at Azure
$applicationId = "%azure.ApplicationId%";
$securePassword = ConvertTo-SecureString "%azure.ApplicationSecret%" -AsPlainText -Force;
$credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $applicationId, $securePassword;
Login-AzureRmAccount -Credential $credential -ServicePrincipal -TenantId "%azure.TenantId%";
Select-AzureRmSubscription -SubscriptionId "%azure.SubscriptionId%";

Write-Host "In input costsSaver.Downscale we have %costsSaver.Downscale%";
if ("%costsSaver.Downscale%".ToLower() -eq "true") {
    $Downscale = $true;
} else {
    $Downscale = $false;
}

Import-Module %system.teamcity.build.tempDir%\azure-costs-saver.psm1;

Set-ResourceSizesForCostsSaving -ResourceGroupName "%costsSaver.ResourceGroupName%" -Downscale $Downscale -executionEnv "teamcity";