# USAGE: ./api_check.sh <EXPERIMENT_ID>
WORK_DIR="./experiment"
BASE_DIR="./experiment_base"

cd "$WORK_DIR"

if [ $# -eq 0 ]
  then
    echo "No arguments supplied."
    exit 1
fi

EXPERIMENT_NAME="$1"

mkdir -p "$EXPERIMENT_NAME"
cp "$BASE_DIR"/* "$EXPERIMENT_NAME/"

faas-faultmaker -o "$EXPERIMENT_NAME/serverless.yml" "$BASE_DIR/serverless.yml"

read -r -p "Continue with deployment?" response
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
	cd "$EXPERIMENT_NAME"
    serverless deploy
fi