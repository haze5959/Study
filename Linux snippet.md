# Linux snippet

### 파일 이동, 삭제, 경로

- mv : 파일 이동
- rm : 파일 삭제
  - -f : 물어보지도 않고 걍 제거
  - -r : 내용 재귀적으로 제거
- rmdir : 디렉토리를 지운다.
- pwd : 파일 경로 출력



### 네트워크

- nslookup : 도메인의 IP주소나 도메인 정보 출력
- netstat -tulpn | grep LISTEN : 현재 열려있는 포트 확인
- firewall-cmd —zone=publaic —add-port=8080/tcp —permanent : 해당 포트 방화벽 열기
- firewall-cmd —reload : 방화벽 리로드



### 권한

- su : 사용자 체인지



### 파일 시스템

- df -m : 파일시스템 구조와 용량을 메가바이트 단위로

- du : 파일 사이즈 보기
  - -s : 총 사이즈 보기

- 
  unzip 압축파일.zip -d ./폴더명 : 압축풀기




### 탐색

- find : 주어진 파일명과 동일한 파일을 찾고 경로를 출력
  - find / -name 'ab*'
  - find / -name '.bash*' -ls  : ls형식으로 출력
  - find / -name 'et*' -type d  : et로 시작하는 디렉토리 찾기



### 시스템 정보

- free : 메모리 상태 확인
- last : 접근한 사용자 표시
- uptime : 서버 부팅시간과 현재시간이 출력
- who : 시스템에 로그인 된 사람 찾기
- env : 환경변수 보기
- ps -ef | grep node : 프로세스 아이디 찾기
  - kill -9 [pid] : 이렇게 지우자



### 편의

- grep : 패턴 검색





# service(centos 7)

### 서비스 파일 만들기

vim /lib/systemd/system/[이름].service

```
[Unit]
Description=AvILoS-KeepAlive-Service

# After=mysql.service # 만약 현재 서비스를 구동하기 위하여 후에 필요한 서비스가 있다면 여기에 서비스 파일 등록

# Wants=mysql.service # 만약 현재 서비스를 구동하기 위하여 선작업이 필요한 서비스가 있다면 여기에 서비스 파일 등록

[Service]
WorkingDirectory=/var/www/nodejs-web/
ExecStart=/root/.nvm/versions/node/v4.4.7/bin/node bin/www     # 웹서버 코드가 위치한 경로 및 node실제 버전 경로
Restart=always # 재시작 여부
RestartSec=2 # 서비스 크래시 발생일 경우 1초뒤 재시작 , RestartSec을 너무 짧게 주면 무한루프로 재구동에 빠지는 경우가 생기므로 3초 정도가 적당

StandardOutput=syslog # Output to syslog
StandardError=syslog # Output to syslog

SyslogIdentifier=avilos-keep-alive

# User=<alternate user>

# Group=<alternate group>

Environment='NODE_ENV=production'

[Install]
WantedBy=multi-user.target
```



systemctl daemon-reload : 서비스 파일 추가한거 적용



- systemctl status [시스템명] : 서비스 상태 확인
- journalctl -u [시스템명] : 서비스 로그 확인
  - —since today : 오늘 로그만 보기
  - -f : 꼬리만 보기
- systemctl restart [시스템명]
- systemctl stop [시스템명]
- systemctl enable [시스템명] : 부팅시 서비스 시작( != disable)
- systemctl list-unit-files —type=service : 서비스 목록보기(그냥 systemctl은 현재 작동중인 것만)
- systemctl —failed : 부팅시 실행에 실패한 서비스 목록



## nginx 설정

설정파일 위치 - /etc/nginx/conf.d/main.conf

```
server {

    # 포트번호. 일반적으로 80번 포트로 되어있습니다.
    listen       80;

    # 연결할 도메인 이름. 이때 도메인은 서버ip로 연결되어있어야합니다.
    server_name  www.conory.com;

    # 웹 루트 디렉토리 지정. 호스트에 접속시 /home/www/에 있는 파일들이 메인이 됩니다.
    root         /home/www;

    # 인덱스 파일 지정. 호스트에 접속시 /home/www/index.php,index.html,index.htm 이 파일이 있으면 먼저 불러옵니다.
    index index.php  index.html index.htm;



    # 자체적인 에러페이지를 만들 수 있습니다. 없다면 아래부분은 제거해주세요.
    error_page 401 /error_401.html;
    error_page 403 /error_403.html;
    }
}
```

설정 반영 - systemctl reload nginx

컨텐츠 타입 설정해줘야 403에러 안뜬다 - chcon -Rt httpd_sys_content_t