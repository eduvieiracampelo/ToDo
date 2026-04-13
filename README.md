# Gerenciador de Tarefas

Um aplicativo de gerenciamento de projetos e tarefas construído com Ruby on Rails 8.

## Funcionalidades

- **Projetos**: Criar, editar e excluir projetos
- **Tarefas**: Gerenciar tarefas dentro de cada projeto com acompanhamento de status
- **Workflow de Status**: Acompanhar tarefas através de A Fazer → Em Progresso → Concluído
- **Datas**: Definir data de início e término dos projetos, data de vencimento das tarefas
- **Dashboard**: Visualizar todos os projetos com estatísticas de tarefas
- **Tema Escuro**: Suporte a modo escuro com alternância automática
- **Toast Notifications**: Mensagens de feedback animadas
- **Interface em Português**: Totalmente traduzido para pt-BR

## Stack Técnica

- Ruby 3.4.7
- Rails 8.1.3
- SQLite3
- Hotwire (Turbo + Stimulus)
- Tailwind CSS 4

## Começando

### Pré-requisitos

- Ruby 3.4.7
- Bundler

### Instalação

```bash
# Instalar dependências
bin/setup

# Executar migrações
bin/rails db:migrate

# Iniciar servidor
bin/dev
```

Acesse `http://localhost:3000` para usar o aplicativo.

## Uso

1. **Criar Projeto**: Clique em "Novo Projeto" e preencha o nome e descrição
2. **Adicionar Tarefas**: Na página do projeto, clique em "Adicionar Tarefa"
3. **Atualizar Status**: Use o dropdown para mudar o status da tarefa
4. **Editar/Excluir**: Use os botões para editar ou excluir projetos e tarefas
5. **Alternar Tema**: Clique no ícone sol/lua no header para alternar entre temas claro e escuro

## Executando Testes

```bash
bin/rails test
```

## Qualidade de Código

```bash
# Executar RuboCop
bin/rubocop

# Executar varredura de segurança
bin/brakeman --no-pager
bin/bundler-audit
```

## CI/CD

O projeto inclui GitHub Actions para:
- Varredura de segurança Ruby (Brakeman)
- Varredura de vulnerabilidade de gems (bundler-audit)
- Audit de dependências JavaScript
- Linting RuboCop
- Suite de testes

## Licença

Este projeto está disponível para fins educacionais.