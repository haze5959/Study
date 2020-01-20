# DDD (Domain-Driven Design)

MSA를 도입하기 위해 먼저 DDD를 알아야겠다는 생각이들어 공부를 시작했다.



### Entity

식별자가 있고 영속성이 필요한 Object를 entity라고 한다. 반드시 식별자가 있어야 하고, 식별자가 같으면 같은 Object 인 것이 보장되어야 한다.

### Value Object

Entity와 비슷한데, 식별자가 없고, 영속성이 필요하지 않은 Object들.

식별성을 가지면 엔티티 그렇지 않으면 value라 이해하면 됨

### Service

상태정보를 관리하지는 않지만, 행위 자체를 담당하는 것들을 Service 라고 칭한다.

스테이트리스함

### Aggregation

외부에서 접근하는 방법은 하나지만, 하나의 단위로 간주되는 관련된 객체들의 집합이다. 

transaction, 데이터의 무결성 등을 처리하기에 용이하다.

예를 들어 쇼핑몰 사이트에서 주문 엔티티 내에 배송주소 정보를 우편번호, 주소, 상세주소 이런식으로 각각 정의하는게 아니라 주소라는 value object를 별도록 작성하고 주문 엔티티에 포함하는 방식으로 일관성 및 단순화 시키는 것

### Factory

복잡한 절차를 지닌 Entity 들의 생성을 Factory로 묶어서 생성을 관리한다.

#### Repository

객체를 저장하는 일을 담당하는 녀석이다.

도메인 영역과 데이터 인프라스트럭쳐 계층을 분리하여 데이터 계층에 대한 결합도를 낮추기 위한 방안

DB 접근 용이하게 하는 클래스라 생각하면 됨

![DDD 패턴](\/files/DDD 패턴.png)



## Clean Architecture

![clean-architecture](files/clean-architecture.png)