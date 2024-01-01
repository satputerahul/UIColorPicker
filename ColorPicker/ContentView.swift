import SwiftUI

struct ContentView: View {
   @State var backgroundColor = Color(.systemBackground)
    @State var copiedToClipboard = false
    
    var body: some View
    {
        NavigationView {
            VStack {
                ZStack {
                    backgroundColor
                    
                    ColorPicker("Select Color", selection: $backgroundColor)
                        .font(.largeTitle).bold()
                        .frame(width: 300, height: 300)
                        .padding()
                }
                
                Text("Hex Color Code: \(hexString(from: backgroundColor))")
                    .font(.system(size: 25))
                    .bold()
                    .foregroundColor(.orange)
                    .padding()
                    .foregroundColor(.primary)
                    .onTapGesture {
                                    copyToClipboard()
                            }
                                .alert(isPresented: $copiedToClipboard) {
                                    Alert(title: Text("Color Code Copied"),
                                          dismissButton: .default(Text("OK")))
                               }
            }
            .navigationTitle("Color Picker")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func copyToClipboard() {
                let colorCode = hexString(from: backgroundColor)
                UIPasteboard.general.string = colorCode
                copiedToClipboard = true
            }
    
    func hexString(from color: Color) -> String {
            let components = color.cgColor?.components
            
            guard let red = components?[0], let green = components?[1], let blue = components?[2] else {
                return ""
            }
            
            let r = Int(red * 255)
            let g = Int(green * 255)
            let b = Int(blue * 255)
            
            return String(format: "#%02X%02X%02X", r, g, b)
        }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
#Preview {
    ContentView()
}

extension UIColor {
    func rgbHexString() -> String {
        guard let components = cgColor.components, components.count >= 3 else {
            return ""
        }

        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])

        return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
    }
}
