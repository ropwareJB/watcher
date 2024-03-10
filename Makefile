
restart:
	sudo docker compose \
		-f docker-compose/docker-compose.dev.yml \
		--project-directory . \
		restart

dev:
	sudo docker compose \
		-f docker-compose/docker-compose.dev.yml \
		--project-directory . \
		up

