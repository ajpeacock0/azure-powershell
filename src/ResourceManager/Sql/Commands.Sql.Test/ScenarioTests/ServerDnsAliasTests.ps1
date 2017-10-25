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
	Tests creating a server dns alias
#>

function Test-CreateServerDNSAlias
{
	# Setup
	$location = "East US 2 EUAP"
	$rg = Create-ResourceGroupForTest $location 	
	$server = Create-ServerForTest $rg $location

	$serverDnsAliasName = Get-ServerDnsAliasName

	try
	{
		$serverDnsAlias = New-AzureRmSqlServerDNSAlias -ResourceGroupName $rg.ResourceGroupName -ServerName $server.ServerName -ServerDNSAliasName $serverDnsAliasName
		Assert-AreEqual $serverDnsAlias.ServerName $server.ServerName
		Assert-AreEqual $serverDnsAlias.ServerDNSAliasName $serverDnsAliasName
	}
	finally
	{
		Remove-ResourceGroupForTest $rg
	}
}

<#
	.SYNOPSIS
	Tests getting server dns alias
#>

function Test-GetServerDNSAlias
{
	# Setup
	$location = "East US 2 EUAP"
	$rg = Create-ResourceGroupForTest $location 	
	$server = Create-ServerForTest $rg $location

	$serverDnsAliasName = Get-ServerDnsAliasName

	try
	{
		# Create server dns alias
		$serverDnsAlias = New-AzureRmSqlServerDNSAlias -ResourceGroupName $rg.ResourceGroupName -ServerName $server.ServerName -ServerDNSAliasName $serverDnsAliasName
		Assert-AreEqual $serverDnsAlias.ServerName $server.ServerName
		Assert-AreEqual $serverDnsAlias.ServerDNSAliasName $serverDnsAliasName

		# Get server dns alias
		$resp = Get-AzureRmSqlServerDNSAlias -ResourceGroupName $rg.ResourceGroupName -ServerName $server.ServerName -ServerDNSAliasName $serverDnsAliasName
		Assert-AreEqual $resp.ServerName $serverName
		Assert-AreEqual $resp.ServerDNSAliasName $serverDnsAliasName
	}
	finally
	{
		Remove-ResourceGroupForTest $rg
	}
}

<#
	.SYNOPSIS
	Tests removing server dns alias
#>

function Test-RemoveServerDNSAlias
{
	# Setup
	$location = "East US 2 EUAP"
	$rg = Create-ResourceGroupForTest $location 	
	$server = Create-ServerForTest $rg $location

	$serverDnsAliasName = Get-ServerDnsAliasName

	try
	{
		# Create Server DNS Alias
		$serverDnsAlias = New-AzureRmSqlServerDNSAlias -ResourceGroupName $rg.ResourceGroupName -ServerName $server.ServerName -ServerDNSAliasName $serverDnsAliasName
		Assert-AreEqual $serverDnsAlias.ServerName $server.ServerName
		Assert-AreEqual $serverDnsAlias.ServerDNSAliasName $serverDnsAliasName

		# Remove Server DNS Alias
		$resp = Remove-AzureRmSqlServerDNSAlias -ResourceGroupName $rg.ResourceGroupName -ServerName $server.ServerName -ServerDNSAliasName $serverDnsAliasName
		$all = Get-AzureRmSqlServerDNSAlias -ResourceGroupName $rg.ResourceGroupName -ServerName $server.ServerName
		Assert-AreEqual $all.Count 0
	}
	finally
	{
		Remove-ResourceGroupForTest $rg
	}
}

<#
	.SYNOPSIS
	Tests updating server dns alias
#>

function Test-UpdateServerDNSAlias
{
	# Setup
	$location = "East US 2 EUAP"
	$rg = Create-ResourceGroupForTest $location 	
	$server = Create-ServerForTest $rg $location
	$server2 = Create-ServerForTest $rg $location

	$serverDnsAliasName = Get-ServerDnsAliasName

	try
	{
		# Create Server DNS Alias
		$serverDnsAlias = New-AzureRmSqlServerDNSAlias -ResourceGroupName $rg.ResourceGroupName -ServerName $server.ServerName -ServerDNSAliasName $serverDnsAliasName
		Assert-AreEqual $serverDnsAlias.ServerName $server.ServerName
		Assert-AreEqual $serverDnsAlias.ServerDNSAliasName $serverDnsAliasName
	}
	finally
	{
		Remove-ResourceGroupForTest $rg
	}
}