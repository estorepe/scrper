chown -R $USER /github/home/.cache/pip
chmod -R u+w /github/home/.cache/pip
pip3 install requests lxml pycurl
while read line; do
  {
    python3 tscr.py "$line"
    exit_status=$?
  } &

  while true; do
    echo "$line"
    sleep 2
  done | (
    trap "kill 0" SIGINT SIGTERM EXIT;
    wait
  )

  if [ $exit_status -eq 0 ]; then
    echo "$line" | tee -a tsite-map-1.txt
  fi
done < tsite-map.txt
