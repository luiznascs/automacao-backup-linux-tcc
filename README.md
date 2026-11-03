# Automação de Backups em Linux com Bash

Projeto desenvolvido como parte de um Trabalho de Conclusão de Curso (TCC) em Ciência da Computação.

O objetivo é estudar a utilização de ferramentas de software livre e de código aberto na automação de tarefas rotineiras, utilizando como aplicação prática uma rotina de backup de arquivos em ambiente Linux.

## Tecnologias utilizadas

- Linux (Ubuntu)
- Shell Script / Bash
- rsync
- Cron
- Python 3
- Tkinter

Também foram realizados experimentos complementares com tar, gzip, GnuPG e SHA-256.

## Funcionalidades

- Backup de arquivos utilizando rsync
- Identificação de arquivos novos ou modificados
- Registro de duração, quantidade e tamanho dos arquivos transferidos
- Registro de erros e histórico de execuções
- Possibilidade de agendamento utilizando Cron
- Interface gráfica para executar backups e consultar o histórico

## Estrutura do projeto

- `scripts/backup.sh`: rotina principal de backup
- `scripts/interface.py`: interface gráfica em Python
- `scripts/backup_teste_erro.sh`: script utilizado no experimento de identificação de falhas
- `Backup-TCC.desktop`: atalho de inicialização da interface no Ubuntu

## Execução

O protótipo foi desenvolvido utilizando a seguinte estrutura de diretórios:

- `~/tcc/scripts/`
- `~/tcc/experimentos/origem/`
- `~/tcc/experimentos/backup_rsync/`
- `~/tcc/logs/`

Para preparar os diretórios necessários:

```bash
mkdir -p ~/tcc/scripts ~/tcc/experimentos/origem ~/tcc/experimentos/backup_rsync ~/tcc/logs
```

Copie os scripts para `~/tcc/scripts/` e execute:

```bash
bash ~/tcc/scripts/backup.sh
```

Para abrir a interface gráfica:

```bash
python3 ~/tcc/scripts/interface.py
```

É necessário possuir Bash, rsync, Python 3 e Tkinter instalados. O agendamento com Cron deve ser configurado separadamente.

O arquivo `Backup-TCC.desktop` contém um caminho absoluto utilizado no ambiente de desenvolvimento e deve ser adaptado conforme o usuário e a localização do projeto.

## Limitações

Este projeto é um protótipo acadêmico, desenvolvido e testado em uma máquina virtual com arquivos fictícios.

A configuração padrão do rsync utiliza informações como tamanho e horário de modificação para identificar arquivos que precisam ser atualizados. Alterações rápidas que não modifiquem essas informações podem não ser detectadas.

A solução não implementa verificação criptográfica automática de integridade, criptografia dos backups, restauração automatizada ou versionamento de arquivos.

Os experimentos complementares de compactação, criptografia e recuperação não estão integrados ao script principal.

O protótipo não foi implantado em ambiente empresarial de produção.

## Finalidade acadêmica

O repositório disponibiliza o código utilizado no desenvolvimento e nos experimentos do TCC, permitindo sua consulta, reprodução e possível aperfeiçoamento.
