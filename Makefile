compose-up:
	docker compose up --build -d postgres redis && docker compose logs -f
.PHONY: compose-up
