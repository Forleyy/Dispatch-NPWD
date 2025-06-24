Free to use, no support, do not ressel this shit thx



```sql

CREATE TABLE IF NOT EXISTS npwd_messages_conversations (
    id INT PRIMARY KEY,
    -- Ajoute d'autres colonnes selon NPWD, par exemple :
    name VARCHAR(64),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS npwd_messages_participants (
    id INT AUTO_INCREMENT PRIMARY KEY,
    conversation_id INT NOT NULL,
    participant VARCHAR(32) NOT NULL, -- numéro de téléphone
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (conversation_id) REFERENCES npwd_messages_conversations(id)
);

INSERT IGNORE INTO npwd_messages_conversations (id, name) VALUES
  (1, 'LSPD'),
  (2, 'EMS'),
  (3, 'EM LSPD'),
  (4, 'DIR EMS'),
  (5, 'LSFS'),
  (6, 'EM LSFS'),
  (7, 'Sheriff'),
  (8, 'EM Sheriff');
```
