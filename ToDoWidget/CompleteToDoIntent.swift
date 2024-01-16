
/*
 Intent için oluşturuldu
 yani tıklandığında yapılcak işler için(interaktivite kazandırmak)
 -https://developer.apple.com/documentation/appintents/ incelenebilir ios 16 ve üssü geçerli
 -App Intent(framework) amacı uygulamamızdaki fonksiyoliteyi arttırmak ve sistemdeki servislere iletişim sağlayabilmek(Siri,Shortcuts ile konuşabilcek hale getirmek)
 */
import Foundation
//eklendi
import SwiftUI
//eklendi
import AppIntents

struct CompleteToDoIntent : AppIntent{

    //App intent başlık istiyor
    static var title: LocalizedStringResource = "Complete To Do"
    
    //seçilenin idsi almak için
    @Parameter(title : "ToDo ID")
    var id : String
    
    init() {
        
    }
    
    init(id: String) {
        self.id = id
    }
    
    
    
    //yapılan işlem sonucunda neolacak ne döndürücez
    func perform() async throws -> some IntentResult {
        //gördüğün ilk id almak diyebiliriz
        if let index = SharedDates.shared.toDos.firstIndex(where: {
            $0.id == id
        }){
            //o id nin isDone ne ise çevircektir
            SharedDates.shared.toDos[index].isDone.toggle()
            //update işlemi olurmesela burda update yapılır
            print("database update")
        }
        
        
        
        
        return .result()
    }
    
}
