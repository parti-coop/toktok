# Hotlinekr

## 실환경 구축 방법

페이스북, 트위터, 카카오를 연결합니다. 각 키는 {project root}/config/config/env.yml에 등록합니다. 각 연결 계정은 email을 얻어 올 권한이 있어야 합니다.

S3_로 시작하는 것은 아마존 s3 관련된 정보입니다. s3를 이용해 업로드나 이미지나 업로드 파일을 관리합니다.

```
production:
  SECRET_KEY_BASE: xx
  FACEBOOK_APP_ID: xx
  FACEBOOK_APP_SECRET: xx
  TWITTER_APP_ID: xx
  TWITTER_APP_SECRET: xx
  KAKAO_CLIENT_ID: xx
  S3_ACCESS_KEY: xx
  S3_SECRET_KEY: xx
  S3_REGION: xx
  S3_BUCKET: xx
  DEFAULT_ADMIN_EMAIL: 최초 관리자 이메일 
  DEFAULT_ADMIN_PROVIDER: 최초 관리자의 인증 제공 업체 구별자, 'email'을 권장합니다.
  DEFAULT_ADMIN_UID: 인증 제공 업체에 등록된 최초 관리자의 uid
```

mysql을 구동해야합니다. mysql의 encoding은 utf8mb4를 사용합니다. mysql은 버전 5.6 이상을 사용합니다. mysql 명령어로 데이터베이스를 만듭니다.

{project root}/config/database.yml에 데이터베이스 연결 정보를 설정합니다.

기본 데이터 로딩을 해야합니다.

```
$ bundle exec rake db:seed_fu
```

redis와 sidekiq을 사용합니다. 배포 후에 sidekiq을 재기동해야합니다.

config/environments/production.rb에 메일 발송 설정을 합니다.

## 로컬 개발 환경 구축 방법

기본적인 Rail 개발 환경에 rbenv를 이용합니다.

```
$ rbenv install 2.3.1
$ bundle install
$ bundle exec rake db:migrate
```

### 소스관리 설정

반드시 https://github.com/awslabs/git-secrets를 설치하도록 합니다. 설치 후에 반드시 https://github.com/awslabs/git-secrets#installing-git-secrets 이 부분을 참고하여 로컬 레포지토리에 모두 설정 합니다.

```
$ git secrets --install
$ git secrets --register-aws
```

그리고 데이터베이스는 각 레포지토리마다 다릅니다. 아래 git hook 을 설정합니다

```
$ echo $'#!/bin/sh\nif [ "1" == "$3" ]; then spring stop && powder restart; fi' > .git/hooks/post-checkout
$ chmod +x .git/hooks/post-checkout
```

### 데이터베이스 준비

#### mysql 설정
mysql을 구동해야합니다. mysql의 encoding은 utf8mb4를 사용합니다. mysql은 버전 5.6 이상을 사용합니다.


encoding세팅은 my.cnf에 아래 설정을 넣고 반드시 재구동합니다. 참고로 맥에선 /usr/local/Cellar/mysql/(설치하신 mysql버전 번호)/my.cnf입니다.

```
[mysqld]
innodb_file_format=Barracuda
innodb_large_prefix = ON
```

#### 연결 정보

프로젝트 최상위 폴더에 local_env.yml이라는 파일을 만듭니다. 데이터베이스 연결 정보를 아래와 예시를 보고 적당히 입력합니다.

```
development:
  database:
    username: 사용자이름
    password: 암호
```
 
#### 스키마

```
CREATE DATABASE hotlinekr_development_브랜치이름 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

이후 db:migrate로 수행합니다.

### 로그인 준비

페이스북, 트위터를 연결합니다. 각 키는 {project root}/config/env.yml에 설정합니다. 트위터는 사용자 email을 얻어오기 위해 twitter에 권한을 적절히 설정해야합니다.

```
FACEBOOK_APP_ID: xx
FACEBOOK_APP_SECRET: xx
TWITTER_APP_ID: xx
TWITTER_APP_SECRET: xx
KAKAO_CLIENT_ID: xx
```

### 관리자

{project root}/config/env.yml에 설정합니다. DEFAULT_ADMIN_UID는 https://dev.twitter.com/rest/tools/console 을 통해 획득합니다 

```
DEFAULT_ADMIN_UID: xx
DEFAULT_ADMIN_PROVIDER: xx
DEFAULT_ADMIN_EMAIL: xx
```

#### 관리자 데이터 추가

[mbleigh/seed-fu](https://github.com/mbleigh/seed-fu) 을 이용하여 설정된 초기 데이터를 로딩합니다.

```
$ bundle exec rake db:seed_fu
```

### 테스트용 파일 서버 설정

{project root}/config/env.yml에 설정합니다. Amazon S3를 이용합니다. 되도록 실제 파일서버와 연결하지 않아야 합니다.

```
S3_ACCESS_KEY: xx
S3_SECRET_KEY: xx
S3_REGION: xx
S3_BUCKET: xx
```
