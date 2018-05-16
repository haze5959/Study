# GIT

git init

- cd로 해당 폴더 들어가서 위의 코드를 치면은 .git이라는 숨김폴더와 함께 생성

git status
- 파일들의 상태를 볼 수 있다.
- branch 상태, commit 상태, 빨간색은 커밋 안하는 파일들, 초록색은 커밋 가능한 파일

git add
- 커밋할 파일 추가/ git add . 으로 모든 파일 다 커밋하게 가능

git rm
- 커밋 안할 파일 추가

git commit -m [설명]
- git commit -m "으히으힛우해우햇" 이런식으로 커밋함

git log
- 커밋 된 내역 볼 수 있음

git reset --hard origin/master  

- 오버라이드 업데이트




## 원격 저장소

git remote
- git remote add [원하는 이름] https://github.com/[아이디]/[저장소]
- 위처럼 등록하면 아이디처럼 생성된거임. git remote 치고 [원하는 이름]치면은 접속함

git push
- git push [원하는 이름] [master 같은 거 브랜치]
- 위와 같이 치면 원격 저장소에 저장!

git pull
- git pull [원하는 이름] [master 같은 거 브랜치]
- 원격 저장소의 내용을 내려받는 거

git clone
- git clone [저장소 주소]
- git clone은 git pull과 비슷하지만 클라이언트 상에 아무것도 없을 때 서버의 프로젝트를 내려받는 명령어
- 자동으로 init도 됨



## 자세히 보기

git diff
- 수정된 점 보기

git checkout
- 커밋하기 전으로 바꾸기 / git checkout [파일]