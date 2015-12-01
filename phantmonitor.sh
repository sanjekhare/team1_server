until '/usr/local/bin/phant 2>&1 | logger'; do
    echo "Server 'phant' crashed with exit code $?.  Respawning.." >&2
    sleep 1
done