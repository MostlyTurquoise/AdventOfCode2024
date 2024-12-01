echo "# Advent Of Code 2024!!" > README.md
echo "" >> README.md
echo "## Languages:" >> README.md
for i in $(seq 1 24)
do
    echo "- [ ] Day ${i}: " >> README.md
done