import SwiftUI

struct ContentView: View {
    @AppStorage("serverURL") private var serverURL: String = ""
    @State private var showSettings = false

    var body: some View {
        Group {
            if !serverURL.isEmpty, let url = URL(string: serverURL) {
                WebView(url: url)
                    .id(serverURL)
                    .ignoresSafeArea()
                    .overlay(alignment: .topTrailing) {
                        Button {
                            showSettings = true
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.title3)
                                .padding(10)
                                .background(.ultraThinMaterial, in: Circle())
                                .shadow(radius: 2)
                        }
                        .padding(.top, 8)
                        .padding(.trailing, 12)
                    }
            } else {
                SetupView(serverURL: $serverURL)
            }
        }
        .sheet(isPresented: $showSettings) {
            SetupView(serverURL: $serverURL)
        }
    }
}

struct SetupView: View {
    @Binding var serverURL: String
    @Environment(\.dismiss) private var dismiss
    @State private var draft: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("https://your-vps.tail1234.ts.net", text: $draft)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .keyboardType(.URL)
                        .font(.system(.body, design: .monospaced))
                } header: {
                    Text("Hermes WebUI Server URL")
                } footer: {
                    Text("Recommended: Tailscale Serve (https://<host>.<tailnet>.ts.net) or an HTTPS reverse proxy. Plain HTTP works for LAN or SSH-tunnel addresses.")
                }

                Section {
                    Button("Connect") {
                        serverURL = draft.trimmingCharacters(in: .whitespacesAndNewlines)
                        dismiss()
                    }
                    .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .navigationTitle("Hermes WebUI")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
            .onAppear { draft = serverURL }
        }
    }
}
