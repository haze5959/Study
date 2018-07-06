# CloundKit

클라우드킷에는 다음과 같이 3개의 zone이 있다.



- Private database
  icloud 계정에 접속이 되어있고 해당 앱 이용자만 접근 가능
- Shared database
  iCloud 계정에 접속이 되어 있고 여러 앱이랑 자원공유 가능
- Public database
  iCloud 계정 접속 안되어있어도 자원 접근 가능. 단, read만 되고 write는 icloud에 접속되어 있어야 한다.



### Retrieve existing records

```swift
let predicate = NSPredicate(value: true)
let query = CKQuery(recordType: recordType, predicate: predicate)
CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { records, error in

}
```

### Create a new record

```swift
let record = CKRecord(recordType: "RecordType")
record.setValue("Some data", forKey: "key")
CKContainer.default().publicCloudDatabase.save(record) { savedRecord, error in

}
```

### Update the record

```swift
let recordId = CKRecordID(recordName: "RecordType")
CKContainer.default().publicCloudDatabase.fetch(withRecordID: recordId) { updatedRecord, error in  
    if error != nil {
        return
    }

    updatedRecord.setObject("Some data", forKey: "key")
    CKContainer.default().publicCloudDatabase.save(updatedRecord) { savedRecord, error in

    }
}
```

### Remove the record

```swift
let recordId = CKRecordID(recordName: recordId)
CKContainer.default().publicCloudDatabase.delete(withRecordID: recordId) { deletedRecordId, error in

}
```