PUBLIC_IP := 158.160.121.55
PROXY_IP := 51.250.106.139

up:
	docker-compose down
	docker-compose up -d

down:
	docker-compose down

exec:
	docker-compose exec -it hadoop bash

.PHONY: sync
sync:
	rsync -avz \
		--exclude='*.log' \
		--exclude='*.out' \
		--exclude='*.err' \
		--exclude='.git' \
		--exclude='*.tfstate' \
		--exclude='*.tfstate.backup' \
		. \
		ubuntu@$(PROXY_IP):/home/ubuntu/otus/otus-dfs/hadoop

.PHONY: scp
scp:
	scp docker-compose.yml ubuntu@$(PUBLIC_IP):/home/ubuntu/hdp/docker-compose.yml