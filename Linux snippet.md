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
- firewall-cmd —zone=public —add-port=8080/tcp —permanent : 해당 포트 방화벽 열기
- firewall-cmd —reload : 방화벽 리로드



### 권한

- su : 사용자 체인지



### 파일 시스템

- df -m : 파일시스템 구조와 용량을 메가바이트 단위로
- du : 파일 사이즈 보기
  - -s : 총 사이즈 보기



### 탐색

- find : 주어진 파일명과 동일한 파일을 찾고 경로를 출력



### 시스템 정보

- free : 메모리 상태 확인
- last : 접근한 사용자 표시
- uptime : 서버 부팅시간과 현재시간이 출력
- who : 시스템에 로그인 된 사람 찾기



### 편의

- grep : 패턴 검색