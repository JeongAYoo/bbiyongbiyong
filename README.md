# bbiyongbiyong

![무제 001](https://user-images.githubusercontent.com/26922015/231452009-f73d6f48-84dc-4467-aebc-7f1f9b09af0c.jpeg)

[AppStore](https://apps.apple.com/us/app/%EC%82%90%EC%9A%A9%EB%B9%84%EC%9A%A9-%EA%B0%90%EC%A0%95%EC%86%8C%EB%B9%84%EB%A5%BC-%EA%B8%B0%EB%A1%9D%ED%95%98%EB%8A%94-%EA%B7%80%EC%97%AC%EC%9A%B4-%EA%B0%80%EA%B3%84%EB%B6%80/id6446201644)에서 확인하기

<br>

## 👋 소개

내 통장은 왜 항상 텅텅 비어있을까? 순간의 감정에 못 이겨 쓴 돈을 모았다면?
감정 소비를 기록하는 귀여운 달력 가계부 '삐용비용'

- 홈

굴비를 든 삐용이와 이번 달 감정소비 금액을 확인해요.

내가 정한 한도에서 쓰고 남은 금액이 계산되어 아래에 표시됩니다.

우측 상단 + 버튼을 눌러 새로운 삐용비용을 기록하세요!

(다양한 삐용이 이미지 업데이트 예정)

- 캘린더

캘린더에서 날짜별로 그 날의 소비를 확인할 수 있어요.

해당 날짜에서 하단 + 버튼을 눌러 지나간 소비도 입력!

소비기록을 눌러 언제든 내용을 수정, 삭제할 수 있습니다.

- 설정

프로필 편집 버튼을 누르면,

닉네임과 이번 달 소비한도를 변경할 수 있어요!

<br>

## 📚 Library

### SnapKit

- AutoLayout을 설정에 있어 편의성을 위해 사용

### FSCalendar

- Custom Calendar 구현을 위해 사용

### Realm

- 소비 기록을 디바이스에 저장하기 위해 사용

```swift
class Consumption: Object {
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var date: Date = Date()    //날짜
    @Persisted var title: String = ""     //제목
    @Persisted var cost: Int = 0          //금액
    @Persisted var content: String = ""   //내용
    @Persisted var emotion: String = ""   //감정
}
```

### AcknowList

- 사용한 오픈소스 라이브러리를 지원링크와 함께 표시

<br>

## 🎨 UI

[Figma](https://www.figma.com/file/XDJOb6mB5rlsiUWCF1Wrrz/%EC%82%90%EC%9A%A9%EB%B9%84%EC%9A%A9?node-id=0%3A1&t=C9D68LsFh3TilkHX-1)
