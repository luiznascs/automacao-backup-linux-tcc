

import tkinter as tk
from tkinter import messagebox, scrolledtext
import subprocess
from pathlib import Path

SCRIPT_BACKUP = Path.home() / "tcc/scripts/backup.sh"

def executar_backup():
    botao_backup.config(state="disabled")
    status.config(text="Executando backup...", fg="#d97706")
    janela.update_idletasks()

    try:
        resultado = subprocess.run(
            ["/bin/bash", str(SCRIPT_BACKUP)],
            capture_output=True,
            text=True,
            timeout=300
        )

        area_resultado.delete("1.0", tk.END)
        area_resultado.insert(tk.END, resultado.stdout)

        if resultado.returncode == 0:
            status.config(text="Backup concluído com sucesso!", fg="green")
            messagebox.showinfo("Sucesso", "Backup realizado com sucesso!")
        else:
            status.config(text="Erro durante o backup", fg="red")
            area_resultado.insert(tk.END, resultado.stderr)
            messagebox.showerror("Erro", "O backup não foi concluído.")

    except Exception as erro:
        status.config(text="Falha na execução", fg="red")
        messagebox.showerror("Erro", str(erro))

    finally:
        botao_backup.config(state="normal")


def visualizar_logs():
    caminho_log = Path.home() / "tcc/logs/backup.log"

    try:
        conteudo = caminho_log.read_text(encoding="utf-8")

        area_resultado.delete("1.0", tk.END)
        area_resultado.insert(tk.END, conteudo)

        status.config(text="Histórico de backups carregado", fg="blue")

    except FileNotFoundError:
        messagebox.showwarning(
            "Aviso",
            "Nenhum histórico de backup foi encontrado."
        )

janela = tk.Tk()
janela.title("Sistema de Automação de Backup")
janela.geometry("650x450")

titulo = tk.Label(
    janela,
    text="Sistema de Backup - Secretaria",
    font=("Arial", 18, "bold")
)
titulo.pack(pady=20)

descricao = tk.Label(
    janela,
    text="Automação de backup utilizando software livre",
    font=("Arial", 11)
)
descricao.pack(pady=5)

botao_backup = tk.Button(
    janela,
    text="Executar Backup",
    font=("Arial", 12, "bold"),
    command=executar_backup,
    width=20,
    height=2
)
botao_backup.pack(pady=15)

# Botao para consultar o historico dos backups

botao_logs = tk.Button(
	janela,
	text="Visualizar Histórico",
	font = ("Arial", 11),
	command=visualizar_logs,
	width=20,
	height=2
)
botao_logs.pack(pady=5)

status = tk.Label(
    janela,
    text="Aguardando execução",
    font=("Arial", 11)
)
status.pack(pady=5)

area_resultado = scrolledtext.ScrolledText(
    janela,
    width=75,
    height=12
)
area_resultado.pack(padx=15, pady=10)

janela.mainloop()

