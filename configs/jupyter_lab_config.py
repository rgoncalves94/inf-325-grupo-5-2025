# Configuração do JupyterLab
# Este arquivo replica as configurações do CMD do Dockerfile

c = get_config()

# Carregar extensões IPython automaticamente
c.InteractiveShellApp.extensions = [
    'redis_command'
] 

# Configurações do servidor
c.ServerApp.ip = '0.0.0.0'
c.ServerApp.port = 8888
c.ServerApp.allow_root = True

# Configurações de autenticação
c.ServerApp.token = ''
c.ServerApp.password = ''

# Configurações de segurança
c.ServerApp.allow_origin = '*'
c.ServerApp.allow_credentials = True

# Configurações do notebook
c.NotebookApp.open_browser = False
c.NotebookApp.notebook_dir = '/notebooks'

# Configurações do Lab
c.LabApp.collaborative = False

# Configurações de desenvolvimento
c.ServerApp.root_dir = '/notebooks'
c.ServerApp.trust_xheaders = True

# Configurações de timeout
c.ServerApp.shutdown_no_activity_timeout = 0
c.ServerApp.iopub_data_rate_limit = 10000000
c.ServerApp.iopub_msg_rate_limit = 1000

# Configurações de memória
c.ServerApp.max_buffer_size = 5368709120  # 5GB

# Configurações de kernel
c.KernelManager.shutdown_wait_time = 5.0
c.KernelManager.autorestart = True 