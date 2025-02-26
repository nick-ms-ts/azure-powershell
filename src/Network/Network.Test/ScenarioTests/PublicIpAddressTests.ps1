﻿# ----------------------------------------------------------------------------------
#
# Copyright Microsoft Corporation
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ----------------------------------------------------------------------------------

<#
.SYNOPSIS
Tests creating new simple publicIpAddress.
#>
function Test-PublicIpAddressCRUD
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $job = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel -AsJob
      $job | Wait-Job
	  $actual = $job | Receive-Job
	  $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName	
      Assert-AreEqual $expected.Name $actual.Name	
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.ResourceGuid
      Assert-AreEqual "Succeeded" $expected.ProvisioningState
      Assert-AreEqual $domainNameLabel $expected.DnsSettings.DomainNameLabel
      
      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName  
      Assert-AreEqual $list[0].Name $actual.Name    
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqual "Dynamic" $list[0].PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState
      Assert-AreEqual $domainNameLabel $list[0].DnsSettings.DomainNameLabel

      $list = Get-AzPublicIpAddress -ResourceGroupName "*"
      Assert-True { $list.Count -ge 0 }

      $list = Get-AzPublicIpAddress -Name "*"
      Assert-True { $list.Count -ge 0 }

      $list = Get-AzPublicIpAddress -ResourceGroupName "*" -Name "*"
      Assert-True { $list.Count -ge 0 }
      
      # delete
      $job = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force -AsJob
	  $job | Wait-Job
	  $delete = $job | Receive-Job
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress without DomainNameLabel.
#>
function Test-PublicIpAddressCRUD-NoDomainNameLabel
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $expected.Name $actual.Name   
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $expected.ProvisioningState

      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName  
      Assert-AreEqual $list[0].Name $actual.Name    
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqual "Dynamic" $list[0].PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress with Static allocation.
#>
function Test-PublicIpAddressCRUD-StaticAllocation
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Static
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $expected.Name $actual.Name   
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqual "Static" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.IpAddress
      Assert-AreEqual "Succeeded" $expected.ProvisioningState

      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName  
      Assert-AreEqual $list[0].Name $actual.Name    
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqual "Static" $list[0].PublicIpAllocationMethod
      Assert-NotNull $list[0].IpAddress
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests edit the domain name label of a publicIpAddress.
#>
function Test-PublicIpAddressCRUD-EditDomainNameLavel
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $newDomainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel
      $publicip = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $publicip.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $publicip.Name $actual.Name   
      Assert-AreEqual $publicip.Location $actual.Location
      Assert-AreEqual "Dynamic" $publicip.PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $publicip.ProvisioningState
      Assert-AreEqual $domainNameLabel $publicip.DnsSettings.DomainNameLabel
      
      $publicip.DnsSettings.DomainNameLabel = $newDomainNameLabel

      # Set publicIpAddress
      $job = $publicip | Set-AzPublicIpAddress -AsJob
      $job | Wait-Job

      $publicip = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $newDomainNameLabel $publicip.DnsSettings.DomainNameLabel
      
      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests edit the domain name label of a publicIpAddress.
#>
function Test-PublicIpAddressCRUD-ReverseFqdn
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel
      $publicip = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $publicip.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $publicip.Name $actual.Name   
      Assert-AreEqual $publicip.Location $actual.Location
      Assert-AreEqual "Dynamic" $publicip.PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $publicip.ProvisioningState
      Assert-AreEqual $domainNameLabel $publicip.DnsSettings.DomainNameLabel
      
      $publicip.DnsSettings.ReverseFqdn = $publicip.DnsSettings.Fqdn

      # Set publicIpAddress
      $publicip | Set-AzPublicIpAddress

      $publicip = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $publicip.DnsSettings.Fqdn $publicip.DnsSettings.ReverseFqdn
      
      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests edit the domain name label of a publicIpAddress with Iptags
#>
function Test-PublicIpAddressCRUD-IpTag
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent

    try
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      $IpTag = New-AzPublicIpTag -IpTagType "FirstPartyUsage" -Tag "/Sql"

      Assert-AreEqual $IpTag.IpTagType "FirstPartyUsage"
      Assert-AreEqual $IpTag.Tag "/Sql"

	  # Routing Preference behind feature flag testing to ensure value is valid
	  $IpTag2 = New-AzPublicIpTag -IpTagType "RoutingPreference" -Tag "/Internet"

      Assert-AreEqual $IpTag2.IpTagType "RoutingPreference"
      Assert-AreEqual $IpTag2.Tag "/Internet"

      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel -IpTag $IpTag
      $publicip = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $publicip.ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $publicip.Name $actual.Name
      Assert-AreEqual $publicip.Location $actual.Location
      Assert-AreEqual "Dynamic" $publicip.PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $publicip.ProvisioningState
      Assert-AreEqual $domainNameLabel $publicip.DnsSettings.DomainNameLabel

      # Set publicIpAddress
      $publicip | Set-AzPublicIpAddress

      $publicip = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual "FirstPartyUsage" $publicip.IpTags.IpTagType
      Assert-AreEqual "/Sql" $publicip.IpTags.Tag

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete

      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new publicIpAddress with IpVersion.
#>
function Test-PublicIpAddressIpVersion
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $rname1 = Get-ResourceName
    $rname2 = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres with default ipversion
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $expected.Name $actual.Name   
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.ResourceGuid
      Assert-AreEqual "Succeeded" $expected.ProvisioningState
      Assert-AreEqual $domainNameLabel $expected.DnsSettings.DomainNameLabel
      Assert-AreEqual $expected.PublicIpAddressVersion IPv4
      
      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName  
      Assert-AreEqual $list[0].Name $actual.Name    
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqual "Dynamic" $list[0].PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState
      Assert-AreEqual $domainNameLabel $list[0].DnsSettings.DomainNameLabel
      Assert-AreEqual $list[0].PublicIpAddressVersion IPv4

      # Create publicIpAddres with IPv4 ipversion
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname1 -location $location -AllocationMethod Dynamic -IpAddressVersion IPv4
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname1
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $expected.Name $actual.Name   
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.ResourceGuid
      Assert-AreEqual "Succeeded" $expected.ProvisioningState      
      Assert-AreEqual $expected.PublicIpAddressVersion IPv4
      
      # Create publicIpAddres with IPv6 ipversion
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname2 -location $location -AllocationMethod Dynamic -IpAddressVersion IPv6
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname2
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $expected.Name $actual.Name   
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.ResourceGuid
      Assert-AreEqual "Succeeded" $expected.ProvisioningState      
      Assert-AreEqual $expected.PublicIpAddressVersion IPv6

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete

      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname1 -PassThru -Force
      Assert-AreEqual true $delete

      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname2 -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

function Get-NameById($Id, $ResourceType)
{
    $name = $Id.Substring($Id.IndexOf($ResourceType + '/') + $ResourceType.Length + 1);
    if ($name.IndexOf('/') -ne -1)
    {
        $name = $name.Substring(0, $name.IndexOf('/'));
    }
    return $name;
}

<#
.SYNOPSIS
Tests checking VMSSPublicIP features.
#>
function Test-PublicIpAddressVmss
{
    # Setup
    $rgname = Get-ResourceGroupName
    $vnetName = Get-ResourceName
    $subnetName = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Compute/virtualMachineScaleSets"
    $location = Get-ProviderLocation $resourceTypeParent

    try
    {
        . ".\AzureRM.Resources.ps1"

        # Create the resource group
        $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
        $vmssName = "vmssip"
        $templateFile = (Resolve-Path ".\ScenarioTests\Data\VmssDeploymentTemplate.json").Path
        New-AzResourceGroupDeployment -Name $rgname -ResourceGroupName $rgname -TemplateFile $templateFile;

        $listAllResults = Get-AzPublicIpAddress -ResourceGroupName $rgname -VirtualMachineScaleSetName $vmssName;
        Assert-NotNull $listAllResults;

        $listFirstResultId = $listAllResults[0].Id;
        $vmIndex = Get-NameById $listFirstResultId "virtualMachines";
        $nicName = Get-NameById $listFirstResultId "networkInterfaces";
        $ipConfigName = Get-NameById $listFirstResultId "ipConfigurations";
        $ipName = Get-NameById $listFirstResultId "publicIPAddresses";

        $listResults = Get-AzPublicIpAddress -ResourceGroupName $rgname -VirtualMachineScaleSetName $vmssName -VirtualmachineIndex $vmIndex -NetworkInterfaceName $nicName -IpConfigurationName $ipConfigName;
        Assert-NotNull $listResults;
        Assert-AreEqualObjectProperties $listAllResults[0] $listResults[0] "List and list all results should contain equal items";

        $vmssIp = Get-AzPublicIpAddress -ResourceGroupName $rgname -VirtualMachineScaleSetName $vmssName -VirtualmachineIndex $vmIndex -NetworkInterfaceName $nicName -IpConfigurationName $ipConfigName -Name $ipName;
        Assert-NotNull $vmssIp;
        Assert-AreEqualObjectProperties $vmssIp $listResults[0] "List and get results should contain equal items";
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress.
#>
function Test-PublicIpAddressCRUD-BasicSku
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel -Sku Basic
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName 
      Assert-AreEqual $expected.Name $actual.Name   
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqualObjectProperties $expected.Sku $actual.Sku
      Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.ResourceGuid
      Assert-AreEqual "Succeeded" $expected.ProvisioningState
      Assert-AreEqual $domainNameLabel $expected.DnsSettings.DomainNameLabel
      
      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName  
      Assert-AreEqual $list[0].Name $actual.Name    
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqualObjectProperties $list[0].Sku $actual.Sku
      Assert-AreEqual "Dynamic" $list[0].PublicIpAllocationMethod
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState
      Assert-AreEqual $domainNameLabel $list[0].DnsSettings.DomainNameLabel
      
      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress with Static allocation.
#>
function Test-PublicIpAddressCRUD-StandardSku
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Static -Sku Standard -DomainNameLabel $domainNameLabel
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $expected.Name $actual.Name
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqualObjectProperties $expected.Sku $actual.Sku
      Assert-AreEqual "Static" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.IpAddress
      Assert-AreEqual "Succeeded" $expected.ProvisioningState

      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $list[0].Name $actual.Name
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqualObjectProperties $list[0].Sku $actual.Sku
      Assert-AreEqual "Static" $list[0].PublicIpAllocationMethod
      Assert-NotNull $list[0].IpAddress
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress with Ddos Protection
#>
function Test-PublicIpAddressCRUD-DdosProtection
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $ddosProtectionPlanName = Get-ResourceName  
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent

    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddress
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Static -Sku Standard -DdosProtectionMode "Enabled"
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $expected.Name $actual.Name
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqualObjectProperties $expected.Sku $actual.Sku
      Assert-AreEqual "Static" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.IpAddress
      Assert-AreEqual "Succeeded" $expected.ProvisioningState
      Assert-AreEqual "Enabled" $expected.DdosSettings.ProtectionMode

      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $list[0].Name $actual.Name
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqualObjectProperties $list[0].Sku $actual.Sku
      Assert-AreEqual "Static" $list[0].PublicIpAllocationMethod
      Assert-NotNull $list[0].IpAddress
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState
      Assert-AreEqual "Enabled" $expected.DdosSettings.ProtectionMode

      #create ddos protection plan
      $ddpp = New-AzDdosProtectionPlan -Name $ddosProtectionPlanName -ResourceGroupName $rgname -Location $location

      # attach plan to pip
      $actual.DdosSettings.DdosProtectionPlan = New-Object Microsoft.Azure.Commands.Network.Models.PSResourceId
      $actual.DdosSettings.DdosProtectionPlan.Id = $ddpp.Id 
      $pip = Set-AzPublicIpAddress -PublicIpAddress $actual

      $pip = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $ddpp.Id $pip.DdosSettings.DdosProtectionPlan.Id

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress with Static allocation and global tier.
#>
function Test-PublicIpAddressCRUD-StandardSkuGlobalTier
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = "eastus2euap"
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Static -Sku Standard -Tier Global -DomainNameLabel $domainNameLabel
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $expected.Name $actual.Name
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqualObjectProperties $expected.Sku $actual.Sku
      Assert-AreEqual "Static" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.IpAddress
      Assert-AreEqual "Succeeded" $expected.ProvisioningState

      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $list[0].Name $actual.Name
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqualObjectProperties $list[0].Sku $actual.Sku
      Assert-AreEqual "Static" $list[0].PublicIpAllocationMethod
      Assert-NotNull $list[0].IpAddress
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress.
#>
function Test-PublicIpAddressZones
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $zones = "1";
    $rglocation = Get-ProviderLocation ResourceManagement
    $location = Get-ProviderLocation "Microsoft.Network/publicIpAddresses" "Central US"

    try
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" }

      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Dynamic -Zone $zones;
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $expected.Name $actual.Name
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.ResourceGuid
      Assert-AreEqual "Succeeded" $expected.ProvisioningState
      Assert-AreEqual $zones $expected.Zones[0]
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new simple publicIpAddress from a PublicIPPrefix.
#>
function Test-PublicIpAddressCRUD-PublicIPPrefix
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $resourceTypeParent = "Microsoft.Network/publicIpAddresses"
    $location = Get-ProviderLocation $resourceTypeParent
   
    try 
     {
      # Create the resource group
      $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation -Tags @{ testtag = "testval" } 
      
      # Create a PublicIPPrefix
      $prefixname = $rname + "prfx"
      $PublicIpPrefix = New-AzPublicIpPrefix -ResourceGroupName $rgname -name $prefixname -location $location -Sku Standard -prefixLength 30
      $expectedPublicIpPrefix = Get-AzPublicIpPrefix -ResourceGroupName $rgname -name $prefixname
      Assert-AreEqual $expectedPublicIpPrefix.ResourceGroupName $PublicIpPrefix.ResourceGroupName
      Assert-AreEqual $expectedPublicIpPrefix.Name $PublicIpPrefix.Name
      Assert-AreEqual $expectedPublicIpPrefix.Location $PublicIpPrefix.Location
      Assert-AreEqualObjectProperties $expectedPublicIpPrefix.Sku $PublicIpPrefix.Sku
      Assert-NotNull $expectedPublicIpPrefix.IPPrefix

      # Create publicIpAddres
      $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -AllocationMethod Static -Sku Standard -DomainNameLabel $domainNameLabel -PublicIPPrefix $expectedPublicIpPrefix
      $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
      Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $expected.Name $actual.Name
      Assert-AreEqual $expected.Location $actual.Location
      Assert-AreEqualObjectProperties $expected.Sku $actual.Sku
      Assert-AreEqual "Static" $expected.PublicIpAllocationMethod
      Assert-NotNull $expected.IpAddress
      Assert-AreEqual "Succeeded" $expected.ProvisioningState

      # list
      $list = Get-AzPublicIpAddress -ResourceGroupName $rgname
      Assert-AreEqual 1 @($list).Count
      Assert-AreEqual $list[0].ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual $list[0].Name $actual.Name
      Assert-AreEqual $list[0].Location $actual.Location
      Assert-AreEqualObjectProperties $list[0].Sku $actual.Sku
      Assert-AreEqual "Static" $list[0].PublicIpAllocationMethod
      Assert-NotNull $list[0].IpAddress
      Assert-AreEqual "Succeeded" $list[0].ProvisioningState

      # delete
      $delete = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force
      Assert-AreEqual true $delete
      
      $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
      Assert-AreEqual 0 @($list).Count
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Tests creating new publicIpAddress with idle timeout.
#>
function Test-PublicIpAddressCRUD-IdleTimeout
{
    # Setup
    $rgname = Get-ResourceGroupName
    $rname = Get-ResourceName
    $domainNameLabel = Get-ResourceName
    $rglocation = Get-ProviderLocation ResourceManagement
    $location = Get-ProviderLocation "Microsoft.Network/publicIpAddresses"

    try
    {
        # Create the resource group
        $resourceGroup = New-AzResourceGroup -Name $rgname -Location $rglocation 

        # Create public ip address
        $actual = New-AzPublicIpAddress -ResourceGroupName $rgname -name $rname -location $location -IdleTimeoutInMinutes 15 -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel
        $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
        Assert-AreEqual $expected.ResourceGroupName $actual.ResourceGroupName 
        Assert-AreEqual $expected.Name $actual.Name 
        Assert-AreEqual $expected.Location $actual.Location
        Assert-NotNull $expected.ResourceGuid
        Assert-AreEqual "Dynamic" $expected.PublicIpAllocationMethod
        Assert-AreEqual "Succeeded" $expected.ProvisioningState
        Assert-AreEqual $domainNameLabel $expected.DnsSettings.DomainNameLabel
        Assert-AreEqual 15 $expected.IdleTimeoutInMinutes

        # Set public ip address
        $actual.IdleTimeoutInMinutes = 30
        $actual = Set-AzPublicIpAddress -PublicIpAddress $actual
        $expected = Get-AzPublicIpAddress -ResourceGroupName $rgname -name $rname
        Assert-AreEqual 30 $expected.IdleTimeoutInMinutes

        # delete
        $job = Remove-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName -name $rname -PassThru -Force -AsJob
        $job | Wait-Job
        $delete = $job | Receive-Job
        Assert-AreEqual true $delete

        $list = Get-AzPublicIpAddress -ResourceGroupName $actual.ResourceGroupName
        Assert-AreEqual 0 @($list).Count

        $list = Get-AzPublicIpAddress | Where-Object { $_.ResourceGroupName -eq $actual.ResourceGroupName -and $_.Name -eq $actual.Name }
        Assert-AreEqual 0 @($list).Count

        # test error handling
        Assert-ThrowsContains { Set-AzPublicIpAddress -PublicIpAddress $actual } "not found";
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $rgname
    }
}

<#
.SYNOPSIS
Test for creating a new simple publicIpAddress in an edge zone. Subscriptions need to be explicitly whitelisted for access to edge zones.
#>
function Test-PublicIpAddressInEdgeZone
{
    # Setup
    $resourceName = Get-ResourceName
	$domainNameLabel = Get-ResourceName
    $resourceGroupName = Get-ResourceGroupName
    $locationName = 'westus'
    $edgeZone = 'microsoftlosangeles1'

    try
    {
        # Create the resource group
        New-AzResourceGroup -Name $resourceGroupName -Location $locationName

        # Create publicIpAddres
        New-AzPublicIpAddress -ResourceGroupName $resourceGroupName -Name $resourceName -Location $locationName -EdgeZone $edgeZone -AllocationMethod Dynamic -DomainNameLabel $domainNameLabel

        $publicIP = Get-AzPublicIpAddress -Name $resourceName -ResourceGroupName $resourceGroupName
        Assert-AreEqual $publicIP.ExtendedLocation.Name $edgeZone
        Assert-AreEqual $publicIP.ExtendedLocation.Type 'EdgeZone'
    }
    catch [Microsoft.Azure.Commands.Network.Common.NetworkCloudException]
    {
        Assert-NotNull { $_.Exception.Message -match 'Resource type .* does not support edge zone .* in location .* The supported edge zones are .*' }
    }
    finally
    {
        # Cleanup
        Clean-ResourceGroup $resourceGroupName
    }
}
