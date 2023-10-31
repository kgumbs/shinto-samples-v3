#!/bin/sh
set -e
set +x
set -o pipefail
if [ "${DEBUG}" == "true" ]; then
    set -x
fi

DEFAULT_USERNAME='admin'
DEFAULT_PASSWORD='Password01!'
PARAMETER_STORE_COGNITO_KEY='/mrwconsulting/shinto/cognito'

read -e -p  "Enter cognito username: [$DEFAULT_USERNAME] " COGNITO_USERNAME
COGNITO_USERNAME="${COGNITO_USERNAME:-$DEFAULT_USERNAME}"
read -e -p  "Enter cognito password: [$DEFAULT_PASSWORD] " COGNITO_PASSWORD
COGNITO_PASSWORD="${COGNITO_PASSWORD:-$DEFAULT_PASSWORD}"

COGNITO_CONFIG=$(aws ssm get-parameter \
                --name ${PARAMETER_STORE_COGNITO_KEY} \
                --query Parameter.Value \
                --output text | base64 --decode)
COGNITO_CLIENT_ID=$(echo $config | jq --raw-output .userPoolClientId)
ACCESS_TOKEN=$(aws cognito-idp initiate-auth  \
            --client-id ${COGNITO_CLIENT_ID} \
            --auth-flow USER_PASSWORD_AUTH \
            --query "AuthenticationResult.IdToken" \
            --output text \
            --auth-parameters USERNAME=${COGNITO_USERNAME},PASSWORD=${COGNITO_PASSWORD})

echo "SHINTO_ACCESS_TOKEN=${ACCESS_TOKEN}"
