build:
	docker build -t openpose .
run:
	docker run -it -d --rm --gpus all --name openpose openpose
attach:
	docker exec -it openpose bash
stop:
	docker container stop openpose