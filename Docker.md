# Docker

### Docker compose

설치 및 초기 설정

```shell
pip3 install docker-compose	# 도커 컴포즈 설치
touch docker-compose.yml	#yml 파일 생성
```



docker-compose.yml

```shell
version: '3'	# 최신 버전으로 해라

services:
	web:
		image: nginx	# 도커 허브에 등록된 이미지들 가져다 쓴다
		build:	# 아니면 자기의 이미지를 가져다쓴다.
      context: .
      dockerfile: ./compose/django/Dockerfile-dev
  ports:
      - "8000:8000"
  command:
    - python manage.py runserver 0:8000
		
	database:
		image: redis
		volumes:
      - ./docker/data:/var/lib/postgresql/data
    environment:
    - POSTGRES_DB=sampledb
    - POSTGRES_USER=sampleuser
    - POSTGRES_PASSWORD=samplesecret
    - POSTGRES_INITDB_ARGS=--encoding=UTF-8
```



기본 명령어

```shell
docker-compose -v	# 버전 확인
docker-compose version	# 디테일 버전 확인
docker-compose config	# docker-compose.yml에 기록된 설정들 보기
docker-compose up	# 이미지들 시작
docker-compose down	# 이미지들 종료
docker-compose start {이미지}	# 이미지 시작	(종료는 stop)
docker-compose logs {이미지} # 해당 도커의 로그 보기
```



### Docker

설치

```shell
sudo apt-get update && sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"
 
sudo apt-get update && sudo apt-cache search docker-ce
sudo apt-get update && sudo apt-get install docker-ce

# Docker 버전 확인
$ docker -v
```



기본 명령어

```shell
docker ps	# 실행 중인 프로세스 보기

```

