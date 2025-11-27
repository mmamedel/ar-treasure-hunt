# Jogo de Caça ao Tesouro em AR 🎮

Um jogo de caça ao tesouro em realidade aumentada baseado em reconhecimento de imagens, desenvolvido com **Svelte 5**, **TypeScript** e **MindAR**. Os jogadores usam a câmera do celular para encontrar marcadores físicos e coletar tesouros virtuais escondidos no mundo real.

## 🚀 Funcionalidades

- **AR Baseada em Imagens** - Tesouros aparecem ao detectar marcadores específicos com a câmera
- **Feed de Câmera em Tempo Real** - Usa a câmera do dispositivo para experiência AR
- **TypeScript** - Segurança de tipos completa com TypeScript
- **Svelte 5 State Runes** - Gerenciamento de estado moderno com `$state` e `$derived`
- **Interface Responsiva** - Design mobile-first otimizado para celulares
- **Mecânicas de Jogo** - Sistema de pistas, dicas temporizadas, rastreamento de progresso
- **Modelos 3D Animados** - Cada tesouro possui um modelo 3D único com animações personalizadas
- **PWA** - Progressive Web App com suporte offline

## 🛠️ Stack Tecnológico

- **Framework**: Svelte 5 + SvelteKit
- **Linguagem**: TypeScript
- **Biblioteca AR**: MindAR (reconhecimento de imagens)
- **Renderização 3D**: Three.js
- **Banco de Dados**: Prisma + PostgreSQL
- **Gerenciador de Pacotes**: pnpm
- **Deploy**: Vercel

## 📱 Pré-requisitos

O aplicativo requer:

- Dispositivo com câmera
- Permissão de acesso à câmera
- Navegador mobile moderno (Chrome/Safari recomendados)
- Marcadores impressos para reconhecimento AR (localizados em `/static/targets/`)

## 🏗️ Instalação

```bash
# Clone o repositório
git clone <url-do-seu-repo>
cd ar-treasure-hunt

# Instale as dependências com pnpm
pnpm install

# Configure o banco de dados (opcional para desenvolvimento local)
# Crie um arquivo .env com DATABASE_URL

# Execute as migrações do Prisma
pnpm prisma migrate dev

# Inicie o servidor de desenvolvimento
pnpm dev
```

## 🎮 Como Jogar

1. **Digite seu Nome** - Insira seu nome para iniciar uma nova partida
2. **Leia a Pista** - Cada tesouro possui uma pista que indica onde o marcador está escondido
3. **Use a Dica (Opcional)** - Após 5 minutos, uma dica adicional fica disponível
4. **Abra a Câmera** - Clique em "ABRIR CÂMERA" para ativar o modo AR
5. **Encontre o Marcador** - Aponte a câmera para o marcador físico indicado pela pista
6. **Colete o Tesouro** - Quando o marcador for detectado, o modelo 3D aparecerá. Toque na tela para coletar
7. **Continue a Aventura** - Colete todos os tesouros para completar o jogo!

## 🚀 Deploy para Vercel

O aplicativo está configurado para fácil deploy na Vercel:

### Opção 1: Deploy via Git

1. Faça push do seu código para GitHub/GitLab/Bitbucket
2. Importe o repositório no [Painel da Vercel](https://vercel.com/new)
3. A Vercel detectará automaticamente o SvelteKit e configurará as opções de build
4. Adicione a variável de ambiente `DATABASE_URL` nas configurações do projeto
5. Deploy!

### Opção 2: Deploy via CLI

```bash
# Instale a CLI da Vercel
pnpm i -g vercel

# Deploy (siga as instruções)
vercel

# Deploy para produção
vercel --prod
```

### Variáveis de Ambiente Necessárias

Configure as seguintes variáveis de ambiente na Vercel:

- `DATABASE_URL` - String de conexão do PostgreSQL (recomendado: Vercel Postgres)

## 📁 Estrutura do Projeto

```
ar-treasure-hunt/
├── src/
│   ├── lib/
│   │   ├── components/
│   │   │   ├── ClueScreen.svelte       # Tela de pistas
│   │   │   ├── NameEntry.svelte        # Entrada do nome do jogador
│   │   │   ├── GameFinished.svelte     # Tela de conclusão
│   │   │   ├── CaptureSuccess.svelte   # Animação de sucesso
│   │   │   └── ...                     # Outros componentes UI
│   │   └── stores/
│   │       └── gameState.svelte.ts     # Gerenciamento de estado (Svelte 5 runes)
│   └── routes/
│       ├── +page.svelte                # Página principal do jogo
│       └── api/                        # API routes (Prisma)
├── static/
│   ├── ar-viewer.html                  # Visualizador AR (MindAR + Three.js)
│   ├── models/                         # Modelos 3D (.glb)
│   ├── targets/                        # Marcadores de imagem para AR
│   └── treasures.json                  # Configuração dos tesouros
├── prisma/
│   └── schema.prisma                   # Schema do banco de dados
├── vercel.json                         # Configuração da Vercel
└── package.json
```

## 🔧 Configuração

### Configuração dos Tesouros

Os tesouros são configurados no arquivo `/static/treasures.json`. Cada tesouro contém:

- **id**: Identificador único
- **clue**: Pista principal
- **hint**: Dica adicional (disponível após 5 minutos)
- **imageTarget**: Caminho para o arquivo `.mind` (marcador compilado)
- **targetIndex**: Índice do alvo no arquivo `.mind`
- **model**: Configurações do modelo 3D (arquivo, escala, rotação, posição)
- **animation**: Configurações de animação (rotação, balanço, pulsação, etc.)

### Criação de Novos Marcadores

Para adicionar novos tesouros:

1. Acesse [MindAR Image Tracking Compiler](https://hiukim.github.io/mind-ar-js-doc/tools/compile)
2. Faça upload das suas imagens de marcadores
3. Baixe o arquivo `.mind` gerado
4. Adicione à pasta `/static/targets/`
5. Configure no `treasures.json`

### Configurações da Vercel

O arquivo `vercel.json` está pré-configurado com:

- Build command: `pnpm vercel-build` (inclui migração do Prisma)
- Output directory: `build`
- Framework: `svelte-kit`

## 📝 Notas de Desenvolvimento

### Gerenciamento de Estado

O aplicativo usa as novas state runes do Svelte 5:

- `$state()` para estado reativo
- `$derived()` para valores computados
- Acesso direto a propriedades (sem prefixo `$`)

### Arquitetura AR

- **Frontend (SvelteKit)**: Interface do jogo e lógica de progressão
- **AR Viewer (HTML estático)**: Visualizador AR separado usando MindAR + Three.js
- **Comunicação**: Via `localStorage` para compartilhar estado do jogo
- **Modelos 3D**: GLB/GLTF com suporte a compressão Draco

### TypeScript

Todos os componentes são totalmente tipados com:

- Definições de interface para `Treasure`, `GameSession`, etc.
- Event handlers type-safe
- Classes TypeScript adequadas para gerenciamento de estado

## 💡 Dicas para Futuros Eventos

### Design de Marcadores AR

Para criar marcadores que funcionem bem com MindAR:

- **Alto Contraste**: Use imagens com boa distinção entre áreas claras e escuras
- **Detalhes Únicos**: Evite padrões repetitivos ou simétricos
- **Tamanho Mínimo**: Marcadores impressos devem ter pelo menos 10x10cm
- **Qualidade**: Imprima em alta resolução (300 DPI ou superior)
- **Evite Reflexos**: Use papel fosco em vez de brilhante
- **Teste de Rastreamento**: Use o [MindAR Compiler](https://hiukim.github.io/mind-ar-js-doc/tools/compile) para ver a pontuação de rastreabilidade (ideal: > 50)

### Testando sem Marcadores Físicos

Durante o desenvolvimento, você pode testar exibindo marcadores na tela:

1. Abra a imagem do marcador em outra tela/dispositivo
2. Aponte a câmera do dispositivo de teste para a tela
3. Ajuste o brilho da tela para melhor detecção
4. Alternativamente, use o navegador desktop com webcam

### Otimização de Modelos 3D

Para garantir boa performance em dispositivos móveis:

- **Tamanho do Arquivo**: Mantenha modelos abaixo de 5MB
- **Polígonos**: Limite a 50k triângulos por modelo
- **Texturas**: Use texturas comprimidas (máx 2048x2048)
- **Formato**: Prefira GLB com compressão Draco
- **Ferramentas**: Use [glTF Transform](https://gltf-transform.dev/) para otimizar
- **Teste em Dispositivos Reais**: Performance varia significativamente entre dispositivos

### Ajustando Dificuldade do Jogo

Você pode customizar a experiência alterando:

```typescript
// Em ClueScreen.svelte - Linha 17
const HINT_DELAY_MS = 5 * 60 * 1000; // Altere para ajustar tempo até dica

// Em treasures.json
// Adicione mais ou menos tesouros
// Ajuste complexidade das pistas
```

### Posicionamento de Marcadores no Local

Dicas para posicionar marcadores no espaço físico:

- **Iluminação**: Evite luz direta do sol ou sombras muito escuras
- **Altura**: Posicione na altura do peito (mais confortável para câmera)
- **Acessibilidade**: Garanta que todos os jogadores possam alcançar
- **Proteção**: Use plástico/laminação para proteger de água/danos
- **Visibilidade**: Marcadores não devem ser muito óbvios (parte do desafio!)
- **Backup**: Tenha cópias extras de cada marcador

### Troubleshooting Comum

**Marcador não é detectado:**

- Verifique iluminação do ambiente
- Limpe a lente da câmera
- Certifique-se que o marcador está completamente visível
- Tente diferentes distâncias (20cm - 1m é ideal)

**Modelo 3D não aparece:**

- Verifique console do navegador para erros
- Confirme que o caminho do modelo está correto em `treasures.json`
- Teste se o modelo carrega acessando diretamente: `/models/seu-modelo.glb`

**Performance ruim:**

- Reduza complexidade dos modelos 3D
- Simplifique animações
- Teste em dispositivo com especificações similares ao público-alvo

### Personalizando o Tema

Para adaptar para diferentes eventos:

- **Cores**: Modifique variáveis CSS em `src/routes/+layout.svelte`
- **Fontes**: Atualize `@font-face` no layout
- **Imagens de Fundo**: Substitua arquivos em `/static/images/design/`
- **Pistas e Dicas**: Edite diretamente em `treasures.json`
- **Áudio**: Adicione efeitos sonoros em `/static/audio/`

### Gerenciamento de Dados do Evento

O jogo usa Prisma + PostgreSQL para persistência de dados:

**Preparação pré-evento:**

```bash
# Limpar dados de testes anteriores
pnpm prisma studio  # Interface visual para gerenciar dados

# Ou via CLI
pnpm prisma db push  # Sincronizar schema
```

**Durante o evento:**

- Dados de sessão são armazenados em `localStorage` (lado do cliente)
- Dados persistentes vão para o banco via API routes
- Monitore o banco para analytics em tempo real

**Pós-evento:**

```bash
# Exportar resultados
pnpm prisma studio  # Exportar dados como CSV

# Backup do banco
# Use ferramentas da Vercel ou pg_dump
```

**Dica**: Crie uma rota admin (`/admin`) para visualizar estatísticas do evento em tempo real (tempo médio, tesouros mais difíceis, etc.)

### Checklist Pré-Evento

**1 Semana Antes:**

- [ ] Todos os marcadores criados e testados no MindAR Compiler
- [ ] Modelos 3D otimizados e testados em dispositivos reais
- [ ] Pistas e dicas escritas e revisadas
- [ ] Marcadores impressos (+ cópias extras)
- [ ] Locais físicos identificados e mapeados
- [ ] Teste completo do fluxo do jogo end-to-end

**1 Dia Antes:**

- [ ] Deploy final em produção
- [ ] Variáveis de ambiente configuradas
- [ ] Banco de dados limpo e pronto
- [ ] Marcadores laminados/protegidos
- [ ] Verificar iluminação dos locais no horário do evento
- [ ] Testar conexão de internet nos locais

**No Dia do Evento:**

- [ ] Posicionar todos os marcadores 1h antes
- [ ] Testar cada marcador in-loco
- [ ] URL do jogo facilmente acessível (QR code?)
- [ ] Dispositivo de backup para demonstração
- [ ] Suporte técnico disponível

**Materiais Úteis para o Evento:**

- Fita adesiva/blu-tack para fixar marcadores
- Panos para limpar lentes de câmera
- Bateria portátil para dispositivos
- Lista impressa com localizações dos marcadores

### Referência Rápida - Arquivos Importantes

**Configuração do Jogo:**

- `static/treasures.json` - Configuração de todos os tesouros (pistas, dicas, modelos)
- `src/lib/stores/gameState.svelte.ts` - Lógica do estado do jogo
- `src/lib/components/ClueScreen.svelte:17` - Tempo até dica disponível

**Aparência e Tema:**

- `src/routes/+layout.svelte` - Variáveis CSS globais, fontes
- `static/images/design/` - Imagens de fundo e decoração
- `src/lib/components/DecorativeBorder.svelte` - Bordas decorativas

**Experiência AR:**

- `static/ar-viewer.html` - Visualizador AR completo
- `static/targets/` - Marcadores compilados (.mind)
- `static/models/` - Modelos 3D (.glb)

**Banco de Dados:**

- `prisma/schema.prisma` - Schema do banco
- `src/routes/api/` - Endpoints da API

## 🎯 Recursos Adicionais

- [Documentação do MindAR](https://hiukim.github.io/mind-ar-js-doc/)
- [Documentação do Three.js](https://threejs.org/docs/)
- [Documentação do Svelte 5](https://svelte.dev/docs/svelte/overview)
- [Modelos 3D Gratuitos](https://sketchfab.com/feed)
