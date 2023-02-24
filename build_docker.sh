source ./env_argilla/bin/activate
./scripts/build_distribution.sh
docker build -t argilla_custom:v1.4.0 -f release.Dockerfile .
