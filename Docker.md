# Docker

### Docker compose

설치 및 초기 설정

```shell
pip install docker-compose	# 도커 컴포즈 설치
touch docker-compose.yml	#yml 파일 생성
```



docker-compose.yml

```shell
version: '3'	# 최신 버전으로 해라

services:
	web:
		image: nginx	# 도커 허브에 등록된 이미지들 가져다 쓴다
		# 그외에 nginx에 관한 명령어들 쭉 있는데 이 명령어는 뭘 바라보는건지 모르겠다.
		
	database:
		image: redis
```



기본 명령어

```shell
Docker-compose -v	# 버전 확인
Docker-compose version	# 디테일 버전 확인
Docker-compose config	# docker-compose.yml에 기록된 설정들 보기
Docker-compose up	# 이미지들 시작
Docker-compose down	# 이미지들 종료
```



### Docker

기본 명령어

```shell
docker ps	# 실행 중인 프로세스 보기

```

