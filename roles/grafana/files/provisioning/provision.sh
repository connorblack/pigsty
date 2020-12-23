#!/bin/bash

# grafana api endpoint
GRAFANA_API="http://admin:admin@localhost:3000/api"

# use 'light' as default theme
GRAFANA_THEME="light"

# use 'Home' as default dashboard
GRAFANA_HOME="HOME"

# get home dashboard id by name
GRAFANA_HOME_ID=$(curl -s ${GRAFANA_API}/search?query=${GRAFANA_HOME} | jq '.[0].id')

# # build new preference:  {"theme":"dark","homeDashboardId":2}
GRAFANA_PREF='{"theme":"'${GRAFANA_THEME}'","homeDashboardId":'${GRAFANA_HOME_ID}'}'

# star home dashboards
curl -X POST ${GRAFANA_API}/user/stars/dashboard/${GRAFANA_HOME_ID}

# update preference
curl -X PUT -s ${GRAFANA_API}/org/preferences -H "Content-Type: application/json" --data ${GRAFANA_PREF}
curl -X PUT -s ${GRAFANA_API}/user/preferences -H "Content-Type: application/json" --data ${GRAFANA_PREF}