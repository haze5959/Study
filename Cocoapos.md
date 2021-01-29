# Cocoapods 사용법

### 다운로드 및 설치

```
sudo gem install cocoapods
pod setup
```



### 프로젝트에 설치

```
pod init
```



### 라이브러리 설치

```shell
pod install	//락 걸려 있는 버전으로 인스톨
pod update //최신 버전으로 인스톨
```



# Cocoapods 등록 방법

### 1. 프로젝트 생성

```xml
pod lib create 프로젝트이름
```



### 2. 라이브러리 수정 및 repo에 커밋 (tag 추가)

```
git add . 
git commit -m "first commit" 
git remote add origin git주소 
git tag 0.1.0 
git push origin 0.1.0
```



### 3. podspec 수정

```
pod spec lint	//문법 검사
```



### 4. repo 추가 및 push

```
pod repo add [REPO_NAME] [깃 주소]	
pod repo push [REPO_NAME] [.podspec경로] --allow-warnings

//터미널
cd ~/.cocoapods/repos
```



### 5. cocoapods trunk에 계정 추가

```
pod trunk register [E-MAIL] [NAME] -description=’[INFORMATION]’
//이메일에서 승인
```



### 6. trunk에 등록 (다음부터 버전 올릴때는 이부분만 해도 된다.)

```
pod trunk push [podSpec file name] --allow-warnings
```



7. ### 혹시 트렁크에 캐시가 남아있어서 이전 소스를 바라본다면 다음 코드 실행

   ```
   pod cache clean 'FortifySec' --all
   ```

   ### 