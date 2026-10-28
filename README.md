# Hermes WebUI for iOS

A lightweight iOS WKWebView wrapper for [Hermes WebUI](https://github.com/nesquena/hermes-webui).

Hermes WebUI is a self-hosted web interface for [Hermes Agent](https://hermes-agent.nousresearch.com/). This app lets you reach your WebUI instance from an iPhone or iPad without Safari chrome.

## Features

- Full-screen WKWebView loading your WebUI instance
- Persistent login (cookies and localStorage survive app restarts)
- First-launch server URL setup, changeable from the gear button
- Self-signed HTTPS certificate support for the configured host only
- Native back/forward swipe gestures
- Works with Tailscale Serve, SSH tunnels, or any HTTPS reverse proxy

## Building

This repo uses [Jeho974/ipa-build-template](https://github.com/Jeho974/ipa-build-template) to build an **unsigned** IPA on GitHub Actions macOS runners.

Push to `main`, or run the "Build IPA" workflow manually, to produce an unsigned IPA and a GitHub Release.

## Installing on iPhone

1. Download the `.ipa` from the Releases page.
2. Open it in **BuildBox** (Sign tab) to sign and install.
3. Launch the app and enter your Hermes WebUI server URL.

## Server URL

Enter the URL where your Hermes WebUI is reachable from your phone:

- **Tailscale Serve (recommended):** `https://<host>.<tailnet>.ts.net`
- **HTTPS reverse proxy:** `https://your-domain.example`
- **SSH tunnel / LAN:** `http://<server-ip>:8787`

The app trusts self-signed certificates only for the host you configure. Other hosts use standard certificate validation.

## Security notes

- The app stores only the server URL in `UserDefaults`.
- WebUI authentication cookies live in the default WKWebView data store.
- Traffic security depends on your server setup; HTTPS is strongly recommended.

## Upstream

- Hermes WebUI: https://github.com/nesquena/hermes-webui
- Hermes Agent: https://hermes-agent.nousresearch.com/
