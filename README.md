# SlackNotificationScripts
This collection of scripts was born out of the need to find a simple and effective way of scripting notifications to Slack for various shell based tasks/workflows.

* [Python3](##NotifySlack.py)
* [PowerShell](##NotifySlack.ps1)  
* [PowerShell Module](###NotifySlack.psm1)  

## NotifySlack.py
Python3 Script

#### Usage
`NotifySlack.py <parameters> <options>`

|Parameter       |Required         |Description    |
|----------------|-----------------|---------------|
|--message (-m)  |True             |The message you would like to send |
|--webhook (-w)  |True             |The full webhook address assigned to the channel you'd like to send the message to |
|--colour (-c)   |False            |The hex code of the colour you'd like to appear around the message |
|--push (-p)     |False            |The message you'd like display in any pop-up/push/toast notifications|

#### Example
`NotifySlack.py --message 'Hello, world!' --webhook 'https://hooks.slack.com/my-webhook' --colour #FF0000 --push 'Foo Bar'`
This would result in the 'Hello, world!' message being posted to the channel linked to the webhook, the message would have a red stripe alongside it and a pop-up notification entitled 'Foo Bar'

## NotifySlack.ps1
Windows PowerShell Script

#### Usage
`NotifySlack.ps1 <parameters> <options>`
|Parameter       |Required         |Description    |
|----------------|-----------------|---------------|
|-Message        |True             |The message you would like to send |
|-Webhook        |True             |The full webhook address assigned to the channel you'd like to send the message to |
|-Colour         |False            |The hex code of the colour you'd like to appear around the message |
|-Push           |False            |The message you'd like display in any pop-up/push/toast notifications|

#### Example
`PS C:\> NotifySlack.ps1 -Message 'Foo Bar' -Webhook 'https://hooks.slack.com/my-webhook' -Colour '#FF0000' -Push 'Fizz Buzz'`
This would send the 'Foo Bar' message to the channel linked to the given webhook. 
The message would also have a red stripe down the side of it and the pop-up notification would say 'Fizz Buzz'

### NotifySlack.psm1
Windows PowerShell Module

In certain situations it may make more sense to use a cmdlet rather than a commandline script therefor you can use the `NotifySlack.psm1` module.
The parameters are exactly the same as the `NotifySlack.ps1` script.

#### Example
```
PS C:\> Import-Module NotifySlack.psm1
PS C:\> Invoke-SlackNotification -Message 'Hello, world!' -Webhook 'https://hooks.slack.com/my-webhook'
```
The first command imports the `NotifySlack` module and then the second sends the `Hello, world!` message to the channel linked with the given Webhook
