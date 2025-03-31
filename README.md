# 🖥️ RemoteApp Launcher com FreeRDP
Este script Bash realiza a conexão automatizada com uma aplicação RemoteApp em um servidor Windows Terminal Services (RDS), utilizando o cliente FreeRDP (xfreerdp) via linha de comando em sistemas Linux.

# 📋 Funcionalidade
O script:

Verifica se o xfreerdp está instalado.

Instala o xfreerdp automaticamente conforme a distribuição (Debian, RHEL, Arch).

Lê as credenciais de acesso de um arquivo oculto .login (ou solicita manualmente).

Executa a conexão RDP com o servidor TS, abrindo diretamente uma aplicação RemoteApp.

# 📁 Estrutura esperada
script.sh
.login       ← opcional, usado para autenticação automática

# 🔐 Arquivo .login (opcional)
Se presente, deve conter:

usuario
senha
# ⚠️ Atenção: Armazene esse arquivo com permissão restrita:

bash
Copiar
Editar
chmod 600 .login
# ⚙️ Variáveis configuráveis
Variável	Valor Padrão	Descrição
SERVER	10.1.19.11	IP ou hostname do servidor RDS
APP_ALIAS	LogOff_TS	Alias da aplicação publicada via RemoteApp
DOMAIN	intranet	Domínio usado para login (ex: DOMÍNIO\usuário)
# 📦 Dependência
xfreerdp

O script instala automaticamente com:
apt (Debian/Ubuntu)

# ▶️ Uso
bash
Copiar
Editar
./conectar_remoteapp.sh
Se o .login estiver presente, as credenciais são carregadas automaticamente.

Caso contrário, o usuário será solicitado interativamente.

# 💡 Exemplo de execução
bash
Copiar
Editar
[INFO] xfreerdp não encontrado. Instalando...
[INFO] Credenciais carregadas automaticamente do arquivo .login

# 🛡️ Segurança
O script ignora verificação de certificado (/cert:ignore)

Use em redes confiáveis.

Mantenha o .login seguro se optar por autenticação automática.

