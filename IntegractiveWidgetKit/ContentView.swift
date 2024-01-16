/*
 
 Kullanıcı Etkileşimli Widget
 -https://developer.apple.com/videos/all-videos/?q=%22widgets%22%22Live%20Activities%22 diğerlerini iinceleyeiblirsiniz
 -SwiftUI ile
 -Widget eklemek için proje klasörü seçili üst çubuktan File-> New-> Target... -> iOS -> Widget Extension seçildi isim verildi -> Include Live Activity ve Include Configuration App Intent pasif ile Finish tıkladık seçilebilirde sonradanda eklenebiliyor -> Active tıkladık (active ederek direk eklendi çalışsın diyoruz üst taraftan değiştirilebilir)
 
 
 */

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
