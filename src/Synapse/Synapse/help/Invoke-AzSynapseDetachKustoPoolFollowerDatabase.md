---
external help file:
Module Name: Az.Synapse
online version: https://learn.microsoft.com/powershell/module/az.synapse/invoke-azsynapsedetachkustopoolfollowerdatabase
schema: 2.0.0
---

# Invoke-AzSynapseDetachKustoPoolFollowerDatabase

## SYNOPSIS
Detaches all followers of a database owned by this Kusto Pool.

## SYNTAX

### DetachExpanded (Default)
```
Invoke-AzSynapseDetachKustoPoolFollowerDatabase -KustoPoolName <String> -ResourceGroupName <String>
 -WorkspaceName <String> -AttachedDatabaseConfigurationName <String> -KustoPoolResourceId <String>
 [-SubscriptionId <String>] [-DefaultProfile <PSObject>] [-AsJob] [-NoWait] [-PassThru] [-Confirm] [-WhatIf]
 [<CommonParameters>]
```

### DetachViaIdentityExpanded
```
Invoke-AzSynapseDetachKustoPoolFollowerDatabase -InputObject <ISynapseIdentity>
 -AttachedDatabaseConfigurationName <String> -KustoPoolResourceId <String> [-DefaultProfile <PSObject>]
 [-AsJob] [-NoWait] [-PassThru] [-Confirm] [-WhatIf] [<CommonParameters>]
```

## DESCRIPTION
Detaches all followers of a database owned by this Kusto Pool.

## EXAMPLES

### Example 1: Detach a follower database
```powershell
Invoke-AzSynapseDetachKustoPoolFollowerDatabase -ResourceGroupName testrg -WorkspaceName testws -KustoPoolName testkustopool -AttachedDatabaseConfigurationName "myfollowerconfiguration" -KustoPoolResourceId "/subscriptions/$subscriptionId/resourcegroups/testrg/providers/Microsoft.Synapse/workspaces/testws/kustoPools/testfollowerkustopool"

```

The above command detaches the follower database defined in AttachedDatabaseConfiguration "myfollowerconfiguration" from Kusto Pool "testfollowerkustopool".

## PARAMETERS

### -AsJob
Run the command as a job

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -AttachedDatabaseConfigurationName
Resource name of the attached database configuration in the follower cluster.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DefaultProfile
The credentials, account, tenant, and subscription used for communication with Azure.

```yaml
Type: System.Management.Automation.PSObject
Parameter Sets: (All)
Aliases: AzureRMContext, AzureCredential

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputObject
Identity Parameter
To construct, see NOTES section for INPUTOBJECT properties and create a hash table.

```yaml
Type: Microsoft.Azure.PowerShell.Cmdlets.Synapse.Models.ISynapseIdentity
Parameter Sets: DetachViaIdentityExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -KustoPoolName
The name of the Kusto pool.

```yaml
Type: System.String
Parameter Sets: DetachExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -KustoPoolResourceId
Resource id of the cluster that follows a database owned by this cluster.

```yaml
Type: System.String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoWait
Run the command asynchronously

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Returns true when the command succeeds

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroupName
The name of the resource group.
The name is case insensitive.

```yaml
Type: System.String
Parameter Sets: DetachExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SubscriptionId
The ID of the target subscription.

```yaml
Type: System.String
Parameter Sets: DetachExpanded
Aliases:

Required: False
Position: Named
Default value: (Get-AzContext).Subscription.Id
Accept pipeline input: False
Accept wildcard characters: False
```

### -WorkspaceName
The name of the workspace

```yaml
Type: System.String
Parameter Sets: DetachExpanded
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: System.Management.Automation.SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### Microsoft.Azure.PowerShell.Cmdlets.Synapse.Models.ISynapseIdentity

## OUTPUTS

### System.Boolean

## NOTES

ALIASES

COMPLEX PARAMETER PROPERTIES

To create the parameters described below, construct a hash table containing the appropriate properties. For information on hash tables, run Get-Help about_Hash_Tables.


INPUTOBJECT `<ISynapseIdentity>`: Identity Parameter
  - `[AttachedDatabaseConfigurationName <String>]`: The name of the attached database configuration.
  - `[DataConnectionName <String>]`: The name of the data connection.
  - `[DatabaseName <String>]`: The name of the database in the Kusto pool.
  - `[Id <String>]`: Resource identity path
  - `[KustoPoolName <String>]`: The name of the Kusto pool.
  - `[Location <String>]`: The name of Azure region.
  - `[PrincipalAssignmentName <String>]`: The name of the Kusto principalAssignment.
  - `[ResourceGroupName <String>]`: The name of the resource group. The name is case insensitive.
  - `[SubscriptionId <String>]`: The ID of the target subscription.
  - `[WorkspaceName <String>]`: The name of the workspace

## RELATED LINKS

