alias gunnery-db="docker-compose -f docker-compose.develop.yml -p gunnerydevelop up -d db"
alias gunnery-rabbit="docker-compose -f docker-compose.develop.yml -p gunnerydevelop up -d rabbitmq"

alias gunnery="docker-compose -f docker-compose.develop.yml -p gunnerydevelop run --rm --service-ports --no-deps app"
alias gunnery-celery="gunnery celery worker"
