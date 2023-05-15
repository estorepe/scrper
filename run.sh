while read line; do
  {
    python3 tscr.py "$line" &&
    echo "$line processed successfully" &&
    echo "$line" | tee -a tsite-map-1.txt ||
    echo "$line processing failed"
  } &

  while true; do
    echo "$line"
    sleep 2
  done | (
    trap "kill 0" SIGINT SIGTERM EXIT;
    wait
  )
done < tsite-map.txt
