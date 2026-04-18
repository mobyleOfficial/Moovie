# GitHub Secrets Setup for Moovie CI/CD

This document provides complete instructions for configuring GitHub secrets required for the Moovie Flutter CI/CD pipelines.

## Overview

Secrets are organized by platform (iOS/Android) and environment (DEV/PROD). Each secret uses environment-based naming to prevent accidental mixing of development and production credentials.

**Environment Naming Convention:**
- `SECRET_NAME_DEV` for development environment
- `SECRET_NAME_PROD` for production environment

## iOS Secrets

### Development Environment (DEV)

| Secret | Value | Where to Get | Format |
|--------|-------|--------------|--------|
| `APP_STORE_CONNECT_API_KEY_ID_DEV` | App Store Connect API Key ID | https://appstoreconnect.apple.com/access/api | Text (e.g., `ABC123`) |
| `APP_STORE_CONNECT_API_KEY_ISSUER_ID_DEV` | Issuer ID (UUID) | https://appstoreconnect.apple.com/access/api | Text (UUID format) |
| `APP_STORE_CONNECT_API_KEY_CONTENT_DEV` | API Key file content (.p8) | https://appstoreconnect.apple.com/access/api | Base64-encoded .p8 file |
| `SIGNING_CERTIFICATE_P12_BASE64_DEV` | iOS distribution certificate | Keychain Access (export as .p12) | Base64-encoded .p12 file |
| `SIGNING_CERTIFICATE_PASSWORD_DEV` | Password for .p12 certificate | Set when exporting from Keychain | Text (your password) |

### Production Environment (PROD)

Same as DEV but with `_PROD` suffix:
- `APP_STORE_CONNECT_API_KEY_ID_PROD`
- `APP_STORE_CONNECT_API_KEY_ISSUER_ID_PROD`
- `APP_STORE_CONNECT_API_KEY_CONTENT_PROD`
- `SIGNING_CERTIFICATE_P12_BASE64_PROD`
- `SIGNING_CERTIFICATE_PASSWORD_PROD`

**How to get App Store Connect API Key:**
1. Visit https://appstoreconnect.apple.com/access/api
2. Create a new key with "App Manager" role
3. Download the .p8 file
4. Note the Key ID and Issuer ID

**How to encode API Key content for `APP_STORE_CONNECT_API_KEY_CONTENT_*`:**
```bash
cat your-api-key.p8 | base64
```

**How to get signing certificate:**
1. Open Keychain Access on your Mac
2. Find your "iOS Distribution" certificate
3. Right-click → Export
4. Save as .p12 file with a password
5. Encode: `cat your-cert.p12 | base64`

---

## Android Secrets

### Development Environment (DEV)

| Secret | Value | Where to Get | Format |
|--------|-------|--------------|--------|
| `ANDROID_KEYSTORE_BASE64_DEV` | Android signing keystore (.jks) | Generated with keytool | Base64-encoded .jks file |
| `ANDROID_KEYSTORE_PASSWORD_DEV` | Keystore password | Set when creating keystore | Text |
| `ANDROID_KEY_ALIAS_DEV` | Key alias in keystore | Chosen when creating key | Text |
| `ANDROID_KEY_PASSWORD_DEV` | Password for the key | Set when creating key | Text |
| `GOOGLE_PLAY_API_JSON_DEV` | Google Play API JSON key | Google Cloud Console | Base64-encoded JSON file |

### Production Environment (PROD)

Same as DEV but with `_PROD` suffix:
- `ANDROID_KEYSTORE_BASE64_PROD`
- `ANDROID_KEYSTORE_PASSWORD_PROD`
- `ANDROID_KEY_ALIAS_PROD`
- `ANDROID_KEY_PASSWORD_PROD`
- `GOOGLE_PLAY_API_JSON_PROD`

**How to create Android signing keystore (if you don't have one):**
```bash
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10950 \
  -alias upload
```
Follow the prompts to set keystore password, key alias, and key password.

**How to encode keystore:**
```bash
cat upload-keystore.jks | base64
```

**How to get Google Play API JSON:**
1. Go to Google Cloud Console: https://console.cloud.google.com
2. Create a new service account
3. Grant "Editor" role to the service account
4. Create a JSON key for the service account
5. Download the JSON file
6. Encode: `cat your-api-key.json | base64`

---

## Shared Secrets

These secrets are used by both CI and CD workflows:

| Secret | Value | Environment |
|--------|-------|-------------|
| `TMDB_API_KEY_DEV` | TMDB API key for dev | Development |
| `TMDB_API_KEY_PROD` | TMDB API key for prod | Production |
| `BACKEND_URL_DEV` | Backend API URL (e.g., https://api-dev.example.com) | Development |
| `BACKEND_URL_PROD` | Backend API URL (e.g., https://api.example.com) | Production |

---

## How to Add Secrets to GitHub

1. Navigate to your GitHub repository
2. Go to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Enter the secret name (e.g., `APP_STORE_CONNECT_API_KEY_ID_DEV`)
5. Enter the secret value (paste the content or base64-encoded value)
6. Click **Add secret**
7. Repeat for all secrets in this document

**Note:** Secret names are case-sensitive. Use the exact names shown in this document.

---

## Secret Rotation

### When to Rotate Secrets

- API keys expire (typically annually for App Store Connect)
- Credentials are compromised
- Team member leaves
- Regular security audit (recommended annually)

### How to Rotate

1. **Generate new credentials** using the same process as initial setup
2. **Update all `_DEV` and `_PROD` versions** of the secret in GitHub
3. **Test in dev environment first** - trigger `ios-publish` or `android-publish` with dev environment
4. **Revoke old credentials** in the source system (App Store Connect, Google Cloud Console, Keychain)
5. **Document** the rotation date and reason

---

## Troubleshooting

### "Secret not found" error in workflow
- Verify the secret name is spelled correctly (case-sensitive)
- Ensure you're in the correct repository
- Check that the secret was saved (refresh the page)

### "Invalid credentials" error during deployment
- Verify the secret content is complete and correctly encoded
- For base64 values, check that the encoding is valid
- Ensure you're using the correct environment (DEV vs PROD)
- Check that credentials haven't expired

### "Base64 decode error" in Android workflow
- Verify the keystore is a valid .jks file
- Check the base64 encoding: `echo "$ENCODED_VALUE" | base64 -d` should produce valid binary
- Ensure there are no extra spaces or newlines in the base64-encoded value

---

## Security Best Practices

1. **Never commit secrets to version control** - GitHub Actions automatically masks secrets in logs
2. **Use different secrets for dev and prod** - Prevents accidental production deployment
3. **Rotate secrets regularly** - At least annually, or immediately if compromised
4. **Limit secret access** - Use GitHub environment protection rules for production
5. **Audit secret usage** - Review workflow logs to ensure secrets are only used as intended
6. **Cleanup local files** - Delete .p12, .jks, and JSON files from your local machine after encoding

---

## References

- [GitHub Actions: Using secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)
- [Google Play Console: API Access](https://developer.android.com/studio/publish/app-signing)
- [Fastlane: TestFlight](https://docs.fastlane.tools/actions/upload_to_testflight/)
- [Fastlane: Google Play](https://docs.fastlane.tools/actions/upload_to_play/)
