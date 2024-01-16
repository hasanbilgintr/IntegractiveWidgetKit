/*
 Çalıştırırken önce ana uygulamaya geçip üstten çalıştırılır gelir durdurulur sonra extensiona geçip çalıştırılır widget eklenmiştir basılı tutup silinir ardındna boş ekrana basılı tut üst + dan uygulama IntegractiveWidgetKit çıkar seçilir seçersin istediğini vs....
 -üstüne tıkladığında açılır
 -butonlara tıklayınca işaretler .
 */

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    //widget gelmeden ne gösterilcek olan yer
    func placeholder(in context: Context) -> ToDoEntry {
        //        ToDoEntry(date: Date(), emoji: "😀")
        //normalde tabiki time line veri verilirde küçük olduğu için burda verdik sorun yapmaz
        //no datada yazdırabiliri // data loading teyazdırabiliriz
        //prefix o kutucuğa en fazla 3 adet sığcağını belirttik
        ToDoEntry(toDoDisplay: Array(SharedDates.shared.toDos.prefix(3)))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ToDoEntry) -> ()) {
        //        let entry = ToDoEntry(date: Date(), emoji: "😀")
        let entry = ToDoEntry(toDoDisplay: Array(SharedDates.shared.toDos.prefix(3)))
        completion(entry)
    }
    
    //zamana göre değişiklikte yapılcak olan işlemler diyebiliriz
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        //        var entries: [ToDoEntry] = []
        //
        //        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        //        let currentDate = Date()
        //        for hourOffset in 0 ..< 5 {
        //            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        //            let entry = ToDoEntry(date: entryDate, emoji: "😀")
        //            entries.append(entry)
        //        }
        
        //veri çekilcekse güncelleme vs olucaksa basıl burda olur
        
        let toDisplay =  Array(SharedDates.shared.toDos.prefix(3))
        let timeline = Timeline(entries: [ToDoEntry(toDoDisplay: toDisplay)], policy: .atEnd)
        completion(timeline)
    }
}

//widgetin içinde bulunacak modelin özelliklerini aldığı yer
struct ToDoEntry: TimelineEntry {
    //    let date: Date
    let date: Date = .now
    //    let emoji: String
    //gösterilcek olan todolar diye liste açıcaz
    //ToDo burda görmedi ondna dolayı ayrı modüller(klasörler) de olduğu için ToDo ya gidip sağ taraftaki özelliklerinden Show the File İnspector dan -> Target MembersShip ten şuan olduğun ToDoWidgetExtension işaretmek gerekli ki görünsün
    var toDoDisplay : [ToDo]
}

//widget kendisiburda
struct ToDoWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack {
            //            Text("Time:")
            //            Text(entry.date, style: .time)
            //
            //            Text("Emoji:")
            //            Text(entry.emoji)
            
            Text("ToDo Items")
                .fontWeight(.bold)
                .padding(.bottom,5)
            VStack {
                //veri yoksa böyle yazar gibi
                if entry.toDoDisplay.isEmpty {
                    Text("ToDos Completed")
                }else{
                    ForEach(entry.toDoDisplay){toDo in
                        HStack {
                            //CompleteToDoIntent görmesse Target MembersShip ten  işaretlenmesi lazım
                            Button(intent: CompleteToDoIntent(id: toDo.id)) {
                            
                                //toDo.isDone true ise checkmark.circle.fiil içine check atıcak değilse circle ile boş olucak
                        
                                Image(systemName: toDo.isDone ? "checkmark.circle.fill" : "circle")
                                //simgesi rengi değişti
                                    .foregroundStyle(.blue)
                                //.buttonStyle(.plain) normal hale geldi resimdiya farklı button sitilleride var
                            }.buttonStyle(.plain)
                           
                            //alignment : .leading ile textlerin sola yaslı olmasını sağlarız
                            VStack (alignment : .leading) {
                                //lineLimit yapılcak işin en fazla 1satır olcağını belirtir
                                Text(toDo.name).lineLimit(1)
                                //.textScale(.secondary) olabildiğince küçük yazdırır
                                    .textScale(.secondary)
                                //tıklandığında üstünü çizmek  strikethrough() bu direk üstüne çizer yada  strikethrough(toDo.isDone) ile true ise üstüne çizer
                                //pattern çizgi tipi belirleyebiliriz // color çizgi renginide verebiliri
                                    .strikethrough(toDo.isDone,pattern: .solid,color: .primary)
                                //Divider() iletext lerin  aralarına çizgi çektik
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ToDoWidget: Widget {
    let kind: String = "ToDoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ToDoWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ToDoWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        //adı
        .configurationDisplayName("ToDo Widget")
        //açıklaması
        .description("ToDo Widget with Interactions.")
    }
}

#Preview(as: .systemSmall) {
    ToDoWidget()
} timeline: {
    //    ToDoEntry(date: .now, emoji: "1😀")
    //    ToDoEntry(date: .now, emoji: "2🤩")
    ToDoEntry(toDoDisplay: Array(SharedDates.shared.toDos.prefix(3)))
    //reversed sıralaması ters yaptık
    ToDoEntry(toDoDisplay: Array(SharedDates.shared.toDos.reversed().prefix(3)))
}

//similasyonun hemen altında Entry1 ve Entry2 tıklayarak geçiş saplayabiliriz ve değiştiğini görebiliriz


