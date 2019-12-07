touch:
    @echo "reset timetstamps on git working directory files..."
    find ./ | grep -v .git | xargs touch -t 2000010100000.00