#!/bin/bash

# Script para consolidar documentos .md em um único arquivo
# Autor: Script gerado automaticamente
# Data: $(date)

set -e  # Parar execução em caso de erro

REPO_URL="https://github.com/evertonfxavier/docs"
TEMP_DIR=$(mktemp -d)
OUTPUT_DIR=".github"
OUTPUT_FILE="$OUTPUT_DIR/copilot-instructions.md"

echo "🔄 Iniciando processo de consolidação de documentos..."

# Função para limpeza em caso de erro
cleanup() {
    echo "🧹 Limpando arquivos temporários..."
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Clonar repositório
echo "📥 Clonando repositório $REPO_URL..."
git clone "$REPO_URL" "$TEMP_DIR"

# Verificar se a pasta docs existe
if [ ! -d "$TEMP_DIR/docs" ]; then
    echo "❌ Erro: Pasta 'docs' não encontrada no repositório"
    exit 1
fi

# Criar pasta .github se não existir
mkdir -p "$OUTPUT_DIR"

# Inicializar arquivo de saída
echo "📝 Criando arquivo consolidado: $OUTPUT_FILE"
cat > "$OUTPUT_FILE" << 'EOF'
# Copilot Instructions

Este arquivo contém todas as diretrizes e documentações consolidadas do projeto.

---

EOF

# Encontrar e processar todos os arquivos .md na pasta docs
echo "🔍 Procurando arquivos .md na pasta docs..."
md_files=$(find "$TEMP_DIR/docs" -name "*.md" -type f | sort)

if [ -z "$md_files" ]; then
    echo "⚠️  Nenhum arquivo .md encontrado na pasta docs"
    exit 1
fi

# Processar cada arquivo .md
for file in $md_files; do
    filename=$(basename "$file")
    echo "📄 Processando: $filename"
    
    # Adicionar separador e nome do arquivo
    echo "" >> "$OUTPUT_FILE"
    echo "## $filename" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    
    # Adicionar conteúdo do arquivo
    cat "$file" >> "$OUTPUT_FILE"
    
    # Adicionar separador
    echo "" >> "$OUTPUT_FILE"
    echo "---" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
done

# Adicionar rodapé
cat >> "$OUTPUT_FILE" << EOF

---

*Arquivo gerado automaticamente em $(date)*
*Total de arquivos processados: $(echo "$md_files" | wc -l)*
EOF

echo "✅ Processo concluído com sucesso!"
echo "📁 Arquivo criado: $OUTPUT_FILE"
echo "📊 Arquivos processados:"
echo "$md_files" | while read -r file; do
    echo "   - $(basename "$file")"
done

echo ""
echo "🎉 Consolidação finalizada! O arquivo $OUTPUT_FILE está pronto para uso."
