# USAGE: ./teardown.sh <EXPERIMENT_ID>
WORK_DIR="./experiment"

cd "$WORK_DIR"

if [ $# -eq 0 ]
  then
    echo "No arguments supplied."
    exit 1
fi

EXPERIMENT_NAME="$1"
cd "$EXPERIMENT_NAME"

echo "Removing serverless deployment at $(pwd)"

read -r -p "Continue with undeployment?" response
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   serverless remove
fi