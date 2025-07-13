import SwiftUI

@available(iOS 14.0, macOS 11.0, *)
struct AlertToastDemoView: View {
    @State private var showToast = false

    @State private var displayMode: AlertToast.DisplayMode = .hud
    @State private var alertType: AlertTypeOption = .complete
    @State private var widthOption: ToastWidthOption = .default
    @State private var title: String = "Success"
    @State private var subTitle: String? = "This is a subtitle."

    enum AlertTypeOption: String, CaseIterable, Identifiable {
        case complete = "Complete"
        case error = "Error"
        case systemImage = "System Image"
        case image = "Image"
        case loading = "Loading"
        case regular = "Regular"
        var id: String { rawValue }

        var value: AlertToast.AlertType {
            switch self {
                case .complete: return .complete(.green)
                case .error: return .error(.red)
                case .systemImage: return .systemImage("flag.fill", .blue)
                case .image: return .image("applelogo", .primary)
                case .loading: return .loading
                case .regular: return .regular
            }
        }
    }

    enum DisplayModeOption: String, CaseIterable, Identifiable {
        case alert = "Alert"
        case hud = "HUD"
        case banner = "Banner"
        var id: String { rawValue }

        var value: AlertToast.DisplayMode {
            switch self {
                case .alert: return .alert
                case .hud: return .hud
                case .banner: return .banner(.slide)
            }
        }
    }

    enum ToastWidthOption: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case expanded = "Expanded"
        case custom = "Custom (200pt)"
        var id: String { rawValue }

        var value: AlertToast.ToastWidth {
            switch self {
                case .default: return .default
                case .expanded: return .expanded
                case .custom: return .custom(200)
            }
        }
    }

    var body: some View {
        VStack {
            Form {
                Section(header: Text("Toast Options")) {
                    Picker("Display Mode", selection: $displayMode) {
                        ForEach(DisplayModeOption.allCases) { option in
                            Text(option.rawValue).tag(option.value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Picker("Alert Type", selection: $alertType) {
                        ForEach(AlertTypeOption.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }

                    if displayMode == .hud {
                        Picker("Width", selection: $widthOption) {
                            ForEach(ToastWidthOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }

                    TextField("Title", text: $title)
                    TextField("Subtitle (Optional)", text: Binding(
                        get: { self.subTitle ?? "" },
                        set: { self.subTitle = $0.isEmpty ? nil : $0 }
                    ))
                }

                Section {
                    Button("Show Toast") {
                        showToast.toggle()
                    }
                }
            }
        }
        .navigationTitle("AlertToast Demo")
        .toast(isPresenting: $showToast,
               alert: {
                   AlertToast(displayMode: displayMode,
                              type: alertType.value,
                              title: title,
                              subTitle: subTitle,
                              width: displayMode == .hud ? widthOption.value : .default)
               })
    }
}

struct AlertToastDemoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AlertToastDemoView()
        }
    }
}

extension AlertToast.DisplayMode: RawRepresentable, CaseIterable, Identifiable, Hashable {
    public static var allCases: [AlertToast.DisplayMode] = [.alert, .hud, .banner(.slide)]

    public var id: String {
        switch self {
            case .alert: return "alert"
            case .hud: return "hud"
            case .banner: return "banner"
        }
    }

    public init?(rawValue: String) {
        switch rawValue {
            case "alert": self = .alert
            case "hud": self = .hud
            case "banner": self = .banner(.slide)
            default: return nil
        }
    }

    public var rawValue: String {
        switch self {
            case .alert: return "alert"
            case .hud: return "hud"
            case .banner: return "banner"
        }
    }
}
