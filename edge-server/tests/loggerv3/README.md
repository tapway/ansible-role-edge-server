# Netdata as monitoring and alerting solution

Deployment mode - `stand-alone`(can be upgraded to `parent - child`)

UI available at http://localhost:19999, OpenAPI spec - https://learn.netdata.cloud/api

## Configuration

```shell
cd /etc/netdata
./edit-config <collector>.config
```

## Alerts

### Host

- Disc space < 90%
- Inodes < 90%
- Free RAM < 90% 
- System logs errors
- Docker container not healthy
- Docker container stopped

### Containers

- PostgreSQL (?)
- RabbitMQ (?)
- MQTT (?)
- Redis (?)
- Any Python application with logging enabled. Check logs for error messages

## Alerts dispatchers

### Slack

Documentation - https://learn.netdata.cloud/docs/alerting/notifications/agent-dispatched-notifications/slack


# Metric collection
- MQTT
- PostgreSQL
- RabbitMQ
- Redis

- Python producer for Redis, MQTT, RabbitMQ
- 