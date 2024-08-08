# Amazon EventBridge Module

Configuration in this directory creates an Amazon EventBridge Rule and it's associated targets.

Some notable configurations to be aware of when using this module:
- Example

## Requirements

| Name | Version |
| ----------- | ----------- |
| terraform | >= 1.3.0 |
| aws | >= 4.40 |

## Inputs

| Name | Description | Type | Default | Required |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| app_name | The name of the application/service. This will be used to name the resources. | string | N/A | Yes |
| description | A description of the EventBridge Rule. | string | N/A | Yes |
| event_bus | The name or ARN of the Event Bus to associate with the EventBridge Rule. | string | default | No |

|  |  |  |  |  |
