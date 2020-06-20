<#
.SYNOPSIS
    Simple script for sending a Slack message from the commandline.
.DESCRIPTION
    This script allows you to send a basic Slack message from the commandline by simply invoking it with the '-message' and '-webhook' parameters.
    You can optionally declare the '-colour' (sorry for the spelling but I'm British) and the '-push' parameters to set a notification colour and a toast notification message.
.EXAMPLE
    PS C:\> NotifySlack.ps1 -Message 'Hello, world!' -Webhook 'https://hooks.slack.com/my-webhook'
    This would send the 'Hello, world!' message to the channel linked to the given webhook
.EXAMPLE
    PS C:\> NotifySlack.ps1 -Message 'Foo Bar' -Webhook 'https://hooks.slack.com/my-webhook' -Colour '#FF0000' -Push 'Fizz Buzz'
    This would send the 'Foo Bar' message to the channel linked to the given webhook. 
    The message would also have a red stripe down the side of it and the pop-up notification would say 'Fizz Buzz'
.NOTES
    More info on the colour and push (fallback) options can be found at: https://api.slack.com/docs/message-attachments
#>
Param(
    [Parameter(
        Mandatory = $true,
        HelpMessage = "The message you would like sent to Slack"
    )]
    [string]$message,

    [Parameter(
        Mandatory = $true,
        HelpMessage = "The Webhook for the channel/DM you'd like the message to be sent"
    )] 
    [string]$webhook, 
    
    [Parameter(
        Mandatory = $false,
        HelpMessage = "Hex code you would like on the side of the message (if any)"
    )]
    [string]$colour, 
    
    [Parameter(
        Mandatory = $false,
        HelpMessage = "For mobile devices, the content that appears in the notification bar/area"
    )]
    [string]$push
)
# Let's initialize an empty hash table
$slackbody = 
@{
    attachments = 
    @(
        @{
        }
    )
}

# Add any given optional parameters to the hash table.
if ($colour)
{
    ($slackbody.attachments)[0] += 
    @{
        'color' = $colour
    }
}

if ($push)
{
    ($slackbody.attachments)[0] += 
    @{
        'fallback' = $push
    }
}

($slackbody.attachments)[0] += 
@{
    'text' = $message
}
try
{
    invoke-restmethod -Uri $webhook -Method Post -Body (ConvertTo-Json $slackbody) -ErrorAction Stop
}
catch
{
    throw "Failed to send Slack notification.$($_.Exception.Message)"
}
