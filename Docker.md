curl -d "{\"@context\":\"https://schema.org/extensions\",\"@type\":\"MessageCard\",\"themeColor\":\"0072C6\",\"title\":\"test",\"summary\":\"Success!\",\"setcions\":[{\"activityTitle\":\"test1",\"activityText\":\"test2\"}]}" -H "Content-Type: Application/JSON" -X POST https://outlook.office.com/webhook/8e7b3e61-4907-4f49-bfea-dc8867613f3c@f0f864aa-cc3f-4efa-9031-67c45621f9e5/IncomingWebhook/1696ac924722435a88980fb61e6d6f05/58a1e1a1-09ca-4234-b66a-aa7f25aae749



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
docker-compose up	# 이미지들 시작	-d: 지속적
docker-compose down	# 이미지들 종료
docker-compose start {이미지}	# 이미지 시작	(종료는 stop, 재시작 restart)
docker-compose logs {이미지} # 해당 도커의 로그 보기  --tail=5 5줄만
docker-compose rm	# 도커 컴포즈로 생성된 컨테이너 일괄 삭제
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



빌드

```shell
docker build -t hello .	# 해당 경로의 Dockerfile을 보고 hello란 이미지를 만들어준다.
```



실행

```shell
docker run -it -d --name my_debian debian
# debian - 이미지
# my_debian - 해당 프로세스의 이름
# -d - detach: 안죽고 계속 실행하기 (데몬모드)
# -p : 컨테이너와 호스트의 포트를 연결한다.
# --volume : 호스트 OS와 컨테이너의 디렉터리를 공유한다.
# -i : 컨테이너와의 입출력을 interactive하게 설정한다.
# -t : 터미널 역할을 해주는 tty를 사용한다.

docker exec [컨테이너 이름] [명령어]	# 접속하지않고 명령어 날리기
docker exec -it [컨테이너] /bin/sh	# 새 터미널 열어서 접속하기
docker attach	[컨테이너 이름]	# 해당 컨테이너 접속
```



기본 명령어

```shell
docker ps	# 실행 중인 프로세스 보기	-a 붙이면 실행중이지 않은것까지 보임
docker image ls # 빌드된 이미지들 보기
docker rmi -f [이미지]	# 이미지와 컨테이너 삭제
docker rm [컨테이너id] # 컨테이너 삭제, 전부 삭제: docker rm -f $(docker ps -aq)
docker image tag [이미지] [name]:[tag]
```



도커 허브 배포

```shell
docker stop [컨테이너id]	# 먼저 컨테이너를 멈춘다.
docker commit [컨테이너id] [이미지]
docker push [계정]/[이미지 이름]:[버전]
```

