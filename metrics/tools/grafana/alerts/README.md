# JSON alert rules

Refer to [Grafana official docs](https://grafana.com/docs/grafana/latest/developers/http_api/alerting_provisioning/#alert-rules) for APIs.

> We assume that you created an API Key for accessing Grafana.

## Download

1. Create an alert rule from the Grafana UI.
2. Go to the alert rule and use the `copy link` button. In the URL there is the alert rule UID.
3. Use the UID found in the previous phase to download the alert JSON: `curl -s -H "Authorization: Bearer <my-super-token>" -X GET https://<grafana-url>/api/v1/provisioning/alert-rules/<alert-rule-uid> | tee my-super-alert-rule.json`.

> Note: Use `jq` to read the content easely.

## Upload

You can choose between 2 options:
1. curl for just uploading the alert rule. There are some parameters that could be different between 2 different deploys (e.g., UIDs). It relates only to alert rules and no contact point is created.
2. Terraform manages both alert rules and contact points. Repeatable between different Terraform runs.

### curl

```bash
curl -s -H "Authorization: Bearer <my-super-token>" -X POST https://<grafana-url>/api/v1/provisioning/alert-rules -H "Content-Type: application/json" -d "$(cat my-super-alert-rule.json)"
```

## Delete

It is not possible to delete from the UI alert rules created from APIs.

### curl

`curl -s -H "Authorization: Bearer <my-super-token>" -X DELETE https://<grafana-url>/api/v1/provisioning/alert-rules/<alert-rule-uid>`

# Configure the contact point

First you need to setup the contact point to see alerts flowing to slack:
1. Go to contact point page and select a new contact point for slack.
2. Use a name like `alerts-private-channel`
3. Insert the `Webhook URL`  and `token`

Then you need to create an alert policy or use the root one.

1. Go to Alerting > Notification policies > Root policy and select `alerts-private-channel` as default contact point.
2. Go to Alerting > Notification policies > Create a new policy and set `team=operation` as the matching label together with the `alerts-private-channel` as default contact point.