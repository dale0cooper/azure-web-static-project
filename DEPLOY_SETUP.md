# GitHub OIDC Deploy Setup (einmalig)

## 1) Repo-Secrets in GitHub setzen
- AZURE_CLIENT_ID
- AZURE_TENANT_ID
- AZURE_SUBSCRIPTION_ID

## 2) Azure: Federated Credential für GitHub einrichten
Empfohlen auf einer App Registration / Service Principal:
- Issuer: https://token.actions.githubusercontent.com
- Subject: repo:<OWNER>/<REPO>:ref:refs/heads/main
- Audience: api://AzureADTokenExchange

## 3) Azure RBAC
Dem Service Principal auf Storage Account `pdvstatic` zuweisen:
- Rolle: Storage Blob Data Contributor
- Scope: Storage Account `pdvstatic`

## 4) Betrieb
- Änderungen unter `src/`
- Commit + Push auf `main`
- GitHub Action deployt automatisch nach `$web`
