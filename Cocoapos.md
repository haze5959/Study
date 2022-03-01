# Cocoapods 사용법

### 다운로드 및 설치

```
sudo gem install cocoapods
pod setup
```



### 프로젝트에 설치

```
pod init // 프로젝트에 Podfile 생성
```

### Podfile 구성
```shell
platform :ios, '11.0'

# Static 라이브러리 말고 dynamic 라이브러리 사용한다는 의미
use_frameworks!

# pod에서 일어난 워닝은 무시하겠다!
inhibit_all_warnings!

# 이렇게 함수식으로 pod들을 정의해서 편리하게 이용 가능하다.
def shared_Pods
  # Pods
  pod 'TLPhotoPicker'

  # Rx Pods
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Moya/RxSwift'
  
  # Firebase pods
  pod 'Firebase/Crashlytics'
  pod 'Firebase/AnalyticsWithoutAdIdSupport'
  pod 'Firebase/Messaging'
  pod 'Firebase/Performance'
  pod 'Firebase/DynamicLinks'
end

# 타겟 앱에 Pods 추가
target 'OQTest' do
  shared_Pods
  
  target 'OQTestPushService' do
    # 익스텐션 타겟에 앱에서 사용되고 있는 pod들을 그대로 사용한다.
    inherit! :search_paths
  end
end

# UnitTest용 Pods
target 'OQTestTests' do
  shared_Pods
  pod 'RxTest'
end

```


### 라이브러리 설치

```shell
pod install	// 락 걸려 있는 버전으로 인스톨
pod update // 최신 버전으로 인스톨
pod update [모듈 이름] // 특정 모듈만 업데이트
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
pod repo add [프로젝트이름] [깃 주소]	
pod repo push [프로젝트이름] [.podspec경로] --allow-warnings
```



### 5. cocoapods trunk에 계정 추가

```
pod trunk register [E-MAIL] [NAME] -description=’[INFORMATION]’
//이메일에서 승인
```



### 6. trunk에 등록 (다음부터 버전 올릴때는 이부분만 해도 된다.)

```
pod trunk push [.podspec경로] --allow-warnings
```



7. ### 혹시 트렁크에 캐시가 남아있어서 이전 소스를 바라본다면 다음 코드 실행

```
pod cache clean [프로젝트이름] --all
```