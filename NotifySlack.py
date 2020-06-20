#!/usr/bin/env python3
# Python 3 version of the NotifySlack script.
# This script is intended to be invoked directly from the command line.
#   Command argumnents:
#       (--message | -m <message>) The message content you'd like to send to Slack
#       (--webhook | -w <webhook>) The full webhook address assigned to the channel you'd like to send the message to
#       (--colour | -c <colour hex code> *optional*) The hex code of the colour you'd like to appear around the message (if any)
#       (--push | -p <push message> *optional*) The message you'd like display in any pop-up/push/toast notifications
#
#   Example:
#       NotifySlack.py --message 'Hello, world!' --webhook 'https://hooks.slack.com/my-webhook' --colour #FF0000 --push 'Foo Bar'
#       This would result in the 'Hello, world!' message being posted to the channel linked to the webhook, the message would have a red stripe alongside it and a pop-up notification entitled 'Foo Bar'
import json
import requests
import argparse

# Setting up command line arguments so we can parse things
parser = argparse.ArgumentParser(description='This script will send a message to Slack')
parser.add_argument('--message', '-m', type=str, required=True,
                    help='The message you would like to be displayed')
parser.add_argument('--webhook', '-w', type=str, required=True,
                    help='The webhook for the channel/DM you want to post in')
parser.add_argument('--colour', '-c', type=str, required=False,
					help='Hex code you would like on the side of the notification (if any)')
parser.add_argument('--push', '-p', type=str, required=False,
					help='For mobile devices, the message that appears in the notification bar/area')
arguments = parser.parse_args()

# Pulling in our mandatory command line arguments
webhook = arguments.webhook
message = arguments.message

# Create an empty JSON object
post_json = {
    "attachments": [{
      }]
}

# We're not sure we'll have any of these so let's check and add them to our JSON if they've been provided.
if arguments.colour is not None:
	post_json['attachments'][0]['color'] = arguments.colour
if arguments.push is not None:
	post_json['attachments'][0]['fallback'] = arguments.push

# We'll always have a message so we don't need to check for this.
post_json['attachments'][0]['text'] = message

# The send function, returns any errors.
def NotifySlack(webhook,message):
	response = requests.post(
	    webhook, data=json.dumps(post_json),
	    headers={'Content-Type': 'application/json'}
	)
	print(response)
	if response.status_code != 200:
			raise ValueError(
		        'Request to slack returned an error: %s'
		        % (response.status_code)
    		)
	pass
	return

# zero-touch running of the above (so we can call from the command line)
NotifySlack(webhook,post_json)
