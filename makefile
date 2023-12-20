build:
	docker build -t our_project .
run:
	docker run -it -d --rm --name our_project our_project
attach:
	docker exec -it our_project bash
stop:
	docker container stop our_project