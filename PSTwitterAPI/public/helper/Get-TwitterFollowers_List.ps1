﻿function Get-TwitterFollowers_List {
<#
.SYNOPSIS
    Follow, search, and get users

.DESCRIPTION
    GET followers/list
    
    Returns a cursored collection of user objects for users following the specified user.
    
    At this time, results are ordered with the most recent following first — however, this ordering is subject to unannounced change and eventual consistency issues. Results are given in groups of 20 users and multiple "pages" of results can be navigated through using the next_cursor value in subsequent requests. See Using cursors to navigate collections for more information.

.PARAMETER user_id
    The ID of the user for whom to return results.

.PARAMETER screen_name
    The screen name of the user for whom to return results.

.PARAMETER cursor
    Causes the results to be broken into pages. If no cursor is provided, a value of -1 will be assumed, which is the first "page."
The response from the API will include a previous_cursor and next_cursor to allow paging back and forth. See Using cursors to navigate collections for more information.

.PARAMETER count
    The number of users to return per page, up to a maximum of 200. Defaults to 20.

.PARAMETER skip_status
    When set to either true, t or 1, statuses will not be included in the returned user objects. If set to any other value, statuses will be included.

.PARAMETER include_user_entities
    The user object entities node will not be included when set to false.

.NOTES
    This helper function was generated by the information provided here:
    https://developer.twitter.com/en/docs/accounts-and-users/follow-search-get-users/api-reference/get-followers-list

#>
    [CmdletBinding()]
    Param(
        [string]$user_id,
        [string]$screen_name,
        [string]$cursor,
        [string]$count,
        [string]$skip_status,
        [string]$include_user_entities
    )
    Begin {

        [hashtable]$Parameters = $PSBoundParameters
                   $CmdletBindingParameters | ForEach-Object { $Parameters.Remove($_) }

        [string]$Method      = 'GET'
        [string]$Resource    = '/followers/list'
        [string]$ResourceUrl = 'https://api.twitter.com/1.1/followers/list.json'

    }
    Process {

        # Find & Replace any ResourceUrl parameters.
        $UrlParameters = [regex]::Matches($ResourceUrl, '(?<!\w):\w+')
        ForEach ($UrlParameter in $UrlParameters) {
            $UrlParameterValue = $Parameters["$($UrlParameter.Value.TrimStart(":"))"]
            $ResourceUrl = $ResourceUrl -Replace $UrlParameter.Value, $UrlParameterValue
        }

        If (-Not $OAuthSettings) { $OAuthSettings = Get-TwitterOAuthSettings -Resource $Resource }
        Invoke-TwitterAPI -Method $Method -ResourceUrl $ResourceUrl -Parameters $Parameters -OAuthSettings $OAuthSettings

    }
    End {

    }
}
