# USAGE: ./api_check.sh https://<DEPLOY_ID>.execute-api.eu-central-1.amazonaws.com/

if [ $# -eq 0 ]
  then
    echo "No base url supplied"
    exit 1
fi


BASE_URL="$1"

HELLO=$(curl "$BASE_URL")
BYE=$(curl "$BASE_URL/bye")
IMAGE=$(curl "$BASE_URL/image")
PACKAGED=$(curl "$BASE_URL/packaged")

echo "\n============"
echo "HTTP API GET responses:\n"
echo "hello: $HELLO"
echo "bye: $BYE"
echo "imageHello: $IMAGE"
echo "packagedHello: $PACKAGED"