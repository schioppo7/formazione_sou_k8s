# Pipeline di Verifica Giorno della Settimana (pipeline_verifica_data)

## Architettura dell'Ambiente

Il processo si basa su un'architettura distribuita per garantire isolamento e sicurezza:

- **Jenkins Controller:** Gestisce l'orchestrazione, la pianificazione temporale (cron-job) e i trigger di avvio.
- **Jenkins Agent (`agent-1`):** Un nodo di esecuzione dedicato basato su un container Docker (`jenkins/inbound-agent`). Esegue i controlli all'interno di una rete isolata (`jenkins-net`), interfacciandosi con il socket Docker dell'host per garantire un ambiente di runtime pulito e isolato.

---

## Cosa fa la Pipeline

La pipeline esegue un flusso sequenziale suddiviso in due macro-fasi logiche:

### 1. Recupero Ambiente (Checkout)
La pipeline si attiva (manualmente o tramite automazione temporale). Come prima operazione, sincronizza l'area di lavoro scaricando gli script di controllo e i file necessari dal repository.

### 2. Controllo del Giorno e Validazione
Questa è la fase centrale. Viene eseguito uno script che interroga il sistema per ottenere il giorno della settimana corrente (Lunedì, Martedì, ecc.). In base al giorno rilevato, la pipeline prende decisioni automatizzate:
- **Giorni lavorativi standard (Lunedì - Venerdì):** La pipeline procede normalmente con le successive fasi di build o deploy.
- **Giorni critici (Sabato - Domenica):** Se viene rilevato un giorno festivo o a ridosso del weekend, la pipeline può interrompere l'esecuzione in sicurezza o richiedere un'approvazione manuale per evitare rilasci rischiosi.


