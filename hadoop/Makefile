PUBLIC_IP := 158.160.40.1

up:
	docker-compose down
	docker-compose up -d

down:
	docker-compose down

exec:
	docker-compose exec -it hadoop bash

.PHONY: scp
scp:
	scp docker-compose.yml ubuntu@$(PUBLIC_IP):/home/ubuntu/hdp/docker-compose.yml