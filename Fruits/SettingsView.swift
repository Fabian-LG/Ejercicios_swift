//
//  SettingsView.swift
//  Fruits
//
//  Created by Fabián Alejandro López García on 27/09/22.
//

import SwiftUI

struct SettingsView: View {
    //MARK: PROPERTIES
    
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    
    //MARK: BODY
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 20){
                    //MARK: SECTION 1
                    GroupBox(
                        label:
                           SettingsLabelView(labelText: "Fruits", labelImage: "info.circle")){
                               Divider().padding(.vertical, 4)
                               HStack(alignment: .center, spacing: 10){
                                   Image("logo")
                                       .resizable()
                                       .scaledToFit()
                                       .frame(width: 80, height: 80)
                                       .cornerRadius(9)
                                   
                                   Text("Most fruits are naturally low in fat, sodium, and calories. None have cholesterol. Fruits are potassium, dietary fiber, vitamins, and much more.")
                                       .font(.footnote)
                               }
                            }//: GROUP
                    
                    //MARK: SECTION 2
                    GroupBox(label: SettingsLabelView(labelText: "Customization", labelImage: "paintbrush")){
                        Divider().padding(.vertical, 4)
                        
                        Text("If you wish, you can restrt the application by toggle the switch in this box. That way it starts the onboarding process and you will see the welcome screen again")
                            .padding(.vertical, 8)
                            .frame(minHeight: 60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        Toggle(isOn: $isOnboarding){
                            if isOnboarding {
                                Text("Restarted".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                            } else {
                                Text("Restart".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.secondary)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.tertiarySystemBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous)))
                        
                    }
                    
                    
                    //MARK: SECTION 3
                    
                    GroupBox(
                        label: SettingsLabelView(labelText: "Aplicaction", labelImage: "apps.iphone")){
                            
                            SettingsRowView(name: "Developer", content: "Fab")
                            SettingsRowView(name: "Designer", content: "Fabo")
                            SettingsRowView(name: "Compatibility", content: "iOS 14")
                            SettingsRowView(name: "Website", linklabel: "SwiftUI Masterclass", linkDestination: "swiftuimasterclass.com")
                            SettingsRowView(name: "Twitter", linklabel: "@fablg21", linkDestination: "twitter.com")
                            SettingsRowView(name: "SwiftUI", content: "2.0")
                            SettingsRowView(name: "Version", content: "1.1.0")
                        }
                }//: VSTACK
                .navigationBarTitle(Text("Settings"), displayMode: .large)
                .navigationBarItems(
                    trailing:
                        Button(action:{
                            presentationMode.wrappedValue.dismiss()
                        }){
                            Image(systemName: "xmark")
                        }
                )
                .padding()
            }
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
